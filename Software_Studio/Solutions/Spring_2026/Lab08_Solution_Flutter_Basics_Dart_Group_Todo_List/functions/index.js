/**
 * Import function triggers from their respective submodules:
 *
 * const {onRequest} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const logger = require("firebase-functions/logger");

const { initializeApp } = require("firebase-admin/app");
const { getFirestore, FieldValue } = require("firebase-admin/firestore");
const {
  onDocumentCreated,
  onDocumentDeleted,
} = require("firebase-functions/v2/firestore");

initializeApp();
const db = getFirestore();

// Increments the itemCount for a user when a new grocery item is created.
// This function ensures data consistency and prevents duplicate processing
// through the use of idempotency keys.
exports.shoppingAppIncrementUserItemCount = onDocumentCreated(
  {
    document: "apps/group-todo-list/users/{userId}/todo-items/{itemId}",
    region: "us-west1",
  },
  async (event) => {
    const userId = event.params.userId;
    const itemId = event.params.itemId;

    const userRef = db.doc(`apps/group-todo-list/users/${userId}`);
    // Utilizes the unique event ID provided by Firebase to ensure idempotency.
    // This ID remains consistent across retries of the same event, preventing
    // duplicate increments of the itemCount in case the function is invoked
    // multiple times for the same creation event.
    const idempotencyRef = db.doc(`idempotencyKeys/${event.id}`);

    try {
      await db.runTransaction(async (transaction) => {
        // Logs if the function has already processed this event, ensuring
        // that itemCount is only incremented once per grocery item creation.
        const idempotencyDoc = await transaction.get(idempotencyRef);
        if (idempotencyDoc.exists) {
          logger.info(
            "shoppingAppIncrementUserItemCount: User.itemCount already incremented"
          );
          return;
        }

        const userDoc = await transaction.get(userRef);
        if (!userDoc.exists) {
          logger.warn("shoppingAppIncrementUserItemCount: User not found");
          return;
        }
        const userData = userDoc.data();
        const itemCount = userData.itemCount ? userData.itemCount + 1 : 1;
        transaction.update(userRef, { itemCount });

        // Marks this creation event as processed by setting an idempotency record.
        // This record uses Firebase's server timestamp to indicate when the event
        // was processed, providing a traceable log for debugging and audit purposes.
        transaction.set(idempotencyRef, {
          processedAt: FieldValue.serverTimestamp(),
        });
      });
      logger.debug(
        "shoppingAppIncrementUserItemCount: User.itemCount incremented"
      );
    } catch (error) {
      logger.error(
        "shoppingAppIncrementUserItemCount: Error incrementing User.itemCount",
        error
      );
    }
  }
);

// Decrements the itemCount for a user when a new grocery item is deleted
exports.shoppingAppDecrementUserItemCount = onDocumentDeleted(
  {
    document: "apps/group-todo-list/users/{userId}/todo-items/{itemId}",
    region: "us-west1",
  },
  async (event) => {
    const userId = event.params.userId;
    const itemId = event.params.itemId;

    const userRef = db.doc(`apps/group-todo-list/users/${userId}`);
    const idempotencyRef = db.doc(`idempotencyKeys/${event.id}`);

    try {
      await db.runTransaction(async (transaction) => {
        // Check if the operation has already been processed
        const idempotencyDoc = await transaction.get(idempotencyRef);
        if (idempotencyDoc.exists) {
          logger.info(
            "shoppingAppDecrementUserItemCount: User.itemCount already decremented"
          );
          return;
        }

        const userDoc = await transaction.get(userRef);
        if (!userDoc.exists) {
          logger.warn("shoppingAppDecrementUserItemCount: User not found");
          return;
        }
        const userData = userDoc.data();
        const itemCount =
          userData.itemCount && userData.itemCount > 0
            ? userData.itemCount - 1
            : 0;
        transaction.update(userRef, { itemCount });

        // Mark the operation as processed
        transaction.set(idempotencyRef, {
          processedAt: FieldValue.serverTimestamp(),
        });
      });
      logger.debug(
        "shoppingAppDecrementUserItemCount: User.itemCount decremented"
      );
    } catch (error) {
      logger.error(
        "shoppingAppDecrementUserItemCount: Error decrementing Usr.itemCount",
        error
      );
    }
  }
);

exports.todoAppRedistributeOrphanItems = onDocumentDeleted(
  {
    document: "apps/group-todo-list/users/{userId}",
    region: "us-west1",
  },
  async (event) => {
    const deletedUserId = event.params.userId;

    const usersRef = db.collection("apps/group-todo-list/users");
    const orphanItemsRef = usersRef.doc(deletedUserId).collection("todo-items");
    const idempotencyRef = db.doc(`idempotencyKeys/${event.id}`);

    try {
      await db.runTransaction(async (transaction) => {
        const idempotencyDoc = await transaction.get(idempotencyRef);
        if (idempotencyDoc.exists) {
          logger.info(
            "todoAppRedistributeOrphanItems: Orphan items already handled"
          );
          return;
        }

        const [orphanItemsSnapshot, remainingUsersSnapshot] =
          await Promise.all([
            transaction.get(orphanItemsRef),
            transaction.get(usersRef),
          ]);

        if (orphanItemsSnapshot.empty) {
          transaction.set(idempotencyRef, {
            deletedUserId,
            processedAt: FieldValue.serverTimestamp(),
            redistributedCount: 0,
          });
          logger.info("todoAppRedistributeOrphanItems: No orphan items found");
          return;
        }

        const remainingUsers = remainingUsersSnapshot.docs;

        orphanItemsSnapshot.docs.forEach((orphanItemDoc) => {
          if (remainingUsers.length === 0) {
            transaction.delete(orphanItemDoc.ref);
            return;
          }

          const randomUser =
            remainingUsers[Math.floor(Math.random() * remainingUsers.length)];
          const newItemRef = randomUser.ref
            .collection("todo-items")
            .doc(orphanItemDoc.id);

          transaction.set(newItemRef, {
            ...orphanItemDoc.data(),
            userId: randomUser.id,
          });
          transaction.delete(orphanItemDoc.ref);
        });

        transaction.set(idempotencyRef, {
          deletedUserId,
          processedAt: FieldValue.serverTimestamp(),
          redistributedCount: orphanItemsSnapshot.size,
        });
      });

      logger.debug(
        "todoAppRedistributeOrphanItems: Orphan items handled",
        deletedUserId
      );
    } catch (error) {
      logger.error(
        "todoAppRedistributeOrphanItems: Error handling orphan items",
        error
      );
    }
  }
);
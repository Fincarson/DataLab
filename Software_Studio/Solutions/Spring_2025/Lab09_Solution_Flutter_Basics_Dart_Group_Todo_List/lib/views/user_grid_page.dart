import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/services/navigation.dart';
import 'package:flutter_app/view_models/all_users_vm.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class UserGridPage extends StatelessWidget {
  const UserGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group To-do List'),
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () =>
                Provider.of<NavigationService>(context, listen: false)
                    .goAddUserOnUsers(),
          ),
        ],
      ),
      body: Consumer<AllUsersViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.users.isEmpty) {
            return const Center(child: Text('No users.'));
          }
          // Calculate the number of grid columns, ensuring there's at least one column
          double screenWidth = MediaQuery.of(context).size.width;
          double gridTileMinWidth = 150;
          int gridCrossAxisCount =
              max(1, (screenWidth / gridTileMinWidth).floor());
          double safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCrossAxisCount,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 8.0, // 8dp spacing between grid tiles
              mainAxisSpacing: 8.0, // 8dp spacing between grid tiles
            ),
            padding:
                EdgeInsets.fromLTRB(16, 16, 16, 16 + safeAreaBottomPadding),
            itemCount: viewModel.users.length,
            itemBuilder: (context, index) =>
                _buildGridItem(context, viewModel.users[index]),
          );
        },
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, User user) {
    final theme = Theme.of(context);
    final viewModel = Provider.of<AllUsersViewModel>(context, listen: false);

    return GestureDetector(
      onTap: () => Provider.of<NavigationService>(context, listen: false)
          .goTodosOnUsers(user.id!),
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        elevation: 0,
        child: Stack( // ✅ Stack inside the Card
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16), // ✅ Space below the icon
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: _buildAvatarImage(context, user),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  RichText(
                    text: TextSpan(
                      style: theme.textTheme.headlineLarge,
                      text: '${user.itemCount} ',
                      children: <TextSpan>[
                        TextSpan(
                          text: 'items to do.',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // ✅ Delete button in top-right corner *inside* the card
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => _showDeleteConfirmation(context, user, viewModel),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.black.withOpacity(0.50),
                  child: const Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // ✅ New helper method to show confirmation dialog
  void _showDeleteConfirmation(BuildContext context, User user, AllUsersViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.name}?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () async {
              Navigator.of(context).pop();
              await viewModel.deleteUser(user.id!); // ✅ Use injected ViewModel
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarImage(BuildContext context, User user) {
    if (user.avatarSvgData != null) {
      return SvgPicture.string(
        user.avatarSvgData!,
        fit: BoxFit.contain,
        placeholderBuilder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (user.avatarUrl != null) {
      return ClipOval(
        child: Stack(
          children: <Widget>[
            const Center(child: CircularProgressIndicator()),
            Positioned.fill(
              child: Center(
                child: Image.network(
                  user.avatarUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return FittedBox(
      fit: BoxFit.cover,
      child: Icon(
        Icons.account_circle,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
      ),
    );
  }
}

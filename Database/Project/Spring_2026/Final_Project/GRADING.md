## TA60

You must implement an optimized version which can get at least **5% higher throughput** than our both baseline on the TPC-C and micro benchmark.

## TA70

You need to implement an optimized way called: **Group Commit**.

### Our original approach

In the baseline implementation of `RecoveryMgr.onTxCommit()`
(see `core-patch/src/main/java/org/vanilladb/core/storage/tx/recovery/RecoveryMgr.java`),
every committing transaction does the following on its own:

```java
public void onTxCommit(Transaction tx) {
    if (!tx.isReadOnly() && enableLogging) {
        LogSeqNum lsn = new CommitRecord(txNum).writeToLog();
        VanillaDb.logMgr().flush(lsn);   // each commit forces its own disk write
    }
}
```

Each transaction writes a `CommitRecord` into the log buffer and then **immediately calls `LogMgr.flush(lsn)` by itself** to force its commit record onto disk before returning to the client. That means **one synchronous disk I/O per committing transaction**. Under high concurrency this becomes the dominant bottleneck: the disk is forced to perform a separate `fsync`-style write for every commit, even though many concurrent committers could have shared a single physical write.

### What you need to implement

You must replace the per-transaction flush with **Group Commit**: instead of each committing thread flushing the log on its own, multiple concurrent committers form a *group* and share a single log flush. Your implementation should satisfy all of the following requirements:

1. **Defer the flush.** A committing transaction should append its `CommitRecord` to the log buffer and then *wait*, instead of immediately calling `LogMgr.flush(...)` itself.
2. **Trigger one shared flush** when either of the following conditions is met:
   - The number of waiting committers reaches a configurable threshold **N (group size)**, **or**
   - A configurable **T (timeout)** has elapsed since the first thread in the current group started waiting.
3. **Flush once for the whole group.** Use the largest pending LSN as the flush target so that a single `LogMgr.flush(...)` call makes every transaction in the group durable.
4. **Preserve Durability (the *D* in ACID).** A committing thread must only return from `onTxCommit` after its own commit record is *actually* on disk. Returning to the client before the flush completes is incorrect, even if it looks faster in the benchmark..

> **Hint — think about *when* to release locks.**

### Choosing the group size and the timeout

You need to **reason about how to pick the two parameters yourself** — the **group size N** (how many committers share one flush) and the **timeout T** (how long the first arriver is willing to wait for the group to fill up). You are expected to understand the trade-off through experiments, which you should design yourselves.

There are a few questions you must answer in your report:

- **If the group size N is too small**, how much I/O are you actually saving? Why might throughput barely improve?
- **If the group size N is too large**, what happens? Why does latency explode and throughput possibly *drop*?
- **If the timeout T is too short**, is a group ever actually formed? What does your implementation degenerate into?
- **If the timeout T is too long**, what happens to per-transaction latency when the workload is light or bursty?

You should try **several different combinations** of group size and timeout, measure both throughput and average latency, and pick the configuration that you think it is the best.

If you find that group commit does not improve your performance, you may leave it out of your final optimized version. You still need to answer the above questions and clearly explain why you chose not to use it.

### What to put in the report

- Show the throughput **and** average latency you measured for *several* different group-size / timeout combinations. A table or a small chart is ideal.
- Justify your final choice of group size and timeout based on those measurements, and explain the trade-off (4 questions above).
- Compare your best configuration against the baseline (group commit disabled) with both throughput and average latency.
- Briefly argue why your implementation still guarantees Durability.

## Updated Grading Policy

* **70%** implementation
    - TA60
    - TA70
* **20%** performance (linear interpolation, the highest get 20 points, and the lowest get 0)
    - tpc-c
    - micro
* **10%** report

## TA Environment

MacBook Pro, Intel Core i5, 16GB 2133MHz
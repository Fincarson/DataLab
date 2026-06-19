

# Final Project

Optimize VanillaCore!!!😍

You can optimize any module you want.

## Steps

1. Fork this project
2. Understand the source code
3. Write your improvements
4. Run experiments (tpc-c, micro benchmark)
5. Write a report (Details can be seen below)
6. Push to GitLab and open a merge request

## Main Objective: Throughput
Our main goal is to improve throughput (commited transactions) of VanillaCore. 

While you improve throughput, chances are high that average latency decreases too. If your throughput increased but also having burst in latency. You probably did something wrong.

## Parameter

Parameters are fixed in the final project. Please do not change the parameters. If the parameters in project you submmited are inconsistent with the initial version. We'll know and take some points off your team. 

When we run your code, we will run different benchmark_interval (but no longer than 5 minutes) to test the stability of your code.

## Experiments and Grading

You need to run experiments to demonstrate how much performance your optimization improves. You only need to show the result of the final version of your optimization **using plots or tables**.

Please put **BOTH** throughput and average latency in you report

In final project, grade depends on performance. We'll run your code in our server and score your project base on that. (You still need to hand it the results you run on your local computers)

* 70% implementation
  - TA60
  - TA70
* 25% performance (linear interpolation, the highest get 25 points, and the lowest get 0)
  - tpc-c
  - micro
* 5% report

## Note
- The new workload includes `insert`. Please be sure to reload the testbed each time you run a benchmark.

- The detailed report now shows both the committed and aborted transactions. When you record the results on your report, remember to use only the number of the committed transactions.

- **We will announce new information about the project (e.g. TA60, TA70).** New information would be posted on gitlab repo in the form of new file (e.g. 20260521_announcement.txt), and eeclass anouncement section.  Please check the repo regularly. If you miss some information, it's your fault. Here's the easy way to do it.

```bash
git remote add upstream (url)
# This add our repo as upstream. Do this once.

git fetch upstream
# Whenever you want to check if there's update in our repo

git diff --name-only HEAD upstream/master
# This show the files difference. You can see if we add new files. There's no need to merge. 

```


## Constraint

- Please make sure the VanillaCore runs on Windows or MacOS operating system
- You cannot lower the isolation level supported.
- You must use java only.

## Report

- Briefly explain what you exactly do for optimization
- Experiments
  - Your experiment environment including (a list of your hardware components, the operating system)
    - e.g. Intel Core i5-3470 CPU @ 3.2GHz, 16 GB RAM, 128 GB SSD, CentOS 7
  - The experiments showing the overall improvement
  - Analyze and explain the result of the experiments
- **Discuss and conclude why your optimization works**

Note: There is no strict limitation to the length of your report. Generally, a 2~3 pages report with some figures and tables is fine. **Remember to include all the group members' student IDs in your report.**

## Submission

The procedure of submission is as following:

1. Fork our repo on GitLab
2. Clone the repository you forked
3. Finish your work and write the report
4. Commit your work, push your work to GitLab.
    - Name your report as `[Team Number]_final_report.pdf`
        - E.g. team1_final_report.pdf
5. Open a merge request to the original repository.
    - Source branch: Your working branch.
    - Target branch: The branch with your team number. (e.g. `team-1`)
    - Title: `Team-X Submission` (e.g. `Team-1 Submission`).

## No Plagiarism Will Be Tolerated
If we find you copy someone’s code, you will get 0 point for this assignment.


## Deadline

### Phase1: Implementation
Submit your work before **2026/06/03 (Wed.) 23:59:59.**

Note: If your team is ranked in the top 3, you will need to **prepare a brief presentation in class on 2026/06/08 (Mon.).**

### Phase2: Report
Submit your work before **2026/06/08 (Mon.) 23:59:59.**
**Late submission will NOT be accepted.**
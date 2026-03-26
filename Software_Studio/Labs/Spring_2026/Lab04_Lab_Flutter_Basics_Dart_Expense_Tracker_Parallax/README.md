# Lab 04 Expense app with parallax scrolling
During this lab session, you will need to **add a tutorial screen** with **scrolling function** and **parallax scrolling effects** to the expense application discussed in class.  
The lab project (courses > software-studio > 2026-spring > lab-flutter-basics-dart-expense-tracker-parallax) provides the expense tracker app with parallax scrollong effect on the item list for you to build on top of.

<!-- 
1. 規則與如何排隊demo
2. command, git problem (clone, conflict, push reject),
3. clone by ssh
4.  
 -->




# Reading before Starting.
1. [Lab rule and How to Register Demo](https://shwu10.cs.nthu.edu.tw/courses/software-studio/2026-spring/lab-flutter-basics-dart-expense-tracker-parallax/-/blob/master/LabDocuments/Demo___Lab_Guidelines.pdf)
2. [Lab FAQ -eng: command to run, git problem(clone, conflict, push reject, etc.)](https://shwu10.cs.nthu.edu.tw/courses/software-studio/2026-spring/lab-flutter-basics-dart-expense-tracker-parallax/-/blob/master/LabDocuments/FAQ-eng.pdf)
3. [Lab FAQ -mandarin:](https://shwu10.cs.nthu.edu.tw/courses/software-studio/2026-spring/lab-flutter-basics-dart-expense-tracker-parallax/-/blob/master/LabDocuments/FAQ-mandarin.pdf)
4. [Clone by ssh](https://shwu10.cs.nthu.edu.tw/courses/software-studio/2026-spring/lab-flutter-basics-dart-expense-tracker-parallax/-/blob/master/LabDocuments/Setup_Git_SSH_Key.pdf)
5. [View the Flutter Doument Faster](https://shwu10.cs.nthu.edu.tw/courses/software-studio/2026-spring/lab-flutter-basics-dart-expense-tracker-parallax/-/blob/master/LabDocuments/Using_Zeal_to_View_Flutter_and_Dart_Document.pdf)
6. **Please double-check that your target branch is correct. 
Submitting to the wrong branch will result in a 40% penalty (a maximum score of 0.6).**
7. For the **late submission, please "resend a new merge request."** And make sure your source branch and target branch is correct.

# Please using Android Studio Emulator
Some features in this lab cannot be rendered on the web. Please use the **Android Studio Emulator** instead. Keep your Task Manager open to monitor resource usage, and commit your completed code to GitLab frequently to prevent data loss in case of hardware issues. While computer failure is rare, it can happen if you leave too many browser tabs open—please close unnecessary windows.

# Video Demo
- While you demo, please run the app as the vedio to TA.

![](img/Lab05.mp4)

# Description
As you can see from the demo video, we want to see a **additional button** on the app bar which leads to a tutorial screen,  
In the screen, there should be **two swipeable (left to right) screens**, each of which contains some guidence to use the expense tracker app and a button that performs different actions.  
The **icons and text can be arbitrary**, meaning that we won't duduct points based on the content. 

# Grading
1. **Add a button on the appbar** to navigate to an tutorial page **(20%)**  
  

2. Implement a **swipaeble tutorial page** with two pages **(30%)**
    - Please **new a tutoral.dart** to implement this page.
    - The pages thould be **left-right swipeable**


3. Apply **parallax scrolling effects** on each widget of the tutorial page **(30%)**
    - The **text** should move at **1.5x moving speed**
    - the **button** should move at **2.5x moving speed**


4. Program the buttons to perform the following actions **(20%)**
    - The button on the first tutorial page should scroll the page to the second page
    - The button on the second tutorial page should dismiss the tutorial page 


# Hints
- There is a widget for swipeable pages  **Pageview**, There is a link to the documentation at the resources below.  
- Use Transform instead of Flow to do the parallax effect because no custom layout is needed
- In the PageView widget, a **Pagecontroller** is needed, the **page** propery indicates how far the page has been scrolled  
  you may want to set a listener to detect it's changes
- Listening to changes on the PageController are a lot like listening to the **Focusnode** in new_expense.dart  
- You may need to know the screen width in order to determine how much the scrolling effect should be.    



## Deadline
Submit your work before 2026/03/26 (Thur.) 17:30:00.

The score you have done will be 100%.

Submit your work before 2026/03/26 (Thur.) 23:59:59.

The score of other part you have done after 17:30:00 will be 60%.

# Resources

A few introductory tutorials crafted to assist you in completing today's lab.

(If the websites are too slow, please [open the "Zeal" application on the computer](https://shwu10.cs.nthu.edu.tw/courses/software-studio/2026-spring/lab-flutter-basics-dart-expense-tracker-parallax/-/blob/master/LabDocuments/Using_Zeal_to_View_Flutter_and_Dart_Document.pdf) and you'll see the offline flutter document. It's the same as using website to view document.)

- [PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html)
- [PageController](https://api.flutter.dev/flutter/widgets/PageController-class.html)
- [Transform](https://api.flutter.dev/flutter/widgets/Transform-class.html)

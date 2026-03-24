# Lab 03 Expense Tracker app - lab

## Setup Material Theme Builder
```
cd material-theme
python -m http.server
```
Then open the URL `http://localhost:8000/` in your browser, and click on the "Material Theme Builder" link to access the Material Theme Builder.

## WARNING

1. Please **do not** merge the **lab code into the master branch** again. After submitting, navigate to the course public folder (courses > software-studio > 2026-spring > lab-flutter-basics-dart-expense-tracker-app), and click on 'Merge Requests' on the left. Search for your student ID and check your merge request. Confirm that 'Request to merge (your student ID: your branch) into (your student ID)' is displayed, where (**your branch**) should usually be **master**, and 'into (**your student ID**)' should show your own **student ID**.

2. We will only approve your merge request at the **end of the lab, and at 11:59 PM**. During or after the lab, if you wish to update your code, **please push directly to the same branch**; your existing merge request will be updated automatically, and you do not need to close it and open a new one. However, if you accidentally create multiple merge requests, please ensure you close the previous one to keep only the latest one active.

3. If you find that you have submitted an **incorrect merge request**, please **delete** it for us.

If the above situation occurs, points will be **deducted from the original score, multiplied by 0.6.** Please pay special attention.

If an error is found, the safest way to proceed is to click "Close merge request" below and resend a merge request.

## Lab Description
In this lab course, you will be tasked with implementing **three functions** that were discussed in class.

The first part is to implement the **chart**, described as follows:

<br>( 40% )<br> 
<br>![component](img/step 1.png)<br> 

After entering values from the form, the chart will display the difference in bar heights between each category, reflecting the proportion of each item's total amount.

<br>![component](img/step 2.png)<br>  


The second part is to implement the **form**, described as follows:

The Invalid Input warning displayed in the sample program is as follows. 
<br>![component](img/step 3_1.png)<br> 

<br>( 30% )<br> 
Now, you need to modify it to utilize a Form to implement this area and display the warning below each text field as shown below. 
1. When both the title and the amount fields are left empty, both text fields should display a red warning
<br>![component](img/step_3_2.png)<br>
2. When an invalid amount entered (e.g., null or non-numeric text) while the title is correctly enteredm only the amount field should display a red warning 
<br>![component](img/step_3_3.png)<br>
3. when the title is left empty but the amount is correctly entered only the title field should display a red warning.
Each part is worth 10 point.
<br>![component](img/step_3_4.png)<br>


The third part is to implement the **Customized Theme**, described as follows:

<br>![component](img/step 4_1.png)<br> 

<br>( 30% )<br> 
Utilize the Material Theme Builder to configure the theme and dark theme (with a free choice of colors) for your application theme.

<br>![component](img/step 4_2.png)<br> 

## Deadline
Submit your work before 2026/03/19 (Thur.) 17:20:00.

The score you have done will be 100%.

Submit your work before 2026/03/19 (Thur.) 23:59:59.

The score of other part you have done after 17:20:00 will be 60%.

# Resources

A few introductory tutorials crafted to assist you in completing today's lab.

- [Chart bar implementation](https://api.flutter.dev/flutter/widgets/FractionallySizedBox-class.html)
    * Pay particular attention to the heightFactor or widthFactor of the FractionallySizedBox.
- [Form](https://dev.to/aspiiire/easy-way-to-write-forms-in-flutter-37ni)
- [Material Theme Builder](https://m3.material.io/theme-builder#/custom)

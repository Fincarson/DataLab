import 'package:flutter/material.dart';

import 'package:test_dart/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final formKey = GlobalKey<FormState>(); // Added form key
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // Add Invalid Checker
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  bool dateInvalid = false;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
      // Add Date Valid check
      dateInvalid = pickedDate == null;
    });
  }

  // Validate Title
  String? validateTitle(String? value){
    final trimmedValue = value?.trim() ?? '';

    if(trimmedValue.isEmpty) return "Please enter a title.";
    if(trimmedValue.length > 50) return "Title must be 50 characters or less.";

    return null;
  }

  // Validate Amount
  String? validateAmount(String? value){
    final enteredAmount = double.tryParse(value??'');

    if(enteredAmount == null || enteredAmount <= 0) return "Please enter a valid amount.";

    return null;
  }

  // Saving Section
  void saveExpense(){
    final isFormValid = formKey.currentState!.validate();
    final isDateValid = _selectedDate != null;

    setState((){
      dateInvalid = !isDateValid;
    });

    if(!isFormValid || !isDateValid) return;
    widget.onAddExpense(
      Expense(
        title: _titleController.text.trim(),
        amount: double.parse(_amountController.text),
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  // Cancel Saving
  void cancelExpense() {Navigator.pop(context);}

  // Update Category
  void updateCategory(Category? value){
    if(value == null) return;

    setState((){
      _selectedCategory = value;
    });
  }

  // Box Decoration for Title and Amount
  InputDecoration boxDecoration(String label, {String? prefixText}){
    return InputDecoration(
      labelText: label,
      prefixText: prefixText,

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 2,
        ),
      ),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      
      filled: true,
      fillColor: Theme.of(context).colorScheme.surface,
    );
  }

  // Title Field
  Widget titleField(){
    return TextFormField(
      controller: _titleController,
      maxLength: 50,
      decoration: boxDecoration("Title"),
      validator: validateTitle,
    );
  }

  // Amount Field
  Widget amountField(){
    return TextFormField(
      controller: _amountController,
      keyboardType: const TextInputType.numberWithOptions(decimal:  true),
      decoration: boxDecoration(
        "Amount",
        prefixText: "\$",
      ),
      validator: validateAmount,
    );
  }

  // Date
  Widget dateRow(BuildContext context){
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children:[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_selectedDate == null ? "No date selected" : formatter.format(_selectedDate!),),
            IconButton(
              onPressed: _presentDatePicker,
              icon: const Icon(Icons.calendar_month),
            ),
          ],
        ),
        if(dateInvalid) Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text(
            "Please choose a date",
            style: TextStyle(color: colorScheme.error),
          ),
        )
      ],
    );
  }

  // Category Dropdown Menu
  Widget categoryDropdown(){
    return DropdownButton<Category>(
      value: _selectedCategory,
      items: Category.values.map<DropdownMenuItem<Category>>(
        (category) => DropdownMenuItem(
          value: category,
          child: Text(category.toString()),
        ),
      ).toList(),
      onChanged: updateCategory,
    );
  }

  // Action button
  Widget actionButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: cancelExpense,
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: saveExpense,
          child: const Text("Save Expense"),
        ),
      ],
    );
  }

  // Layout
  List<Widget> layout(BuildContext context){
    return [
      const SizedBox(height: 20),
      titleField(),
      const SizedBox(height: 16),

      amountField(),
      const SizedBox(height: 16),

      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(_selectedDate == null ? "No date selected" : formatter.format(_selectedDate!)),
          IconButton(
            onPressed: _presentDatePicker,
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),

      if(dateInvalid)Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 4, left: 4),
          child: Text(
            "Please choose a date.",
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ),
      const SizedBox(height: 20),

      categoryDropdown(),
      const SizedBox(height: 28),
      actionButton(),
    ];
  }

  // void _submitExpenseData() {
  //   final enteredAmount = double.tryParse(_amountController
  //       .text); // tryParse('Hello') => null, tryParse('1.12') => 1.12
  //   final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
  //   if (_titleController.text.trim().isEmpty ||
  //       amountIsInvalid ||
  //       _selectedDate == null) {
  //     showDialog(
  //       context: context,
  //       builder: (ctx) => AlertDialog(
  //         title: const Text('Invalid input'),
  //         content: const Text(
  //             'Please make sure a valid title, amount, date and category was entered.'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(ctx);
  //             },
  //             child: const Text('Okay'),
  //           ),
  //         ],
  //       ),
  //     );
  //     return;
  //   }

  //   widget.onAddExpense(
  //     Expense(
  //       title: _titleController.text,
  //       amount: enteredAmount,
  //       date: _selectedDate!,
  //       category: _selectedCategory,
  //     ),
  //   );
  //   Navigator.pop(context);
  // }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
  //     child: Column(
  //       children: [
  //         TextField(
  //           controller: _titleController,
  //           maxLength: 50,
  //           decoration: const InputDecoration(
  //             label: Text('Title'),
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: TextField(
  //                 controller: _amountController,
  //                 keyboardType: TextInputType.number,
  //                 decoration: const InputDecoration(
  //                   prefixText: '\$ ',
  //                   label: Text('Amount'),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(width: 16),
  //             Expanded(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     _selectedDate == null
  //                         ? 'No date selected'
  //                         : formatter.format(_selectedDate!),
  //                   ),
  //                   IconButton(
  //                     onPressed: _presentDatePicker,
  //                     icon: const Icon(
  //                       Icons.calendar_month,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         Row(
  //           children: [
  //             DropdownButton(
  //               value: _selectedCategory,
  //               items: Category.values
  //                   .map(
  //                     (category) => DropdownMenuItem(
  //                       value: category,
  //                       child: Text(
  //                         category.name.toUpperCase(),
  //                       ),
  //                     ),
  //                   )
  //                   .toList(),
  //               onChanged: (value) {
  //                 if (value == null) {
  //                   return;
  //                 }
  //                 setState(() {
  //                   _selectedCategory = value;
  //                 });
  //               },
  //             ),
  //             const Spacer(),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text('Cancel'),
  //             ),
  //             ElevatedButton(
  //               onPressed: _submitExpenseData,
  //               child: const Text('Save Expense'),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context){
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constraints){
        final formChildren = layout(context);

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardSpace),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 520,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: formChildren,
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

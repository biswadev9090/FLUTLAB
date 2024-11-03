import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Details Form',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProjectDetailsForm(),
    );
  }
}

class ProjectDetailsForm extends StatefulWidget {
  @override
  _ProjectDetailsFormState createState() => _ProjectDetailsFormState();
}

class _ProjectDetailsFormState extends State<ProjectDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Project information
  String? _projectNumber,
      _projectObjective,
      _paymentTerms,
      _performanceCriteria,
      _roleDescription;
  double? _projectBudget, _bidSecurityAmount;
  DateTime? _startDate, _endDate;

  // Category data
  String? _selectedCategory, _selectedSubcategory;
  int? _selectedRoleId;

  // Sample data for categories, subcategories, and roles
  final List<Map<String, dynamic>> categories = [
    {
      'category': 'Retail and Customer Service',
      'subcategories': [
        {
          'name': 'Skilled',
          'roles': [
            {
              'id': 1,
              'name': 'Product Specialists',
              'description': 'Provide expert knowledge about products.'
            },
            {
              'id': 2,
              'name': 'Retail Managers',
              'description': 'Supervise retail operations.'
            },
          ]
        },
        {
          'name': 'Unskilled',
          'roles': [
            {
              'id': 3,
              'name': 'Cashiers',
              'description': 'Process payments and handle transactions.'
            },
            {
              'id': 4,
              'name': 'Retail Stock Clerks',
              'description': 'Restock shelves and manage inventory.'
            },
            {
              'id': 5,
              'name': 'Customer Service Representatives',
              'description': 'Handle inquiries and assist customers.'
            },
            {
              'id': 6,
              'name': 'Self-Checkout Attendants',
              'description': 'Help customers use checkout systems.'
            },
            {
              'id': 7,
              'name': 'Greeters',
              'description': 'Welcome customers and provide information.'
            },
          ]
        },
      ],
    },
  ];
  void _nextPage() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_currentPage < 5) {
        _pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      } else {
        // Final submission can happen here
        // Navigate to the summary page
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SummaryPage(
                    projectNumber: _projectNumber,
                    projectObjective: _projectObjective,
                    startDate: _startDate,
                    projectBudget: _projectBudget,
                    bidSecurityAmount: _bidSecurityAmount,
                    paymentTerms: _paymentTerms,
                    performanceCriteria: _performanceCriteria,
                    selectedCategory: _selectedCategory,
                    selectedSubcategory: _selectedSubcategory,
                    selectedRoleId: _selectedRoleId,
                    roleDescription: _roleDescription,
                  )),
        );
      }
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Project Details Form')),
      body: Form(
        key: _formKey,
        child: PageView(
          controller: _pageController,
          children: [
            _buildBasicInfoPage(),
            _buildFinancialDetailsPage(),
            _buildTechnicalRequirementsPage(),
            _buildDocumentationPage(),
            _buildEvaluationPage(),
            _buildCategoryOfWorkPage(),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_currentPage >
              0) // Only show the back button if not on the first page
            FloatingActionButton(
              onPressed: _previousPage,
              child: Icon(Icons.navigate_before),
              heroTag: null,
            ),
          SizedBox(width: 16), // Space between buttons
          FloatingActionButton(
            onPressed: _nextPage,
            child: Icon(Icons.navigate_next),
            heroTag: null,
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoPage() {
    return _buildPage(
      children: [
        _buildTextFormField('Project Number',
            onSaved: (value) => _projectNumber = value),
        _buildTextFormField('Project Objective',
            onSaved: (value) => _projectObjective = value),
        _buildDatePicker('Start Date', _startDate,
            (picked) => setState(() => _startDate = picked)),
      ],
    );
  }

  Widget _buildFinancialDetailsPage() {
    return _buildPage(
      children: [
        _buildTextFormField('Project Budget',
            keyboardType: TextInputType.number,
            onSaved: (value) => _projectBudget = double.tryParse(value!)),
        _buildTextFormField('Bid Security Amount',
            keyboardType: TextInputType.number,
            onSaved: (value) => _bidSecurityAmount = double.tryParse(value!)),
        _buildTextFormField('Payment Terms',
            onSaved: (value) => _paymentTerms = value),
      ],
    );
  }

  Widget _buildTechnicalRequirementsPage() {
    return _buildPage(
      children: [
        _buildTextFormField('Performance Criteria',
            onSaved: (value) => _performanceCriteria = value),
      ],
    );
  }

  Widget _buildDocumentationPage() {
    return _buildPage(children: [
      // Fields for required documents and regulatory compliance can be added here
    ]);
  }

  Widget _buildEvaluationPage() {
    return _buildPage(children: [
      // Fields for evaluation criteria, selection method, and notes can be added here
    ]);
  }

  Widget _buildCategoryOfWorkPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Category'),
            value: _selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue;
                _selectedSubcategory =
                    null; // Reset subcategory and role when category changes
                _selectedRoleId = null;
                _roleDescription = null; // Reset description
              });
            },
            items: categories.map((category) {
              return DropdownMenuItem<String>(
                value: category['category'],
                child: Text(category['category']),
              );
            }).toList(),
            validator: (value) => value == null ? 'Select a category' : null,
          ),
          SizedBox(height: 16.0), // Space between dropdowns
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Subcategory'),
            value: _selectedSubcategory,
            onChanged: (String? newValue) {
              setState(() {
                _selectedSubcategory = newValue;
                _selectedRoleId = null; // Reset role when subcategory changes
                _roleDescription = null; // Reset description
              });
            },
            items: _selectedCategory != null
                ? categories
                    .firstWhere((cat) => cat['category'] == _selectedCategory)[
                        'subcategories']
                    .map<DropdownMenuItem<String>>((subcategory) {
                    return DropdownMenuItem<String>(
                      value: subcategory['name'],
                      child: Text(subcategory['name']),
                    );
                  }).toList()
                : [],
            validator: (value) => value == null ? 'Select a subcategory' : null,
          ),
          SizedBox(height: 16.0), // Space between dropdowns
          DropdownButtonFormField<int>(
            decoration: InputDecoration(labelText: 'Role ID'),
            value: _selectedRoleId,
            onChanged: (int? newValue) {
              setState(() {
                _selectedRoleId = newValue;
                // Find the description based on the selected role ID
                if (_selectedSubcategory != null && _selectedCategory != null) {
                  var roles = categories
                      .firstWhere((cat) =>
                          cat['category'] == _selectedCategory)['subcategories']
                      .firstWhere((subcat) =>
                          subcat['name'] == _selectedSubcategory)['roles'];
                  var selectedRole =
                      roles.firstWhere((role) => role['id'] == newValue);
                  _roleDescription = selectedRole['description'];
                }
              });
            },
            items: _selectedSubcategory != null && _selectedCategory != null
                ? categories
                    .firstWhere((cat) => cat['category'] == _selectedCategory)[
                        'subcategories']
                    .firstWhere((subcat) =>
                        subcat['name'] == _selectedSubcategory)['roles']
                    .map<DropdownMenuItem<int>>((role) {
                    return DropdownMenuItem<int>(
                      value: role['id'],
                      child: Text(role['name']),
                    );
                  }).toList()
                : [],
            validator: (value) => value == null ? 'Select a role ID' : null,
          ),
          SizedBox(height: 16.0), // Space between dropdowns
          // Show the role description
          if (_roleDescription != null)
            Text(
              'Role Description: $_roleDescription',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Project Number: $_projectNumber'),
          Text('Project Objective: $_projectObjective'),
          Text(
              'Start Date: ${_startDate != null ? DateFormat('yyyy-MM-dd').format(_startDate!) : 'N/A'}'),
          Text('Budget: \$${_projectBudget?.toStringAsFixed(2) ?? 'N/A'}'),
          Text(
              'Bid Security Amount: \$${_bidSecurityAmount?.toStringAsFixed(2) ?? 'N/A'}'),
          Text('Payment Terms: $_paymentTerms'),
          Text('Performance Criteria: $_performanceCriteria'),
          Text('Selected Category: $_selectedCategory'),
          Text('Selected Subcategory: $_selectedSubcategory'),
          Text('Selected Role ID: $_selectedRoleId'),
          Text('Role Description: $_roleDescription'),
        ],
      ),
    );
  }

  Widget _buildPage({required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildTextFormField(String label,
      {TextInputType? keyboardType,
      ValueChanged<String?>? onSaved,
      bool readOnly = false,
      String? initialValue}) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      onSaved: onSaved,
      readOnly: readOnly,
      initialValue: initialValue,
      validator: (value) => value!.isEmpty ? 'Enter $label' : null,
    );
  }

  Widget _buildDatePicker(
      String label, DateTime? date, Function(DateTime?) onDateSelected) {
    return ListTile(
      title: Text(
          '$label: ${date != null ? DateFormat('yyyy-MM-dd').format(date) : 'Select a date'}'),
      trailing: Icon(Icons.calendar_today),
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        onDateSelected(picked);
      },
    );
  }
}

class SummaryPage extends StatelessWidget {
  final String? projectNumber;
  final String? projectObjective;
  final DateTime? startDate;
  final double? projectBudget;
  final double? bidSecurityAmount;
  final String? paymentTerms;
  final String? performanceCriteria;
  final String? selectedCategory;
  final String? selectedSubcategory;
  final int? selectedRoleId;
  final String? roleDescription;

  const SummaryPage({
    Key? key,
    this.projectNumber,
    this.projectObjective,
    this.startDate,
    this.projectBudget,
    this.bidSecurityAmount,
    this.paymentTerms,
    this.performanceCriteria,
    this.selectedCategory,
    this.selectedSubcategory,
    this.selectedRoleId,
    this.roleDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Project Number: $projectNumber'),
            Text('Project Objective: $projectObjective'),
            Text(
                'Start Date: ${startDate != null ? DateFormat('yyyy-MM-dd').format(startDate!) : 'N/A'}'),
            Text('Budget: \$${projectBudget?.toStringAsFixed(2) ?? 'N/A'}'),
            Text(
                'Bid Security Amount: \$${bidSecurityAmount?.toStringAsFixed(2) ?? 'N/A'}'),
            Text('Payment Terms: $paymentTerms'),
            Text('Performance Criteria: $performanceCriteria'),
            Text('Selected Category: $selectedCategory'),
            Text('Selected Subcategory: $selectedSubcategory'),
            Text('Selected Role ID: $selectedRoleId'),
            Text('Role Description: $roleDescription'),
          ],
        ),
      ),
    );
  }
}

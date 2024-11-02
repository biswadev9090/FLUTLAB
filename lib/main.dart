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

  // Stage 1: Basic Project Information
  String? _projectNumber;
  String? _projectObjective;
  List<String> _deliverables = [];
  DateTime? _startDate;
  DateTime? _endDate;

  // Stage 2: Financial Details
  double? _projectBudget;
  double? _bidSecurityAmount;
  String? _paymentTerms;

  // Stage 3: Technical Requirements
  List<String> _technicalRequirements = [];
  List<String> _qualityStandards = [];
  String? _performanceCriteria;

  // Stage 4: Documentation and Compliance
  List<String> _requiredDocuments = [];
  List<String> _regulatoryCompliance = [];

  // Stage 5: Evaluation and Selection Criteria
  List<String> _evaluationCriteria = [];
  String? _selectionMethod;
  String? _notes;

  // Stage 6: Category of Work
  String? _category;
  String? _subcategory;
  int? _roleId;
  String? _roleName;

  void _nextPage() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save form values
      if (_pageController.page!.toInt() < 5) {
        _pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      } else {
        // Final submission can happen here
        print("Final Submission:");
        print("Project Number: $_projectNumber");
        // Continue printing other fields...
      }
    }
  }

  String? _selectedCategory;
  String? _selectedSubcategory;
  int? _selectedRoleId;
  String? _roleDescription;

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
              'description':
                  'Provide expert knowledge about products, recommend solutions, and assist customers with specialized needs.'
            },
            {
              'id': 2,
              'name': 'Retail Managers',
              'description':
                  'Supervise retail operations, including staff management, inventory, and customer service.'
            },
          ]
        },
        {
          'name': 'Unskilled',
          'roles': [
            {
              'id': 3,
              'name': 'Cashiers',
              'description':
                  'Process payments, handle customer transactions, and manage checkout areas.'
            },
            {
              'id': 4,
              'name': 'Retail Stock Clerks',
              'description':
                  'Restock shelves, manage inventory, and assist with product placement.'
            },
            {
              'id': 5,
              'name': 'Customer Service Representatives',
              'description':
                  'Handle inquiries, process returns, and assist customers with basic issues.'
            },
            {
              'id': 6,
              'name': 'Self-Checkout Attendants',
              'description':
                  'Help customers use self-service checkout systems and resolve any issues that arise.'
            },
            {
              'id': 7,
              'name': 'Greeters',
              'description':
                  'Welcome customers at the entrance of stores, provide information, and assist with navigation.'
            },
          ]
        },
      ],
    },
  ];
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
      floatingActionButton: FloatingActionButton(
        onPressed: _nextPage,
        child: Icon(Icons.navigate_next),
      ),
    );
  }

  Widget _buildBasicInfoPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Project Number'),
            onSaved: (value) => _projectNumber = value,
            validator: (value) =>
                value!.isEmpty ? 'Enter project number' : null,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Project Objective'),
            onSaved: (value) => _projectObjective = value,
            validator: (value) =>
                value!.isEmpty ? 'Enter project objective' : null,
          ),
          // Add other fields like deliverables, start date etc.
          // Example for Start Date
          ListTile(
            title: Text(
                'Start Date: ${_startDate != null ? DateFormat('yyyy-MM-dd').format(_startDate!) : 'Select a date'}'),
            trailing: Icon(Icons.calendar_today),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _startDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (picked != null) {
                setState(() {
                  _startDate = picked;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialDetailsPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Project Budget'),
            keyboardType: TextInputType.number,
            onSaved: (value) => _projectBudget = double.tryParse(value!),
            validator: (value) =>
                value!.isEmpty ? 'Enter project budget' : null,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Bid Security Amount'),
            keyboardType: TextInputType.number,
            onSaved: (value) => _bidSecurityAmount = double.tryParse(value!),
            validator: (value) =>
                value!.isEmpty ? 'Enter bid security amount' : null,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Payment Terms'),
            onSaved: (value) => _paymentTerms = value,
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalRequirementsPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Fields for technical requirements and quality standards
          TextFormField(
            decoration: InputDecoration(labelText: 'Performance Criteria'),
            onSaved: (value) => _performanceCriteria = value,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentationPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Fields for required documents and regulatory compliance
        ],
      ),
    );
  }

  Widget _buildEvaluationPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Fields for evaluation criteria, selection method, and notes
        ],
      ),
    );
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
          TextFormField(
            decoration: InputDecoration(labelText: 'Description'),
            readOnly:
                true, // Make it read-only since it's derived from the selected role ID
            initialValue: _roleDescription,
            onSaved: (value) => _roleDescription = value,
          ),
        ],
      ),
    );
  }
}

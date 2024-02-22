import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(BeauticianApp());
}

class BeauticianApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beautician App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Beauty Connect',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              'Your go-to destination for beauty services',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'Discover talented beauticians near you',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to user type selection page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserTypeSelectionPage()),
                );
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserTypeSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User Type'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to beautician login page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BeauticianLoginPage()),
                );
              },
              child: Text('Beautician'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to customer login page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerLoginPage()),
                );
              },
              child: Text('Customer'),
            ),
          ],
        ),
      ),
    );
  }
}

class BeauticianLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beautician Login'),
      ),
      body: LoginForm(userType: 'beautician'),
    );
  }
}

class CustomerLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Login'),
      ),
      body: LoginForm(userType: 'customer'),
    );
  }
}

class LoginForm extends StatelessWidget {
  final String userType;

  LoginForm({required this.userType});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Perform login action based on user type
              String email = _emailController.text.trim();
              String password = _passwordController.text.trim();

              // Example: Validate login credentials
              bool isValidCredentials = true; // Perform your validation here

              if (isValidCredentials) {
                // Navigate to corresponding dashboard page
                if (userType == 'beautician') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BeauticianDetailsForm()),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomerDashboardPage()),
                  );
                }
              } else {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('Invalid email or password. Please try again.'),
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
class BeauticianDetailsForm extends StatefulWidget {
  @override
  _BeauticianDetailsFormState createState() => _BeauticianDetailsFormState();
}

class _BeauticianDetailsFormState extends State<BeauticianDetailsForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _introductionController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _socialMediaController = TextEditingController();
  TextEditingController _certificatesController = TextEditingController();

  List<String> _selectedServices = [];
  File? _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _toggleService(String service) {
    setState(() {
      if (_selectedServices.contains(service)) {
        _selectedServices.remove(service);
      } else {
        _selectedServices.add(service);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beautician Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your details:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: getImage,
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? Icon(
                          Icons.add_a_photo,
                          size: 50.0,
                        )
                      : null,
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: _introductionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Introduction',
                ),
              ),
              TextField(
                controller: _mobileNumberController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _socialMediaController,
                decoration: InputDecoration(
                  labelText: 'Social Media Profile',
                ),
              ),
              Text(
                'Services Offered:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 10.0),
              CheckboxListTile(
                title: Text('Bridal Makeup'),
                value: _selectedServices.contains('Bridal Makeup'),
                onChanged: (_) => _toggleService('Bridal Makeup'),
              ),
              CheckboxListTile(
                title: Text('Hair Styling'),
                value: _selectedServices.contains('Hair Styling'),
                onChanged: (_) => _toggleService('Hair Styling'),
              ),
              CheckboxListTile(
                title: Text('Skincare Consultation'),
                value: _selectedServices.contains('Skincare Consultation'),
                onChanged: (_) => _toggleService('Skincare Consultation'),
              ),
              TextField(
                controller: _certificatesController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Certificates (Optional)',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Placeholder for form submission
                  // You can access the entered data here and proceed with saving it
                  // For now, let's just navigate to the profile page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BeauticianProfilePage(
                        name: _nameController.text,
                        introduction: _introductionController.text,
                        servicesOffered: _selectedServices,
                        mobileNumber: _mobileNumberController.text,
                        email: _emailController.text,
                        socialMediaProfile: _socialMediaController.text,
                        certificates: _certificatesController.text,
                        // Placeholder, you can format the date as needed
                      ),
                    ),
                  );
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class BeauticianProfilePage extends StatelessWidget {
  final String name;
  final String introduction;
  final List<String> servicesOffered;
  final String mobileNumber;
  final String email;
  final String socialMediaProfile;
  final String certificates;
  final File? profileImage;

  BeauticianProfilePage({
    required this.name,
    required this.introduction,
    required this.servicesOffered,
    required this.mobileNumber,
    required this.email,
    required this.socialMediaProfile,
    required this.certificates,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beautician Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            profileImage != null
                ? CircleAvatar(
                    radius: 60.0,
                    backgroundImage: FileImage(profileImage!),
                  )
                : Container(), // Show empty container if no profile image
            SizedBox(height: 20.0),
            // Introduction
            Text(
              'Hi, I\'m $name',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            Text(
              introduction,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            // Services Offered
            Text(
              'Services Offered:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: servicesOffered
                  .map((service) =>
                      Text('- $service', style: TextStyle(fontSize: 18.0)))
                  .toList(),
            ),
            SizedBox(height: 20.0),
            // Contact Information
            Text(
              'Contact Information:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Phone: $mobileNumber\nEmail: $email\nSocial Media: $socialMediaProfile',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            // Availability
            if (certificates.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Certificates:',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    certificates,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            // Booking Options
            ElevatedButton(
              onPressed: () {
                // Placeholder for booking action
              },
              child: Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomerDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Dashboard'),
      ),
      body: Center(
        child: Text(
          'Customer Dashboard Page',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

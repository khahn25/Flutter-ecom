import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TermsConditionsScreen(),
    );
  }
}

class TermsConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 82, 69, 69),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: Text(
          "Terms & Conditions",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
      "assets/images/hehe.png",
      width: 100,
      height: 50,
    ),
                ),
                
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Terms & Conditions",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "A. Introduction:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Welcome to Dopey."
                        " By accessing and using our platform, you agree to these terms and conditions. If you do not agree with any part of these terms, please do not use our services",
                      ),
                      Text(
                        "B. User Accounts:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "1. Users must register a valid account to access full features of the application."
                         "\n\n2. You are responsible for maintaining the confidentiality of your account and login information."
                         "\n\n3. Do not share your account or use someone else’s account."
                      ),
                      Text(
                        "C.  User Rights & Responsibilities:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "1. Do not use the service for illegal activities."
                         "\n\n2. Do not upload harmful, fraudulent, or offensive content."
                         "\n\n3. We reserve the right to suspend accounts involved in fraudulent activities."
                      ),
                      Text(
                        "D.  Personal Data Protection:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "1. Your personal data is protected in accordance with our privacy policy."
                         "\n\n2. We do not share your information with third parties without your consent."
                      ),
                      Text(
                        "E. Limitation of Liability:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "1. We are not responsible for unexpected incidents such as delivery delays, system errors, hacking, etc."
                         "\n\n2. In any case, our liability will not exceed the total value of your order."
                      ),
                      Text(
                        "F. Changes to Terms & Conditions:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "1. We may modify these terms at any time."
                         "\n\n2. Continued use of our service after any changes means you accept the updated terms."
                      ),
                      Text(
                        "G. Contact Information:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "If you have any questions regarding these terms, please contact us:"
                         "\n\n 📧 Email: xuankhanh359@gmail.com"
                           " \n\n 📞 Hotline: 0966352821"
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:assignment/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  bool _passwordVisible = false;
  bool agreedToTerms = false;
  
  String name = '';
  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
         
          margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 90.0),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      decoration: _textInputDecoration('Name', 'Enter your name'),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      decoration: _textInputDecoration("E-mail address", "Enter your email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter your email address";
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                            .hasMatch(val)) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      decoration: _passwordInputDecoration('Password', 'Enter your Password'),
                      obscureText: !_passwordVisible, 
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      decoration: _passwordInputDecoration('Confirm Password', 'Re-Enter your Password'),
                      obscureText: !_passwordVisible,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please re-enter your password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Checkbox(
                          value: agreedToTerms,
                          onChanged: (value) {
                            setState(() {
                              agreedToTerms = value!;
                            });
                          },
                        ),
                        Text("I agree to the Terms and Conditions"),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: _buttonStyle(context),
                      onPressed: () async {
                   if (_formKey.currentState!.validate() && agreedToTerms) {
                        try {
                       final newUser = await _auth.createUserWithEmailAndPassword(
                           email: email,
                             password: password,
                     );

              if (newUser != null) {

                await _firestore.collection('users').doc(newUser.user?.uid).set({
                  'name': name,
                  'email': email,
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashBoard(),
                  ),
                );
              }
            } catch (e) {
              // Handle registration error
              print(e);
            }
          }
        },

                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => SignIn(),
                           ),
                            );
                      },
                      child: Text("Already a user? Sign In"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _textInputDecoration([String labelText = "", String hintText = ""]) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  InputDecoration _passwordInputDecoration([String labelText = "", String hintText = ""]) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
      suffixIcon: IconButton(
        icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      ),
    );
  }

  ButtonStyle _buttonStyle(BuildContext context) {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(Colors.orange),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      foregroundColor: MaterialStateProperty.all(Colors.white),
    );
  }
}



//sign in screen


class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String email = '';
  String password = '';
  bool _passwordVisible = false;

  @override
   Widget build(BuildContext context) {
    return Scaffold(
 backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back), 
        ),
       
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    TextFormField(
                      decoration: _textInputDecoration("E-mail ", "Enter your email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter your email address";
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zAZ0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zAZ0-9-]{0,253}[a-zA-Z0-9])?)*$")
                            .hasMatch(val)) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      decoration: _passwordInputDecoration('Password', 'Enter your Password'),
                      obscureText: !_passwordVisible,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40.0),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: _buttonStyle(context),
                            onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                           try {
                         await _auth.signInWithEmailAndPassword(email: email, password: password);

                               Navigator.push(
                                context,
                          MaterialPageRoute(
                          builder: (context) => DashBoard(),
                ),
              );
              } catch (e) {
              // Handle sign-in error
              print(e);
            }
          }
        },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                      },
                      child: Text("Forgot Password"),
                    ),
                    SizedBox(height: 20.0),
                    Text("or Sign In using"),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialButton(
                          icon: 'assets/twitter.svg',
                          onPressed: () {
                            // Handle Twitter sign-in
                          },
                        ),
                        SizedBox(width: 20),
                        SocialButton(
                          icon: 'assets/facebook.svg',
                          onPressed: () {
                            // Handle Facebook sign-in
                          },
                        ),
                        SizedBox(width: 20),
                        SocialButton(
                          icon: 'assets/google.svg',
                          onPressed: () {
                            // Handle Google sign-in
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationPage(),
                              ),
                            );
                          },
                           
                          child: Text("Create an account"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _textInputDecoration([String labelText = "", String hintText = ""]) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  InputDecoration _passwordInputDecoration([String labelText = "", String hintText = ""]) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
      suffixIcon: IconButton(
        icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      ),
    );
  }

  ButtonStyle _buttonStyle(BuildContext context) {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(Colors.orange),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      foregroundColor: MaterialStateProperty.all(Colors.white),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String icon;
  final Function onPressed;

  SocialButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.all(10),
        child: SvgPicture.asset(
          icon,
         // color: Colors.white,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  late double screenwidth = MediaQuery.of(context).size.width;
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  InputBorder bd=UnderlineInputBorder(borderSide: BorderSide(width: 2,color: const Color.fromARGB(255, 0, 0, 0))) ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          backgroundColor: Colors.red,
          automaticallyImplyLeading: true,
          title: Text(
            "New Password",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter New Password",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: screenwidth - 100,
                          child: TextFormField(
                            
                            controller: oldPassword,
                            obscureText: _obscureOldPassword,
                            decoration: InputDecoration(
                              enabledBorder: bd,
                              labelText: 'Old Password',
                                helperText: '  Minimum 8 character With 1 number/symbol',
                              prefixIcon: Icon(Icons.lock_open),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureOldPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureOldPassword =
                                        !_obscureOldPassword;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: screenwidth - 100,
                          child: TextFormField(
                            
                            
                            controller: newPassword,
                            obscureText: _obscureNewPassword,
                            decoration: InputDecoration(
                              helperText: '  Minimum 8 character With 1 number/symbol',
                              enabledBorder: bd,
                               prefixIcon: Icon(Icons.lock),
                              labelText: 'New Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureNewPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureNewPassword =
                                        !_obscureNewPassword;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: screenwidth - 100,
                          child: TextFormField(
                            controller: confirmPassword,
                            obscureText: _obscureConfirmPassword,
                            decoration: InputDecoration(
                              enabledBorder:bd,
                              border: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Colors.white)),
                              labelText: 'Confirm Password',
                               prefixIcon: Icon(Icons.password),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialButton(color: Colors.blue,
                    height: 50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
                    
                                        
                      
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          // Implement your reset password logic here
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Reset',style: TextStyle(color: Colors.white,fontSize: 25),),
                      ),
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
}

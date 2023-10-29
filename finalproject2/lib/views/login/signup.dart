import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../repository/user_repo.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();

  //_SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? selectedGender;

  final genderList = ['male', 'female', 'others'];

  String selectedImagePath = 'jhgggj';

  bool loading=false;
  bool iserror=false;
  bool issuccess=false;
  String error="";
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var nameCtr=TextEditingController();

  var phoneCtr=TextEditingController();
  var emailCtr=TextEditingController();
  var passwordCtr=TextEditingController();
  var genderCtr=TextEditingController();
  var perCtr=TextEditingController();
  var usernameCtr=TextEditingController();


  var formKey=GlobalKey<FormState>();



  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Form(
          key: formKey,child:
        SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 35, top: 30),
                  child: Text(
                    'Create\nAccount',
                    style: TextStyle(color: Colors.white, fontSize: 33),
                  ),
                ),
                Container(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: nameCtr,
                                autovalidateMode: AutovalidateMode.onUserInteraction,

                                style: TextStyle(color: Colors.black54),

                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person,color: Colors.brown[300]),

                                  border:
                                  OutlineInputBorder(borderSide:BorderSide(color: Colors.amber),
                                      borderRadius: BorderRadius.circular(10)),
                                  errorBorder:  OutlineInputBorder(borderSide:BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10)),



                                  enabledBorder: OutlineInputBorder(

                                    borderRadius: BorderRadius.circular(10),

                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Name",
                                  fillColor: Colors.grey.shade100,
                                  filled: true,

                                ),

                                  validator: (val) {
                                    if (val == "") {
                                      return "value is null";
                                    }
                                    if (val != null) {
                                      if (val.length < 3) {
                                        return "Name must be more than 3 chars";
                                      }
                                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(val)) {
                                        return "Name can only contain alphabets and spaces";
                                      }

                                    }

                                  }


                              ),
                              SizedBox(
                                height: 30,
                              ),//name
                              TextFormField(
                                controller: usernameCtr,
                                style: TextStyle(color: Colors.black54),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person_outline,color: Colors.brown[300]),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "User Name",
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  border:
                                  OutlineInputBorder(borderSide:BorderSide(color: Colors.amber),
                                      borderRadius: BorderRadius.circular(20)),
                                  errorBorder:  OutlineInputBorder(borderSide:BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(20)),

                                ),


                                  validator: (val) {
                                    if (val == "") {
                                      return "value is null";
                                    }
                                    if (val != null) {
                                      if (val.length < 3) {
                                        return "User Name must be more than 3 chars";
                                      }
                                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(val)) {
                                        return "User Name can only contain alphabets and spaces";
                                      }

                                    }

                                  }
                              ),
                              SizedBox(
                                height: 30,
                              ),//img
                              TextFormField(
                                controller: emailCtr,
                                style: TextStyle(color: Colors.black54),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email,color: Colors.brown[300]),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "email",
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  border:
                                  OutlineInputBorder(borderSide:BorderSide(color: Colors.amber),
                                      borderRadius: BorderRadius.circular(20)),
                                  errorBorder:  OutlineInputBorder(borderSide:BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(20)),

                                ),


                                validator: (value) {
                                  RegExp emailRegex =
                                  RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                                  if (value == null) {
                                    return 'Email is required';
                                  } else if (value.length < 10) {
                                    return 'Email must be more than 10 characters';
                                  } else if (!value.contains('@')) {
                                    return 'Email must contain @';
                                  } else if (!emailRegex.hasMatch(value)) {
                                    return 'Invalid email';
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),//email
                              TextFormField(
                                controller: phoneCtr,
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.black54),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone,color: Colors.brown[300]),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "phone",
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  border:
                                  OutlineInputBorder(borderSide:BorderSide(color: Colors.amber),
                                      borderRadius: BorderRadius.circular(20)),
                                  errorBorder:  OutlineInputBorder(borderSide:BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(20)),

                                ),


                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the Phone Number';
                                  }
                                  if (value.length < 3) {
                                    return "Phone must be more than 3 chars";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),//user

                              TextFormField(
                                controller: passwordCtr,

                                style: TextStyle(color: Colors.black54),
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.password,color: Colors.brown[300]),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Password",
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  border:
                                  OutlineInputBorder(borderSide:BorderSide(color: Colors.amber),
                                      borderRadius: BorderRadius.circular(20)),
                                  errorBorder:  OutlineInputBorder(borderSide:BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the Password';
                                  }
                                  if (value.length < 3) {
                                    return "Password must be more than 3 chars";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              SizedBox(height: 16.0),
                              Container(//////////////////////////////////////////////////////////////////////////////////////////////

                                  child: DropdownButtonFormField<String>(
                                    value: selectedGender,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedGender = newValue;
                                        genderCtr.text = newValue ?? '';
                                      });
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.woman_outlined,color: Colors.brown[300]),



                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Gender",
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      border:
                                      OutlineInputBorder(borderSide:BorderSide(color: Colors.amber),
                                          borderRadius: BorderRadius.circular(20)),
                                      errorBorder:  OutlineInputBorder(borderSide:BorderSide(color: Colors.red),
                                          borderRadius: BorderRadius.circular(20)),
                                    ),

                                    items: genderList.map((gender) {
                                      return DropdownMenuItem<String>(
                                        value: gender,
                                        child: Text(gender),
                                      );
                                    }).toList(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Phone gender';
                                      }
                                      return null;
                                    },
                                  ),

                              ),
                              SizedBox(height: 24.0),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  if (loading)
                                    CircularProgressIndicator()
                                  else
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.brown[300],
                                      child: IconButton(
                                        color: Colors.white,
                                        onPressed: () async {
                                          if (formKey.currentState!.validate()) {
                                            try {
                                              setState(() {
                                                loading = true;
                                                issuccess = false;
                                                iserror = false;
                                              });

                                              // Check if email already exists
                                              bool emailExists = await UserRepository().checkEmailExists(emailCtr.text);

                                              if (emailExists) {
                                                // Email already exists, show an error message or handle accordingly
                                                setState(() {
                                                  loading = false;
                                                  issuccess = false;
                                                  iserror = true;
                                                  error = "Email already exists!";
                                                });
                                              } else {
                                                // Email does not exist, proceed with adding the new user
                                                var date = {
                                                  "fName": nameCtr.text,
                                                  "img": "assets/person.jpg",
                                                  "uName": nameCtr.text,
                                                  "password": passwordCtr.text,
                                                  "phone": int.parse(phoneCtr.text),
                                                  "per": "user",
                                                  "gender": genderCtr.text,
                                                  "email": emailCtr.text,
                                                };

                                                var addRes = await UserRepository().addd(UserModel.fromJson(date));

                                                if (addRes != true) {
                                                  setState(() {
                                                    loading = false;
                                                    issuccess = true;
                                                    iserror = false;
                                                    error = "";
                                                  });
                                                  Navigator.of(context).pop(true);
                                                } else {
                                                  setState(() {
                                                    loading = false;
                                                    issuccess = false;
                                                    iserror = true;
                                                    error = "Operation failed!";
                                                  });
                                                }
                                              }
                                            } catch (e) {
                                              setState(() {
                                                loading = false;
                                                issuccess = false;
                                                iserror = true;
                                                error = "Exception: $e";
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('$error'),backgroundColor:Colors.brown[300]),);
                                              });
                                            }
                                          }
                                        },
                                        icon: Icon(Icons.arrow_forward),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text(
                                      'Sign In',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    style: ButtonStyle(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                iserror?Text("error:${error}",style: TextStyle(color: Colors.red),):SizedBox(),
                issuccess?Text("Added successfully",style: TextStyle(color: Colors.green),):SizedBox()

              ],
            ),
          ),
        ),
      ),
    );
  }
}

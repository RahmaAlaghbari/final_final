import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/user_model.dart';
import '../../../repository/user_repo.dart';
import '../../CustomPages/appbar.dart';


String? selectedGender;
final genderList = ['female', 'male','others'];


class userUpdate extends StatefulWidget {
  final String userId;

  userUpdate({required this.userId});

  @override
  _userUpdate createState() => _userUpdate();
}

class _userUpdate extends State<userUpdate> {
  final _formKey = GlobalKey<FormState>();
  final _UserRepository = UserRepository();
  TextEditingController _perController = TextEditingController();
  TextEditingController _fNameController = TextEditingController();
  // TextEditingController _imgController = TextEditingController();
  TextEditingController _uNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool isError = false;
  String errorMsg = "";

  @override
  void initState() {
    super.initState();
    // Load the Product data by ID when the page is initialized
    _loadUser();
  }

  void _loadUser() async {
    try {
      // Retrieve the Product by ID
      UserModel? user =
      await _UserRepository.getById(widget.userId);
      if (user != null) {
        _fNameController.text = user.fName?? "";
        _imgController.text = user.img?? "";
        _uNameController.text = user.uName?? "";
        _passwordController.text = user.password?? "";
        _phoneController.text = user.phone as String;
        _perController.text = user.per?? "";
        _genderController.text = user.gender?? "";
        _emailController.text = user.email?? "";

      }
    } catch (e) {
      // Handle any errors
      print('Error loading user: $e');
    }
  }

  void _updateUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Retrieve the existing user data
        UserModel? existingUser = await _UserRepository.getById(widget.userId);
        if (existingUser != null) {
          // Create a new UserModel object with the updated permission
          UserModel updatedUser = UserModel(
            id: widget.userId,
            per: existingUser.per,
            fName: _fNameController.text,
            img: _imgController.text,
            // img: _selectedImageBytes.toString(),
            uName: _uNameController.text,
            password: _passwordController.text,
            phone: int.parse(_phoneController.text),
            gender: _genderController.text,
            email: _emailController.text,
          );

          // Update the user with the new permission
          Object rowsAffected = await _UserRepository.editt(updatedUser);
          if (rowsAffected != true) {
            // User updated successfully
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User updated successfully')),
            );
            Navigator.of(context).pop(true);
          } else {
            // Failed to update user
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to update user')),
            );
          }
        }
      } catch (e) {
        // Handle any errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating user')),
        );
      }
    }
  }

  @override
  void dispose() {
    _perController.dispose();
    _fNameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    _imgController.dispose();
    _uNameController.dispose();

    super.dispose();
  }
  // Uint8List?  _imgController;
//   String? _imgString;
//
// // ...
//   DecorationImage? _backgroundImage;
//
// // ...
//
//   void selectImage() async {
//     final imagePicker = ImagePicker();
//     final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       final imageBytes = await pickedImage.readAsBytes();
//       final base64Image = base64Encode(imageBytes);
//       setState(() {
//         _backgroundImage = DecorationImage(
//           image: MemoryImage(base64Decode(base64Image)),
//           fit: BoxFit.cover,
//         );
//       });
//     }
//   }

  File? _imgFile;

  var _imgController = TextEditingController();

  var _selectedImageBytes;
  Future<void> selectImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _imgFile = File(pickedImage.path);
        _imgController.text = pickedImage.path; // Set the image path to the controller
      } else {
        print('No image selected.');
      }
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: customAppBar(context, 'Edit Profile'),
    body: ListView(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: _imgFile != null
                            ? FileImage(_imgFile!) as ImageProvider<Object>
                            : NetworkImage(
                          'https://w7.pngwing.com/pngs/340/956/png-transparent-profile-user-icon-computer-icons-user-profile-head-ico-miscellaneous-black-desktop-wallpaper-thumbnail.png',
                        ),
                      ),

                      Positioned(
                        child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(Icons.add_a_photo),
                          color: Colors.brown[300],
                        ),
                        bottom: -5,
                        left: 50,
                      ),


                      SizedBox(height: 16.0),
                      TextFormField(
                          controller: _fNameController,
                          autovalidateMode: AutovalidateMode
                              .onUserInteraction,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "Full Name",
                            labelText: "Full Name",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold),
                            counterText: "20",
                            border:
                            OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                                borderRadius: BorderRadius.circular(20)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(20)),


                          ),

                          validator: (val) {
                            if (val == "") {
                              return "value is null";
                            }
                            if (val != null) {
                              if (val.length < 3) {
                                return "name must be more than 3 chars";
                              }
                              if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(val)) {
                                return "Name can only contain alphabets and spaces";
                              }
                            }
                          }
                      ),
                      TextFormField(
                        controller: _uNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "User Name",
                          labelText: "User Name",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          counterText: "20",
                          border:
                          OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(20)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(20)),


                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an User Name';
                          }
                          if (value.length < 3) {
                            return "name must be more than 3 chars";
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Password",
                          labelText: "Password",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          counterText: "20",
                          border:
                          OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(20)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(20)),


                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _phoneController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          labelText: "Phone Number",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          counterText: "20",
                          border:
                          OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(20)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(20)),


                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: DropdownButtonFormField<String>(
                          value: selectedGender,
                          onChanged: (newValue) {
                            setState(() {
                              selectedGender = newValue;
                              _genderController.text = newValue ?? '';
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'gender',
                            counterText: "  ",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          items: genderList.map((gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the gender';
                            }
                            return null;
                          },

                        ),
                      ),


                      TextFormField(
                        controller: _emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Email",
                          labelText: "Email",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          counterText: "20",
                          border:
                          OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(20)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(20)),


                        ),
                        validator: (value) {
                          RegExp emailRegex =
                          RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
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

                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _updateUser,
                        child: Text('Update'),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.brown[300])),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}}
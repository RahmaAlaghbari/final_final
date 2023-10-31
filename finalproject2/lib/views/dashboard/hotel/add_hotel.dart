import 'dart:ffi';

import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:typed_data';

// import 'package:image_picker/image_picker.dart';
import 'package:project4/repository/hotel_repo.dart';

import '../../../CustomPages/appbar.dart';
import '../../../models/hotel_model.dart';


//
// selectImageFromGallery() async {
//   XFile? file = await ImagePicker()
//       .pickImage(source: ImageSource.gallery, imageQuality: 10);
//   if (file != null) {
//     return file.path;
//   } else {
//     return '';
//   }
// }
String? selectedCat;
final catList = ['Luxury Hotels', 'Business Hotels','Resort Hotels'];

class hotelAdd extends StatefulWidget {
  const hotelAdd({Key? key}) : super(key: key);

  @override
  State<hotelAdd> createState() => _hotelAdd();
}

class _hotelAdd extends State<hotelAdd> {
  @override


  String selectedImagePath = 'jhgggj';

  bool loading=false;
  bool iserror=false;
  bool issuccess=false;
  String error="";
  var nameCtr=TextEditingController();

  var descnmaeCtr=TextEditingController();
  var descriptionCtr=TextEditingController();
  var priceCtr=TextEditingController();
  var locationCtr=TextEditingController();
  var catCtr=TextEditingController();
 // var avatarCtr=TextEditingController();




  var formKey=GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  customAppBar(context,'Add New Hotel'),
      body: 
      Form(key: formKey,child:
      SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 10),
            SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(

                controller: nameCtr,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Name",
                  labelText: "Name",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  counterText: "20",
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
                        return "name must be more than 3 chars";
                      }
                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(val)) {
                        return "Name can only contain alphabets and spaces";
                      }

                    }

                  }

              ),
            ),//name
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(

                controller: descnmaeCtr,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Desdescription Name",
                  labelText: "Desdescription Name",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  counterText: "20",
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
                        return "Desdescription Name must be more than 3 chars";
                      }
                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(val)) {
                        return "Desdescription Name can only contain alphabets and spaces";
                      }

                    }

                  }

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(

                controller: descriptionCtr,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "description",
                  labelText: "desdescription",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  counterText: "20",
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
                        return "Desdescription must be more than 3 chars";
                      }


                    }

                  }


              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DropdownButtonFormField<String>(
                value: selectedCat,
                onChanged: (newValue) {
                  setState(() {
                    selectedCat = newValue; // Update the selected permission value
                    catCtr.text = newValue ?? ''; // Assign the selected permission to the _perController
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                items: catList.map((Category) {
                  return DropdownMenuItem<String>(
                    value: Category,
                    child: Text(Category),
                  );
                }).toList(),
                  validator: (val) {
                    if (val == "") {
                      return "value is null";
                    }
                  }
              ),
            ),



            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(

                controller: priceCtr,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "price",
                  labelText: "price",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  counterText: "20",
                  border:
                  OutlineInputBorder(borderSide:BorderSide(color: Colors.amber),
                      borderRadius: BorderRadius.circular(20)),
                  errorBorder:  OutlineInputBorder(borderSide:BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(20)),



                ),
                validator: (val){
                  if(val == ""){
                    return "value is null";}

                }
                ,

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(

                controller: locationCtr,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "location",
                  labelText: "location",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  counterText: "20",
                  border:
                  OutlineInputBorder(borderSide:BorderSide(color: Colors.amber),
                      borderRadius: BorderRadius.circular(20)),
                  errorBorder:  OutlineInputBorder(borderSide:BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(20)),



                ),


                validator: (val){
                  if(val == ""){
                    return "value is null";}
                  if(val != null){
                    if(val.length <3){
                      return "location must be more than 3 chars";
                    }

                  }
                }
                ,

              ),
            ),





            if (loading) CircularProgressIndicator() else TextButton(onPressed: ()async{
              if(formKey.currentState!.validate()){
                try{
                  setState(() {
                    loading=true;
                    issuccess=false;
                    iserror=false;

                  });
                var data={
                "name":nameCtr.text,
                  "avatar":"https://th.bing.com/th/id/R.ce43f7e8e0571c21e762b8924aad874d?rik=0ATDeAN%2bQ7cyxQ&riu=http%3a%2f%2ftravelji.com%2fwp-content%2fuploads%2fHotel-Tips.jpg&ehk=LzuGeOKqbj3J7q%2f%2fldexRjd2c0yRmq%2b%2fypHlVvmA3dM%3d&risl=&pid=ImgRaw&r=0",

                "descnmae":descnmaeCtr.text,
                "description":descriptionCtr.text,
                "price":priceCtr.text,
                "location":locationCtr.text,
                "cat":catCtr.text,



                };
                var addRes=await HotelRepository().addd(HotelModel.fromJson(data));
                if(addRes!=true){
                setState(() {
                loading=false;
                issuccess=true;
                iserror=false;
                error="";

                });
                Navigator.of(context).pop(true);
                }
                else{
                setState(() {
                  loading=false;
                  issuccess=false;
                  iserror=true;
                  error="Operation failed!!";

                });
                  }
                          }

                catch(e){
                  setState(() {
                    loading=false;
                    issuccess=false;
                    iserror=true;
                    error="Exception: ${e}";

                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('$error'),backgroundColor:Colors.brown[300],
                    //   ),
                    // );

                  });
                }
                }

              }





                , child: Text("send",style: TextStyle(color: Colors.white))  , style: ElevatedButton.styleFrom(
    primary: Colors.black54,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    ),
    padding: EdgeInsets.symmetric(vertical: 16.0),

    ),),
            iserror?Text("error:${error}",style: TextStyle(color: Colors.red),):SizedBox(),
            issuccess?Text("Added successfully",style: TextStyle(color: Colors.green),):SizedBox()




          ],
        ),
      ),),
    );
  }
}



import 'dart:io';

import 'package:flutter/material.dart';

import '../../../CustomPages/appbar.dart';
import '../../../models/user_model.dart';
import '../../../repository/user_repo.dart';
import '../../../repository/reservation_repo.dart';
import 'add_user.dart';
import 'delete_user.dart';
import 'edit_user.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserView();
}

class _UserView extends State<UserView> {
  final ReservationRepository reservationRepository = ReservationRepository();

  @override
  Widget build(BuildContext context) {
    return
      RefreshIndicator(
        onRefresh: ()async{
          setState(() {

          });
        },
        child: Scaffold(
          appBar:   customAppBar(context,'Users'),
          floatingActionButton: FloatingActionButton(child: Icon(Icons.add),backgroundColor: Colors.black54,
              onPressed: ()async{
                var isAdd=await  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => userAdd()),
                );
                if(isAdd!=null && isAdd==true){
                  setState(() {

                  });
                }
              }),

          body: Container(

            child: FutureBuilder<List<UserModel>>(
            future: UserRepository().getAll(),

            builder: (context,snapshot){
              if(snapshot.connectionState ==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }

              else if(snapshot.connectionState ==ConnectionState.done){
                if(snapshot.hasError)
                  return Center(child: Text("Error ${snapshot.error.toString()}"));
                else if(snapshot.hasData){
                  var list=snapshot.data??[];
                  // Sort the list based on a specific property (e.g., fName)
                  // list.sort((a, b) => a.fName.compareTo(b.fName!));

                  return Container(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final File _imgFile = File(list[index].img!);
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0), // Increase the vertical padding
                          leading: list[index].img == ''
                              ? Container(
                            child: Icon(Icons.image),
                            width: 50,
                            height: 50,
                          )
                              :  CircleAvatar(
                        backgroundImage: list[index].img == 'assets/person.jpg'
                        ? AssetImage('${list[index].img}') as ImageProvider<Object>?
                            : _imgFile != null ? FileImage(_imgFile) : null,
                        ),
                          title: Text(
                            "${list[index].fName}",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "${list[index].email}",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                "${list[index].gender}",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  // Handle the update action here
                                  // For example, navigate to the update screen
                                  var isUpdated = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UserUpdate(
                                        userId: list[index].id.toString(),
                                      ),
                                    ),
                                  );
                                  if (isUpdated != null && isUpdated == true) {
                                    setState(() {});
                                  }
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 24,
                                  color: Colors.black45,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await  reservationRepository.deleteReservationsForUser(list[index].id!);

                                  print(list[index].id);
                                  var delRes = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return UserDelete(itemId: list[index].id.toString());

                                    },
                                  );
                                  print(list[index].id);


                                      setState(() {});



                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 24,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: list.length,
                    ),
                  );
                }
                else{
                  return Center(child: Text("Error ${snapshot.error.toString()}"));

                }

              }
              else{
                return Center(child: Text("Error ${snapshot.error.toString()}"));

              }

            },),),
        ),
      );
  }
}

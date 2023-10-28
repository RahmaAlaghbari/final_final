import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../CustomPages/appbar.dart';
import '../../../models/hotel_model.dart';
import '../../../repository/hotel_repo.dart';
import 'add_hotel.dart';
import 'delete_hotel.dart';
import 'edit_hotel.dart';


class HotelView extends StatefulWidget {
  const HotelView({Key? key}) : super(key: key);

  @override
  State<HotelView> createState() => _HotelView();
}

class _HotelView extends State<HotelView> {
  @override
  Widget build(BuildContext context) {
    return
      RefreshIndicator(
        onRefresh: ()async{
          setState(() {

          });
        },
        child: Scaffold(
          appBar:   customAppBar(context,'Hotels'),
          floatingActionButton: FloatingActionButton(child: Icon(Icons.add,),backgroundColor: Colors.black54,
              onPressed: ()async{
                var isAdd=await  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => hotelAdd()),
                );
                if(isAdd!=null && isAdd==true){
                  setState(() {

                  });
                }
              }),

          body: Container(
            child: FutureBuilder<List<HotelModel>>(
              future: HotelRepository().getAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError)
                    return Center(child: Text("Error ${snapshot.error.toString()}"));
                  else if (snapshot.hasData) {
                    var list = snapshot.data ?? [];
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: list[index].avatar == ''
                                        ? Container(
                                      child: Icon(Icons.image),
                                      width: 50,
                                      height: 50,
                                    )
                                        : Image.network(
                                      list[index].avatar!,
                                      width: double.infinity,
                                      height: 150.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${list[index].name}",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${list[index].price}',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '${list[index].cat}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: ()  async {
                                    // Handle the update action here
                                    // For example, navigate to the update screen
                                    var isUpdated =
                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => HotelUpdate(
                                          hotelId: list[index].id.toString(),
                                        ),
                                      ),
                                    );
                                    if (isUpdated != null &&
                                        isUpdated == true) {
                                      setState(() {});
                                    }
                                  },

                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.black45,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    print(list[index].id);
                                    var delRes = await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return HotelDelete(itemId: list[index].id.toString());
                                      },
                                    );
                                    if (delRes != null && delRes == true) {
                                      setState(() {});
                                    }
                                  },


                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: list.length,
                    );
                  } else {
                    return Center(child: Text("Error ${snapshot.error.toString()}"));
                  }
                } else {
                  return Center(child: Text("Error ${snapshot.error.toString()}"));
                }
              },
            ),
          ),
        ),
      );
  }
}

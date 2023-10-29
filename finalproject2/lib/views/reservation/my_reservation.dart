import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../CustomPages/appbar.dart';
import '../../models/hotel_model.dart';
import '../../models/reservation_model.dart';
import '../../repository/authontication.dart';
import '../../repository/hotel_repo.dart';
import '../../repository/reservation_repo.dart';
import 'delete_res.dart';

class MyReservations extends StatefulWidget {
  @override
  State<MyReservations> createState() => _MyReservationsState();
}

class _MyReservationsState extends State<MyReservations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context,'My Reservation'),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              HotelCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class HotelCard extends StatefulWidget {
  @override
  State<HotelCard> createState() => _HotelCardState();
}class _HotelCardState extends State<HotelCard> {
  Future<List<ReservationModel>?> _fetchReservations(String userid) async {
    try {
      List<ReservationModel> reservations = await ReservationRepository().getByField('userid', AuthenticationProvider.iduser!);
      if (reservations.isNotEmpty) {
        return reservations;
      }
      return null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e.toString()'),backgroundColor:Colors.brown[300]),);
      // Handle the error gracefully, e.g., display an error message
      return null;
    }
  }

  Future<HotelModel?> _fetchHotel(String hotelId) async {
    try {
      HotelModel? hotel = await HotelRepository().getById(hotelId);
      return hotel;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e.toString()'),backgroundColor:Colors.brown[300]),);
      // Handle the error gracefully, e.g., display an error message
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        color: Colors.white,
        child: FutureBuilder<List<ReservationModel>?>(
          future: _fetchReservations(AuthenticationProvider.iduser!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text("Error ${snapshot.error.toString()}"));
              } else if (snapshot.hasData && snapshot.data != null) {
                List<ReservationModel> reservations = snapshot.data!;
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    ReservationModel reservation = reservations[index];
                    return FutureBuilder<HotelModel?>(
                      future: _fetchHotel(reservation.hotelid!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Center(child: Text("Error ${snapshot.error.toString()}"));
                          } else {
                            HotelModel hotel = snapshot.data ?? HotelModel();
                            return Container(
                              child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    print("#################################${AuthenticationProvider.idhotel}");
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${hotel.name}",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${hotel.price}',
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
                                          '${reservation.fromdate} -> ${reservation.todate}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        RatingBar.builder(
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 24,
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            // Handle rating update
                                          },
                                        ),



                                        Row(mainAxisSize: MainAxisSize.min,
                                          children: [



                                            IconButton(
                                              onPressed: () async {
                                                print(reservation.id);
                                                var delRes = await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return resDelete(itemId: reservation.id!);
                                                    },
                                                );
                                                if (delRes != null && delRes == true) {
                                                  setState(() {});
                                                }
                                              },
                                              icon: Icon(Icons.delete,),
                                            ),
                                          ],
                                        )







                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        } else {
                          return Center(child: Text("Errorloading hotel data"));
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16.0);
                  },
                  itemCount: reservations.length,
                );
              }else {
                return  Center(
                  child: Column(

                    children: [
                      SizedBox(height: 300.0),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // Adjust the color as per your preference
                        ),

                        padding: EdgeInsets.all(20),
                        child: Text(
                          "No data available",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45, // Adjust the color as per your preference
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return  Center(
                child: Column(

                  children: [
                    SizedBox(height: 300.0),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // Adjust the color as per your preference
                      ),

                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Error loading data",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45, // Adjust the color as per your preference
                        ),
                      ),
                    ),




                  ],
                ),
              );
            }
          },
        ),
      );
  }
}
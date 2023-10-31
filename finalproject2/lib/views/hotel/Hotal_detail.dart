import 'package:flutter/material.dart';
import '../../CustomPages/appbar.dart';
import '../../CustomPages/configuration.dart';
import '../../repository/authontication.dart';
import '../reservation/add_reservation.dart';

class HotelDetailsPage extends StatefulWidget {
  @override
  State<HotelDetailsPage> createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  Future<void> refreshPage() async {
    // Simulate an asynchronous operation to refresh the page
    await Future.delayed(Duration(seconds: 6));

    setState(() {
      // Update the necessary data or perform any other actions
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshPage,
      child: Scaffold(
        appBar: customAppBar(context, 'Details'),
        body: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 160),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Hero(
                          tag: 1,
                          child: Transform.scale(
                            scaleX: 3.2,
                            scaleY: 5, // Increase the scale factor as desired
                            child:
                            Image.network('${AuthenticationProvider.avatarhotel}',fit: BoxFit.cover,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      refreshPage();
                      // Handle the onTap action here
                      // For example, you can show a dialog or perform a specific action
                    },
                    child: Text(
                      '${AuthenticationProvider.namehotel}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  )
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 120,
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.pink
                            .,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReservationPage(),
                                ),
                              );
                              // Handle the onTap action here
                              // For example, navigate to a new page or perform a specific action
                            },
                            child: Text(
                              'Book Now!!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
              ),
            ),


            // Add description, location, and price here
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(top: 430),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description:',
                      style: TextStyle(color: Colors.brown[300],

                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${AuthenticationProvider.descriptionhotel}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Location:',
                      style: TextStyle(color: Colors.brown[300],

                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${AuthenticationProvider.locationhotel}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Price:',
                      style: TextStyle(
                        color: Colors.brown[300],

                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${AuthenticationProvider.pricehotel}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../CustomPages/appbar.dart';
import '../../models/comp_model.dart';
import '../../models/hotel_model.dart';
import '../../models/reservation_model.dart';
import '../../models/user_model.dart';
import '../../repository/comp_repo.dart';
import '../../repository/hotel_repo.dart';
import '../../repository/reservation_repo.dart';
import 'comp_view.dart';
import 'hotel/hotels.dart';
import 'reservation/reservation_view.dart';
import 'users/users.dart';

import '../../../repository/user_repo.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final UserRepository userRepository = UserRepository();
  final HotelRepository hotelRepository = HotelRepository();
  final ReservationRepository resRepository = ReservationRepository();
  final CompRepository compRepository = CompRepository();

  int userCount = 0;
  int hotelCount = 0;
  int resCount = 0;
  int compCount = 0;
 // Variable to store the user count
  @override
  void initState() {
    super.initState();
    getUserCount();
    gethotelCount();// Call the method to get the user count when the view is initialized
    getresCount();// Call the method to get the user count when the view is initialized
    getcompCount();// Call the method to get the user count when the view is initialized
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:   customAppBar(context,'Hotels'),

      body: RefreshIndicator(
        onRefresh: ()async{
          setState(() {

          });
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: DashboardCard(
                        title: 'Hotels',
                        value: hotelCount.toString(),
                        color: Colors.blue,
                        icon: Icons.hotel,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HotelView(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: DashboardCard(
                        title: 'Users',
                        value: userCount.toString(),
                        color: Colors.orange,
                        icon: Icons.person,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserView(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: DashboardCard(
                        title: 'Reservations',
                        value: resCount.toString(),
                        color: Colors.green,
                        icon: Icons.calendar_today,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Reservations(),
                            ),
                          );
                        },
                      ),
                    ),


              SizedBox(width: 16.0),

              Expanded(
                child: DashboardCard(
                  title: 'Complaints',
                  value: compCount.toString(),
                  color: Colors.red,
                  icon: Icons.edit,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompColumn(),
                      ),
                    );
                  },
                ),
              ),
                  ],
                ),  ),
            ],

          ),

        ),
      ),
    );
  }



  Future<void> getUserCount() async {
    try {
      List<UserModel> userList = await userRepository.getAll();
      setState(() {
        userCount = userList.length; // Update the user count
      });
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting user count: $ex'),backgroundColor:Colors.brown[300]),);
    }
  }
  Future<void> gethotelCount() async {
    try {
      List<HotelModel> hotelList = await hotelRepository.getAll();
      setState(() {
        hotelCount = hotelList.length; // Update the user count
      });
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting Hotel count: $ex'),backgroundColor:Colors.brown[300]),);
    }
  }
  Future<void> getresCount() async {
    try {
      List<ReservationModel> hotelList = await resRepository.getAll();
      setState(() {
        resCount = hotelList.length; // Update the user count
      });
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting Reservation count: $ex'),backgroundColor:Colors.brown[300]),);
    }
  }
  Future<void> getcompCount() async {
    try {
      List<CompModel> hotelList = await compRepository.getAll();
      setState(() {
        compCount = hotelList.length; // Update the user count
      });
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting Complaints count: $ex'),backgroundColor:Colors.brown[300]),);
    }
  }

}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              SizedBox(height: 16.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
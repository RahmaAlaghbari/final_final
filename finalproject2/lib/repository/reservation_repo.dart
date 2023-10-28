
import 'package:dio/dio.dart';

import '../models/hotel_model.dart';
import '../models/reservation_model.dart';
import '../views/reservation/my_reservation.dart';


class ReservationRepository{
  late Dio dio ;
  ReservationRepository(){
    dio = Dio();
    dio.options.connectTimeout = Duration(seconds: 10);
    dio.options.responseType = ResponseType.json;
  }

  Future<List<ReservationModel>> getAll()async{

    try{
      // await Future.delayed(Duration(milliseconds: 300));
      var res = await dio.get('https://652b9ff8d0d1df5273ee8a8e.mockapi.io/hotels2/reservation');
      List<ReservationModel> items = [];
      if(res.statusCode == 200){
        var data = res.data as List;
        if(data.isNotEmpty){
          for (var e in data) {
            items.add(ReservationModel.fromJson(e));
          }
          return items;
        }
      }

      return items;
    }
    catch(ex){
      rethrow;
    }
  }


  Future<ReservationModel?> getById(String id) async {
    try {
      var apiUrl = 'https://652b9ff8d0d1df5273ee8a8e.mockapi.io/hotels2/reservation/$id';
      var response = await dio.get(apiUrl); // Make the API request using Dio

      if (response.statusCode == 200) {
        var res = response.data;

        return  ReservationModel.fromJson(res);
      }

      return null;
    }  catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<Object> addd(ReservationModel obj)async{
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${obj}");
    try{

      await Future.delayed(Duration(milliseconds: 3000));
      var addRes = await dio.post('https://652b9ff8d0d1df5273ee8a8e.mockapi.io/hotels2/reservation', data: obj.toJson());
      print("###########################################add res: ${addRes}");
      if (addRes.statusCode == 200) {

        var data = addRes.data;
        var prod = ReservationModel.fromJson(data);

        if(prod != null){
          return prod.id??0;



        }
        else{
          return 0;
        }
      }

      return 0;
    }
    catch(ex){
      rethrow;
    }
  }
  Future<List<ReservationModel>> getByField(String fieldName, String fieldValue) async {
    try {
      var apiUrl = 'https://652b9ff8d0d1df5273ee8a8e.mockapi.io/hotels2/reservation';
      var response = await dio.get(apiUrl); // Make the API request using Dio

      if (response.statusCode == 200) {
        var res = response.data;
        List<ReservationModel> reservations = [];

        for (var item in res) {
          if (item[fieldName] == fieldValue) {
            reservations.add(ReservationModel.fromJson(item));
          }
        }

        return reservations;
      }

      return [];
    }  catch (e) {
      print('Error: $e');
      rethrow;
    }
  }


  Future<Object> deletee(String hotelId) async {
    try {
      await Future.delayed(Duration(milliseconds: 300));
      var deleteRes = await dio.delete(
        'https://652b9ff8d0d1df5273ee8a8e.mockapi.io/hotels2/reservation/$hotelId',
      );
      print("###########################################delete res: $deleteRes");
      if (deleteRes.statusCode == 200) {
        var data = deleteRes.data;
        var prod = ReservationModel.fromJson(data);
        if (prod != null) {
          return prod.id ?? 0;
        } else {
          // Handle error response or unexpected data
          throw Exception('Unexpected response data');
        }
      } else {
        // Handle error response
        throw Exception('Failed to delete Hotel');
      }
    } catch (ex) {
      rethrow;
    }
  }
  Future<void> deleteReservationsForUser(String userId) async {
    try {
      // Retrieve reservations for the specified user
      List<ReservationModel> userReservations = await getByField('userId', userId.toString());
        print(userReservations);
      // Delete each reservation associated with the user
      for (var reservation in userReservations) {
        await deletee(reservation.id.toString());
      }
    } catch (ex) {
      // Handle any errors that occur during the process
      print('Error deleting user reservations: $ex');
    }
  }
}
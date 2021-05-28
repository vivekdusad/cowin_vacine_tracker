import 'package:cowin_vaccine_tracker/models/pincode.dart';
import 'package:cowin_vaccine_tracker/web/server.dart';

class PinCodeRepo {
  final Server server;
  PinCodeRepo(this.server);

  
  // Future<PinCodeModel> getPincodeData(String pincode) async{
  //   return await server.getFindByPin(pincode);
  // }
}

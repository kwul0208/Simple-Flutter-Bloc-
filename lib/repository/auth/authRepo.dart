import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRepository{
  login(String email, String pass)async{
    try {
      var res = await http.post(Uri.parse("https://api.escuelajs.co/api/v1/auth/login"),
        headers: {},
        body: {"email": "john@mail.com", "password": "changeme"}
      );

      final Map data = jsonDecode(res.body);
      print("data");
      print(data);
      if(data.containsKey("access_token")){
        print("1");
        return {"status": true, "data": data};
      }else{
        print("2");
        return {"status": false ,"message": data['message']};
      }
    } catch (e) {
      return {"status": false ,"message": "Sorry, network error!"};
    }
  }
}
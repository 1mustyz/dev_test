import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
class Service {
  Service();
  Future<String> getJson()  {
    return rootBundle.loadString('transactions.json');
  }

  dynamic getData ()async {
    var my_data = await json.decode(await getJson());
    // print(my_data);
    return(my_data);
  }

}
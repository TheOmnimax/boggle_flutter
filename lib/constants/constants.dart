import 'package:rflutter_alert/rflutter_alert.dart';

export 'enums.dart';
export 'regex.dart';
export 'theme_data.dart';

// const baseUrl = 'https://boggle-347503.uc.r.appspot.com/'; // Real app
const baseUrl = 'http://127.0.0.1:8000/'; // Web testing
// const baseUrl = 'http://localhost:8000/';
// const baseUrl = 'http://10.0.2.2:8000/'; // Android testing

const sendHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Content-Type': 'application/json; charset=UTF-8',
};

const popupStyle = AlertStyle(
  animationDuration: Duration(seconds: 0),
);

import 'package:flutter/material.dart';

navigateTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}

navigatePop(BuildContext context) {
  Navigator.pop(context);
}

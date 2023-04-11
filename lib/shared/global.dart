library config.globals;

import 'package:flutter/material.dart';

const kLargeScreenBreakpoint = 1000;

bool isDekstop(BuildContext context) {
  return MediaQuery.of(context).size.width > kLargeScreenBreakpoint;
}

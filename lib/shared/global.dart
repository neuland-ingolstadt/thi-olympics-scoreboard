library config.globals;

import 'package:flutter/material.dart';

const kLargeScreenBreakpoint = 700;

bool isDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width > kLargeScreenBreakpoint;
}

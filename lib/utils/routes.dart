import 'package:contact_info/screen/addData/add_data_screen.dart';
import 'package:contact_info/screen/details/details_screen.dart';
import 'package:contact_info/screen/home/home_screen.dart';
import 'package:contact_info/screen/splesh/splesh_screen.dart';
import 'package:flutter/cupertino.dart';

Map <String,WidgetBuilder> myRouts={
  "/":(context) => const SpleshScreen_(),
  "home":(context) => const HomeScreen(),
  "add":(context) => const AddDataScreen(),
  "view":(context) => const DetailsScreen(),
};
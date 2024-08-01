import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CityTextField extends StatelessWidget {
  final Color myClr;
  final TextEditingController myController;
  const CityTextField({super.key, required this.myClr, required this.myController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 250,
        child: TextFormField(
          controller: myController,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: myClr),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: myClr,
              ),
            ),
            prefixIcon: Icon(
              Icons.location_on,
              color: myClr,
            ),
            hintText: "Enter your Name",
            hintStyle: TextStyle(color: myClr),
          ),
          style:
              GoogleFonts.oxygen(fontSize: 25, fontWeight: FontWeight.w500 ,color: myClr),
        ));
  }
}

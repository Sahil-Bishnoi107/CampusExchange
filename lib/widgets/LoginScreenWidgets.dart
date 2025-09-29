import 'package:flutter/material.dart';


class LoginOption extends StatefulWidget {

  double iconsize;
  String text;
  IconData icon;
  VoidCallback myaction;
   LoginOption({super.key,required this.icon,required this.text,required this.iconsize,required this.myaction});

  @override
  State<LoginOption> createState() => _LoginOptionState();
}

class _LoginOptionState extends State<LoginOption> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: screenHeight * 0.056,
        width: screenWidth * 0.85,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400,width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon,size: widget.iconsize,),
            SizedBox(width: screenWidth * 0.02),
             Text(
              widget.text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}


class Button extends StatefulWidget {
  final String text;
  const Button({super.key, required this.text});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        height: screenHeight * 0.056,
        width: screenWidth * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(70, 150, 216, 1)
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      width: screenWidth * 0.85,
      height: screenHeight*0.056,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.top,
        
        decoration: InputDecoration(
          
          contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.00,
            horizontal: screenWidth * 0.04,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

Widget midline(){
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    child: Row(
      children: [
        Expanded(child: Container(height: 1.5,color: Colors.grey,)),
        Container(
          alignment: Alignment.center,
          child: Text("   OR   ")),
        Expanded(child: Container(height: 1.5,color: Colors.grey,) )
      ],
    ),
  );
}

Widget forgotpassword(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text("Forgot Password?",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
    ],
  );
}
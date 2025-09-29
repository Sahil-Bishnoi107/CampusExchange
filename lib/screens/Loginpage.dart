
import 'package:ecommerceapp/services/UserAuth.dart';
import 'package:ecommerceapp/widgets/loginscreenwidgets.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: height,width: width,
        alignment: Alignment.center,
        child: Container(
          width: width*0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*0.12,),
             // Image.asset('assets/images/logo.png',height: 100,width: 100,),
              Container(width: width * 0.9,child: Text("WELCOME TO CAMPUS EXCHANGE!",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),)),
              SizedBox(height: height*0.04,),
              TextFieldWidget(hintText: "Email or Username", controller: namecontroller),
              TextFieldWidget(hintText: "Password", controller: passwordcontroller),
              forgotpassword(),
              GestureDetector(
                onTap: () {
                 signInWithEmail(email: namecontroller.text, password: passwordcontroller.text,context: context);
                },
                child: Button(text: "Login")),
             // SizedBox(height: 15,),
              midline(),
             // SizedBox(height: 20,),
              LoginOption( icon: FontAwesome.google_brand, text: "Continue with Google", iconsize: 20,myaction:() => signInWithGoogle(context)),
              LoginOption( icon: Bootstrap.apple, text: "Continue with Apple", iconsize: 20, myaction: notavailable,),
              LoginOption( icon: IonIcons.logo_facebook, text: "Continue with Facebook", iconsize: 25,myaction: () => signInWithFacebook(context),),
              GestureDetector(
                onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_) => RegisterPage())),
                child: LoginOption( icon:Icons.email_sharp, text: "Signup with Email", iconsize: 20,myaction:() => Navigator.push(context,MaterialPageRoute(builder: (_) => RegisterPage())))),
          
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usrname = TextEditingController();
  TextEditingController pas = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
         height: height,width: width,
        alignment: Alignment.center,
        child: Container(
          width: width*0.85,
          child: Column(
            children: [
              SizedBox(height: height*0.04,),
              Container(
                alignment: Alignment.centerLeft,
                width: width,
                child: GestureDetector(
                  onTap:() => Navigator.pop(context),
                  child: Icon(Icons.arrow_back,size: 40,)),
              ),
              SizedBox(height: height*0.04,),
              Text("REGISTER NEW USER!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32),),
              SizedBox(height: height*0.05,),
              TextFieldWidget(hintText: "Username", controller: usrname),
              TextFieldWidget(hintText: "Email", controller: email),
              TextFieldWidget(hintText: "Phone No", controller: phone),
              TextFieldWidget(hintText: "Password", controller: pas),
              GestureDetector(
                onTap: () async =>await  signUpWithEmail(email :email.text,password:  pas.text),
                child: Button(text: "Register"))
            ],
          ),
        ),
      ),
    );
  }
}
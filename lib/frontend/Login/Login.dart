import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radio/frontend/Login/Signin.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double radius = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          color: Color(0xFF283149),
        ),
        child: Stack(
          children: [
            Positioned(
                top: -radius,
                left: -radius,
                child: CircleAvatar(
                  backgroundColor: Color(0xFF21293E),
                  radius: radius,
                )),
            Positioned(
                bottom: -radius,
                right: -radius,
                child: CircleAvatar(
                  backgroundColor: Color(0xFF21293E),
                  radius: radius,
                )),
            Positioned(
              top: MediaQuery.sizeOf(context).height/2 - 300,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 8),
                color: Colors.transparent,
                height: 600,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/library/login.jpg'),
                      radius: 150,
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(0)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left:60,right: 60),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.transparent,
                          border: Border.all(
                            color: Color(0xFF404B69), // Màu sắc của đường viền
                            width: 2, // Độ dày của đường viền
                          ),
                        ),
                        child: Text('Sign in',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF3EA513)
                          ),
                        ),

                      ),
                    ),
                    SizedBox(height: 30,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(1)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left:60,right: 60),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Color(0xFF3EA513).withOpacity(0.9),
                        ),
                        child: Text('Sign up',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.9)
                          ),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

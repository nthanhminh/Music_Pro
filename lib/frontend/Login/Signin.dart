import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radio/frontend/API/API.dart';
import 'package:radio/frontend/User/UserSession.dart';

class Signin extends StatefulWidget {
  Signin(this.initialIndex);
  int initialIndex = 1;
  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> with SingleTickerProviderStateMixin {
  double radius = 250;
  String name_signin = '';
  String password_signin  = '';
  String name_signup = '';
  String password_signup = '';
  int current_index = 0;
  String mes = '';
  API api = API();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    current_index = widget.initialIndex;
    _tabController = TabController(length: 2, vsync: this,initialIndex: widget.initialIndex);
    _tabController.addListener((){
      print(_tabController.index);
      setState(() {
        current_index = _tabController.index;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
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
                      Container(
                        child:TabBar(
                          controller: _tabController,
                          labelColor: Colors.black,
                          // unselectedLabelColor: Colors.red,
                          // indicatorColor: Colors.red.withOpacity(0.6),
                          //Đổi màu thanh trượt ở đây
                          indicatorColor: Colors.green,
                          dividerColor: Colors.transparent,
                          tabs: [
                            Tab(
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: current_index == 0 ? Colors.white.withOpacity(0.8) : Colors.grey.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                ), // Điều chỉnh kích thước văn bản ở đây
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: current_index == 1 ? Colors.white.withOpacity(0.8) : Colors.grey.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                ), // Điều chỉnh kích thước văn bản ở đây
                              ),
                            ),
                          ],
                        ),
                      ), Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Container(
                              padding:EdgeInsets.only(left: 32,right: 32),
                              margin: EdgeInsets.only(top: 64, bottom: 32),
                              child: Column(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Name',
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.white.withOpacity(0.45),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 18 , horizontal: 32),
                                      hintStyle: TextStyle(
                                        fontStyle: FontStyle.italic, // Kiểu chữ của gợi ý
                                        color: Colors.grey, // Màu sắc của gợi ý
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFF404B69)), // Màu sắc của đường viền
                                        borderRadius: BorderRadius.circular(10), // Độ cong của đường viền
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 18,
                                    ),
                                    onChanged: (text){
                                      setState(() {
                                        name_signin = text;
                                      });
                                    },
                                    onTap: (){
                                      setState(() {
                                        mes = '';
                                      });
                                    },
                                  ),
                                  SizedBox(height: 28,),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      prefixIcon: Icon(
                                        Icons.key,
                                        color: Colors.white.withOpacity(0.45),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 18 , horizontal: 32),
                                      hintStyle: TextStyle(
                                        fontStyle: FontStyle.italic, // Kiểu chữ của gợi ý
                                        color: Colors.grey, // Màu sắc của gợi ý
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFF404B69)), // Màu sắc của đường viền
                                        borderRadius: BorderRadius.circular(10), // Độ cong của đường viền
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 18,
                                    ),
                                    onChanged: (text){
                                      setState(() {
                                        password_signin = text;
                                      });
                                    },
                                    onTap: (){
                                      setState(() {
                                        mes = '';
                                      });
                                    },
                                  ),
                                  SizedBox(height: 12,),
                                  Container(
                                    child: Text(
                                      mes,
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 60,),
                                  GestureDetector(
                                    onTap: () async {
                                      var respone = await api.login(name_signin, password_signin);
                                      if(respone != "Invalid name" && respone!= "Invalid password")
                                        {
                                          print(respone);
                                          int userId = int.tryParse(respone) ?? 0;
                                          UserSession().setUserId(userId);
                                          print(userId);
                                          Navigator.pushNamed(context, '/Home');
                                        }
                                      else{
                                        setState(() {
                                          mes = respone;
                                        });
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: 60,right: 60),
                                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color: Color(0xFF3EA513).withOpacity(0.9),
                                      ),
                                      child: Text('Sign in',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white.withOpacity(0.9)
                                        ),
                                      ),

                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:EdgeInsets.only(left: 32,right: 32,),
                              margin: EdgeInsets.only(top: 64, bottom: 32),
                              child: Column(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Name',
                                      prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.white.withOpacity(0.45),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 18 , horizontal: 32),
                                      hintStyle: TextStyle(
                                        fontStyle: FontStyle.italic, // Kiểu chữ của gợi ý
                                        color: Colors.grey, // Màu sắc của gợi ý
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFF404B69)), // Màu sắc của đường viền
                                        borderRadius: BorderRadius.circular(10), // Độ cong của đường viền
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 18,
                                    ),
                                    onChanged: (text){
                                      setState(() {
                                        name_signup = text;
                                      });
                                    },
                                    onTap: (){
                                      setState(() {
                                        mes = '';
                                      });
                                    },
                                  ),
                                  SizedBox(height: 28,),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      prefixIcon: Icon(
                                        Icons.key,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 18 , horizontal: 32),
                                      hintStyle: TextStyle(
                                        fontStyle: FontStyle.italic, // Kiểu chữ của gợi ý
                                        color: Colors.grey, // Màu sắc của gợi ý
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFF404B69)), // Màu sắc của đường viền
                                        borderRadius: BorderRadius.circular(10), // Độ cong của đường viền
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 18,
                                    ),
                                    onChanged: (text){
                                      setState(() {
                                        password_signup = text;
                                      });
                                    },
                                    onTap: (){
                                      setState(() {
                                        mes = '';
                                      });
                                    },
                                  ),
                                  SizedBox(height: 12,),
                                  Container(
                                    child: Text(
                                      mes,
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 60,),
                                  GestureDetector(
                                    onTap: () async {
                                      var res = await api.createNewUser(name_signup,password_signup);
                                      if(res == 'User created successfully:')
                                        {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signin(0)));
                                        }
                                      else
                                        {
                                          setState(() {
                                            mes = res;
                                          });
                                        }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: 60,right: 60),
                                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color: Color(0xFF3EA513).withOpacity(0.9),
                                      ),
                                      child: Text('Sign up',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white.withOpacity(0.9)
                                        ),
                                      ),

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

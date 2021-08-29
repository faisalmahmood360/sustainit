import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/ApiManager/ApiManager.dart';
import 'package:foodapp/screens/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _contactKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Builder(
              builder: (context) => IconButton(
                icon: SvgPicture.asset('assets/images/back_icon.svg'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
        ),
        body: Form(
          key: _contactKey,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 40),
                      child: Text(
                        'Contact Us',
                        style:
                            TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                      )),
                  Container(
                      alignment: Alignment.center,
                      child: Text('How can we help you?')),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffFAFAFA),
                        contentPadding: EdgeInsets.only(left: 10),
                        labelText: 'First Name',

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffFAFAFA),
                        contentPadding: EdgeInsets.only(left: 10),
                        labelText: 'Email Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      maxLength: 800,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffFAFAFA),
                        // contentPadding: EdgeInsets.only(left: 10, top: 0),
                        labelText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 20.0),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                            textColor: Colors.white,
                            color: Color(0xff50E569),
                            child: Text('Send Message'),
                            onPressed: () {

                               if(!_contactKey.currentState.validate()){
                                 return;
                               }
                               else{
                                 var firstName = nameController.text;
                                 var email = emailController.text;
                                 var description = descriptionController.text;
                                 print(firstName+email+description);
                                 contactUsSubmit(firstName,email,description);
                               }

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Home()),
                              // );
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  contactUsSubmit(firstName,email,description)async{
    var apis = ApiManager();
    Response response = await apis.contactUsApi(firstName, email, description);
    if(response.statusCode == 200){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
    }
  }
}

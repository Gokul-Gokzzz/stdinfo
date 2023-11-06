
import 'dart:io';

import 'package:flutter/material.dart';



class ViewStudentScreen extends StatelessWidget {
  final String name;
  final String age;
  final String place;
  final String phone;
  final String imagePath;

  const ViewStudentScreen({
    required this.name,
    required this.age,
    required this.place,
    required this.phone,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 56, 56, 58),
        appBar: AppBar(  flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                  Colors.black,
                   Colors.grey ,
                  ]
                  )
              ),
            ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
          backgroundColor: Colors.transparent,
          title: Text('PrOfIlE'),
          centerTitle: true,
        ),
        body: Container(decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover
            )
            ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.lightBlue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.transparent,
                      backgroundImage: FileImage(File(imagePath)),
                    ),
                  ),
                  SizedBox(height: 30),
                  CardItem(
                    title: 'Name',
                    content: name,
                     color: false,
                  ),
                  CardItem(
                    title: 'Age',
                    content: age,
                     color: true,
                  ),
                  CardItem(
                    title: 'Education',
                    content: place,
                     color: false,
                  ),
                  CardItem(
                    title: 'Address',
                    content: phone,
                   color: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final String content;
   final bool color;

  const CardItem({
    required this.title,
    required this.content,
     required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = color ? Colors.transparent : Colors.transparent;
    final textColor =
        color ?Colors.white : Colors.red;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
       color: bgColor,
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                 color: textColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold,
                    color: textColor
                   ),
            ),
          ],
        ),
      ),
    );
  }
}
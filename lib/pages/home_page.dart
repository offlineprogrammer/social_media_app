import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/widgets/home_drawer.dart';
import '/controllers/user_controller.dart';

class HomePage extends GetWidget<UserController> {
  get kTransparentImage => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffE1E5E4),
        appBar: AppBar(
          title: Text(
            'All Expenses',
          ),
          centerTitle: true,
        ),
        drawer: const HomeDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Your Expenses",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}

import 'package:cmslms/customWidgets/forText.dart';
import 'package:cmslms/utils/colors.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBgColor,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyColor, // Shadow color
                      spreadRadius: 1, // How much the shadow spreads
                      blurRadius: 5, // Softness of the shadow
                      offset: Offset(0, 3), // Position of the shadow (x, y)
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "My Profile",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.person, size: 100),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Student Name", style: MainPageUp),
                              Text("Enrollment", style: MainPageUp),
                              Text("Depart Class", style: MainPageUp),
                              Text("MS Email", style: MainPageUp),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(flex: 2, child: MainPageLowerBody()),
          ],
        ),
      ),
    );
  }
}

class MainPageLowerBody extends StatelessWidget {
  const MainPageLowerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBgColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primaryColor, width: 2),
                color: AppColors.scaffoldBgColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyColor, // Shadow color
                    spreadRadius: 2, // How much the shadow spreads
                    blurRadius: 5, // Softness of the shadow
                    offset: Offset(0, 3), // Position of the shadow (x, y)
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLigtColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 30,
                    width: double.infinity,
                    child: Center(child: Text("Alerts", style: popupheader)),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OptionTabs(
                icon_: Icon(Icons.calendar_today),
                text_: "Attandance",
              ),
              OptionTabs(icon_: Icon(Icons.assignment), text_: "Assignment"),
            ],
          ),
         
        ],
      ),
    );
  }
}

class OptionTabs extends StatelessWidget {
  final Icon icon_;
  final String text_;
  const OptionTabs({super.key, required this.icon_, required this.text_});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 20,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primaryColor, width: 2),
          color: AppColors.primaryLigtColor,

          // boxShadow: [
          //   BoxShadow(
          //     color: AppColors.greyColor, // Shadow color
          //     spreadRadius: 2, // How much the shadow spreads
          //     blurRadius: 5, // Softness of the shadow
          //     offset: Offset(0, 3), // Position of the shadow (x, y)
          //   ),
          // ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon_,
            SizedBox(height: 10),
            Text(text_, style: popupheader),
          ],
        ),
      ),
    );
  }
}

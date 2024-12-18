import 'package:cmslms/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SquareButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const SquareButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Rx<bool> loading = false.obs;
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      if (loading.value) {
                        return SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: AppColors.textWhiteColor,
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
                    SizedBox(width: 10),
                    Text(
                      text,
                      style: TextStyle(
                        color: AppColors.textWhiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

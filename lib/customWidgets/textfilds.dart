import 'package:cmslms/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class LoginFields extends StatelessWidget {
  final String labeltext;
  final bool isPassword;
  final TextEditingController textControler;
  LoginFields({
    super.key,
    required this.textControler,
    required this.labeltext,
    required this.isPassword,
  });

  Rx<bool> showPassword = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextField(
        controller: textControler,
        decoration: InputDecoration(
          label: Text(labeltext, style: TextStyle(fontSize: 20)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          suffix:
              (isPassword)
                  ? (showPassword.value)
                      ? IconButton(
                        onPressed: () {
                          showPassword.value = false;
                        },
                        icon: Icon(Icons.visibility),
                      )
                      : IconButton(
                        onPressed: () {
                          showPassword.value = true;
                        },
                        icon: Icon(Icons.visibility_off),
                      )
                  : SizedBox.shrink(),
        ),
        obscureText: (showPassword.value) ? true : false,
        obscuringCharacter: "*",
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String labelText;
  final List<Map<String, String>> options;
  final RxString selectedValue;

  CustomDropdown({
    required this.labelText,
    required this.options,
    required this.selectedValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue.value.isEmpty ? null : selectedValue.value,
            hint: Text(
              labelText,
              style: TextStyle(
                fontSize: 20,
                color: AppColors.primaryColor.withOpacity(0.7),
              ),
            ),
            items:
                options
                    .map(
                      (optionMap) => DropdownMenuItem<String>(
                        value: optionMap['value'],
                        child: Text(
                          optionMap['option'] ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              if (value != null) {
                selectedValue.value = value;
              }
            },
            icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}

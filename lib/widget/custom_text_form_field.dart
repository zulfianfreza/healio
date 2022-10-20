import 'package:flutter/material.dart';

import '../shared/theme.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    required this.label,
    this.icon,
    this.isPassword = false,
    this.obscureText = false,
    required this.controller,
    this.hint,
    Key? key,
  }) : super(key: key);

  final String label;
  final bool isPassword;
  final bool obscureText;
  final String? icon;
  final TextEditingController controller;
  final String? hint;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

bool isShow = false;

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void initState() {
    super.initState();
    isShow = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 57,
          decoration: BoxDecoration(
            color: kLightGrayColor,
            borderRadius: BorderRadius.circular(
              defaultRadius,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Row(
            children: [
              widget.icon != null
                  ? Row(
                      children: [
                        Image.asset(
                          widget.icon!,
                          height: 16,
                          color: kGrayColor,
                        ),
                        const SizedBox(width: 10),
                      ],
                    )
                  : const SizedBox(),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  decoration: InputDecoration.collapsed(
                    hintText: widget.hint ?? 'Masukan ${widget.label}',
                    hintStyle: grayTextStyle,
                  ),
                  obscureText: isShow ? true : false,
                ),
              ),
              widget.isPassword
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Image.asset(
                          isShow
                              ? 'assets/fi_eye.png'
                              : 'assets/fi_eye-off.png',
                          height: 16,
                          color: kGrayColor,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}

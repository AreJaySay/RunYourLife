import 'package:flutter/material.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';

class TextFields extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool is_password, isWeight, isCode, isEnable;
  final TextInputType inputType;
  final Function(String)? onChanged;
  TextFields(this.controller,{this.hintText = "", this.is_password = false, this.onChanged, this.inputType = TextInputType.text, this.isWeight = false, this.isCode = false, this.isEnable = true});
  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  bool _isvisible = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.isWeight ? 3 : null,
      keyboardType: widget.inputType,
      enabled: widget.isEnable,
      textAlignVertical: widget.isEnable ? TextAlignVertical.center : null,
      controller: widget.controller,
      obscureText: widget.is_password ? _isvisible : false,
      style: TextStyle(fontFamily: "AppFontStyle",fontSize: widget.isCode ? 17 : 15,fontWeight: widget.isCode ? FontWeight.w600 : FontWeight.normal),
      inputFormatters: !widget.isWeight ? null : [FilteringTextInputFormatter.allow(RegExp('[0-9]+')),],
      decoration: new InputDecoration(
          fillColor: Colors.white,
          filled: true,
          suffixIcon: widget.is_password ? IconButton(
            icon: !_isvisible ? Icon(Icons.visibility_off_sharp,color: Colors.grey,) : Icon(Icons.visibility_sharp,color: Colors.grey,),
            onPressed: (){
              setState(() {
                _isvisible = !_isvisible;
              });
            },
          ) : null,
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(1000)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.appmaincolor),
              borderRadius: BorderRadius.circular(1000)
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[400],fontFamily: "AppFontStyle"),
          counterText: "",
      ),
      onChanged: widget.onChanged,
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

class CacheNetworkImages{
  Widget cacheNetwork({String? image, double radius = 10}){
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: image!,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(
            color: AppColors.appmaincolor,
            strokeWidth: 2.5,
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
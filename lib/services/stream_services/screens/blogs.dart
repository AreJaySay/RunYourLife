import 'package:rxdart/rxdart.dart';

class BlogStreamServices{
  // ALL BLOGS
  final BehaviorSubject<List> subject = new BehaviorSubject.seeded([]);
  Stream get stream => subject.stream;
  List get currentdata => subject.value;

  updateBlogs({required List data}){
    subject.add(data);
  }

  pagination({required List data}){
    currentdata.addAll(data);
  }

  // RECETTES
  final BehaviorSubject<List> recettes = new BehaviorSubject();
  Stream get streamRecettes => recettes.stream;
  List get currentRecettes => recettes.value;

  updateRecettes({required List data}){
    recettes.add(data);
  }

  // LIFESTYLE
  final BehaviorSubject<List> lifestyle = new BehaviorSubject();
  Stream get streamLifestyle => lifestyle.stream;
  List get currentLifestyle => lifestyle.value;

  updateLifestyle({required List data}){
    lifestyle.add(data);
  }

  // NUTRITION
  final BehaviorSubject<List> nutrition = new BehaviorSubject();
  Stream get streamNutrition => nutrition.stream;
  List get currentNutrition => nutrition.value;

  updateNutrition({required List data}){
    nutrition.add(data);
  }

  // BLOGS BY CATEGORY
  final BehaviorSubject<List> blogsCat = new BehaviorSubject.seeded([]);
  Stream get streamBlogsCat => blogsCat.stream;
  List get currentBlogsCat => blogsCat.value;

  updateBlogCategory({required List data}){
    blogsCat.add(data);
  }
}

BlogStreamServices blogStreamServices = new BlogStreamServices();

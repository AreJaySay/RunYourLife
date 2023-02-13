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

  // BLOGS BY CATEGORY
  final BehaviorSubject<List> blogsCat = new BehaviorSubject.seeded([]);
  Stream get streamBlogsCat => blogsCat.stream;
  List get currentBlogsCat => blogsCat.value;

  updateBlogCategory({required List data}){
    blogsCat.add(data);
  }
}

BlogStreamServices blogStreamServices = new BlogStreamServices();

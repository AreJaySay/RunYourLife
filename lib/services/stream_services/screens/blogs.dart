import 'package:rxdart/rxdart.dart';

class BlogStreamServices{
  final BehaviorSubject<List> subject = new BehaviorSubject();
  Stream get stream => subject.stream;
  List get currentdata => subject.value;

  updateBlogs({required List data}){
    subject.add(data);
  }
}

BlogStreamServices blogStreamServices = new BlogStreamServices();

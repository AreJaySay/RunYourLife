import 'package:rxdart/rxdart.dart';

class BlogStreamServices{
  final BehaviorSubject<List> subject = new BehaviorSubject.seeded([]);
  Stream get stream => subject.stream;
  List get currentdata => subject.value;

  updateBlogs({required List data}){
    subject.add(data);
  }

  pagination({required List data}){
    currentdata.addAll(data);
  }
}

BlogStreamServices blogStreamServices = new BlogStreamServices();

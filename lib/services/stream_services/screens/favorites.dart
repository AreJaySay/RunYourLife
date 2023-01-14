import 'package:rxdart/rxdart.dart';

class FavoriteStreamServices{
  final BehaviorSubject<List> subject = new BehaviorSubject();
  Stream get stream => subject.stream;
  List get currentdata => subject.value;

  update({required List data}){
    subject.add(data);
  }
}

FavoriteStreamServices favoriteStreamServices = new FavoriteStreamServices();
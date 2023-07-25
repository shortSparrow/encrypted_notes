import 'package:equatable/equatable.dart';

class AppPage extends Equatable {
  final String name;
  final String route;
  final String path;

  AppPage({required this.name, required this.route, required this.path});
  
  @override
  List<Object?> get props => [name, route, path];
}
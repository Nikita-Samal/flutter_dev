import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String? imageUrl;
  final String? actionUrl;
  final bool isActive;

  const BannerEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.actionUrl,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [id, title, subtitle, imageUrl, actionUrl, isActive];
}

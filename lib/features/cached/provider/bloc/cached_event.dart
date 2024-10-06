part of 'cached_bloc.dart';

@immutable
sealed class CachedEvent {}

// Data

class AddCachedDataEvent implements CachedEvent {
  final CachedData cachedData;

  AddCachedDataEvent({required this.cachedData});
}

class LoadAllCachedData implements CachedEvent {}

// Images

class AddCachedImageEvent implements CachedEvent {
  final CachedImage cachedImage;

  AddCachedImageEvent({required this.cachedImage});
}

class LoadAllCachedImages implements CachedEvent {}

part of 'cached_bloc.dart';

@immutable
sealed class CachedState {}

final class CachedInitial extends CachedState {}

// Data

final class CachedDataLoaded implements CachedState {}

final class CachedDataLoading implements CachedState {}

final class CachedDataFailure implements CachedState {}

// Images

final class CachedImagesLoaded implements CachedState {
  final List<CachedImage> cachedImages;

  CachedImagesLoaded(this.cachedImages);
}

final class CachedImagesLoading implements CachedState {}

final class CachedImagesFailure implements CachedState {
  final String message;

  CachedImagesFailure(this.message);
}

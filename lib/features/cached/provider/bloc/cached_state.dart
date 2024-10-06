part of 'cached_bloc.dart';

@immutable
sealed class CachedState {}

final class CachedInitial extends CachedState {}

// Data

class CachedDataLoaded implements CachedState {}

class CachedDataLoading implements CachedState {}

class CachedDataFailure implements CachedState {}

// Images

class CachedImagesLoaded implements CachedState {}

class CachedImagesLoading implements CachedState {}

class CachedImagesFailure implements CachedState {}

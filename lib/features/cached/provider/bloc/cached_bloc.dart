import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/features/cached/domain/entity/cached_data.dart';
import 'package:pod_app/features/cached/domain/entity/cached_image.dart';

// UseCases
import 'package:pod_app/features/cached/domain/usecase/add_cached_data.dart';
import 'package:pod_app/features/cached/domain/usecase/add_cached_image.dart';
import 'package:pod_app/features/cached/domain/usecase/get_all_cached_images.dart';

part 'cached_event.dart';
part 'cached_state.dart';

class CachedBloc extends Bloc<CachedEvent, CachedState> {
  final AddCachedData _addCachedData;
  final AddCachedImage _addCachedImage;

  final GetAllCachedImages _getAllCachedImages;

  CachedBloc({
    required AddCachedData addCachedData,
    required AddCachedImage addCachedImage,
    required GetAllCachedImages getAllCachedImages,
  })  : _addCachedData = addCachedData,
        _addCachedImage = addCachedImage,
        _getAllCachedImages = getAllCachedImages,
        super(CachedInitial()) {
    on<AddCachedDataEvent>(_onAddCachedData);
    on<AddCachedImageEvent>(_onAddCachedImage);
    on<LoadAllCachedImages>(_onLoadAllCachedImages);
  }

  void _onAddCachedData(
      AddCachedDataEvent event, Emitter<CachedState> emit) async {
    final res = await _addCachedData(event.cachedData);

    res.fold((l) => {print("There was a problem: ${l.message}")},
        (r) => {print("Record saved successfully")});
  }

  void _onAddCachedImage(
      AddCachedImageEvent event, Emitter<CachedState> emit) async {
    final res = await _addCachedImage(event.cachedImage);

    res.fold((l) => {print("There was a problem: ${l.message}")},
        (r) => {print("Record saved successfully")});
  }

  void _onLoadAllCachedImages(
      LoadAllCachedImages event, Emitter<CachedState> emit) async {
    emit(CachedImagesLoading());
    final res = await _getAllCachedImages(NoParams());

    res.fold(
        (l) => CachedImagesFailure(l.message), (r) => CachedImagesLoaded(r));
  }
}

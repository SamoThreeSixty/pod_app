import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_app/features/cached/domain/entity/cached_image.dart';
import 'package:pod_app/features/cached/domain/usecase/get_all_cached_images.dart';
import 'package:pod_app/features/cached/provider/bloc/cached_bloc.dart';

class CachedPage extends StatefulWidget {
  const CachedPage({super.key});

  @override
  State<CachedPage> createState() => _CachedPageState();
}

class _CachedPageState extends State<CachedPage> {
  @override
  void initState() {
    context.read<CachedBloc>().add(
          LoadAllCachedImages(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("This is where cached data will go"),
          BlocBuilder<CachedBloc, CachedState>(
            builder: (context, state) {
              debugger();
              if (state is CachedImagesLoaded) {
                return const Text("All loaded");
              }

              if (state is CachedImagesLoading) {
                return const Text("loading");
              }

              if (state is CachedImagesLoaded) {
                final List<CachedImage> cachedImages;
              }

              return Container();
            },
          )
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';
import 'package:tourist_app/features/explore/data/repos/explore_repo.dart';
import 'package:tourist_app/features/explore/view_model/cubit/explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepo exploreRepo;

  ExploreCubit(this.exploreRepo) : super(const ExploreInitial());

  static const int _pageSize = 10;

  PagingState<int, PlaceModel> _pagingState = PagingState<int, PlaceModel>();

  String selectedCategory = 'All';
  String searchQuery = '';

  Timer? _searchDebounce;
  // Used to ignore responses belonging to old filters/search queries. (debounce)
  bool _isFetching = false;
  // Used to avoid race conditions
  int _requestGeneration = 0;

  Future<void> getPlaces() async {
    _searchDebounce?.cancel();
    await _resetAndFetch();
  }

  Future<void> _resetAndFetch() async {
    // avoid old responses
    _requestGeneration++;

    final generation = _requestGeneration;
    // reset state
    _pagingState = PagingState<int, PlaceModel>();
    _isFetching = true;
    emit(const ExploreLoading());
    await _fetchPage(1, generation);
  }

  Future<void> fetchNextPage() async {
    if (_isFetching || _pagingState.hasNextPage == false) return;

    final nextPage = (_pagingState.keys?.last ?? 0) + 1;

    _isFetching = true;
    _pagingState = _pagingState.copyWith(isLoading: true);

    _emitSuccess();

    await _fetchPage(nextPage, _requestGeneration);
  }

  Future<void> _fetchPage(int pageIndex, int generation) async {
    final result = await exploreRepo.getPlaces(
      pageIndex: pageIndex,
      pageSize: _pageSize,
      category: selectedCategory == 'All' ? null : selectedCategory,
      search: searchQuery.trim().isEmpty ? null : searchQuery.trim(),
    );
    // Ignore responses belonging to old filters/search queries.
    //لو ||اليوزر غيّر الفلتر/البحث والطلب ده لسه راجع متأخرـ Cubit اتقفل -> تجاهل النتيجة
    if (generation != _requestGeneration || isClosed) return;

    result.fold(
      (failure) {
        _isFetching = false;

        if (pageIndex == 1) {
          emit(ExploreFailure(message: failure.message));
        } else {
          _pagingState = _pagingState.copyWith(
            isLoading: false,
            error: failure.message,
          );
          _emitSuccess();
        }
      },
      (response) {
        _isFetching = false;

        _pagingState = _pagingState.copyWith(
          // add new data to existing data
          pages: [...?_pagingState.pages, response.data],
          keys: [...?_pagingState.keys, pageIndex],
          hasNextPage: response.pageIndex < response.totalPages,
          isLoading: false,
          error: null,
        );

        _emitSuccess();
      },
    );
  }

  void selectCategory(String category) {
    if (selectedCategory == category) return;

    selectedCategory = category;
    _searchDebounce?.cancel();

    _resetAndFetch();
  }

  void searchPlaces(String value) {
    searchQuery = value;

    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 500), _resetAndFetch);
  }

  void _emitSuccess() {
    emit(
      ExploreSuccess(
        pagingState: _pagingState,
        selectedCategory: selectedCategory,
        searchQuery: searchQuery,
      ),
    );
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}

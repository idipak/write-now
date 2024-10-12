

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/feeds_services.dart';
import '../data/models/enriched_post.dart';

final feedsProvider = StateNotifierProvider<FeedsController, FeedsStates>((ref){
  final service = ref.watch(feedsServicesProvider);
  return FeedsController(service);
});

class FeedsController extends StateNotifier<FeedsStates>{
  final FeedsServices _feedsServices;
  FeedsController(this._feedsServices):super(FeedsLoading()){
    init();
  }

  init()async{
    try{
      state = FeedsLoading();
      final feeds = await _feedsServices.getEnrichedPost('7892641450');
      state = FeedsLoaded(feeds);
    }catch(e){
      state = FeedsError(e.toString());
    }
  }

}

abstract class FeedsStates{}

class FeedsLoading extends FeedsStates{}

class FeedsLoaded extends FeedsStates{
  final List<EnrichedPost> posts;
  FeedsLoaded(this.posts);
}

class FeedsError extends FeedsStates{
  final String msg;
  FeedsError(this.msg);
}
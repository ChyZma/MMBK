import 'package:api/api.dart';

class UserRepository {
  final CaffCommentApi _api;

  UserRepository(
    this._api,
  );

  Future<void> sendComment(int id, String comment) async {
    await _api.apiCaffIdCommentPost(id, body: comment);
  }

  Future<void> deleteComment(int caffId, int commentId) async {
    await _api.apiCaffIdCommentCommentIdDelete(caffId, commentId);
  }

  Future<List<CaffCommentResponse>?> getComments(int id) async {
    return await _api.apiCaffIdCommentGet(id);
  }
}

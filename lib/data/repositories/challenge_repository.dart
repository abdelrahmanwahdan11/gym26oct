import '../models/challenge.dart';
import '../seed/mock_data.dart';

class ChallengeRepository {
  Future<List<Challenge>> fetchChallenges() async {
    await Future.delayed(const Duration(milliseconds: 220));
    return mockChallenges.map(Challenge.fromJson).toList(growable: false);
  }
}

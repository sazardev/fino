import 'package:fino/features/teams/domain/failures/team_failure.dart';
import 'package:fino/features/teams/domain/failures/team_failure_reason.dart';
import 'package:flutter_test/flutter_test.dart';

Matcher throwsTeam(TeamFailureReason reason) =>
    throwsA(isA<TeamFailure>().having((e) => e.reason, 'reason', reason));

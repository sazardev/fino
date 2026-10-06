import 'demo_member.dart';

/// A team of sample data and who is in it.
typedef DemoTeam = ({
  String id,
  String name,
  String inviteCode,
  DateTime createdAt,
  List<DemoMember> members,
});

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/changelog/presentation/pages/changelog_page.dart';
import '../../ui/navigation/app_transition_page.dart';
import '../gallery/gallery_page.dart';
import '../home/compose_page.dart';
import '../home/home_page.dart';
import '../settings/appearance_page.dart';
import '../settings/settings_page.dart';
import '../shell/app_shell.dart';
import 'back_navigation.dart';

part 'app_routes.g.dart';
part 'routes/app_shell_route.dart';
part 'routes/appearance_route.dart';
part 'routes/changelog_route.dart';
part 'routes/compose_route.dart';
part 'routes/gallery_branch.dart';
part 'routes/gallery_route.dart';
part 'routes/home_branch.dart';
part 'routes/home_route.dart';
part 'routes/settings_branch.dart';
part 'routes/settings_route.dart';
part 'routes/sign_in_route.dart';

/// Public so the auth redirect can recognise the sign-in screen.
const signInPath = '/iniciar-sesion';

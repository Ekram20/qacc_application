import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: BottomNavigationBarEmployees.page, initial: true),
        AutoRoute(page: LeaveTypeSelectionRoute.page),
        AutoRoute(page: ItemsOrderRoute.page),
        AutoRoute(page: FormSelectionRoute.page),
        AutoRoute(page: FullRouteAdRoute.page),
        AutoRoute(page: MaintenanceRequestType.page),
        AutoRoute(page: AnnualLeaveRequest.page),
        AutoRoute(page: PDFViewerRoute.page),

      ];
}

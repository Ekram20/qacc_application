import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: LeaveTypeSelectionRoute.page),
        AutoRoute(page: ItemsOrderRoute.page),
        AutoRoute(page: FormSelectionRoute.page),
        AutoRoute(page: FullRouteAdRoute.page),
        AutoRoute(page: MaintenanceRequestType.page),
        AutoRoute(page: AnnualLeaveRequest.page),
        AutoRoute(page: PDFViewerRoute.page),
        AutoRoute(page: MarriageLeaveRoute.page),
        AutoRoute(page: SickLeaveRequest.page),
        AutoRoute(page: HajjLeave.page),
        AutoRoute(page: ExamsLeave.page),
        AutoRoute(page: DeathLeave.page),
        AutoRoute(page: EmergencyLeaveRequest.page),
        AutoRoute(page: MaternityLeaveRequest.page),
        AutoRoute(page: LeaveInfoRoute.page),
        AutoRoute(page: MarriageLeaveInfoRoute.page),
        AutoRoute(page: AttendanceTableRoute.page),
        AutoRoute(page: BottomNavigationBarEmployees.page),
        AutoRoute(page: RequestManagement.page),
        AutoRoute(page: RequestTypeSelectionWidget.page),
        AutoRoute(page: LeavesRequestsRoute.page),
        AutoRoute(page: SelectManagerRoleRoute.page),
        AutoRoute(page: DirectManagerLeavesApproval.page),
        AutoRoute(page: HigherManagerLeavesApproval.page),
        AutoRoute(page: TermsConditionsRoute.page),

      ];
}

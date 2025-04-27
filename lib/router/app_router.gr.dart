// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i26;
import 'package:flutter/material.dart' as _i27;
import 'package:qacc_application/bottom_navigation_bar_employees.dart' as _i3;
import 'package:qacc_application/views/annual_leave_request.dart' as _i1;
import 'package:qacc_application/views/attendance_table_page.dart' as _i2;
import 'package:qacc_application/views/death_leave.dart' as _i4;
import 'package:qacc_application/views/direct_manager_leaves_approval.dart'
    as _i5;
import 'package:qacc_application/views/emergency_leave_request.dart' as _i6;
import 'package:qacc_application/views/exams_leave.dart' as _i7;
import 'package:qacc_application/views/form_selection_page.dart' as _i8;
import 'package:qacc_application/views/full_screen_ad_page.dart' as _i9;
import 'package:qacc_application/views/hajj_leave.dart' as _i10;
import 'package:qacc_application/views/higher_manager_leaves_approval.dart'
    as _i11;
import 'package:qacc_application/views/items_order_page.dart' as _i12;
import 'package:qacc_application/views/leave_type_selection_page.dart' as _i14;
import 'package:qacc_application/views/leaves_requests_screen.dart' as _i15;
import 'package:qacc_application/views/login_screen.dart' as _i16;
import 'package:qacc_application/views/maintenance_request_type.dart' as _i17;
import 'package:qacc_application/views/marriage_leave_info_page.dart' as _i18;
import 'package:qacc_application/views/marriage_leave_page.dart' as _i19;
import 'package:qacc_application/views/maternity_leave_request.dart' as _i20;
import 'package:qacc_application/views/pdf_viewer_screen.dart' as _i21;
import 'package:qacc_application/views/request_management.dart' as _i22;
import 'package:qacc_application/views/select_manager_role_page.dart' as _i24;
import 'package:qacc_application/views/sick_leave_request.dart' as _i25;
import 'package:qacc_application/widgets/leave_info_page.dart' as _i13;
import 'package:qacc_application/widgets/request_type_selection_widget.dart'
    as _i23;

abstract class $AppRouter extends _i26.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i26.PageFactory> pagesMap = {
    AnnualLeaveRequest.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AnnualLeaveRequest(),
      );
    },
    AttendanceTableRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AttendanceTablePage(),
      );
    },
    BottomNavigationBarEmployees.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BottomNavigationBarEmployees(),
      );
    },
    DeathLeave.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.DeathLeave(),
      );
    },
    DirectManagerLeavesApproval.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DirectManagerLeavesApproval(),
      );
    },
    EmergencyLeaveRequest.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.EmergencyLeaveRequest(),
      );
    },
    ExamsLeave.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ExamsLeave(),
      );
    },
    FormSelectionRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.FormSelectionPage(),
      );
    },
    FullRouteAdRoute.name: (routeData) {
      final args = routeData.argsAs<FullRouteAdRouteArgs>();
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.FullScreenAdPage(imageUrl: args.imageUrl),
      );
    },
    HajjLeave.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.HajjLeave(),
      );
    },
    HigherManagerLeavesApproval.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.HigherManagerLeavesApproval(),
      );
    },
    ItemsOrderRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.ItemsOrderPage(),
      );
    },
    LeaveInfoRoute.name: (routeData) {
      final args = routeData.argsAs<LeaveInfoRouteArgs>(
          orElse: () => const LeaveInfoRouteArgs());
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.LeaveInfoPage(
          key: args.key,
          leaveName: args.leaveName,
          leaveDuration: args.leaveDuration,
          procedureStepsTitle: args.procedureStepsTitle,
          stepDescription: args.stepDescription,
          stepOne: args.stepOne,
          stepTwo: args.stepTwo,
          stepThree: args.stepThree,
          stepFour: args.stepFour,
          stepFive: args.stepFive,
        ),
      );
    },
    LeaveTypeSelectionRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.LeaveTypeSelectionPage(),
      );
    },
    LeavesRequestsRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.LeavesRequestsScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.LoginScreen(),
      );
    },
    MaintenanceRequestType.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.MaintenanceRequestType(),
      );
    },
    MarriageLeaveInfoRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.MarriageLeaveInfoPage(),
      );
    },
    MarriageLeaveRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.MarriageLeavePage(),
      );
    },
    MaternityLeaveRequest.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.MaternityLeaveRequest(),
      );
    },
    PDFViewerRoute.name: (routeData) {
      final args = routeData.argsAs<PDFViewerRouteArgs>();
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.PDFViewerScreen(pdfPath: args.pdfPath),
      );
    },
    RequestManagement.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.RequestManagement(),
      );
    },
    RequestTypeSelectionWidget.name: (routeData) {
      final args = routeData.argsAs<RequestTypeSelectionWidgetArgs>(
          orElse: () => const RequestTypeSelectionWidgetArgs());
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.RequestTypeSelectionWidget(
          key: args.key,
          onLeavesTap: args.onLeavesTap,
          onItemsTap: args.onItemsTap,
          onFormsTap: args.onFormsTap,
        ),
      );
    },
    SelectManagerRoleRoute.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.SelectManagerRolePage(),
      );
    },
    SickLeaveRequest.name: (routeData) {
      return _i26.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.SickLeaveRequest(),
      );
    },
  };
}

/// generated route for
/// [_i1.AnnualLeaveRequest]
class AnnualLeaveRequest extends _i26.PageRouteInfo<void> {
  const AnnualLeaveRequest({List<_i26.PageRouteInfo>? children})
      : super(
          AnnualLeaveRequest.name,
          initialChildren: children,
        );

  static const String name = 'AnnualLeaveRequest';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AttendanceTablePage]
class AttendanceTableRoute extends _i26.PageRouteInfo<void> {
  const AttendanceTableRoute({List<_i26.PageRouteInfo>? children})
      : super(
          AttendanceTableRoute.name,
          initialChildren: children,
        );

  static const String name = 'AttendanceTableRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BottomNavigationBarEmployees]
class BottomNavigationBarEmployees extends _i26.PageRouteInfo<void> {
  const BottomNavigationBarEmployees({List<_i26.PageRouteInfo>? children})
      : super(
          BottomNavigationBarEmployees.name,
          initialChildren: children,
        );

  static const String name = 'BottomNavigationBarEmployees';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i4.DeathLeave]
class DeathLeave extends _i26.PageRouteInfo<void> {
  const DeathLeave({List<_i26.PageRouteInfo>? children})
      : super(
          DeathLeave.name,
          initialChildren: children,
        );

  static const String name = 'DeathLeave';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DirectManagerLeavesApproval]
class DirectManagerLeavesApproval extends _i26.PageRouteInfo<void> {
  const DirectManagerLeavesApproval({List<_i26.PageRouteInfo>? children})
      : super(
          DirectManagerLeavesApproval.name,
          initialChildren: children,
        );

  static const String name = 'DirectManagerLeavesApproval';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i6.EmergencyLeaveRequest]
class EmergencyLeaveRequest extends _i26.PageRouteInfo<void> {
  const EmergencyLeaveRequest({List<_i26.PageRouteInfo>? children})
      : super(
          EmergencyLeaveRequest.name,
          initialChildren: children,
        );

  static const String name = 'EmergencyLeaveRequest';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ExamsLeave]
class ExamsLeave extends _i26.PageRouteInfo<void> {
  const ExamsLeave({List<_i26.PageRouteInfo>? children})
      : super(
          ExamsLeave.name,
          initialChildren: children,
        );

  static const String name = 'ExamsLeave';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i8.FormSelectionPage]
class FormSelectionRoute extends _i26.PageRouteInfo<void> {
  const FormSelectionRoute({List<_i26.PageRouteInfo>? children})
      : super(
          FormSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'FormSelectionRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i9.FullScreenAdPage]
class FullRouteAdRoute extends _i26.PageRouteInfo<FullRouteAdRouteArgs> {
  FullRouteAdRoute({
    required String imageUrl,
    List<_i26.PageRouteInfo>? children,
  }) : super(
          FullRouteAdRoute.name,
          args: FullRouteAdRouteArgs(imageUrl: imageUrl),
          initialChildren: children,
        );

  static const String name = 'FullRouteAdRoute';

  static const _i26.PageInfo<FullRouteAdRouteArgs> page =
      _i26.PageInfo<FullRouteAdRouteArgs>(name);
}

class FullRouteAdRouteArgs {
  const FullRouteAdRouteArgs({required this.imageUrl});

  final String imageUrl;

  @override
  String toString() {
    return 'FullRouteAdRouteArgs{imageUrl: $imageUrl}';
  }
}

/// generated route for
/// [_i10.HajjLeave]
class HajjLeave extends _i26.PageRouteInfo<void> {
  const HajjLeave({List<_i26.PageRouteInfo>? children})
      : super(
          HajjLeave.name,
          initialChildren: children,
        );

  static const String name = 'HajjLeave';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i11.HigherManagerLeavesApproval]
class HigherManagerLeavesApproval extends _i26.PageRouteInfo<void> {
  const HigherManagerLeavesApproval({List<_i26.PageRouteInfo>? children})
      : super(
          HigherManagerLeavesApproval.name,
          initialChildren: children,
        );

  static const String name = 'HigherManagerLeavesApproval';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i12.ItemsOrderPage]
class ItemsOrderRoute extends _i26.PageRouteInfo<void> {
  const ItemsOrderRoute({List<_i26.PageRouteInfo>? children})
      : super(
          ItemsOrderRoute.name,
          initialChildren: children,
        );

  static const String name = 'ItemsOrderRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i13.LeaveInfoPage]
class LeaveInfoRoute extends _i26.PageRouteInfo<LeaveInfoRouteArgs> {
  LeaveInfoRoute({
    _i27.Key? key,
    String leaveName = '',
    String leaveDuration = '',
    String procedureStepsTitle = '',
    String stepDescription = '',
    String stepOne = '',
    String stepTwo = '',
    String stepThree = '',
    String stepFour = '',
    String stepFive = '',
    List<_i26.PageRouteInfo>? children,
  }) : super(
          LeaveInfoRoute.name,
          args: LeaveInfoRouteArgs(
            key: key,
            leaveName: leaveName,
            leaveDuration: leaveDuration,
            procedureStepsTitle: procedureStepsTitle,
            stepDescription: stepDescription,
            stepOne: stepOne,
            stepTwo: stepTwo,
            stepThree: stepThree,
            stepFour: stepFour,
            stepFive: stepFive,
          ),
          initialChildren: children,
        );

  static const String name = 'LeaveInfoRoute';

  static const _i26.PageInfo<LeaveInfoRouteArgs> page =
      _i26.PageInfo<LeaveInfoRouteArgs>(name);
}

class LeaveInfoRouteArgs {
  const LeaveInfoRouteArgs({
    this.key,
    this.leaveName = '',
    this.leaveDuration = '',
    this.procedureStepsTitle = '',
    this.stepDescription = '',
    this.stepOne = '',
    this.stepTwo = '',
    this.stepThree = '',
    this.stepFour = '',
    this.stepFive = '',
  });

  final _i27.Key? key;

  final String leaveName;

  final String leaveDuration;

  final String procedureStepsTitle;

  final String stepDescription;

  final String stepOne;

  final String stepTwo;

  final String stepThree;

  final String stepFour;

  final String stepFive;

  @override
  String toString() {
    return 'LeaveInfoRouteArgs{key: $key, leaveName: $leaveName, leaveDuration: $leaveDuration, procedureStepsTitle: $procedureStepsTitle, stepDescription: $stepDescription, stepOne: $stepOne, stepTwo: $stepTwo, stepThree: $stepThree, stepFour: $stepFour, stepFive: $stepFive}';
  }
}

/// generated route for
/// [_i14.LeaveTypeSelectionPage]
class LeaveTypeSelectionRoute extends _i26.PageRouteInfo<void> {
  const LeaveTypeSelectionRoute({List<_i26.PageRouteInfo>? children})
      : super(
          LeaveTypeSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'LeaveTypeSelectionRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i15.LeavesRequestsScreen]
class LeavesRequestsRoute extends _i26.PageRouteInfo<void> {
  const LeavesRequestsRoute({List<_i26.PageRouteInfo>? children})
      : super(
          LeavesRequestsRoute.name,
          initialChildren: children,
        );

  static const String name = 'LeavesRequestsRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i16.LoginScreen]
class LoginRoute extends _i26.PageRouteInfo<void> {
  const LoginRoute({List<_i26.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i17.MaintenanceRequestType]
class MaintenanceRequestType extends _i26.PageRouteInfo<void> {
  const MaintenanceRequestType({List<_i26.PageRouteInfo>? children})
      : super(
          MaintenanceRequestType.name,
          initialChildren: children,
        );

  static const String name = 'MaintenanceRequestType';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i18.MarriageLeaveInfoPage]
class MarriageLeaveInfoRoute extends _i26.PageRouteInfo<void> {
  const MarriageLeaveInfoRoute({List<_i26.PageRouteInfo>? children})
      : super(
          MarriageLeaveInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'MarriageLeaveInfoRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i19.MarriageLeavePage]
class MarriageLeaveRoute extends _i26.PageRouteInfo<void> {
  const MarriageLeaveRoute({List<_i26.PageRouteInfo>? children})
      : super(
          MarriageLeaveRoute.name,
          initialChildren: children,
        );

  static const String name = 'MarriageLeaveRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i20.MaternityLeaveRequest]
class MaternityLeaveRequest extends _i26.PageRouteInfo<void> {
  const MaternityLeaveRequest({List<_i26.PageRouteInfo>? children})
      : super(
          MaternityLeaveRequest.name,
          initialChildren: children,
        );

  static const String name = 'MaternityLeaveRequest';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i21.PDFViewerScreen]
class PDFViewerRoute extends _i26.PageRouteInfo<PDFViewerRouteArgs> {
  PDFViewerRoute({
    required String pdfPath,
    List<_i26.PageRouteInfo>? children,
  }) : super(
          PDFViewerRoute.name,
          args: PDFViewerRouteArgs(pdfPath: pdfPath),
          initialChildren: children,
        );

  static const String name = 'PDFViewerRoute';

  static const _i26.PageInfo<PDFViewerRouteArgs> page =
      _i26.PageInfo<PDFViewerRouteArgs>(name);
}

class PDFViewerRouteArgs {
  const PDFViewerRouteArgs({required this.pdfPath});

  final String pdfPath;

  @override
  String toString() {
    return 'PDFViewerRouteArgs{pdfPath: $pdfPath}';
  }
}

/// generated route for
/// [_i22.RequestManagement]
class RequestManagement extends _i26.PageRouteInfo<void> {
  const RequestManagement({List<_i26.PageRouteInfo>? children})
      : super(
          RequestManagement.name,
          initialChildren: children,
        );

  static const String name = 'RequestManagement';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i23.RequestTypeSelectionWidget]
class RequestTypeSelectionWidget
    extends _i26.PageRouteInfo<RequestTypeSelectionWidgetArgs> {
  RequestTypeSelectionWidget({
    _i27.Key? key,
    void Function()? onLeavesTap,
    void Function()? onItemsTap,
    void Function()? onFormsTap,
    List<_i26.PageRouteInfo>? children,
  }) : super(
          RequestTypeSelectionWidget.name,
          args: RequestTypeSelectionWidgetArgs(
            key: key,
            onLeavesTap: onLeavesTap,
            onItemsTap: onItemsTap,
            onFormsTap: onFormsTap,
          ),
          initialChildren: children,
        );

  static const String name = 'RequestTypeSelectionWidget';

  static const _i26.PageInfo<RequestTypeSelectionWidgetArgs> page =
      _i26.PageInfo<RequestTypeSelectionWidgetArgs>(name);
}

class RequestTypeSelectionWidgetArgs {
  const RequestTypeSelectionWidgetArgs({
    this.key,
    this.onLeavesTap,
    this.onItemsTap,
    this.onFormsTap,
  });

  final _i27.Key? key;

  final void Function()? onLeavesTap;

  final void Function()? onItemsTap;

  final void Function()? onFormsTap;

  @override
  String toString() {
    return 'RequestTypeSelectionWidgetArgs{key: $key, onLeavesTap: $onLeavesTap, onItemsTap: $onItemsTap, onFormsTap: $onFormsTap}';
  }
}

/// generated route for
/// [_i24.SelectManagerRolePage]
class SelectManagerRoleRoute extends _i26.PageRouteInfo<void> {
  const SelectManagerRoleRoute({List<_i26.PageRouteInfo>? children})
      : super(
          SelectManagerRoleRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectManagerRoleRoute';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

/// generated route for
/// [_i25.SickLeaveRequest]
class SickLeaveRequest extends _i26.PageRouteInfo<void> {
  const SickLeaveRequest({List<_i26.PageRouteInfo>? children})
      : super(
          SickLeaveRequest.name,
          initialChildren: children,
        );

  static const String name = 'SickLeaveRequest';

  static const _i26.PageInfo<void> page = _i26.PageInfo<void>(name);
}

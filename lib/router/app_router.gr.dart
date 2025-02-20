// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i20;
import 'package:flutter/material.dart' as _i21;
import 'package:qacc_application/bottom_navigation_bar_employees.dart' as _i3;
import 'package:qacc_application/views/annual_leave_request.dart' as _i1;
import 'package:qacc_application/views/attendance_table_page.dart' as _i2;
import 'package:qacc_application/views/death_leave.dart' as _i4;
import 'package:qacc_application/views/emergency_leave_request.dart' as _i5;
import 'package:qacc_application/views/exams_leave.dart' as _i6;
import 'package:qacc_application/views/form_selection_page.dart' as _i7;
import 'package:qacc_application/views/full_screen_ad_page.dart' as _i8;
import 'package:qacc_application/views/hajj_leave.dart' as _i9;
import 'package:qacc_application/views/items_order_page.dart' as _i10;
import 'package:qacc_application/views/leave_type_selection_page.dart' as _i12;
import 'package:qacc_application/views/login_screen.dart' as _i13;
import 'package:qacc_application/views/maintenance_request_type.dart' as _i14;
import 'package:qacc_application/views/marriage_leave_info_page.dart' as _i15;
import 'package:qacc_application/views/marriage_leave_page.dart' as _i16;
import 'package:qacc_application/views/maternity_leave_request.dart' as _i17;
import 'package:qacc_application/views/pdf_viewer_screen.dart' as _i18;
import 'package:qacc_application/views/sick_leave_request.dart' as _i19;
import 'package:qacc_application/widgets/leave_info_page.dart' as _i11;

abstract class $AppRouter extends _i20.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i20.PageFactory> pagesMap = {
    AnnualLeaveRequest.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AnnualLeaveRequest(),
      );
    },
    AttendanceTableRoute.name: (routeData) {
      final args = routeData.argsAs<AttendanceTableRouteArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AttendanceTablePage(
          key: args.key,
          employeeID: args.employeeID,
        ),
      );
    },
    BottomNavigationBarEmployees.name: (routeData) {
      final args = routeData.argsAs<BottomNavigationBarEmployeesArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.BottomNavigationBarEmployees(
          key: args.key,
          email: args.email,
        ),
      );
    },
    DeathLeave.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.DeathLeave(),
      );
    },
    EmergencyLeaveRequest.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.EmergencyLeaveRequest(),
      );
    },
    ExamsLeave.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ExamsLeave(),
      );
    },
    FormSelectionRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.FormSelectionPage(),
      );
    },
    FullRouteAdRoute.name: (routeData) {
      final args = routeData.argsAs<FullRouteAdRouteArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.FullScreenAdPage(imageUrl: args.imageUrl),
      );
    },
    HajjLeave.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.HajjLeave(),
      );
    },
    ItemsOrderRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ItemsOrderPage(),
      );
    },
    LeaveInfoRoute.name: (routeData) {
      final args = routeData.argsAs<LeaveInfoRouteArgs>(
          orElse: () => const LeaveInfoRouteArgs());
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.LeaveInfoPage(
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
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.LeaveTypeSelectionPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.LoginScreen(),
      );
    },
    MaintenanceRequestType.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.MaintenanceRequestType(),
      );
    },
    MarriageLeaveInfoRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.MarriageLeaveInfoPage(),
      );
    },
    MarriageLeaveRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.MarriageLeavePage(),
      );
    },
    MaternityLeaveRequest.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.MaternityLeaveRequest(),
      );
    },
    PDFViewerRoute.name: (routeData) {
      final args = routeData.argsAs<PDFViewerRouteArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.PDFViewerScreen(pdfPath: args.pdfPath),
      );
    },
    SickLeaveRequest.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.SickLeaveRequest(),
      );
    },
  };
}

/// generated route for
/// [_i1.AnnualLeaveRequest]
class AnnualLeaveRequest extends _i20.PageRouteInfo<void> {
  const AnnualLeaveRequest({List<_i20.PageRouteInfo>? children})
      : super(
          AnnualLeaveRequest.name,
          initialChildren: children,
        );

  static const String name = 'AnnualLeaveRequest';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AttendanceTablePage]
class AttendanceTableRoute
    extends _i20.PageRouteInfo<AttendanceTableRouteArgs> {
  AttendanceTableRoute({
    _i21.Key? key,
    required int employeeID,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          AttendanceTableRoute.name,
          args: AttendanceTableRouteArgs(
            key: key,
            employeeID: employeeID,
          ),
          initialChildren: children,
        );

  static const String name = 'AttendanceTableRoute';

  static const _i20.PageInfo<AttendanceTableRouteArgs> page =
      _i20.PageInfo<AttendanceTableRouteArgs>(name);
}

class AttendanceTableRouteArgs {
  const AttendanceTableRouteArgs({
    this.key,
    required this.employeeID,
  });

  final _i21.Key? key;

  final int employeeID;

  @override
  String toString() {
    return 'AttendanceTableRouteArgs{key: $key, employeeID: $employeeID}';
  }
}

/// generated route for
/// [_i3.BottomNavigationBarEmployees]
class BottomNavigationBarEmployees
    extends _i20.PageRouteInfo<BottomNavigationBarEmployeesArgs> {
  BottomNavigationBarEmployees({
    _i21.Key? key,
    required String email,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          BottomNavigationBarEmployees.name,
          args: BottomNavigationBarEmployeesArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'BottomNavigationBarEmployees';

  static const _i20.PageInfo<BottomNavigationBarEmployeesArgs> page =
      _i20.PageInfo<BottomNavigationBarEmployeesArgs>(name);
}

class BottomNavigationBarEmployeesArgs {
  const BottomNavigationBarEmployeesArgs({
    this.key,
    required this.email,
  });

  final _i21.Key? key;

  final String email;

  @override
  String toString() {
    return 'BottomNavigationBarEmployeesArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i4.DeathLeave]
class DeathLeave extends _i20.PageRouteInfo<void> {
  const DeathLeave({List<_i20.PageRouteInfo>? children})
      : super(
          DeathLeave.name,
          initialChildren: children,
        );

  static const String name = 'DeathLeave';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EmergencyLeaveRequest]
class EmergencyLeaveRequest extends _i20.PageRouteInfo<void> {
  const EmergencyLeaveRequest({List<_i20.PageRouteInfo>? children})
      : super(
          EmergencyLeaveRequest.name,
          initialChildren: children,
        );

  static const String name = 'EmergencyLeaveRequest';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ExamsLeave]
class ExamsLeave extends _i20.PageRouteInfo<void> {
  const ExamsLeave({List<_i20.PageRouteInfo>? children})
      : super(
          ExamsLeave.name,
          initialChildren: children,
        );

  static const String name = 'ExamsLeave';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i7.FormSelectionPage]
class FormSelectionRoute extends _i20.PageRouteInfo<void> {
  const FormSelectionRoute({List<_i20.PageRouteInfo>? children})
      : super(
          FormSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'FormSelectionRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i8.FullScreenAdPage]
class FullRouteAdRoute extends _i20.PageRouteInfo<FullRouteAdRouteArgs> {
  FullRouteAdRoute({
    required String imageUrl,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          FullRouteAdRoute.name,
          args: FullRouteAdRouteArgs(imageUrl: imageUrl),
          initialChildren: children,
        );

  static const String name = 'FullRouteAdRoute';

  static const _i20.PageInfo<FullRouteAdRouteArgs> page =
      _i20.PageInfo<FullRouteAdRouteArgs>(name);
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
/// [_i9.HajjLeave]
class HajjLeave extends _i20.PageRouteInfo<void> {
  const HajjLeave({List<_i20.PageRouteInfo>? children})
      : super(
          HajjLeave.name,
          initialChildren: children,
        );

  static const String name = 'HajjLeave';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ItemsOrderPage]
class ItemsOrderRoute extends _i20.PageRouteInfo<void> {
  const ItemsOrderRoute({List<_i20.PageRouteInfo>? children})
      : super(
          ItemsOrderRoute.name,
          initialChildren: children,
        );

  static const String name = 'ItemsOrderRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i11.LeaveInfoPage]
class LeaveInfoRoute extends _i20.PageRouteInfo<LeaveInfoRouteArgs> {
  LeaveInfoRoute({
    _i21.Key? key,
    String leaveName = '',
    String leaveDuration = '',
    String procedureStepsTitle = '',
    String stepDescription = '',
    String stepOne = '',
    String stepTwo = '',
    String stepThree = '',
    String stepFour = '',
    String stepFive = '',
    List<_i20.PageRouteInfo>? children,
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

  static const _i20.PageInfo<LeaveInfoRouteArgs> page =
      _i20.PageInfo<LeaveInfoRouteArgs>(name);
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

  final _i21.Key? key;

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
/// [_i12.LeaveTypeSelectionPage]
class LeaveTypeSelectionRoute extends _i20.PageRouteInfo<void> {
  const LeaveTypeSelectionRoute({List<_i20.PageRouteInfo>? children})
      : super(
          LeaveTypeSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'LeaveTypeSelectionRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i13.LoginScreen]
class LoginRoute extends _i20.PageRouteInfo<void> {
  const LoginRoute({List<_i20.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i14.MaintenanceRequestType]
class MaintenanceRequestType extends _i20.PageRouteInfo<void> {
  const MaintenanceRequestType({List<_i20.PageRouteInfo>? children})
      : super(
          MaintenanceRequestType.name,
          initialChildren: children,
        );

  static const String name = 'MaintenanceRequestType';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i15.MarriageLeaveInfoPage]
class MarriageLeaveInfoRoute extends _i20.PageRouteInfo<void> {
  const MarriageLeaveInfoRoute({List<_i20.PageRouteInfo>? children})
      : super(
          MarriageLeaveInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'MarriageLeaveInfoRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i16.MarriageLeavePage]
class MarriageLeaveRoute extends _i20.PageRouteInfo<void> {
  const MarriageLeaveRoute({List<_i20.PageRouteInfo>? children})
      : super(
          MarriageLeaveRoute.name,
          initialChildren: children,
        );

  static const String name = 'MarriageLeaveRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i17.MaternityLeaveRequest]
class MaternityLeaveRequest extends _i20.PageRouteInfo<void> {
  const MaternityLeaveRequest({List<_i20.PageRouteInfo>? children})
      : super(
          MaternityLeaveRequest.name,
          initialChildren: children,
        );

  static const String name = 'MaternityLeaveRequest';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i18.PDFViewerScreen]
class PDFViewerRoute extends _i20.PageRouteInfo<PDFViewerRouteArgs> {
  PDFViewerRoute({
    required String pdfPath,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          PDFViewerRoute.name,
          args: PDFViewerRouteArgs(pdfPath: pdfPath),
          initialChildren: children,
        );

  static const String name = 'PDFViewerRoute';

  static const _i20.PageInfo<PDFViewerRouteArgs> page =
      _i20.PageInfo<PDFViewerRouteArgs>(name);
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
/// [_i19.SickLeaveRequest]
class SickLeaveRequest extends _i20.PageRouteInfo<void> {
  const SickLeaveRequest({List<_i20.PageRouteInfo>? children})
      : super(
          SickLeaveRequest.name,
          initialChildren: children,
        );

  static const String name = 'SickLeaveRequest';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i21;
import 'package:flutter/material.dart' as _i22;
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
import 'package:qacc_application/views/leave_management.dart' as _i12;
import 'package:qacc_application/views/leave_type_selection_page.dart' as _i13;
import 'package:qacc_application/views/login_screen.dart' as _i14;
import 'package:qacc_application/views/maintenance_request_type.dart' as _i15;
import 'package:qacc_application/views/marriage_leave_info_page.dart' as _i16;
import 'package:qacc_application/views/marriage_leave_page.dart' as _i17;
import 'package:qacc_application/views/maternity_leave_request.dart' as _i18;
import 'package:qacc_application/views/pdf_viewer_screen.dart' as _i19;
import 'package:qacc_application/views/sick_leave_request.dart' as _i20;
import 'package:qacc_application/widgets/leave_info_page.dart' as _i11;

abstract class $AppRouter extends _i21.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i21.PageFactory> pagesMap = {
    AnnualLeaveRequest.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AnnualLeaveRequest(),
      );
    },
    AttendanceTableRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AttendanceTablePage(),
      );
    },
    BottomNavigationBarEmployees.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BottomNavigationBarEmployees(),
      );
    },
    DeathLeave.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.DeathLeave(),
      );
    },
    EmergencyLeaveRequest.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.EmergencyLeaveRequest(),
      );
    },
    ExamsLeave.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ExamsLeave(),
      );
    },
    FormSelectionRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.FormSelectionPage(),
      );
    },
    FullRouteAdRoute.name: (routeData) {
      final args = routeData.argsAs<FullRouteAdRouteArgs>();
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.FullScreenAdPage(imageUrl: args.imageUrl),
      );
    },
    HajjLeave.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.HajjLeave(),
      );
    },
    ItemsOrderRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ItemsOrderPage(),
      );
    },
    LeaveInfoRoute.name: (routeData) {
      final args = routeData.argsAs<LeaveInfoRouteArgs>(
          orElse: () => const LeaveInfoRouteArgs());
      return _i21.AutoRoutePage<dynamic>(
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
    LeaveManagement.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.LeaveManagement(),
      );
    },
    LeaveTypeSelectionRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.LeaveTypeSelectionPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.LoginScreen(),
      );
    },
    MaintenanceRequestType.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.MaintenanceRequestType(),
      );
    },
    MarriageLeaveInfoRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.MarriageLeaveInfoPage(),
      );
    },
    MarriageLeaveRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.MarriageLeavePage(),
      );
    },
    MaternityLeaveRequest.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.MaternityLeaveRequest(),
      );
    },
    PDFViewerRoute.name: (routeData) {
      final args = routeData.argsAs<PDFViewerRouteArgs>();
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.PDFViewerScreen(pdfPath: args.pdfPath),
      );
    },
    SickLeaveRequest.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.SickLeaveRequest(),
      );
    },
  };
}

/// generated route for
/// [_i1.AnnualLeaveRequest]
class AnnualLeaveRequest extends _i21.PageRouteInfo<void> {
  const AnnualLeaveRequest({List<_i21.PageRouteInfo>? children})
      : super(
          AnnualLeaveRequest.name,
          initialChildren: children,
        );

  static const String name = 'AnnualLeaveRequest';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AttendanceTablePage]
class AttendanceTableRoute extends _i21.PageRouteInfo<void> {
  const AttendanceTableRoute({List<_i21.PageRouteInfo>? children})
      : super(
          AttendanceTableRoute.name,
          initialChildren: children,
        );

  static const String name = 'AttendanceTableRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BottomNavigationBarEmployees]
class BottomNavigationBarEmployees extends _i21.PageRouteInfo<void> {
  const BottomNavigationBarEmployees({List<_i21.PageRouteInfo>? children})
      : super(
          BottomNavigationBarEmployees.name,
          initialChildren: children,
        );

  static const String name = 'BottomNavigationBarEmployees';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i4.DeathLeave]
class DeathLeave extends _i21.PageRouteInfo<void> {
  const DeathLeave({List<_i21.PageRouteInfo>? children})
      : super(
          DeathLeave.name,
          initialChildren: children,
        );

  static const String name = 'DeathLeave';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EmergencyLeaveRequest]
class EmergencyLeaveRequest extends _i21.PageRouteInfo<void> {
  const EmergencyLeaveRequest({List<_i21.PageRouteInfo>? children})
      : super(
          EmergencyLeaveRequest.name,
          initialChildren: children,
        );

  static const String name = 'EmergencyLeaveRequest';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ExamsLeave]
class ExamsLeave extends _i21.PageRouteInfo<void> {
  const ExamsLeave({List<_i21.PageRouteInfo>? children})
      : super(
          ExamsLeave.name,
          initialChildren: children,
        );

  static const String name = 'ExamsLeave';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i7.FormSelectionPage]
class FormSelectionRoute extends _i21.PageRouteInfo<void> {
  const FormSelectionRoute({List<_i21.PageRouteInfo>? children})
      : super(
          FormSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'FormSelectionRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i8.FullScreenAdPage]
class FullRouteAdRoute extends _i21.PageRouteInfo<FullRouteAdRouteArgs> {
  FullRouteAdRoute({
    required String imageUrl,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          FullRouteAdRoute.name,
          args: FullRouteAdRouteArgs(imageUrl: imageUrl),
          initialChildren: children,
        );

  static const String name = 'FullRouteAdRoute';

  static const _i21.PageInfo<FullRouteAdRouteArgs> page =
      _i21.PageInfo<FullRouteAdRouteArgs>(name);
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
class HajjLeave extends _i21.PageRouteInfo<void> {
  const HajjLeave({List<_i21.PageRouteInfo>? children})
      : super(
          HajjLeave.name,
          initialChildren: children,
        );

  static const String name = 'HajjLeave';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ItemsOrderPage]
class ItemsOrderRoute extends _i21.PageRouteInfo<void> {
  const ItemsOrderRoute({List<_i21.PageRouteInfo>? children})
      : super(
          ItemsOrderRoute.name,
          initialChildren: children,
        );

  static const String name = 'ItemsOrderRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i11.LeaveInfoPage]
class LeaveInfoRoute extends _i21.PageRouteInfo<LeaveInfoRouteArgs> {
  LeaveInfoRoute({
    _i22.Key? key,
    String leaveName = '',
    String leaveDuration = '',
    String procedureStepsTitle = '',
    String stepDescription = '',
    String stepOne = '',
    String stepTwo = '',
    String stepThree = '',
    String stepFour = '',
    String stepFive = '',
    List<_i21.PageRouteInfo>? children,
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

  static const _i21.PageInfo<LeaveInfoRouteArgs> page =
      _i21.PageInfo<LeaveInfoRouteArgs>(name);
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

  final _i22.Key? key;

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
/// [_i12.LeaveManagement]
class LeaveManagement extends _i21.PageRouteInfo<void> {
  const LeaveManagement({List<_i21.PageRouteInfo>? children})
      : super(
          LeaveManagement.name,
          initialChildren: children,
        );

  static const String name = 'LeaveManagement';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i13.LeaveTypeSelectionPage]
class LeaveTypeSelectionRoute extends _i21.PageRouteInfo<void> {
  const LeaveTypeSelectionRoute({List<_i21.PageRouteInfo>? children})
      : super(
          LeaveTypeSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'LeaveTypeSelectionRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i14.LoginScreen]
class LoginRoute extends _i21.PageRouteInfo<void> {
  const LoginRoute({List<_i21.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i15.MaintenanceRequestType]
class MaintenanceRequestType extends _i21.PageRouteInfo<void> {
  const MaintenanceRequestType({List<_i21.PageRouteInfo>? children})
      : super(
          MaintenanceRequestType.name,
          initialChildren: children,
        );

  static const String name = 'MaintenanceRequestType';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i16.MarriageLeaveInfoPage]
class MarriageLeaveInfoRoute extends _i21.PageRouteInfo<void> {
  const MarriageLeaveInfoRoute({List<_i21.PageRouteInfo>? children})
      : super(
          MarriageLeaveInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'MarriageLeaveInfoRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i17.MarriageLeavePage]
class MarriageLeaveRoute extends _i21.PageRouteInfo<void> {
  const MarriageLeaveRoute({List<_i21.PageRouteInfo>? children})
      : super(
          MarriageLeaveRoute.name,
          initialChildren: children,
        );

  static const String name = 'MarriageLeaveRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i18.MaternityLeaveRequest]
class MaternityLeaveRequest extends _i21.PageRouteInfo<void> {
  const MaternityLeaveRequest({List<_i21.PageRouteInfo>? children})
      : super(
          MaternityLeaveRequest.name,
          initialChildren: children,
        );

  static const String name = 'MaternityLeaveRequest';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i19.PDFViewerScreen]
class PDFViewerRoute extends _i21.PageRouteInfo<PDFViewerRouteArgs> {
  PDFViewerRoute({
    required String pdfPath,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          PDFViewerRoute.name,
          args: PDFViewerRouteArgs(pdfPath: pdfPath),
          initialChildren: children,
        );

  static const String name = 'PDFViewerRoute';

  static const _i21.PageInfo<PDFViewerRouteArgs> page =
      _i21.PageInfo<PDFViewerRouteArgs>(name);
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
/// [_i20.SickLeaveRequest]
class SickLeaveRequest extends _i21.PageRouteInfo<void> {
  const SickLeaveRequest({List<_i21.PageRouteInfo>? children})
      : super(
          SickLeaveRequest.name,
          initialChildren: children,
        );

  static const String name = 'SickLeaveRequest';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

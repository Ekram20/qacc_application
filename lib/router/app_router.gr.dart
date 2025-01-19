// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:qacc_application/bottom_navigation_bar_employees.dart' as _i2;
import 'package:qacc_application/views/annual_leave_request.dart' as _i1;
import 'package:qacc_application/views/form_selection_page.dart' as _i3;
import 'package:qacc_application/views/full_screen_ad_page.dart' as _i4;
import 'package:qacc_application/views/items_order_page.dart' as _i5;
import 'package:qacc_application/views/leave_type_selection_page.dart' as _i6;
import 'package:qacc_application/views/maintenance_request_type.dart' as _i7;
import 'package:qacc_application/views/marriage_leave_page.dart' as _i8;
import 'package:qacc_application/views/pdf_viewer_screen.dart' as _i9;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    AnnualLeaveRequest.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AnnualLeaveRequest(),
      );
    },
    BottomNavigationBarEmployees.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.BottomNavigationBarEmployees(),
      );
    },
    FormSelectionRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.FormSelectionPage(),
      );
    },
    FullRouteAdRoute.name: (routeData) {
      final args = routeData.argsAs<FullRouteAdRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.FullScreenAdPage(imageUrl: args.imageUrl),
      );
    },
    ItemsOrderRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ItemsOrderPage(),
      );
    },
    LeaveTypeSelectionRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LeaveTypeSelectionPage(),
      );
    },
    MaintenanceRequestType.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.MaintenanceRequestType(),
      );
    },
    MarriageLeaveRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child:  _i8.MarriageLeavePage(),
      );
    },
    PDFViewerRoute.name: (routeData) {
      final args = routeData.argsAs<PDFViewerRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.PDFViewerScreen(pdfPath: args.pdfPath),
      );
    },
  };
}

/// generated route for
/// [_i1.AnnualLeaveRequest]
class AnnualLeaveRequest extends _i10.PageRouteInfo<void> {
  const AnnualLeaveRequest({List<_i10.PageRouteInfo>? children})
      : super(
          AnnualLeaveRequest.name,
          initialChildren: children,
        );

  static const String name = 'AnnualLeaveRequest';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BottomNavigationBarEmployees]
class BottomNavigationBarEmployees extends _i10.PageRouteInfo<void> {
  const BottomNavigationBarEmployees({List<_i10.PageRouteInfo>? children})
      : super(
          BottomNavigationBarEmployees.name,
          initialChildren: children,
        );

  static const String name = 'BottomNavigationBarEmployees';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.FormSelectionPage]
class FormSelectionRoute extends _i10.PageRouteInfo<void> {
  const FormSelectionRoute({List<_i10.PageRouteInfo>? children})
      : super(
          FormSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'FormSelectionRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.FullScreenAdPage]
class FullRouteAdRoute extends _i10.PageRouteInfo<FullRouteAdRouteArgs> {
  FullRouteAdRoute({
    required String imageUrl,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          FullRouteAdRoute.name,
          args: FullRouteAdRouteArgs(imageUrl: imageUrl),
          initialChildren: children,
        );

  static const String name = 'FullRouteAdRoute';

  static const _i10.PageInfo<FullRouteAdRouteArgs> page =
      _i10.PageInfo<FullRouteAdRouteArgs>(name);
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
/// [_i5.ItemsOrderPage]
class ItemsOrderRoute extends _i10.PageRouteInfo<void> {
  const ItemsOrderRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ItemsOrderRoute.name,
          initialChildren: children,
        );

  static const String name = 'ItemsOrderRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LeaveTypeSelectionPage]
class LeaveTypeSelectionRoute extends _i10.PageRouteInfo<void> {
  const LeaveTypeSelectionRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LeaveTypeSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'LeaveTypeSelectionRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MaintenanceRequestType]
class MaintenanceRequestType extends _i10.PageRouteInfo<void> {
  const MaintenanceRequestType({List<_i10.PageRouteInfo>? children})
      : super(
          MaintenanceRequestType.name,
          initialChildren: children,
        );

  static const String name = 'MaintenanceRequestType';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.MarriageLeavePage]
class MarriageLeaveRoute extends _i10.PageRouteInfo<void> {
  const MarriageLeaveRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MarriageLeaveRoute.name,
          initialChildren: children,
        );

  static const String name = 'MarriageLeaveRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.PDFViewerScreen]
class PDFViewerRoute extends _i10.PageRouteInfo<PDFViewerRouteArgs> {
  PDFViewerRoute({
    required String pdfPath,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          PDFViewerRoute.name,
          args: PDFViewerRouteArgs(pdfPath: pdfPath),
          initialChildren: children,
        );

  static const String name = 'PDFViewerRoute';

  static const _i10.PageInfo<PDFViewerRouteArgs> page =
      _i10.PageInfo<PDFViewerRouteArgs>(name);
}

class PDFViewerRouteArgs {
  const PDFViewerRouteArgs({required this.pdfPath});

  final String pdfPath;

  @override
  String toString() {
    return 'PDFViewerRouteArgs{pdfPath: $pdfPath}';
  }
}

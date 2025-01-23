import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/section_header.dart';

@RoutePage()
class MarriageLeaveInfoPage extends StatefulWidget {
  const MarriageLeaveInfoPage({super.key});

  @override
  State<MarriageLeaveInfoPage> createState() => _MarriageLeaveInfoPageState();
}

class _MarriageLeaveInfoPageState extends State<MarriageLeaveInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: const Icon(
            Icons.arrow_circle_left_rounded,
            color: Colors.white,
            size: 40.0,
          ),
        ),
      ),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(20),
                  SectionHeader(
                    title: 'خطوات إجراء الإجازة ',
                    onImageTap: () {},
                  ),
                  Gap(20),
                ],
              ),
            ),
          )),
    );
  }
}

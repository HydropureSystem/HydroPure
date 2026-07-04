import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:hydropure/app/theme/app_colors.dart';
import 'package:hydropure/models/iot_log_model.dart';
import 'package:hydropure/modules/nutrition_stats/controllers/nutrition_controller.dart';
import 'package:hydropure/widgets/bottom_nav.dart';
import 'package:hydropure/widgets/profile_button.dart';
import '../../../app/routes/app_routes.dart';

class NutritionView extends GetView<NutritionController> {
  const NutritionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      bottomNavigationBar: BottomNav(currentIndex: 1),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.offAllNamed(Routes.HOME),

                        child: Container(
                          padding: const EdgeInsets.all(10),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),

                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      Text(
                        "HydroPure",
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  CircleAvatar(child: ProfileButton()),
                ],
              ),

              const SizedBox(height: 30),

              Text(
                "Nutrition Statistics",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (controller.logs.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        "No sensor data available",
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  );
                }

                final List<HydroponicLog> logs = controller.logs.toList();

                return Column(
                  children: [
                    /// TDS CHART
                    _buildChartCard(
                      title: "TDS History",
                      logs: logs,
                      valueMapper: (item) => item.tds,
                    ),

                    const SizedBox(height: 20),

                    /// PH CHART
                    _buildChartCard(
                      title: "pH History",
                      logs: logs,
                      valueMapper: (item) => item.ph,
                    ),

                    const SizedBox(height: 20),

                    /// TEMPERATURE CHART
                    _buildChartCard(
                      title: "Temperature History",
                      logs: logs,
                      valueMapper: (item) => item.temperature,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard({
    required String title,
    required List<HydroponicLog> logs,
    required double Function(HydroponicLog) valueMapper,
  }) {
    late ZoomPanBehavior _zoomPanBehavior;
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      zoomMode: ZoomMode.x,
    );
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),

      child: SizedBox(
        height: 250,

        child: SfCartesianChart(
          zoomPanBehavior: _zoomPanBehavior,
          title: ChartTitle(text: title),

          primaryXAxis: DateTimeAxis(
            intervalType: DateTimeIntervalType.minutes,
            interval: 1,
          ),
          // primaryXAxis: DateTimeAxis(),
          tooltipBehavior: TooltipBehavior(enable: true),

          series: <CartesianSeries>[
            LineSeries<HydroponicLog, DateTime>(
              dataSource: logs,
              color: AppColors.primary,
              xValueMapper: (data, _) => data.timestamp,

              yValueMapper: (data, _) => valueMapper(data),

              markerSettings: const MarkerSettings(
                isVisible: true,
                color: AppColors.primary,
                borderColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

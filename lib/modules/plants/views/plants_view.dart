import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/plants_controller.dart';

class PlantsView extends GetView<PlantsController> {
  const PlantsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Obx(() => Text(controller.plantsName.value))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.psychology),
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "https://images.unsplash.com/photo-1622205313162-be1d5712a43f",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              /// PROGRESS
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Growth Progress"),
                            Text(
                              "${controller.progress.value}%",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text("12 days until harvest"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: CircularProgressIndicator(
                          value: controller.progress.value / 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// METRICS
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.7,
                children: [
                  _metricCard(
                    Icons.science,
                    "pH Level",
                    controller.ph.value.toString(),
                  ),

                  _metricCard(
                    Icons.water_drop,
                    "Nutrient",
                    "${controller.ppm.value} PPM",
                  ),

                  _metricCard(
                    Icons.thermostat,
                    "Water Temp",
                    "${controller.waterTemp.value}°C",
                  ),

                  _metricCard(
                    Icons.air,
                    "Humidity",
                    "${controller.humidity.value}%",
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Maintenance Log",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),

              const SizedBox(height: 10),

              ...controller.maintenanceLogs.map(
                (log) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(log["date"]!),
                    subtitle: Text(log["description"]!),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                color: Colors.green.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.auto_awesome),
                          SizedBox(width: 10),
                          Text(
                            "AI Recommendation",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "Based on current light cycles and growth rate, increasing nutrients by 5% over the next 3 days could accelerate harvest by 24 hours.",
                      ),

                      const SizedBox(height: 12),

                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Optimize Now"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _metricCard(IconData icon, String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(title),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert'; // Untuk jsonDecode
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // Tambahkan ini
import 'package:permission_handler/permission_handler.dart';
import '../../../app/routes/app_routes.dart';

class PestDetectionController extends GetxController {
  CameraController? cameraController;
  RxBool isCameraInitialized = false.obs;
  RxInt selectedMode = 0.obs;
  List<CameraDescription> cameras = [];

  // 1. Tambahkan state loading untuk UI saat proses API berjalan
  RxBool isLoading = false.obs;

  // 2. TENTUKAN IP ADDRESS LOKAL LAPTOP ANDA (Ganti sesuai hasil ipconfig Anda)
  final String baseUrl = "http://10.83.92.116:5000";

  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  Future<void> initCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) return;

    cameras = await availableCameras();
    if (cameras.isEmpty) return;

    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController!.initialize();
    isCameraInitialized.value = true;
  }

  void changeMode(int index) {
    selectedMode.value = index;
  }

  // 3. SELESAIKAN FUNGSI TAKE PICTURE UNTUK MENGIRIM KE BACKEND FLASK
  Future<void> takePicture() async {

  if (cameraController == null) return;

  if (!cameraController!.value.isInitialized) return;

  if (isLoading.value) return;

  try {

    isLoading.value = true;

    final image =
        await cameraController!.takePicture();

    final request =
        http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/detect"),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        "image",
        image.path,
      ),
    );

    final streamed =
        await request.send();

    final response =
        await http.Response.fromStream(streamed);

    if (response.statusCode == 200) {

      final result =
          jsonDecode(response.body);

      Get.toNamed(
        Routes.DETECTION_RESULT,
        arguments: {
          "imagePath": image.path,
          "result": result,
        },
      );

    } else {

      Get.snackbar(
        "Error",
        response.body,
      );

    }

  } catch(e){

      Get.snackbar(
        "Error",
        e.toString(),
      );

  } finally{

      isLoading.value=false;

  }

}

  Future<void> switchCamera() async {
    if (cameras.length < 2) return;

    final currentLens = cameraController!.description.lensDirection;
    CameraDescription newCamera;

    if (currentLens == CameraLensDirection.back) {
      newCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );
    } else {
      newCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );
    }

    await cameraController?.dispose();
    cameraController = CameraController(
      newCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await cameraController!.initialize();
    isCameraInitialized.value = true;
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../app/routes/app_routes.dart';

class PestDetectionController extends GetxController {

  CameraController? cameraController;

  RxBool isCameraInitialized = false.obs;

  RxInt selectedMode = 0.obs;

  List<CameraDescription> cameras = [];

  @override
  void onInit() {
    super.onInit();

    initCamera();
  }

  Future<void> initCamera() async {

    final status = await Permission.camera.request();

    if (!status.isGranted) {
      return;
    }

    cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

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

  Future<void> takePicture() async {

  if (cameraController == null ||
      !cameraController!.value.isInitialized) {
    return;
  }

  final image = await cameraController!.takePicture();
  (image.path); //perubahan

  /// simulasi processing AI
  await Future.delayed(
    const Duration(seconds: 2),
  );

  /// pindah ke hasil deteksi
  Get.toNamed(
    Routes.DETECTION_RESULT,
  );
}

  Future<void> switchCamera() async {

    if (cameras.length < 2) return;

    final currentLens =
        cameraController!.description.lensDirection;

    CameraDescription newCamera;

    if (currentLens == CameraLensDirection.back) {
      newCamera = cameras.firstWhere(
        (camera) =>
            camera.lensDirection ==
            CameraLensDirection.front,
      );
    } else {
      newCamera = cameras.firstWhere(
        (camera) =>
            camera.lensDirection ==
            CameraLensDirection.back,
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
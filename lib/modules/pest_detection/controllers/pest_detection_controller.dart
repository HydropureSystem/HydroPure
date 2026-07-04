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
  final String baseUrl = "http://192.168.1.25:5000";

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
    if (cameraController == null ||
        !cameraController!.value.isInitialized ||
        isLoading.value) {
      return;
    }

    try {
      isLoading.value = true; // Aktifkan loading di UI

      // Ambil foto secara lokal di HP
      final image = await cameraController!.takePicture();

      // Siapkan request Multipart ke Flask Endpoint /predict
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/predict'),
      );

      // Tambahkan file gambar ke dalam form-data dengan key 'file' (harus cocok dengan Flask)
      request.files.add(await http.MultipartFile.fromPath('file', image.path));

      // Kirim data ke server
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Dekode data JSON dari backend Flask
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Pindah halaman sambil membawa data hasil prediksi AI dari Flask
        Get.toNamed(
          Routes.DETECTION_RESULT,
          arguments: responseData, // Kirim hasil kesini!
        );
      } else {
        Get.snackbar(
          "Error Backend",
          "Gagal memproses gambar (${response.statusCode})",
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error Koneksi",
        "Pastikan laptop dan HP satu Wi-Fi. Detail: $e",
      );
    } finally {
      isLoading.value = false; // Matikan loading
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

import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'http://192.168.1.5:3000',
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
                sendTimeout: const Duration(seconds: 10),
                headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                },
              ),
            );

  Future<Map<String, dynamic>> getAllData() async {
    try {
      final response = await _dio.get('/api/all-data');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          'حدث خطأ في الاستجابة من السيرفر: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'انتهت مهلة الاتصال بالسيرفر - تأكد من أن السيرفر شغال والشبكة متصلة';
      case DioExceptionType.sendTimeout:
        return 'مهلة إرسال البيانات انتهت';
      case DioExceptionType.receiveTimeout:
        return 'السيرفر لم يرد في الوقت المحدد';
      case DioExceptionType.badResponse:
        return 'السيرفر أرجع رد غير متوقع: ${e.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'تم إلغاء الاتصال';
      case DioExceptionType.connectionError:
        return 'فشل الاتصال - تأكد من IP Address والشبكة: ${e.message}';
      default:
        return 'حدث خطأ غير معروف: ${e.message}';
    }
  }
}

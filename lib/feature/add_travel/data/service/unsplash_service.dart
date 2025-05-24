// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class UnsplashService {
  static const String _accessKey =
      'sbprXyclWCTCmu0c4XMkczGBULnWaNDaF_ZN-0kb5Vw';
  static const String _baseUrl = 'https://api.unsplash.com';

  static final Map<String, List<String>> _imageCache = {};
  static final Map<String, Set<int>> _usedPages = {};
  static final Map<String, List<String>> _searchQueries = {};

  static List<String> _generateSearchQueries(String cityName) {
    final baseQueries = [
      '$cityName egypt travel',
      '$cityName city landmark',
      '$cityName architecture',
      '$cityName tourism',
      '$cityName destination',
      '$cityName culture',
      '$cityName street view',
      '$cityName buildings',
      '$cityName landscape',
      '$cityName historical',
      '$cityName modern',
      '$cityName nightlife',
      'egypt $cityName',
      'egyptian $cityName',
      '$cityName market',
      '$cityName mosque',
      '$cityName nile',
      '$cityName desert',
      '$cityName ancient',
      '$cityName temple'
    ];

    baseQueries.shuffle();
    return baseQueries;
  }

  static Future<String?> getCityImage(String cityName) async {
    try {
      final images = await getCityImages(cityName, count: 1);
      return images.isNotEmpty ? images.first : null;
    } catch (e) {
      print('خطأ في جلب الصورة: $e');
      return _getFallbackImage(cityName);
    }
  }

  static Future<List<String>> getCityImages(String cityName,
      {int count = 6}) async {
    try {
      String cleanCityName = cityName.trim().toLowerCase();

      if (!_searchQueries.containsKey(cleanCityName)) {
        _searchQueries[cleanCityName] = _generateSearchQueries(cleanCityName);
      }

      _usedPages[cleanCityName] ??= <int>{};

      List<String> allImageUrls = [];
      final queries = _searchQueries[cleanCityName]!;
      final maxAttempts = min(queries.length, 5);

      for (int attempt = 0;
          attempt < maxAttempts && allImageUrls.length < count;
          attempt++) {
        final query = queries[attempt % queries.length];

        int page = _getUnusedRandomPage(cleanCityName);

        print('🔍 البحث عن صور: $query (صفحة: $page)');

        final response = await http.get(
          Uri.parse(
              '$_baseUrl/search/photos?query=$query&page=$page&per_page=${count * 2}&orientation=landscape&content_filter=high&order_by=relevant'),
          headers: {
            'Authorization': 'Client-ID $_accessKey',
            'Accept-Version': 'v1',
          },
        ).timeout(const Duration(seconds: 15));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List results = data['results'] ?? [];

          if (results.isNotEmpty) {
            List<String> newImageUrls = results
                .map((photo) => photo['urls']['regular'] as String)
                .where((url) => url.isNotEmpty && !allImageUrls.contains(url))
                .toList();

            newImageUrls.shuffle();

            allImageUrls.addAll(newImageUrls.take(count - allImageUrls.length));

            print('تم العثور على ${newImageUrls.length} صورة جديدة');
          }
        } else {
          print('خطأ في API: ${response.statusCode}');
        }

        if (attempt < maxAttempts - 1) {
          await Future.delayed(const Duration(milliseconds: 200));
        }
      }

      if (allImageUrls.length < count) {
        final randomImages =
            await _getRandomImages(cleanCityName, count - allImageUrls.length);
        allImageUrls.addAll(randomImages);
      }

      allImageUrls = _removeSimilarImages(allImageUrls);

      _imageCache[cleanCityName] = allImageUrls;

      print('إجمالي الصور المُستلمة: ${allImageUrls.length}');

      return allImageUrls.take(count).toList();
    } catch (e) {
      print('خطأ في جلب الصور من Unsplash: $e');
      return _generateFallbackImages(cityName, count);
    }
  }

  static int _getUnusedRandomPage(String cityName) {
    final usedPages = _usedPages[cityName]!;
    final maxPage = 50;

    if (usedPages.length >= maxPage) {
      usedPages.clear();
    }

    int page;
    do {
      page = Random().nextInt(maxPage) + 1;
    } while (usedPages.contains(page));

    usedPages.add(page);
    return page;
  }

  static Future<List<String>> _getRandomImages(
      String cityName, int count) async {
    try {
      print('جلب صور عشوائية إضافية...');

      final response = await http.get(
        Uri.parse(
            '$_baseUrl/photos/random?query=$cityName egypt&orientation=landscape&content_filter=high&count=$count'),
        headers: {
          'Authorization': 'Client-ID $_accessKey',
          'Accept-Version': 'v1',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<String> imageUrls = [];
        if (data is List) {
          imageUrls = data
              .map((photo) => photo['urls']['regular'] as String)
              .where((url) => url.isNotEmpty)
              .toList();
        } else if (data is Map<String, dynamic>) {
          final url = data['urls']?['regular'] as String?;
          if (url != null && url.isNotEmpty) {
            imageUrls.add(url);
          }
        }

        return imageUrls;
      }
    } catch (e) {
      print('خطأ في جلب الصور العشوائية: $e');
    }

    return [];
  }

  static List<String> _removeSimilarImages(List<String> imageUrls) {
    final uniqueImages = <String>[];
    final seenHashes = <String>{};

    for (final url in imageUrls) {
      final imageId = _extractImageId(url);
      if (imageId != null && !seenHashes.contains(imageId)) {
        seenHashes.add(imageId);
        uniqueImages.add(url);
      }
    }

    return uniqueImages;
  }

  static String? _extractImageId(String url) {
    try {
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;

      for (final segment in pathSegments) {
        if (segment.length > 10 &&
            RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(segment)) {
          return segment;
        }
      }
    } catch (e) {
      //
    }
    return null;
  }

  static List<String> _generateFallbackImages(String cityName, int count) {
    final fallbackSources = [
      'https://source.unsplash.com/800x400/?$cityName,egypt,travel',
      'https://source.unsplash.com/800x400/?$cityName,city,architecture',
      'https://source.unsplash.com/800x400/?$cityName,landmark,tourism',
      'https://source.unsplash.com/800x400/?egypt,$cityName,culture',
      'https://source.unsplash.com/800x400/?$cityName,destination,travel',
      'https://picsum.photos/800/400?random=${cityName.hashCode}',
      'https://picsum.photos/800/400?random=${cityName.hashCode + 1}',
      'https://picsum.photos/800/400?random=${cityName.hashCode + 2}',
    ];

    return List.generate(count, (index) {
      final sourceIndex = (cityName.hashCode + index) % fallbackSources.length;
      return '${fallbackSources[sourceIndex]}&seed=${DateTime.now().millisecondsSinceEpoch + index}';
    });
  }

  static String _getFallbackImage(String cityName) {
    return _generateFallbackImages(cityName, 1).first;
  }

  static Future<bool> isImageUrlValid(String imageUrl) async {
    try {
      final response = await http.head(
        Uri.parse(imageUrl),
        headers: {
          'User-Agent': 'Travel App/1.0',
        },
      ).timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (e) {
      print('خطأ في التحقق من صحة الرابط: $e');
      return false;
    }
  }

  static void clearCache() {
    _imageCache.clear();
    _usedPages.clear();
    _searchQueries.clear();
    print('تم مسح cache الصور والصفحات المستخدمة');
  }

  static void clearCacheForCity(String cityName) {
    final cleanName = cityName.trim().toLowerCase();
    _imageCache.remove(cleanName);
    _usedPages.remove(cleanName);
    _searchQueries.remove(cleanName);
    print('تم مسح cache للمدينة: $cityName');
  }

  static Map<String, dynamic> getCacheInfo() {
    return {
      'cached_cities': _imageCache.keys.toList(),
      'used_pages':
          _usedPages.map((key, value) => MapEntry(key, value.toList())),
      'search_queries': _searchQueries,
    };
  }

  static Future<bool> checkApiStatus() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/photos/random?count=1'),
        headers: {
          'Authorization': 'Client-ID $_accessKey',
          'Accept-Version': 'v1',
        },
      ).timeout(const Duration(seconds: 10));

      return response.statusCode == 200;
    } catch (e) {
      print('خطأ في التحقق من حالة API: $e');
      return false;
    }
  }

  static Future<List<String>> getRefreshedImages(String cityName,
      {int count = 6}) async {
    clearCacheForCity(cityName);
    return await getCityImages(cityName, count: count);
  }
}

import 'package:get/get.dart';
import '../models/article_model.dart';
import '../services/api_service.dart';

class ApiController extends GetxController {
  var articles = <ArticleModel>[].obs;
  var isLoading = false.obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  void fetchArticles() async {
    try {
      isLoading.value = true;
      articles.value = await apiService.fetchArticles();
    } finally {
      isLoading.value = false;
    }
  }
}

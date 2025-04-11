import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/api_controller.dart';

class ApiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ApiController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Berita Terkini",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.articles.isEmpty) {
          return Center(
              child: Text(
                "Tidak ada artikel tersedia.",
                style: GoogleFonts.poppins(fontSize: 16),
              ));
        }

        return ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: controller.articles.length,
          itemBuilder: (context, index) {
            final article = controller.articles[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed('/webview', arguments: article.url);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thumbnail Gambar
                    ClipRRect(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15)),
                      child: article.urlToImage.isNotEmpty
                          ? Image.network(
                        article.urlToImage,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        height: 180,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: Icon(Icons.image, size: 50),
                      ),
                    ),
                    // Isi konten
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6),
                          Text(
                            article.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                article.publishedAt.split("T").first,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios,
                                  size: 14, color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

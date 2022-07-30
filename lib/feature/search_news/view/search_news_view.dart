import 'package:dio_rest_api/feature/search_news/controller/search_news_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio_rest_api/core/widget/drawer.dart';

class SearchNewsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchNewsController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      drawer: getAppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller.searchTextController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(child: Obx(() {
            return controller.isLoading.isTrue
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.articles.isEmpty
                    ? Center(
                        child: Text("No news found"),
                      )
                    : Container(
                        margin: const EdgeInsets.all(10),
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                controller.articles[index].urlToImage == null
                                    ? Container()
                                    : Image.network(
                                        controller.articles[index].urlToImage),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  controller.articles[index].title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  controller.articles[index].description,
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: controller.articles.length,
                        ),
                      );
          }))
        ],
      ),
    );
  }
}

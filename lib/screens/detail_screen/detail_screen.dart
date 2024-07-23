import 'dart:io';
import 'dart:typed_data';
import 'package:bhagwat_geeta/utils/colors.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';
import '../../provider/shloks_provider.dart';
import '../../utils/global.dart';
import '../home_screen/provider/home_screen_provider.dart';
import '../home_screen/view/home_screen.dart';
import 'dart:ui' as ui;

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homeScreenProviderFalse =
        Provider.of<HomeScreenProvider>(context, listen: false);
    var homeScreenProvideTrue =
        Provider.of<HomeScreenProvider>(context, listen: true);
    var gitaProvider = Provider.of<GitaProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        scrolledUnderElevation: 0.1,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: Text(translate[homeScreenProvideTrue.languageIndex]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 15.0,
            ),
            child: Consumer<HomeScreenProvider>(
              builder: (context, value, child) => InkWell(
                onTap: () {
                  homeScreenProviderFalse.translateLanguage();
                },
                child: const Icon(
                  Icons.translate,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/img/gita2.jpg'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  verses.length,
                  (index) => shloksContainer(
                    height: height,
                    width: width,
                    gitaProvider: gitaProvider,
                    index: index,
                    homeScreenProviderTrue: homeScreenProvideTrue,
                    context: context,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container shloksContainer({
    required double height,
    required double width,
    required GitaProvider gitaProvider,
    required int index,
    required HomeScreenProvider homeScreenProviderTrue,
    required context,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      width: width,
      decoration: BoxDecoration(
        color: color1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectableText(
            (homeScreenProviderTrue.languageIndex == 0)
                ? gitaProvider.gitaModalList[selectedIndex].verses[index]
                    .language.sanskrit
                : (homeScreenProviderTrue.languageIndex == 1)
                    ? gitaProvider.gitaModalList[selectedIndex].verses[index]
                        .language.hindi
                    : (homeScreenProviderTrue.languageIndex == 2)
                        ? gitaProvider.gitaModalList[selectedIndex]
                            .verses[index].language.english
                        : gitaProvider.gitaModalList[selectedIndex]
                            .verses[index].language.gujarati,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            cursorColor: Colors.blue,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog.fullscreen(
                      backgroundColor: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RepaintBoundary(
                              key: repaintKey,
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/img/bg2.jpg'),
                                  ),
                                ),
                                child: Text(
                                  (homeScreenProviderTrue.languageIndex == 0)
                                      ? gitaProvider
                                          .gitaModalList[selectedIndex]
                                          .verses[index]
                                          .language
                                          .sanskrit
                                      : (homeScreenProviderTrue.languageIndex ==
                                              1)
                                          ? gitaProvider
                                              .gitaModalList[selectedIndex]
                                              .verses[index]
                                              .language
                                              .hindi
                                          : (homeScreenProviderTrue
                                                      .languageIndex ==
                                                  2)
                                              ? gitaProvider
                                                  .gitaModalList[selectedIndex]
                                                  .verses[index]
                                                  .language
                                                  .english
                                              : gitaProvider
                                                  .gitaModalList[selectedIndex]
                                                  .verses[index]
                                                  .language
                                                  .gujarati,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  RenderRepaintBoundary boundary = repaintKey
                                          .currentContext!
                                          .findRenderObject()
                                      as RenderRepaintBoundary;

                                  ui.Image image = await boundary.toImage();
                                  ByteData? byteData = await image.toByteData(
                                      format: ui.ImageByteFormat.png);

                                  Uint8List img =
                                      byteData!.buffer.asUint8List();

                                  final imgPath =
                                      await getApplicationDocumentsDirectory();
                                  final file = File("${imgPath.path}/img.png");

                                  file.writeAsBytes(img);
                                  ShareExtend.share(file.path, 'image');
                                },
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  RenderRepaintBoundary boundary = repaintKey
                                          .currentContext!
                                          .findRenderObject()
                                      as RenderRepaintBoundary;

                                  ui.Image image = await boundary.toImage();

                                  ByteData? byteData = await image.toByteData(
                                      format: ui.ImageByteFormat.png);

                                  Uint8List img =
                                      byteData!.buffer.asUint8List();

                                  ImageGallerySaver.saveImage(img);
                                },
                                icon: const Icon(
                                  Icons.save_alt,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  FlutterClipboard.copy(
                    (homeScreenProviderTrue.languageIndex == 0)
                        ? gitaProvider.gitaModalList[selectedIndex]
                            .verses[index].language.sanskrit
                        : (homeScreenProviderTrue.languageIndex == 1)
                            ? gitaProvider.gitaModalList[selectedIndex]
                                .verses[index].language.hindi
                            : (homeScreenProviderTrue.languageIndex == 2)
                                ? gitaProvider.gitaModalList[selectedIndex]
                                    .verses[index].language.english
                                : gitaProvider.gitaModalList[selectedIndex]
                                    .verses[index].language.gujarati,
                  );
                },
                icon: const Icon(
                  Icons.copy,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

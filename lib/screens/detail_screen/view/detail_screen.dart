import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:bhagwat_geeta/screens/detail_screen/provider/detail_screen_provider.dart';
import 'package:bhagwat_geeta/utils/colors.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';
import '../../../provider/shloks_provider.dart';
import '../../../utils/global.dart';
import '../../home_screen/provider/home_screen_provider.dart';
import '../../home_screen/view/home_screen.dart';
import 'dart:ui' as ui;

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homeScreenProviderFalse =
        Provider.of<HomeScreenProvider>(context, listen: false);
    var homeScreenProvideTrue =
        Provider.of<HomeScreenProvider>(context, listen: true);
    var detailScreenProviderTrue =
        Provider.of<DetailScreenProvider>(context, listen: true);
    var detailScreenProviderFalse =
        Provider.of<DetailScreenProvider>(context, listen: false);
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
        title: Text(
          (detailScreenProviderTrue.selectedLanguage == 'Sanskrit')
              ? gitaProvider.gitaModalList[selectedIndex].chapterName.sanskrit
              : (detailScreenProviderTrue.selectedLanguage == 'Hindi')
                  ? gitaProvider.gitaModalList[selectedIndex].chapterName.hindi
                  : (detailScreenProviderTrue.selectedLanguage == 'English')
                      ? gitaProvider
                          .gitaModalList[selectedIndex].chapterName.english
                      : gitaProvider
                          .gitaModalList[selectedIndex].chapterName.gujarati,
        ),
        actions: [
          DropdownButton(
            value: detailScreenProviderTrue.selectedLanguage,
            onChanged: (String? value) {
              detailScreenProviderFalse.languageTranslate(value!);
            },
            items: <String>['Sanskrit', 'Hindi', 'English', 'Gujarati']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     right: 15.0,
          //   ),
          //   child: Consumer<HomeScreenProvider>(
          //     builder: (context, value, child) => InkWell(
          //       onTap: () {
          //         homeScreenProviderFalse.translateLanguage();
          //       },
          //       child: const Icon(
          //         Icons.translate,
          //         size: 30,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(imageListOfChapters[selectedIndex]),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   height: height * 0.4,
                //   width: width,
                //   child: Image.asset(
                //     'assets/img/gita3.png',
                //     fit: BoxFit.cover,
                //   ),
                // ),
                // SizedBox(
                //   height: height * 0.02,
                // ),
                ...List.generate(
                  verses.length,
                  (index) => shloksContainer(
                    height: height,
                    width: width,
                    gitaProvider: gitaProvider,
                    index: index,
                    homeScreenProviderTrue: homeScreenProvideTrue,
                    context: context,
                    detailScreenProviderTrue: detailScreenProviderTrue,
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
    required DetailScreenProvider detailScreenProviderTrue,
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
            (detailScreenProviderTrue.selectedLanguage == 'Sanskrit')
                ? gitaProvider.gitaModalList[selectedIndex].verses[index]
                    .language.sanskrit
                : (detailScreenProviderTrue.selectedLanguage == 'Hindi')
                    ? gitaProvider.gitaModalList[selectedIndex].verses[index]
                        .language.hindi
                    : (detailScreenProviderTrue.selectedLanguage == 'English')
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
                  Random random = Random();
                  int x = random.nextInt(imageList.length);
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
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(imageList[x]),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      (detailScreenProviderTrue
                                                  .selectedLanguage ==
                                              'Sanskrit')
                                          ? gitaProvider
                                              .gitaModalList[selectedIndex]
                                              .chapterName
                                              .sanskrit
                                          : (detailScreenProviderTrue
                                                      .selectedLanguage ==
                                                  'Hindi')
                                              ? gitaProvider
                                                  .gitaModalList[selectedIndex]
                                                  .chapterName
                                                  .hindi
                                              : (detailScreenProviderTrue
                                                          .selectedLanguage ==
                                                      'English')
                                                  ? gitaProvider
                                                      .gitaModalList[
                                                          selectedIndex]
                                                      .chapterName
                                                      .english
                                                  : gitaProvider
                                                      .gitaModalList[
                                                          selectedIndex]
                                                      .chapterName
                                                      .gujarati,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.03,
                                    ),
                                    Text(
                                      (detailScreenProviderTrue
                                                  .selectedLanguage ==
                                              'Sanskrit')
                                          ? gitaProvider
                                              .gitaModalList[selectedIndex]
                                              .verses[index]
                                              .language
                                              .sanskrit
                                          : (detailScreenProviderTrue
                                                      .selectedLanguage ==
                                                  'Hindi')
                                              ? gitaProvider
                                                  .gitaModalList[selectedIndex]
                                                  .verses[index]
                                                  .language
                                                  .hindi
                                              : (detailScreenProviderTrue
                                                          .selectedLanguage ==
                                                      'English')
                                                  ? gitaProvider
                                                      .gitaModalList[
                                                          selectedIndex]
                                                      .verses[index]
                                                      .language
                                                      .english
                                                  : gitaProvider
                                                      .gitaModalList[
                                                          selectedIndex]
                                                      .verses[index]
                                                      .language
                                                      .gujarati,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
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

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(10),
                                      content: Text('Saved to the gallery!'),
                                    ),
                                  );

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
                    (detailScreenProviderTrue.selectedLanguage == 'Sanskrit')
                        ? gitaProvider.gitaModalList[selectedIndex]
                            .verses[index].language.sanskrit
                        : (detailScreenProviderTrue.selectedLanguage == 'Hindi')
                            ? gitaProvider.gitaModalList[selectedIndex]
                                .verses[index].language.hindi
                            : (detailScreenProviderTrue.selectedLanguage ==
                                    'English')
                                ? gitaProvider.gitaModalList[selectedIndex]
                                    .verses[index].language.english
                                : gitaProvider.gitaModalList[selectedIndex]
                                    .verses[index].language.gujarati,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(10),
                      content: Text('Copied to clipboard'),
                    ),
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

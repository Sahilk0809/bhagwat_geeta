import 'package:bhagwat_geeta/provider/shloks_provider.dart';
import 'package:bhagwat_geeta/screens/home_screen/provider/home_screen_provider.dart';
import 'package:bhagwat_geeta/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/global.dart';
import '../../detail_screen/provider/detail_screen_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  get languageIndex => null;

  @override
  Widget build(BuildContext context) {
    var homeScreenProviderFalse =
        Provider.of<HomeScreenProvider>(context, listen: false);
    var homeScreenProvideTrue =
        Provider.of<HomeScreenProvider>(context, listen: true);
    var gitaProvider = Provider.of<GitaProvider>(context);
    var detailScreenProviderTrue =
        Provider.of<DetailScreenProvider>(context, listen: true);
    var detailScreenProviderFalse =
        Provider.of<DetailScreenProvider>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        scrolledUnderElevation: 0.1,
        centerTitle: true,
        leading: const Icon(
          Icons.account_circle_outlined,
          size: 30,
        ),
        title: Text(
          (detailScreenProviderTrue.selectedLanguage == 'Sanskrit')
              ? translate[0]
              : (detailScreenProviderTrue.selectedLanguage == 'Hindi')
                  ? translate[1]
                  : (detailScreenProviderTrue.selectedLanguage == 'English')
                      ? translate[2]
                      : translate[3],
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
        child: SingleChildScrollView(
          child: Consumer<GitaProvider>(
            builder: (context, value, child) => Column(
              children: [
                ...List.generate(
                  gitaProvider.gitaModalList.length,
                  (index) => GestureDetector(
                    onTap: () {
                      selectedIndex = index;
                      verses = gitaProvider.gitaModalList[selectedIndex].verses;
                      Navigator.of(context).pushNamed('/detail');
                    },
                    child: adhyayContainer(
                      height: height,
                      width: width,
                      gitaProvider: gitaProvider,
                      index: index,
                      homeScreenProviderTrue: homeScreenProvideTrue,
                      detailScreenProviderTrue: detailScreenProviderTrue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container adhyayContainer(
      {required double height,
      required double width,
      required GitaProvider gitaProvider,
      required int index,
      required HomeScreenProvider homeScreenProviderTrue,
      required DetailScreenProvider detailScreenProviderTrue}) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      padding: const EdgeInsets.all(30),
      // height: height * 0.12,
      width: width * 0.95,
      decoration: BoxDecoration(
        color: color1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        (detailScreenProviderTrue.selectedLanguage == 'Sanskrit')
            ? gitaProvider.gitaModalList[index].chapterName.sanskrit
            : (detailScreenProviderTrue.selectedLanguage == 'Hindi')
                ? gitaProvider.gitaModalList[index].chapterName.hindi
                : (detailScreenProviderTrue.selectedLanguage == 'English')
                    ? gitaProvider
                        .gitaModalList[index].chapterName.english
                    : gitaProvider
                        .gitaModalList[index].chapterName.gujarati,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    );
  }
}

List translate = [
  'अध्यायः',
  'अध्याय',
  'Chapter',
  'પ્રકરણ',
];

int selectedIndex = 0;

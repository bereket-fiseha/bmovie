import 'package:bmovie/provider/themesettingprovider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AppSetting extends StatefulWidget {
  const AppSetting({super.key});

  @override
  State<AppSetting> createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  bool playerXEditable = false;
  bool playerOEditable = false;
  final TextEditingController _playerXEditingController =
      TextEditingController();
  final TextEditingController _playerOEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Setting"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).backgroundColor),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Consumer<ThemeSettingProvider>(
                          builder: ((context, provider, child) =>
                              SwitchListTile(
                                title: const Text("Armold Mode"),
                                value: provider.isCustomThemeEnabled(),
                                secondary: const Icon(FontAwesomeIcons.themeco,
                                    color: Color.fromARGB(217, 243, 171, 46)),
                                onChanged: (bool value) {
                                  provider.toggleCustomTheme(value);
                                },
                              )),
                        ),
                        Consumer<ThemeSettingProvider>(
                          builder: ((context, provider, child) =>
                              SwitchListTile(
                                title: const Text("Dark Mode"),
                                value: provider.isDarkModeEnabled(),
                                secondary: const Icon(Icons.dark_mode_rounded,
                                    color: Color.fromARGB(217, 243, 171, 46)),
                                onChanged: (bool value) {
                                  provider.toggleDarkMode(value);
                                },
                              )),
                        )
                      ])),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

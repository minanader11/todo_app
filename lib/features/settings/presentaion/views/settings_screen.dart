import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_config_provider.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    List<String> dropdownThemes = [
      AppLocalizations.of(context)!.light,
      AppLocalizations.of(context)!.dark
    ];

    List<String> dropdownLanguage = [
      AppLocalizations.of(context)!.english,
      AppLocalizations.of(context)!.arabic
    ];

    var configProvider = Provider.of<AppConfigProvider>(context);
    String selectedTheme = configProvider.themeMode == ThemeMode.light
        ? AppLocalizations.of(context)!.light
        : AppLocalizations.of(context)!.dark;
    String selectedLanguage = configProvider.language == 'en'
        ? AppLocalizations.of(context)!.english
        : AppLocalizations.of(context)!.arabic;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.app_title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        ),

        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppLocalizations.of(context)!.language),
              const SizedBox(
                height: 23,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: MyTheme.primaryColor),
                    color: configProvider.themeMode == ThemeMode.light
                        ? MyTheme.whiteColor
                        : MyTheme.blackColor),
                child: DropdownButton(
                  dropdownColor: configProvider.themeMode == ThemeMode.light
                      ? MyTheme.whiteColor
                      : MyTheme.blackColor,
                  underline: const SizedBox(),
                  isExpanded: true,
                  value: selectedLanguage,
                  items: dropdownLanguage.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    selectedLanguage = value!;
                    if (selectedLanguage ==
                        AppLocalizations.of(context)!.english) {
                      configProvider.changeLanguage('en');

                    } else {
                      configProvider.changeLanguage('ar');
                    }
                    setState(() {});
                  },
                  style: configProvider.themeMode == ThemeMode.light
                      ? Theme.of(context).textTheme.bodyMedium
                      : Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: MyTheme.primaryColor),
                  itemHeight: 50,
                ),
              ),
              const SizedBox(
                height: 23,
              ),
              Text(AppLocalizations.of(context)!.theme),
              const SizedBox(
                height: 23,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: MyTheme.primaryColor),
                    color: configProvider.themeMode == ThemeMode.light
                        ? MyTheme.whiteColor
                        : MyTheme.blackColor),
                child: DropdownButton(
                  dropdownColor: configProvider.themeMode == ThemeMode.light
                      ? MyTheme.whiteColor
                      : MyTheme.blackColor,
                  underline: const SizedBox(),
                  isExpanded: true,
                  value: selectedTheme,
                  items: dropdownThemes.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    selectedTheme = value!;
                    configProvider.changeTheme(selectedTheme);
                    setState(() {});
                  },
                  style: configProvider.themeMode == ThemeMode.light
                      ? Theme.of(context).textTheme.bodyMedium
                      : Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: MyTheme.primaryColor),
                  itemHeight: 50,
                ),
              ),
            ],
          ),
        ));
  }
}

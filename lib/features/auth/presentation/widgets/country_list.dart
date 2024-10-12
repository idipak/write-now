import 'package:country_list_pick/support/code_countries_en.dart';
import 'package:flutter/material.dart';


class CountryList extends StatelessWidget {
  final String? groupValue;
  final Function(String, String) onSelection;
  const CountryList({super.key, this.groupValue, required this.onSelection});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: countriesEnglish.length,
        itemBuilder: (context, index){
          final country = countriesEnglish[index];
          final flagUrl = 'flags/${country['code'].toLowerCase()}.png';
          final dialCode = country['dial_code'];
          return RadioListTile(
            controlAffinity: ListTileControlAffinity.trailing,
            value: dialCode,
            groupValue: groupValue,
            onChanged: (val){
              onSelection(dialCode, flagUrl);
            },
            title: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage(flagUrl, package: 'country_list_pick',),
                ),
                const SizedBox(width: 8,),
                Expanded(
                    child: Text('${country['name']}($dialCode)',
                      style: Theme.of(context).textTheme.labelMedium,)),
              ],
            ),
          );
        });
  }
}


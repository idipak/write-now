import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/widgets/custom_text_form_fields.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/svg_assets.dart';


class ShareViaChatSection extends StatelessWidget {
  const ShareViaChatSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: SizedBox(
        height: 420,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Share via chat', style: Theme.of(context).textTheme.bodyLarge,),
                const SizedBox(height: 16,),
                TextFormFieldFilled(
                  hintText: 'Write some message...',
                  leadingIcon: SvgPicture.asset(SvgAssets.editPen, height: 24, width: 24, fit: BoxFit.scaleDown,),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: TextFormFieldFilled(
                    hintText: 'Search Connections',
                    leadingIcon: SvgPicture.asset(SvgAssets.magnifier, height: 24, width: 24, fit: BoxFit.scaleDown,),
                  ),
                ),

                SizedBox(
                  height: 194,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _userTile(context, false),
                      _userTile(context, true),
                      _userTile(context, false),
                      _userTile(context, false),
                    ],
                  ),
                ),

                MaterialButton(
                  onPressed: (){
                    print("LINK");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.white,
                        margin: const EdgeInsets.only(bottom: 70, left: 16, right: 16),
                        content: Row(
                          children: [
                            const Icon(Icons.check, color: kDarkGrey, size: 16,),
                            const SizedBox(width: 4,),
                            Text('Link Copied', style: Theme.of(context).textTheme.bodyMedium,),
                          ],
                        )));
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: kAppBlue)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(SvgAssets.link),
                      const SizedBox(width: 4,),
                      Text('Copy Link', style: Theme.of(context).textTheme.titleSmall,)
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userTile(BuildContext context, bool shared){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/temp/avatar.jpeg'),
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Floyed Miles'),
                Text('@ann_rime', style: Theme.of(context).textTheme.bodySmall,)
              ],
            ),
          ),
          IconButton(
              onPressed: (){

              },
              icon: shared
                  ? SvgPicture.asset(SvgAssets.msgTick)
                  : SvgPicture.asset(SvgAssets.sendButtonOutlined))
        ],
      ),
    );
  }

}


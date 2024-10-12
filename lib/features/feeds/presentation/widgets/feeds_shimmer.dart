import 'package:bhealth/features/feeds/presentation/widgets/post_item_card.dart';
import 'package:bhealth/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeedsShimmer extends StatelessWidget {
  final bool hideImageBox;
  const FeedsShimmer({super.key, this.hideImageBox = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 460,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
      ),
      width: double.infinity,
      // color: Colors.white,
      child: Shimmer.fromColors(
          baseColor: kGrey200,
          highlightColor: Colors.white,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 22,
                  ),
                  const SizedBox(width: 6,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      circularLine(width: 70),
                      circularLine(width: 70, height: 12),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 16,),
            circularLine(),
            circularLine(),
            circularLine(),
            Padding(
              padding: const EdgeInsets.only(right: 120.0),
              child: circularLine(),
            ),

            if(!hideImageBox)
            const SizedBox(height: 16,),

            if(!hideImageBox)
            Container(
              height: 210,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey
              ),
            ),

            const SizedBox(height: 16,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                twoDots(),
                twoDots(),
                twoDots(),
                twoDots(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget twoDots(){
    return Row(
      children: [
        circularLine(width: 16, height: 16),
        const SizedBox(width: 4,),
        circularLine(width: 28, height: 16)
      ],
    );
  }

  Widget circularLine({double height = 16, double width = double.infinity}){
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey
      ),
    );
  }
}

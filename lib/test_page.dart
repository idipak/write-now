import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  static const route = '/test-route';
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Text("Normal Text"),
          Text("Normal Text", style: Theme.of(context).textTheme.bodyMedium),

          Text("BodySmall", style: Theme.of(context).textTheme.bodySmall,),
          Text("BodyMedium", style: Theme.of(context).textTheme.bodyMedium,),
          Text("BodyLarge", style: Theme.of(context).textTheme.bodyLarge,),
          Text("TitleSmall", style: Theme.of(context).textTheme.titleSmall,),
          Text("TitleMedium", style: Theme.of(context).textTheme.titleMedium,),
          Text("TitleLarge", style: Theme.of(context).textTheme.titleLarge,),
          Text("DisplayLarge", style: Theme.of(context).textTheme.displayLarge,),
          Text("DisplayMedium", style: Theme.of(context).textTheme.displayMedium,),
          Text("DisplaySmall", style: Theme.of(context).textTheme.displaySmall,),
          Text("HeadlineLarge", style: Theme.of(context).textTheme.headlineLarge,),
          Text("HeadlineMedium", style: Theme.of(context).textTheme.headlineMedium,),
          Text("HeadlineSmall", style: Theme.of(context).textTheme.headlineSmall,),
          Text("labelLarge", style: Theme.of(context).textTheme.labelLarge,),
          Text("LabelMedium", style: Theme.of(context).textTheme.labelMedium,),
          Text("labelSmall", style: Theme.of(context).textTheme.labelSmall,),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueAccent
            ),
            child: MaterialButton(

              onPressed: (){
              showModalBottomSheet(
                  showDragHandle: true,
                  context: context, builder: (context){
                return SizedBox(height: 600, width: double.infinity,);
              });
            }, child: Text('Material Button'),),
          )
        ],
      ),
    );
  }
}

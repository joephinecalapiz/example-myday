import 'package:flutter/material.dart';



class DetailsPage extends StatefulWidget {
  final int detail;

  const DetailsPage({Key? key, required this.detail}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {
    var details;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details Page'),
        ),
        body: ListView(
            padding: const EdgeInsets.only(left:2),
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                  title: Column(
                    children: [
                      const Expanded (
                        flex: 3,
                        child: Text('ID number'),
                      ),
                      Expanded (
                        flex: 7,
                        child: Text(': ${details.id}'),
                      ),
                    ],
                  )
              )
            ]
        )

    );
  }
}

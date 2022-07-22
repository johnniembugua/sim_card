import 'package:carrier_info/carrier_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  CarrierData? carrierInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Ask for permissions before requesting data
    await [
      Permission.locationWhenInUse,
      Permission.phone,
    ].request();

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      carrierInfo = await CarrierInfo.all;
      setState(() {});
    } catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrier Info example app'),
      ),
      backgroundColor: CupertinoColors.lightBackgroundGray,
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'CARRIER INFORMATION',
                  style: TextStyle(
                    fontSize: 11,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
              HomeItem(
                title: 'Name',
                value: carrierInfo!.carrierName!,
                isFirst: true,
              ),
              HomeItem(
                title: 'Country Code',
                value: carrierInfo!.isoCountryCode!,
              ),
              HomeItem(
                title: 'Mobile Country Code',
                value: carrierInfo?.mobileCountryCode,
              ),
              HomeItem(
                title: 'Mobile Network Operator',
                value: '${carrierInfo?.mobileNetworkOperator}',
              ),
              HomeItem(
                title: 'Mobile Network Code',
                value: '${carrierInfo?.mobileNetworkCode}',
              ),
              HomeItem(
                title: 'Allows VOIP',
                value: '${carrierInfo?.allowsVOIP}',
              ),
              HomeItem(
                title: 'Radio Type',
                value: '${carrierInfo?.radioType}',
              ),
              HomeItem(
                title: 'Network Generation',
                value: '${carrierInfo?.networkGeneration}',
              ),
              HomeItem(
                title: 'Cell Id (cid)',
                value: '${carrierInfo?.cid.toString()}',
              ),
              HomeItem(
                title: 'Local Area Code (lac)',
                value: '${carrierInfo?.lac.toString()}',
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HomeItem extends StatelessWidget {
  final bool isFirst;
  final String title;
  final String? value;
  const HomeItem({
    Key? key,
    required this.title,
    this.value,
    this.isFirst = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          if (!isFirst)
            Container(height: 0.5, color: Colors.grey.withOpacity(0.3)),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Text(title),
                Spacer(),
                Text(value!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

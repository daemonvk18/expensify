import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cloud_service_controller.dart';

class CloudServiceView extends GetView<CloudServiceController> {
  const CloudServiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CloudServiceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CloudServiceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

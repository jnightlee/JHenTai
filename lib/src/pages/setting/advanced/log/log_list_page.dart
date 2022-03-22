import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jhentai/src/utils/log.dart';
import 'package:path/path.dart';

import '../../../../routes/routes.dart';

class LogListPage extends StatefulWidget {
  const LogListPage({Key? key}) : super(key: key);

  @override
  _LogListPageState createState() => _LogListPageState();
}

class _LogListPageState extends State<LogListPage> {
  late List<io.FileSystemEntity> logs;

  @override
  void initState() {
    io.Directory logDir = io.Directory(Log.logPath);
    logs = logDir.listSync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('logList'.tr),
        elevation: 1,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: logs.reversed
            .map(
              (log) => ListTile(
                title: Text(basename(log.path)),
                onTap: () => Get.toNamed(Routes.log, arguments: log),
              ),
            )
            .toList(),
      ),
    );
  }
}
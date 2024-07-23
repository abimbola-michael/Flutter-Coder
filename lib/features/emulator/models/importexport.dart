// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ImportExport {
  bool export;
  String package;
  String filename;
  ImportExport({
    this.export = false,
    required this.package,
    required this.filename,
  });
}


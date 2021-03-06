// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

/// Generates a single-line comment for each class
class CommentGenerator extends Generator {
  final bool forClasses, forLibrary;

  const CommentGenerator({this.forClasses: true, this.forLibrary: false});

  @override
  Future<String> generate(Element element, _) async {
    if (forClasses && element is ClassElement) {
      if (element.displayName.contains('GoodError')) {
        throw new InvalidGenerationSourceError(
            "Don't use classes with the word 'Error' in the name",
            todo: "Rename ${element.displayName} to something else.");
      }

      if (element.displayName.contains('Error')) {
        throw new ArgumentError.value(
            element,
            'element',
            "We don't support class names with the word 'Error'.\n"
            "Try renaming the class.");
      }

      return '// Code for "$element"';
    }

    if (forLibrary && element is LibraryElement) {
      return '// Code for "$element"';
    }
    return null;
  }

  String toString() => 'CommentGenerator';
}

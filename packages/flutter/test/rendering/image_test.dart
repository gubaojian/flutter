// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' as ui show Image;

import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'rendering_tester.dart';

class SquareImage implements ui.Image {
  @override
  int get width => 10;

  @override
  int get height => 10;

  @override
  String toString() => '[$width\u00D7$height]';

  @override
  void dispose() { }
}

class WideImage implements ui.Image {
  @override
  int get width => 20;

  @override
  int get height => 10;

  @override
  String toString() => '[$width\u00D7$height]';

  @override
  void dispose() { }
}

class TallImage implements ui.Image {
  @override
  int get width => 10;

  @override
  int get height => 20;

  @override
  String toString() => '[$width\u00D7$height]';

  @override
  void dispose() { }
}

void main() {
  test('Image sizing', () {
    RenderImage image;

    image = new RenderImage(image: new SquareImage());
    layout(image,
          constraints: const BoxConstraints(
              minWidth: 25.0,
              minHeight: 25.0,
              maxWidth: 100.0,
              maxHeight: 100.0));
    expect(image.size.width, equals(25.0));
    expect(image.size.height, equals(25.0));

    expect(image, hasAGoodToStringDeep);
    expect(
      image.toStringDeep(minLevel: DiagnosticLevel.info),
      equalsIgnoringHashCodes(
        'RenderImage#00000 relayoutBoundary=up2 NEEDS-PAINT\n'
        '   parentData: <none> (can use size)\n'
        '   constraints: BoxConstraints(25.0<=w<=100.0, 25.0<=h<=100.0)\n'
        '   size: Size(25.0, 25.0)\n'
        '   image: [10×10]\n'
      ),
    );

    image = new RenderImage(image: new WideImage());
    layout(image,
           constraints: const BoxConstraints(
              minWidth: 5.0,
              minHeight: 30.0,
              maxWidth: 100.0,
              maxHeight: 100.0));
    expect(image.size.width, equals(60.0));
    expect(image.size.height, equals(30.0));

    image = new RenderImage(image: new TallImage());
    layout(image,
           constraints: const BoxConstraints(
              minWidth: 50.0,
              minHeight: 5.0,
              maxWidth: 75.0,
              maxHeight: 75.0));
    expect(image.size.width, equals(50.0));
    expect(image.size.height, equals(75.0));

    image = new RenderImage(image: new WideImage());
    layout(image,
           constraints: const BoxConstraints(
              minWidth: 5.0,
              minHeight: 5.0,
              maxWidth: 100.0,
              maxHeight: 100.0));
    expect(image.size.width, equals(20.0));
    expect(image.size.height, equals(10.0));

    image = new RenderImage(image: new WideImage());
    layout(image,
           constraints: const BoxConstraints(
              minWidth: 5.0,
              minHeight: 5.0,
              maxWidth: 16.0,
              maxHeight: 16.0));
    expect(image.size.width, equals(16.0));
    expect(image.size.height, equals(8.0));

    image = new RenderImage(image: new TallImage());
    layout(image,
           constraints: const BoxConstraints(
              minWidth: 5.0,
              minHeight: 5.0,
              maxWidth: 16.0,
              maxHeight: 16.0));
    expect(image.size.width, equals(8.0));
    expect(image.size.height, equals(16.0));

    image = new RenderImage(image: new SquareImage());
    layout(image,
           constraints: const BoxConstraints(
              minWidth: 4.0,
              minHeight: 4.0,
              maxWidth: 8.0,
              maxHeight: 8.0));
    expect(image.size.width, equals(8.0));
    expect(image.size.height, equals(8.0));

    image = new RenderImage(image: new WideImage());
    layout(image,
           constraints: const BoxConstraints(
              minWidth: 20.0,
              minHeight: 20.0,
              maxWidth: 30.0,
              maxHeight: 30.0));
    expect(image.size.width, equals(30.0));
    expect(image.size.height, equals(20.0));

    image = new RenderImage(image: new TallImage());
    layout(image,
           constraints: const BoxConstraints(
              minWidth: 20.0,
              minHeight: 20.0,
              maxWidth: 30.0,
              maxHeight: 30.0));
    expect(image.size.width, equals(20.0));
    expect(image.size.height, equals(30.0));
  });

  test('Null image sizing', () {
    RenderImage image;

    image = new RenderImage();
    layout(image,
           constraints: const BoxConstraints(
             minWidth: 25.0,
             minHeight: 25.0,
             maxWidth: 100.0,
             maxHeight: 100.0));
    expect(image.size.width, equals(25.0));
    expect(image.size.height, equals(25.0));

    image = new RenderImage(width: 50.0);
    layout(image,
           constraints: const BoxConstraints(
             minWidth: 25.0,
             minHeight: 25.0,
             maxWidth: 100.0,
             maxHeight: 100.0));
    expect(image.size.width, equals(50.0));
    expect(image.size.height, equals(25.0));

    image = new RenderImage(height: 50.0);
    layout(image,
           constraints: const BoxConstraints(
             minWidth: 25.0,
             minHeight: 25.0,
             maxWidth: 100.0,
             maxHeight: 100.0));
    expect(image.size.width, equals(25.0));
    expect(image.size.height, equals(50.0));

    image = new RenderImage(width: 100.0, height: 100.0);
    layout(image,
           constraints: const BoxConstraints(
             minWidth: 25.0,
             minHeight: 25.0,
             maxWidth: 75.0,
             maxHeight: 75.0));
    expect(image.size.width, equals(75.0));
    expect(image.size.height, equals(75.0));
  });

  test('update image colorBlendMode', () {
    final RenderImage image = new RenderImage();
    expect(image.colorBlendMode, isNull);
    image.colorBlendMode = BlendMode.color;
    expect(image.colorBlendMode, BlendMode.color);
  });
}

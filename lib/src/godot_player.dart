import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class GodotPlayer extends StatelessWidget {
  const GodotPlayer({super.key, this.name, this.package});

  final String? name;
  final String? package;

  static const String _viewType = 'godot-player';

  @override
  Widget build(BuildContext context) {
    return PlatformViewLink(
      surfaceFactory:
          (BuildContext context, PlatformViewController controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
              gestureRecognizers:
                  const <Factory<OneSequenceGestureRecognizer>>{},
            );
          },
      onCreatePlatformView: (PlatformViewCreationParams params) {
        return PlatformViewsService.initExpensiveAndroidView(
            id: params.id,
            viewType: _viewType,
            layoutDirection: TextDirection.ltr,
            creationParamsCodec: const StandardMessageCodec(),
            creationParams: name != null
                ? package == null
                      ? {'asset_name': 'res://flutter_assets/$name'}
                      : {
                          'asset_name':
                              'res://flutter_assets/packages/$package/$name',
                        }
                : null,
            onFocus: () => params.onFocusChanged(true),
          )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
      },
      viewType: _viewType,
    );
  }
}

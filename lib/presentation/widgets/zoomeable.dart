import 'package:flutter/material.dart';

class Zoomable extends StatefulWidget {
  final Widget? child;
  final Function? onZoom;
  final Function? onTapUp;

  const Zoomable({Key? key, this.child, this.onZoom, this.onTapUp}) : super(key: key);

  @override
  _ZoomableState createState() => _ZoomableState();
}

class _ZoomableState extends State<Zoomable> {
  double zoom = 1;
  double prevZoom = 1;
  Offset? offset;

  bool handleZoom(newZoom){
    if (newZoom >= 1) {
      if (newZoom > 10) {
        return false;
      }
      setState(() {
        zoom = newZoom;
      });
    }
    if(widget.onZoom != null) widget.onZoom!(zoom);
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onDoubleTap: (){
        if (zoom.round() == 1) {
          handleZoom(3.0);
        } else {
          handleZoom(1.0);
        }
      },
      onScaleStart: (scaleDetails) {
        setState(() => { prevZoom = zoom, offset = scaleDetails.localFocalPoint});
      },
      onScaleUpdate: (ScaleUpdateDetails scaleDetails) {
        var newZoom = (prevZoom * scaleDetails.scale);
        handleZoom(zoom);
      },
      child: Transform.translate(
        offset: offset ?? Offset.zero,
        child: Transform.scale(
          scale: zoom,
          child: widget.child!,
        ),
      )
    );
  }
}

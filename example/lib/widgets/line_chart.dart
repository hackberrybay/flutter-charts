import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charts/chart.dart';

typedef DataToValue<T> = double Function(T item);
typedef DataToAxis<T> = String Function(int item);

String defaultAxisValues(int item) => '$item';

class LineChart<T> extends StatelessWidget {
  LineChart({
    @required this.data,
    @required this.dataToValue,
    this.height = 240.0,
    this.lineWidth = 2.0,
    this.itemColor,
    this.backgroundDecorations,
    this.foregroundDecorations,
    this.chartOptions,
    this.chartItemOptions,
    this.chartBehaviour,
    this.smoothCurves,
    this.gradient,
    Key key,
  })  : _mappedValues = data.map((e) => BubbleValue<T>(dataToValue(e))).toList().asMap(),
        super(key: key);

  final List<T> data;
  final DataToValue<T> dataToValue;

  final double height;

  final bool smoothCurves;
  final Color itemColor;
  final Gradient gradient;
  final double lineWidth;

  final List<DecorationPainter> backgroundDecorations;
  final List<DecorationPainter> foregroundDecorations;
  final ChartBehaviour chartBehaviour;
  final ChartOptions chartOptions;
  final ChartItemOptions chartItemOptions;

  final Map<int, BubbleValue<T>> _mappedValues;

  @override
  Widget build(BuildContext context) {
    final _foregroundDecorations = foregroundDecorations ?? <DecorationPainter>[];
    final _backgroundDecorations = backgroundDecorations ?? <DecorationPainter>[];

    return AnimatedChart<T>(
      height: height,
      duration: const Duration(milliseconds: 450),
      state: ChartState<T>(
        _mappedValues,
        options: chartOptions,
        itemPainter: bubbleItemPainter,
        itemOptions: chartItemOptions,
        foregroundDecorations: [
          SparkLineDecoration<T>(
            id: 'chart_decoration',
            lineWidth: lineWidth,
            lineColor: itemColor,
            gradient: gradient,
            smoothPoints: smoothCurves,
          ),
          ..._foregroundDecorations,
        ],
        backgroundDecorations: [
          ..._backgroundDecorations,
        ],
      ),
    );
  }
}
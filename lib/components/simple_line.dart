/// Timeseries chart example
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'portfoliotimeclass.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  //final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {required this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      List.from(seriesList),
      //seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesPortfolio, DateTime>>
      _createSampleData() {
    final data = [
      new TimeSeriesPortfolio(new DateTime(2017, 9, 19), 5),
      new TimeSeriesPortfolio(new DateTime(2017, 9, 26), 25),
      new TimeSeriesPortfolio(new DateTime(2017, 10, 3), 100),
      new TimeSeriesPortfolio(new DateTime(2017, 10, 10), 75),
    ];

    return [
      new charts.Series<TimeSeriesPortfolio, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (PortfolioDataType portstamp, _) => portstamp.timestamp,
        measureFn: (PortfolioDataType portstamp, _) => portstamp.portstamp,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesPortfolio {
  final DateTime time;
  final int portval;

  TimeSeriesPortfolio(this.time, this.portval);
}

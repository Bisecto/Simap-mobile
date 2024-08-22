import 'package:flutter/material.dart';
import '../../../../widgets/appBar_widget.dart';
import '../../../home_section/home_page_components/welcome_container.dart';

class PerformancePage extends StatefulWidget {
  const PerformancePage({super.key});

  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const MainAppBar(
              isBackKey: true,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WelcomeContainer(
                    welcomeMsg: 'Hello Champ 👋',
                    mainText: 'Here are your performance\nSo far',
                    subText: '',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Column(children: [
                  //   //Initialize the chart widget
                  //   SfCartesianChart(
                  //       primaryXAxis: const CategoryAxis(),
                  //       // Chart title
                  //       title: const ChartTitle(text: 'Half yearly sales analysis'),
                  //       // Enable legend
                  //       legend: const Legend(isVisible: true),
                  //       // Enable tooltip
                  //       tooltipBehavior: TooltipBehavior(enable: true),
                  //       series: <CartesianSeries<_SalesData, String>>[
                  //         LineSeries<_SalesData, String>(
                  //             dataSource: data,
                  //             xValueMapper: (_SalesData sales, _) => sales.year,
                  //             yValueMapper: (_SalesData sales, _) => sales.sales,
                  //             name: 'Sales',
                  //             // Enable data label
                  //             dataLabelSettings: const DataLabelSettings(isVisible: true))
                  //       ]),
                  //   Expanded(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       //Initialize the spark charts widget
                  //       child: SfSparkLineChart.custom(
                  //         //Enable the trackball
                  //         trackball: const SparkChartTrackball(
                  //             activationMode: SparkChartActivationMode.tap),
                  //         //Enable marker
                  //         marker: const SparkChartMarker(
                  //             displayMode: SparkChartMarkerDisplayMode.all),
                  //         //Enable data label
                  //         labelDisplayMode: SparkChartLabelDisplayMode.all,
                  //         xValueMapper: (int index) => data[index].year,
                  //         yValueMapper: (int index) => data[index].sales,
                  //         dataCount: 5,
                  //       ),
                  //     ),
                  //   )
                  // ])
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:senso_seat/core/constants.dart';
import 'package:senso_seat/screens/widgets/dark_app_bar.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
  import '../core/color.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Color> gradientColors = [
    const Color(0xff71acc7),
    const Color(0xff71acc7),
  ];

  // bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getDarkAppBar(),
      body: NeumorphicTheme(
        theme: NeumorphicThemeData(
          baseColor: mainBackgroundColor,
          intensity: 0.3,
          accentColor: activeColor,
          lightSource: LightSource.topLeft,
          depth: 2,
        ),
        child: SafeArea(
          child: NeumorphicBackground(
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(startDateString)
                        TextButton(
                            onPressed: () {
                            },
                            child: Text(
                              'selected date',
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    )),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: 800,
                      height: 400,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          color: Color(0xff232d37)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 18.0, left: 12.0, top: 24, bottom: 12),
                        child: LineChart(
                          /* showAvg ? avgData() :*/
                          mainData(),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                    child: SizedBox())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('2th', style: style);
        break;
      case 5:
        text = const Text('5th', style: style);
        break;
      case 7:
        text = const Text('7th', style: style);
        break;
      case 8:
        text = const Text('8th', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10m';
        break;
      case 3:
        text = '30m';
        break;
      case 5:
        text = '50m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }

// LineChartData avgData() {
//   return LineChartData(
//     lineTouchData: LineTouchData(enabled: false),
//     gridData: FlGridData(
//       show: true,
//       drawHorizontalLine: true,
//       verticalInterval: 1,
//       horizontalInterval: 1,
//       getDrawingVerticalLine: (value) {
//         return FlLine(
//           color: const Color(0xff37434d),
//           strokeWidth: 1,
//         );
//       },
//       getDrawingHorizontalLine: (value) {
//         return FlLine(
//           color: const Color(0xff37434d),
//           strokeWidth: 1,
//         );
//       },
//     ),
//     titlesData: FlTitlesData(
//       show: true,
//       bottomTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 30,
//           getTitlesWidget: bottomTitleWidgets,
//           interval: 1,
//         ),
//       ),
//       leftTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: true,
//           getTitlesWidget: leftTitleWidgets,
//           reservedSize: 42,
//           interval: 1,
//         ),
//       ),
//       topTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//       rightTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//     ),
//     borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: const Color(0xff37434d), width: 1)),
//     minX: 0,
//     maxX: 11,
//     minY: 0,
//     maxY: 6,
//     lineBarsData: [
//       LineChartBarData(
//         spots: const [
//           FlSpot(0, 3.44),
//           FlSpot(2.6, 3.44),
//           FlSpot(4.9, 3.44),
//           FlSpot(6.8, 3.44),
//           FlSpot(8, 3.44),
//           FlSpot(9.5, 3.44),
//           FlSpot(11, 3.44),
//         ],
//         isCurved: true,
//         gradient: LinearGradient(
//           colors: [
//             ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                 .lerp(0.2)!,
//             ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                 .lerp(0.2)!,
//           ],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//         barWidth: 5,
//         isStrokeCapRound: true,
//         dotData: FlDotData(
//           show: false,
//         ),
//         belowBarData: BarAreaData(
//           show: true,
//           gradient: LinearGradient(
//             colors: [
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!
//                   .withOpacity(0.1),
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!
//                   .withOpacity(0.1),
//             ],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//         ),
//       ),
//     ],
//   );
// }
}

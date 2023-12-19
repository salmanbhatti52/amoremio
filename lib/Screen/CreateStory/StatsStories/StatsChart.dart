import 'package:amoremio/Resources/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsChart extends StatefulWidget {
  const StatsChart({super.key});

  @override
  State<StatsChart> createState() => _StatsChartState();
}

class _StatsChartState extends State<StatsChart> {

  @override
  Widget build(BuildContext context) {
    return LineChart(
      mainData(),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = const TextStyle(
      color: Colors.grey,
      fontSize: 10,
      fontFamily: 'Poppins',
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Sun', style: style);
        break;
      case 2:
        text = Text('Mon', style: style);
        break;
      case 4:
        text = Text('Tue', style: style);
        break;
      case 6:
        text = Text('Wed', style: style);
        break;
      case 8:
        text = Text('Thu', style: style);
        break;
      case 10:
        text = Text('Fri', style: style);
        break;
      case 12:
        text = Text('Sat', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = const TextStyle(
      color: Colors.grey,
      fontSize: 10,
      fontFamily: 'Poppins',
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 1:
        text = '1000';
        break;
      case 2:
        text = '2000';
        break;
      case 3:
        text = '3000';
        break;
      case 4:
        text = '4000';
        break;
        case 5:
        text = '5000';
        break;
        case 6:
        text = '6000';
        break;

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: const LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.red,
          tooltipRoundedRadius: 5,
          tooltipBorder: BorderSide(
            width: 1,
            color: Colors.yellow,
          ),
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        horizontalInterval: 1,
        verticalInterval: 2,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 25,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(width: 0.5,  color: Colors.grey.withOpacity(0.3),),
        // border: const Border(
        //   left: BorderSide(width: 1, color: Colors.grey),
        //   bottom: BorderSide(width: 1, color: Colors.grey),
        // ),
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 0),
            FlSpot(2.5, 3.5),
            FlSpot(4.5, 1),
            FlSpot(6.5, 5),
            FlSpot(9.5, 3),
            FlSpot(12, 2.5),
          ],
          isCurved: true,
          curveSmoothness: 0.5,
          isStrokeCapRound: true,
          color: const Color(0xffFB9115),
          barWidth: 3,
          dotData: const FlDotData(
            show: false,
          ),
          //   belowBarData: BarAreaData(
          //     show: true,
          //     gradient: LinearGradient(
          //       colors: gradientColors
          //           .map((color) => color.withOpacity(0.3))
          //           .toList(),
          //     ),
          //   ),
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0, 0),
            FlSpot(3.5, 5.5),
            FlSpot(5.5, 1),
            FlSpot(6.5, 5),
            FlSpot(9.5, 3),
            FlSpot(12.5, 2.5),
          ],
          isCurved: true,
          color: AppColor.primaryColor,
          barWidth: 3,
          isStrokeCapRound: false,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
        LineChartBarData(
          spots: const [

            FlSpot(0, 0),
            FlSpot(1.5, 4.5),
            FlSpot(5.5, 1),
            FlSpot(7.5, 5),
            FlSpot(11.5, 3),
            FlSpot(12.5, 2.5),

          ],
          isCurved: true,
          color: AppColor.yellowColor,
          barWidth: 3,
          isStrokeCapRound: false,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
    );
  }
}

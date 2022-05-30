import 'package:flutter/material.dart';
import 'package:flutter_martgage/screens/calculate_martgage_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthlyPaymentScrenn extends StatelessWidget {
  const MonthlyPaymentScrenn({Key? key}) : super(key: key);

  Widget _typesPayment() {
    if (paytypeIsDiff) {
      return const PaymentChartDiff();
    } else {
      return const PaymentDetailsAnn();
    }
  }

  @override
  Widget build(BuildContext context) {
    var appBar2 = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 8, 113),
      appBar: appBar2,
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Header(
                title1: 'Помесячная',
                title2: "Оплата",
                fontColor: Colors.black),
          ),
          const SizedBox(height: 5),
          const CircularChart(),
          const SizedBox(
            height: 10,
          ),
          Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(27),
                      topRight: Radius.circular(27))),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Стоимость квартиры с учетом переплат:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    sumresult["Total"].toString(),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 143, 18, 9),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Переплаты по кредиту по текущей ставке:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (sumresult['Total'] -
                            (sumresult['Sum'] - sumresult['Initial Payment']))
                        .toString(),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 143, 18, 9),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _typesPayment(),
                  const SizedBox(height: 10)
                ],
              )),
        ],
      ),
    );
  }
}

class CircularChart extends StatefulWidget {
  const CircularChart({Key? key}) : super(key: key);

  @override
  State<CircularChart> createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {
  late List<ChartsData> _chartsData;
  late TooltipBehavior _tooltipBehavior = TooltipBehavior();

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    _chartsData = getChartsDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SfCircularChart(
        legend: Legend(
            textStyle: const TextStyle(color: Colors.white),
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
            position: LegendPosition.bottom),
        tooltipBehavior: _tooltipBehavior,
        series: <CircularSeries>[
          DoughnutSeries<ChartsData, String>(
            dataSource: _chartsData,
            xValueMapper: (ChartsData data, _) => data.name,
            yValueMapper: (ChartsData data, _) => data.value,
            dataLabelSettings: const DataLabelSettings(
              overflowMode: OverflowMode.hide,
              isVisible: true,
            ),
            enableTooltip: true,
          )
        ],
      ),
    );
  }

  List<ChartsData> getChartsDate() {
    final List<ChartsData> chartsData = [
      ChartsData(
          name: 'первоначальный взнос', value: sumresult['Initial Payment']),
      ChartsData(
          name: "Сумма кредита",
          value: sumresult['Sum'] - sumresult['Initial Payment']),
      ChartsData(
          name: "Проценты",
          value: (sumresult['Total'] -
              (sumresult['Sum'] - sumresult['Initial Payment']))),
    ];
    return chartsData;
  }
}

class ChartsData {
  ChartsData({required this.name, required this.value});
  final String name;
  final int value;
}

class PaymentDetailsAnn extends StatelessWidget {
  const PaymentDetailsAnn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 550,
      child: Column(children: [
        const Text(
          'Ежемесячный платеж:',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Text(
          (sumresult["Monthly Payment"]).toString(),
          style: const TextStyle(
              color: Color.fromARGB(255, 143, 18, 9),
              fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}

class PaymentChartDiff extends StatelessWidget {
  const PaymentChartDiff({Key? key}) : super(key: key);

  List<PaymentDiffData> getData() {
    final List<PaymentDiffData> dataList = [
      PaymentDiffData(x: 0, y: sumresult["Monthly Payment"][0])
    ];
    for (int i = 1; i < sumresult["Monthly Payment"].length - 1; i++) {
      dataList.add(PaymentDiffData(x: i, y: sumresult["Monthly Payment"][i]));
    }
    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: SfCartesianChart(
        title: ChartTitle(
          text: "Ежемесячный платеж",
        ),
        crosshairBehavior: CrosshairBehavior(
          enable: true,
          activationMode: ActivationMode.longPress,
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: "Сумма ежемесячного платежа"),
        ),
        primaryXAxis: NumericAxis(title: AxisTitle(text: "Месяц")),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        // tooltipBehavior: TooltipBehavior(
        //   enable: true,
        //   activationMode: ActivationMode.longPress,
        // ),
        series: <ChartSeries>[
          LineSeries<PaymentDiffData, int>(
              dataSource: getData(),
              xValueMapper: (PaymentDiffData payments, _) => payments.x,
              yValueMapper: (PaymentDiffData payments, _) => payments.y,
              name: "Платеж",
              legendIconType: LegendIconType.diamond,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ))
        ],
      ),
    );
  }
}

class PaymentDiffData {
  PaymentDiffData({required this.x, required this.y});
  final int x;
  final int y;
}

import 'package:assessment_chart/core/common_widgets/error_screen.dart';
import 'package:assessment_chart/core/common_widgets/loading_indicator.dart';
import 'package:assessment_chart/di/injector.dart';
import 'package:assessment_chart/features/pap/data/model/pap_response_model.dart';
import 'package:assessment_chart/features/pap/presentation/bloc/pap_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PapTransactionScreen extends StatefulWidget {
  const PapTransactionScreen({super.key});

  @override
  State<PapTransactionScreen> createState() => _PapTransactionScreenState();
}

class _PapTransactionScreenState extends State<PapTransactionScreen> {
  final papTransactionBloc = sl<PapTransactionBloc>();

  @override
  void initState() {
    super.initState();
    papTransactionBloc.add(FetchPapTransactionReport());
  }

  @override
  void dispose() {
    papTransactionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PapTransactionBloc, PapTransactionState>(
        bloc: papTransactionBloc,
        builder: (context, state) {
          if (state is PapTransactionLoading) {
            return LoadingIndicator();
          } else if (state is PapTransactionSuccess) {
            final data = state.data.data.items;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SfCartesianChart(
                    title: ChartTitle(
                      text: 'Transaction Overview',
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                        text: 'Transaction Type',
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      labelRotation: 45,
                      majorGridLines: MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(
                        text: 'Values',
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      axisLine: const AxisLine(width: 0),
                      majorGridLines: MajorGridLines(
                        width: 0.5,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    tooltipBehavior: TooltipBehavior(
                      enable: true,
                      color: Colors.blueAccent,
                      borderWidth: 1,
                      borderColor: Colors.grey,
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                      overflowMode: LegendItemOverflowMode.wrap,
                    ),
                    series: <ChartSeries>[
                      ColumnSeries<Item, String>(
                        dataSource: data,
                        xValueMapper: (item, _) => item.type,
                        yValueMapper: (item, _) => item.value,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                        pointColorMapper: (item, _) =>
                            item.value > 5 ? Colors.green : Colors.red,
                        gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 60, 15, 68),
                              Colors.grey.withOpacity(0.2),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderWidth: 1.5,
                        borderColor: Colors.black.withOpacity(0.2),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is PapTransactionError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.redAccent, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    state.error,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () =>
                        papTransactionBloc.add(FetchPapTransactionReport()),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}


// class PapTransactionScreen extends StatefulWidget {
//   const PapTransactionScreen({super.key});

//   @override
//   State<PapTransactionScreen> createState() => _PapTransactionScreenState();
// }

// class _PapTransactionScreenState extends State<PapTransactionScreen> {
//   final papTransactionBloc = sl<PapTransactionBloc>();

//   @override
//   void initState() {
//     super.initState();
//     papTransactionBloc.add(FetchPapTransactionReport());
//   }

//   @override
//   void dispose() {
//     papTransactionBloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<PapTransactionBloc, PapTransactionState>(
//         bloc: papTransactionBloc,
//         builder: (context, state) {
//           if (state is PapTransactionLoading) {
//             return LoadingIndicator();
//           } else if (state is PapTransactionSuccess) {
//             final data = state.data.data.items;
//             return Card(
//               //color: Colors.grey.withOpacity(0.1),
//               child: SfCartesianChart(
//                 primaryXAxis: CategoryAxis(),
//                 tooltipBehavior: TooltipBehavior(enable: true),
//                 legend: Legend(isVisible: true),
//                 series: <ChartSeries>[
//                   ColumnSeries<Item, String>(
//                     dataSource: data,
//                     xValueMapper: (item, _) => item.type,
//                     yValueMapper: (item, _) => item.value,
//                     dataLabelSettings: const DataLabelSettings(isVisible: true),
//                     pointColorMapper: (item, _) =>
//                         item.value > 5 ? Colors.green : Colors.red,
//                     borderColor: Colors.black.withOpacity(0.2),
//                     borderWidth: 1.5,
//                   ),
//                 ],
//               ),
//             );
//           } else if (state is PapTransactionError) {
//             return ErrorScreen(
//               message: state.error,
//               onRetry: () =>
//                   papTransactionBloc.add(FetchPapTransactionReport()),
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }

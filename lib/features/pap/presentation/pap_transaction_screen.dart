import 'package:assessment_chart/core/common_widgets/error_screen.dart';
import 'package:assessment_chart/core/common_widgets/loading_indicator.dart';
import 'package:assessment_chart/di/injector.dart';
import 'package:assessment_chart/features/pap/data/model/pap_response_model.dart';
import 'package:assessment_chart/features/pap/presentation/bloc/pap_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PapTransactionScreen extends StatefulWidget {
  const PapTransactionScreen({super.key});

  @override
  State<PapTransactionScreen> createState() => _PapTransactionScreenState();
}

class _PapTransactionScreenState extends State<PapTransactionScreen> {
    final papTransactionBloc = sl<PapTransactionBloc>();

@override
  void initState() {
    papTransactionBloc.add(FetchPapTransactionReport());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<PapTransactionBloc, PapTransactionState>(
        builder: (context, state) {
          if (state is PapTransactionLoading) {
            return const LoadingIndicator();
          } else if (state is PapTransactionSuccess) {
            final data = state.data.data.items;
            return SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              tooltipBehavior: TooltipBehavior(enable: true),
              legend: Legend(isVisible: true),
              series: <ChartSeries>[
                ColumnSeries<Item, String>(
                  dataSource: data,
                  xValueMapper: (item, _) => item.type,
                  yValueMapper: (item, _) => item.value,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
            );
          } else if (state is PapTransactionError) {
            return ErrorScreen(
              message: state.error,
              onRetry: () => papTransactionBloc.add(FetchPapTransactionReport()),
            );
          }
          return const SizedBox();
        },
      );
  }
}

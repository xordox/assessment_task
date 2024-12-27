
import 'package:assessment_chart/core/common_widgets/error_screen.dart';
import 'package:assessment_chart/core/common_widgets/loading_indicator.dart';
import 'package:assessment_chart/di/injector.dart';
import 'package:assessment_chart/features/outlet/data/model/outlet_response_model.dart';
import 'package:assessment_chart/features/outlet/presentation/bloc/outlet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class OutletScreen extends StatefulWidget {
  const OutletScreen({super.key});

  @override
  State<OutletScreen> createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {

    final outletBloc = sl<OutletBloc>();

    @override
  void initState() {
    super.initState();
    outletBloc.add(FetchOutlet());
  }

 @override
  void dispose() {
    outletBloc.close(); // Dispose of the bloc to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<OutletBloc, OutletState>(
        bloc: outletBloc,
        builder: (context, state) {
          if (state is OutletLoading) {
            return const LoadingIndicator();
          } else if (state is OutletSuccess) {
            return _buildSuccess(state);
          } else if (state is OutletError) {
            return _buildError(state, outletBloc);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildSuccess(OutletSuccess state) {
    final data = state.outletResponseModel.data.items;
    return Card(
      child: SfCircularChart(
        //title: ChartTitle(text: "Outlet Stats"),
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          DoughnutSeries<OutletItem, String>(
            innerRadius: "0",
            dataSource: data,
            explode: true,
            xValueMapper: (item, _) => item.type,
            yValueMapper: (item, _) => item.value,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }

  Widget _buildError(OutletError state, OutletBloc outletBloc) {
    return ErrorScreen(
      message: state.error,
      onRetry: () {
        outletBloc.add(FetchOutlet());
      },
    );
  }
}

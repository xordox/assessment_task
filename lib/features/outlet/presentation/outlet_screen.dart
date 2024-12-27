
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
    outletBloc.add(FetchOutlet());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<OutletBloc, OutletState>(
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
    );
  }

  Widget _buildSuccess(OutletSuccess state) {
    final data = state.outletResponseModel.data.items;
    return SfCircularChart(
      tooltipBehavior: TooltipBehavior(enable: true),
      legend: Legend(isVisible: true),
      series: <CircularSeries>[
        DoughnutSeries<OutletItem, String>(
          dataSource: data,
          xValueMapper: (item, _) => item.type,
          yValueMapper: (item, _) => item.value,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
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

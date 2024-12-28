import 'package:assessment_chart/core/common_widgets/error_screen.dart';
import 'package:assessment_chart/core/common_widgets/loading_indicator.dart';
import 'package:assessment_chart/di/injector.dart';
import 'package:assessment_chart/features/outlet/data/model/outlet_response_model.dart';
import 'package:assessment_chart/features/outlet/presentation/bloc/outlet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Loading outlet data...',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SfCircularChart(
            title: ChartTitle(
              text: 'Outlet Distribution',
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              header: '',
              format: 'point.x: point.y',
              color: Colors.blueAccent,
              borderWidth: 1,
              borderColor: Colors.grey,
              textStyle: const TextStyle(color: Colors.white),
            ),
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.scroll,
              position: LegendPosition.bottom,
              textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 60, 15, 68)),
            ),
            series: <CircularSeries>[
              DoughnutSeries<OutletItem, String>(
                innerRadius: "0%",
                dataSource: data,
                explode: true,
                explodeOffset: '10%',
                xValueMapper: (item, _) => item.type,
                yValueMapper: (item, _) => item.value,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  textStyle:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                //pointColorMapper: (item, _) => _getColor(item.type),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildError(OutletError state, OutletBloc outletBloc) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.redAccent, size: 64),
          const SizedBox(height: 16),
          Text(
            state.error,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              outletBloc.add(FetchOutlet());
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(String type) {
    switch (type) {
      case 'Type A':
        return Colors.blue;
      case 'Type B':
        return Colors.green;
      case 'Type C':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}


// class OutletScreen extends StatefulWidget {
//   const OutletScreen({super.key});

//   @override
//   State<OutletScreen> createState() => _OutletScreenState();
// }

// class _OutletScreenState extends State<OutletScreen> {
//   final outletBloc = sl<OutletBloc>();

//   @override
//   void initState() {
//     super.initState();
//     outletBloc.add(FetchOutlet());
//   }

//   @override
//   void dispose() {
//     outletBloc.close(); // Dispose of the bloc to prevent memory leaks
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<OutletBloc, OutletState>(
//         bloc: outletBloc,
//         builder: (context, state) {
//           if (state is OutletLoading) {
//             return  LoadingIndicator();
//           } else if (state is OutletSuccess) {
//             return _buildSuccess(state);
//           } else if (state is OutletError) {
//             return _buildError(state, outletBloc);
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }

//   Widget _buildSuccess(OutletSuccess state) {
//     final data = state.outletResponseModel.data.items;
//     return Card(
//       child: SfCircularChart(
//         //title: ChartTitle(text: "Outlet Stats"),
//         tooltipBehavior: TooltipBehavior(enable: true),
//         legend: Legend(isVisible: true),
//         series: <CircularSeries>[
//           DoughnutSeries<OutletItem, String>(
//             innerRadius: "0",
//             dataSource: data,
//             explode: true,
//             xValueMapper: (item, _) => item.type,
//             yValueMapper: (item, _) => item.value,
//             dataLabelSettings: const DataLabelSettings(isVisible: true),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildError(OutletError state, OutletBloc outletBloc) {
//     return ErrorScreen(
//       message: state.error,
//       onRetry: () {
//         outletBloc.add(FetchOutlet());
//       },
//     );
//   }
// }

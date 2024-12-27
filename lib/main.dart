import 'dart:developer';

import 'package:assessment_chart/di/injector.dart';
import 'package:assessment_chart/features/outlet/presentation/bloc/outlet_bloc.dart';
import 'package:assessment_chart/features/outlet/presentation/outlet_screen.dart';
import 'package:assessment_chart/features/pap/presentation/bloc/pap_bloc.dart';
import 'package:assessment_chart/features/pap/presentation/pap_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(MultiBlocProvider(
    providers: [
        BlocProvider<PapTransactionBloc>(
          create: (context) => sl<PapTransactionBloc>()..add(FetchPapTransactionReport()),
        ),
        BlocProvider<OutletBloc>(
          create: (context) => sl<OutletBloc>()..add(FetchOutlet()),
        ),
    ],
    child: const MyApp()));
}



// Main App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PAP & Outlet Report',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

// Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    PapTransactionScreen(),
    OutletScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PAP & Outlet Report'),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'PAP Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Outlet Report',
          ),
        ],
      ),
    );
  }
}



// // PAP Transaction Bloc
// class PapTransactionBloc extends Cubit<PapTransactionState> {
//   final ApiService apiService;

//   PapTransactionBloc(this.apiService) : super(PapTransactionInitial());

//   void fetchTransactionReport() async {
//     emit(PapTransactionLoading());
//     try {
//       final data = await apiService.fetchPapTransactionReport();
//       log("data: ${data.toString()}");
//       emit(PapTransactionSuccess(data));
//     } catch (error) {
//       emit(PapTransactionError(error.toString()));
//     }
//   }
// }

// // PAP Transaction States
// abstract class PapTransactionState {}
// class PapTransactionInitial extends PapTransactionState {}
// class PapTransactionLoading extends PapTransactionState {}
// class PapTransactionSuccess extends PapTransactionState {
//   final Map<String, dynamic> data;
//   PapTransactionSuccess(this.data);
// }
// class PapTransactionError extends PapTransactionState {
//   final String message;
//   PapTransactionError(this.message);
// }

// // Outlet Bloc
// class OutletBloc extends Cubit<OutletState> {
//   final ApiService apiService;

//   OutletBloc(this.apiService) : super(OutletInitial());

//   void fetchOutlet() async {
//     emit(OutletLoading());
//     try {
//       final data = await apiService.fetchOutlet();
//       emit(OutletSuccess(data));
//     } catch (error) {
//       emit(OutletError(error.toString()));
//     }
//   }
// }

// // Outlet States
// abstract class OutletState {}
// class OutletInitial extends OutletState {}
// class OutletLoading extends OutletState {}
// class OutletSuccess extends OutletState {
//   final Map<String, dynamic> data;
//   OutletSuccess(this.data);
// }
// class OutletError extends OutletState {
//   final String message;
//   OutletError(this.message);
// }
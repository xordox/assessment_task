import 'package:assessment_chart/di/injector.dart';
import 'package:assessment_chart/features/outlet/presentation/bloc/outlet_bloc.dart';
import 'package:assessment_chart/features/outlet/presentation/outlet_screen.dart';
import 'package:assessment_chart/features/pap/presentation/bloc/pap_bloc.dart';
import 'package:assessment_chart/features/pap/presentation/pap_transaction_screen.dart';
import 'package:assessment_chart/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<PapTransactionBloc>(
      create: (context) => sl<PapTransactionBloc>(),
    ),
    BlocProvider<OutletBloc>(
      create: (context) => sl<OutletBloc>(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PAP & Outlet Report',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    BlocProvider<PapTransactionBloc>(
      create: (context) =>
          sl<PapTransactionBloc>()..add(FetchPapTransactionReport()),
      child: const PapTransactionScreen(),
    ),
    BlocProvider<OutletBloc>(
      create: (context) => sl<OutletBloc>()..add(FetchOutlet()),
      child: const OutletScreen(),
    ),
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
        title: const Text(
          'PAP & Outlet Report',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Color.fromARGB(255, 60, 15, 68),
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

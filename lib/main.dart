import 'package:flutter/material.dart';
import 'src/http/dio_client.dart';
import 'src/modules/history/controller/history_controller.dart';
import 'src/modules/history/page/history_page.dart';
import 'src/modules/home/controller/home_controller.dart';
import 'src/modules/home/page/home_page.dart';
import 'src/modules/home/repositories/address_api_repository.dart';
import 'src/modules/home/repositories/address_local_repository.dart';
import 'src/modules/home/service/address_service.dart';
import 'src/modules/initial/page/initial_page.dart';
import 'src/routes/app_routes.dart';
import 'src/shared/colors/app_colors.dart';
import 'src/shared/storage/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(const FastLocationApp());
}

class FastLocationApp extends StatelessWidget {
  const FastLocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiRepository = AddressApiRepository(DioClient.instance);
    final localRepository = AddressLocalRepository();
    final service = AddressService(apiRepository, localRepository);
    final homeController = HomeController(service);
    final historyController = HistoryController(service);

    return MaterialApp(
      title: 'FastLocation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary), useMaterial3: true),
      initialRoute: AppRoutes.initial,
      routes: {
        AppRoutes.initial: (_) => const InitialPage(),
        AppRoutes.home: (_) => HomePage(controller: homeController),
        AppRoutes.history: (_) => HistoryPage(controller: historyController),
      },
    );
  }
}

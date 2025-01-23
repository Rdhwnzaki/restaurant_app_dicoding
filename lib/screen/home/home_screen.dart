import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/setting/local_notification_provider.dart';
import 'package:restaurant_app/screen/home/home_error_state_widget.dart';
import 'package:restaurant_app/screen/home/home_appbar_widget.dart';
import 'package:restaurant_app/screen/home/restaurant_list_widget.dart';
import 'package:restaurant_app/screen/loading_state_widget.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _fetchRestaurantList();
    _scheduleDailyElevenAMNotification();
    context.read<LocalNotificationProvider>().initialize();
  }

  void _fetchRestaurantList() {
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  Future<void> _scheduleDailyElevenAMNotification() async {
    context
        .read<LocalNotificationProvider>()
        .scheduleDailyElevenAMNotification();
  }

  Future<void> _checkPendingNotificationRequests() async {
    final localNotificationProvider = context.read<LocalNotificationProvider>();
    await localNotificationProvider.checkPendingNotificationRequests();

    if (!mounted) {
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final pendingData = context
            .watch<LocalNotificationProvider>()
            .pendingNotificationRequests;
        return AlertDialog(
          title: Text(
            '${pendingData.length} pending notification requests',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          content: SizedBox(
            height: 300,
            width: 300,
            child: ListView.builder(
              itemCount: pendingData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = pendingData[index];
                return ListTile(
                  title: Text(
                    item.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    item.body ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  contentPadding: EdgeInsets.zero,
                  trailing: IconButton(
                    onPressed: () {
                      localNotificationProvider.cancelNotification(item.id);
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Consumer<RestaurantListProvider>(
          builder: (context, provider, child) {
            switch (provider.resultState) {
              case RestaurantListLoadingState():
                return const LoadingStateWidget();
              case RestaurantListLoadedState(data: var restaurantList):
                return RestaurantListWidget(
                  restaurants: restaurantList,
                  onRetry: _fetchRestaurantList,
                );
              case RestaurantListErrorState(error: var message):
                return HomeErrorStateWidget(
                  errorMessage: message,
                  onRetry: _fetchRestaurantList,
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

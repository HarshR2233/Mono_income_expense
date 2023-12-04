import 'dart:async';
import 'package:background_fetch/background_fetch.dart';
import 'package:income_expense/services/DataStorage.dart';
import 'package:income_expense/services/MonthUtils.dart';

class BackgroundService {
  static void start() {
    BackgroundFetch.registerHeadlessTask(onHeadlessTask);

    BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        enableHeadless: true,
        startOnBoot: true,
      ),
          (String taskId) async {
        print("[BackgroundFetch] Event received: $taskId");
        await _handleTask();
        BackgroundFetch.finish(taskId);
      },
    );
  }

  static Future<void> onHeadlessTask(String taskId) async {
    print("[BackgroundFetch] Headless event received: $taskId");
    await _handleTask();
    BackgroundFetch.finish(taskId);
  }

  static Future<void> _handleTask() async {
    String currentMonth = MonthUtils.getCurrentMonth();
    String? storedMonth = await DataStorage.getCurrentMonth();

    if (currentMonth != storedMonth) {
      await DataStorage.saveCurrentMonth(currentMonth);
    }
  }
}

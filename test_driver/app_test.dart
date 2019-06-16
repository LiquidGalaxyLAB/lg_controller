// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Main App', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test('Home to POI and Nav Bar emnu check', () async {
      await checkTitleBar(driver);
      await driver.tap(find.text("POI"));
      await checkTitleBar(driver);
      await checkNavBar(driver);
      await driver.tap(find.text("Category_1"));
      await checkTitleBar(driver);
      await checkNavBar(driver);
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
  });
}

checkTitleBar(FlutterDriver driver) async {
  await driver.waitFor(find.text("LG Controller"));
  await driver.waitFor(find.text("Home"));
  await driver.waitFor(find.text("Tours"));
  await driver.waitFor(find.text("POI"));
  await driver.waitFor(find.text("Guide"));
  await driver.waitFor(find.text("Overlay"));
}

checkNavBar(FlutterDriver driver) async {
  await driver.waitFor(find.text("Recently_Viewed"));
  await driver.waitFor(find.text("Category_1"));
  await driver.waitFor(find.text("Category_2"));
  await driver.waitFor(find.text("Category_3"));
  await driver.waitFor(find.text("Category_4"));
  await driver.waitFor(find.text("Category_5"));
}

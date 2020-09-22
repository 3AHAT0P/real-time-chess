part 'development.dart';
part 'test.dart';
part 'production.dart';

enum Environment { development, test, production }

abstract class ApplicationConfig {
  final Environment environment;

  factory ApplicationConfig(environment) {
    if (environment == Environment.production) return new _ProductionApplicationConfig();
    if (environment == Environment.test) return new _TestApplicationConfig();
    return new _DevelopmentApplicationConfig();
  }
}
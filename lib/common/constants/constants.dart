class Constants {
  Constants._();
  static const sharedPreferencesKey = SharedPreferencesKey();
  static const apiUrl =
      "https://878e-202-184-8-138.ngrok-free.app/";

  static const stripePublishableKey =
      "pk_test_51OmSFdIGtvkAiXyxrpvC4ohbIbN4COdgvxZlihCNKSE0j0AR8gg4hXvYcj9MQKUxSS4J7LjMGHUDTA5fG2ynSFQs00EODoklrH";
}

class SharedPreferencesKey {
  const SharedPreferencesKey();

  // User
  final String user = "user";

  // Auth
  final String accessToken = "accessToken";
  final String refreshToken = "refreshToken";

  // App data constants
  final String stateAndRegion = "stateAndRegion";
  final String stateAndRegionExpiration = "stateAndRegionExpiration";
  final String courseCategories = "courseCategories";
  final String courseCategoriesExpiration = "campaignCategoriesExpiration";
}

class AppApis {
  static String http = "http://";
  static String appBaseUrl = ".localhost:8000";

  //static String imageBaseUrl = "https://nau-slc.s3.eu-west-2.amazonaws.com";

  // static String appBaseUrl = "https://portal.cbtq.app";
  // static String imageBaseUrl = "https://portal.cbtq.app";

  // static String imageBaseUrl = "http://192.168.0.155:8002";
  // static String appBaseUrl = "http://192.168.0.155:8002";

  ///Authentication Endpoints

  static String verifyOtp = "$appBaseUrl/u-auth/verify-otp/";
  static String resetPassword = "$appBaseUrl/u-auth/reset-password/";
  static String loginStudent = "$appBaseUrl/endpoint/login";

  static String dashboard = "$appBaseUrl/endpoint/dashboard";
  static String resultsArchive = "$appBaseUrl/endpoint/results-archive";
}

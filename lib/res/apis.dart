class AppApis {
  static String appBaseUrl = "https://api.campusedge.net";
  static String imageBaseUrl = "https://nau-slc.s3.eu-west-2.amazonaws.com";

  // static String appBaseUrl = "https://portal.cbtq.app";
  // static String imageBaseUrl = "https://portal.cbtq.app";

  // static String imageBaseUrl = "http://192.168.0.155:8002";
  // static String appBaseUrl = "http://192.168.0.155:8002";

  ///Authentication Endpoints
  static String loginCreateToken = "$appBaseUrl/auth/jwt/create/";
  static String refreshTokenApi = "$appBaseUrl/auth/jwt/refresh/";
  static String verifyTokenApi = "$appBaseUrl/auth/jwt/refresh/";

  static String requestPasswordResetOtp =
      "$appBaseUrl/u-auth/request-password-reset/";
  static String verifyOtp = "$appBaseUrl/u-auth/verify-otp/";
  static String resetPassword = "$appBaseUrl/u-auth/reset-password/";
  static String loginStudent = "$appBaseUrl/u-auth/login-student/";

  static String studentSession = "$appBaseUrl/mobile_student_sessions/";

  ///COURSE REGISTRATION

  static String baseSession = "$appBaseUrl/sessions/";
  static String baseSemester = "/semesters/";
  static String studentFeeSession = "${appBaseUrl}/get-student-sessions/";
  static String registeredCourse = "/registered_courses/";
  static String unRegisteredCourse = "/unregistered_courses/";
  static String carryOverCourse = "/carryover_courses/";
  static String registerCourse = "/register_courses/";
  static String unRegisterCourse = "/unregister_course/";

  //static String getSecondSemesterCourse = "$baseSemester/registered_courses/";

  ///RESULTS
  static String studentFee = "$appBaseUrl/fees/";
  static String studentFeeHistory =
      "$appBaseUrl/fee/get-student-payment-history/";
  static String studentResult = "$appBaseUrl/results/student_result/";

  static String studentProfile = "$appBaseUrl/students/me/";
  static String sessionApi = "$appBaseUrl/sessions/current/";
  static String studentCGPA = "$appBaseUrl/results/calculate_cgpa/";
}

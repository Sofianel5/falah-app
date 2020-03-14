class Urls {
  static const bool Debug = true;
  static String getBaseURL() => Debug ? "http://127.0.0.1:8000/" : "https://falah.world/";
  static String LOGIN_URL = getBaseURL() + "api/auth/token/login/";
  static String USER_URL = getBaseURL() + "api/auth/users/me/";
  static String MY_PROGRAM_GETTER_URL = getBaseURL() + "api/me/getprograms/";
  static String VENUE_GETTER_URL = getBaseURL() + "api/get-venues/";
  static String MEDIA_BASE_URL = getBaseURL().substring(0, getBaseURL().length - 1);
  static String SIGNUP_URL = getBaseURL() + "api/auth/users/";
  static String PASSWORD_RESET_URL = getBaseURL() + "passwordreset/";
  static String DEFAULT_PFP_URL = getBaseURL() + "media/pfps/default-pfp.png";
  static String PROGRAM_GETTER_URL = getBaseURL() + "api/get-programs/";
  static String PROGRAMS_AT_VENUE = getBaseURL() + "api/get-programs-at-venue/";
  static String PROGRAM_REGISTER_URL = getBaseURL() + "api/register/";
  static String VENUE_FROM_PROGRAM_GETTER_URL = getBaseURL() + "get-venue-for-program/";
  static String PROGRAM_UNREGISTER_URL = getBaseURL() + "api/unregister/";
  static String PRIMARY_SUBJECTS_GETTER_URL = getBaseURL() + "api/primary-subjects/";
  static String SECONDARY_SUBJECTS_GETTER_URL = getBaseURL() + "api/secondary-subjects/";
  static String CITY_GETTER_URL = getBaseURL() + "api/get-cities/";
  static String COUNTRY_GETTER_URL = getBaseURL() + "api/get-countries/";
}
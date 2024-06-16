class Endpoints {
  static const String baseURL = "https://66038e2c2393662c31cf2e7d.mockapi.io/api/v1";
  static const String baseURLLive = "https://simobile.singapoly.com";

  static const String news = "$baseURL/news";
  static const String datas = "$baseURLLive/api/datas";

  //UTS
  static const String baseURLUTS = "https://simobile.singapoly.com";
  static const String customerService = "$baseURLUTS/api/customer-service";
  static const String customerServiceWithNIM = "$customerService/2215091039";

  //PinjamNada
  static const String pinjamNadaBase = "http://10.0.2.2:5000";

  static const String login = "$pinjamNadaBase/api/v1/auth/login";
  static const String logout = "$pinjamNadaBase/api/v1/auth/logout";
  static const String staticImage = "$pinjamNadaBase/static/img";
  static const String decodeToken = "$pinjamNadaBase/api/v1/protected/data";

  static const String pinjamNadaInstruments = "$pinjamNadaBase/api/v1/instruments";
  static const String fetchAllAvailableInstruments = "$pinjamNadaInstruments/read_instruments_by_availability_excluding_user";
  static const String fetchInstrumentsByID = "$pinjamNadaInstruments/read_instruments_by_user";
}

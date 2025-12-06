class ApiUrl {
  static const String baseUrl = 'http://192.168.100.19:8080';
  
  static const String login = '$baseUrl/login';
  static const String registrasi = '$baseUrl/registrasi';
  
  static const String listBook = '$baseUrl/buku';
  static const String createBook = '$baseUrl/buku';
  
  static String showBook(String id) => '$baseUrl/buku/$id';
  static String updateBook(String id) => '$baseUrl/buku/$id';
  static String deleteBook(String id) => '$baseUrl/buku/$id';
  static String statistikBook() => '$baseUrl/buku/statistik';
}
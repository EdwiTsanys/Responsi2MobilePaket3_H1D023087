import 'dart:convert';
import '../model/book.dart';
import '../helpers/api.dart';
import '../helpers/api_url.dart';

class BookBloc {
  static Future<List<Book>> getBooks() async {
    try {
      final response = await Api().get(ApiUrl.listBook);
      print('DEBUG - List Response: ${response.body}');
      
      var jsonObj = json.decode(response.body);
      
      if (jsonObj['status'] == true && jsonObj['code'] == 200) {
        List<dynamic> data = jsonObj['data'] ?? [];
        print('DEBUG - Raw data from server: $data');
        
        var books = data.map((json) {
          print('DEBUG - Parsing book: $json');
          return Book.fromJson(json);
        }).toList();
        
        print('DEBUG - Parsed books: ${books.map((b) => b.toJson()).toList()}');
        return books;
      } else {
        print('DEBUG - API Error: $jsonObj');
        return [];
      }
    } catch (e) {
      print('DEBUG - Exception in getBooks: $e');
      return [];
    }
  }
  
  static Future<Map<String, dynamic>> addBook(Book book) async {
    try {
      print('DEBUG - Create Book Data: ${book.toJson()}');
      
      final response = await Api().post(ApiUrl.createBook, book.toJson());
      print('DEBUG - Create Response: ${response.body}');
      
      var jsonObj = json.decode(response.body);
      
      if (jsonObj['status'] == true && jsonObj['code'] == 200) {
        print('DEBUG - Created book data: ${jsonObj['data']}');
        return {
          'success': true,
          'message': 'Buku berhasil ditambahkan',
          'data': jsonObj['data']
        };
      } else {
        return {
          'success': false,
          'message': jsonObj['data'] ?? 'Gagal menambahkan buku'
        };
      }
    } catch (e) {
      print('DEBUG - Exception in addBook: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan: ${e.toString()}'
      };
    }
  }
  
  static Future<Map<String, dynamic>> updateBook(Book book) async {
    try {
      print('DEBUG - Update Book Data: ${book.toJson()}');
      print('DEBUG - Update URL: ${ApiUrl.updateBook(book.id!)}');
      
      // Add _method field for Laravel/CI4 method spoofing
      var updateData = book.toJson();
      updateData['_method'] = 'PUT';
      
      final response = await Api().post(ApiUrl.updateBook(book.id!), updateData);
      
      print('DEBUG - Response Status: ${response.statusCode}');
      print('DEBUG - Response Body: ${response.body}');
      
      var jsonObj = json.decode(response.body);
      
      if (jsonObj['status'] == true && jsonObj['code'] == 200) {
        return {
          'success': true,
          'message': 'Buku berhasil diupdate',
          'data': jsonObj['data']
        };
      } else {
        return {
          'success': false,
          'message': jsonObj['data'] ?? 'Gagal mengupdate buku'
        };
      }
    } catch (e) {
      print('DEBUG - Error: ${e.toString()}');
      return {
        'success': false,
        'message': 'Terjadi kesalahan: ${e.toString()}'
      };
    }
  }
  
  static Future<Map<String, dynamic>> deleteBook(String id) async {
    try {
      final response = await Api().delete(ApiUrl.deleteBook(id));
      var jsonObj = json.decode(response.body);
      
      if (jsonObj['status'] == true && jsonObj['code'] == 200) {
        return {
          'success': true,
          'message': 'Buku berhasil dihapus'
        };
      } else {
        return {
          'success': false,
          'message': jsonObj['data'] ?? 'Gagal menghapus buku'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: ${e.toString()}'
      };
    }
  }
}
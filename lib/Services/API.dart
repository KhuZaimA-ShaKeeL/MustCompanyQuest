import "dart:convert";

import "package:http/http.dart" as http;

class API {
  final server = 'https://dummyjson.com';

  Future<List?> getproducts() async {
    try {
      final res = await http.get(Uri.parse("$server/product"));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        print("Successful");
        return data['products'];
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> deleteProduct(int id) async {
    try {
      final res = await http.delete(Uri.parse("$server/product/$id"));
      if (res.statusCode == 200) {
        print(
          "Delete item  with id: $id successfully: ${jsonDecode(res.body)}",
        );
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<Map?> updateProduct(int id, String title) async {
    try {
      final res = await http.put(
        Uri.parse("$server/product/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"title": title}),
      );
      if (res.statusCode == 200) {
        print("Update item with id: $id successfully: ${jsonDecode(res.body)}");
        return jsonDecode(res.body);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future<bool> addProduct(Map data) async{
    try {
      final res = await http.post(
        Uri.parse("$server/products/add"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          ...data
        }),
      );
      if(res.statusCode == 201){
        print("Add item successfully: ${jsonDecode(res.body)}");
        return true;
      }else{
        print("Add item failed: ${jsonDecode(res.body)}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
  Future<String?> getImage(String imageUrl) async {
    try {
      final res = await http.get(Uri.parse("$server/image/$imageUrl"));
      if (res.statusCode == 200) {
        print("Image fetched successfully");

        print(res.body);
        List<int> ImageBytesLists = res.bodyBytes;
        return base64Encode(ImageBytesLists);
      }
      return null;
    } catch (e) {
      print("Catach:"+e.toString());
      return null;
    }
  }
}

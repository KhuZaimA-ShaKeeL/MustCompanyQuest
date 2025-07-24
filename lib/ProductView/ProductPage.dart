import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:mustcompanyy/ProductView/ImageViewPage.dart';

import '../Services/API.dart';

class Productpage extends StatefulWidget {
  const Productpage({super.key});

  @override
  State<Productpage> createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpage> {
  List? products;
  TextEditingController _updateTitleController = TextEditingController();
  TextEditingController _addTitleController = TextEditingController();
  TextEditingController _addPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void deleteProduct(int id) async {
    bool res = await API().deleteProduct(id);
    if (res == true) {
      setState(() {
        products!.removeWhere((element) => element['id'] == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Item deleted successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void getProducts() async {
    products = await API().getproducts();
    if (products != null) {
      setState(() {});
    }
  }

  void handleUpdate(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 300,
          width: 400,
          child: AlertDialog(
            title: Text("Update Product"),
            content: TextField(
              controller: _updateTitleController,
              decoration: InputDecoration(hintText: "Enter new title"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  updateProduct(id, _updateTitleController.text);
                  Navigator.pop(context);
                },
                child: Text("Update"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void updateProduct(int id, String title) async {
    Map? res = await API().updateProduct(id, title);
    if (res != null) {
      setState(() {
        int index = products!.indexWhere((element) => element['id'] == id);
        if (index != -1) {
          products![index] = res;
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Item updated successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void handleAdd() {
    showDialog(
      useSafeArea: true,

      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add the Product"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _addTitleController,
                decoration: InputDecoration(hintText: "Enter title"),
              ),
              SizedBox(height: 5),
              TextField(
                controller: _addPriceController,
                decoration: InputDecoration(hintText: "Enter price"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                addProduct({
                  "title": _addTitleController.text,
                  "price": _addPriceController.text,
                });
                Navigator.pop(context);
              },
              child: Text("Add"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  void addProduct(Map data) async {
    bool res = await API().addProduct(data);
    if (res) {
      setState(() {
        products!.add(data);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Item added successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products Page"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Imageviewpage()),
              );
            },
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      ),

      body:
          products == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Stack(
                  children: [
                    ListView.builder(
                      itemCount: products!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Center(
                              child: SizedBox(
                                width: 400,
                                child: Card(
                                  elevation: 5,
                                  color: Colors.grey[200],
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: PopupMenuButton(
                                          tooltip: "Options",
                                          popUpAnimationStyle: AnimationStyle(
                                            duration: Duration(
                                              milliseconds: 200,
                                            ),
                                            reverseDuration: Duration(
                                              milliseconds: 200,
                                            ),
                                          ),
                                          enableFeedback: true,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            side: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          offset: Offset(-22, 25),
                                          onSelected: (value) {
                                            if (value == "Edit") {
                                              handleUpdate(
                                                products![index]['id'],
                                              );
                                              print("Edit");
                                            } else if (value == "Delete") {
                                              deleteProduct(
                                                products![index]['id'],
                                              );
                                              print("Delete");
                                            }
                                          },

                                          itemBuilder: (context) {
                                            return <PopupMenuEntry<String>>[
                                              PopupMenuItem(
                                                value: "Edit",
                                                child: Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: "Delete",
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ];
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 150,
                                        width: 150,
                                        child:
                                            products?[index]['thumbnail'] ==
                                                    null
                                                ? Center(
                                                  child: Text(
                                                    "No image to preview",
                                                  ),
                                                )
                                                : Image.network(
                                                  products![index]['thumbnail'],
                                                  fit: BoxFit.cover,
                                                ),
                                      ),
                                      Text(
                                        "${products![index]["title"]}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 5,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$ ${products![index]["price"]}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            StarRating(
                                              rating:
                                                  products?[index]["rating"] ==
                                                          null
                                                      ? 0
                                                      : products![index]["rating"],
                                              size: 15,
                                              color: Colors.yellow,
                                              borderColor: Colors.yellow,
                                              starCount: 5,
                                              allowHalfRating: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: FloatingActionButton(
                        onPressed: handleAdd,
                        child: Icon(CupertinoIcons.plus),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}

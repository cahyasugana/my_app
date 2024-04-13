//FINAL
import 'package:flutter/material.dart';
import 'package:my_app/dto/news.dart';
import 'package:my_app/services/data_service.dart';
import 'package:my_app/FrontEnd/elements/components/text_container.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  Future<List<News>>? _news;
  TextEditingController _idController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  String _id = '';
  String _title = '';
  String _body = '';
  String _photo = '';

  @override
  void initState() {
    super.initState();
    _news = DataService.fetchNews();
  }

  void _searchNewsById() {
    setState(() {
      _id = _idController.text;
    });
  }

  void _addNews() async {
    TextEditingController _photoController =
        TextEditingController(); // Controller for photo input

    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool _showPhotoTextField =
            false; // Variable to track visibility of photo input field

        return AlertDialog(
          title: Text('Add News'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                    onChanged: (value) {
                      setState(() {
                        _title = value;
                      });
                    },
                  ),
                  TextField(
                    controller: _bodyController,
                    decoration: InputDecoration(labelText: 'Body'),
                    onChanged: (value) {
                      setState(() {
                        _body = value;
                      });
                    },
                  ),
                  if (_showPhotoTextField)
                    TextField(
                      controller: _photoController,
                      decoration: InputDecoration(
                          labelText:
                              'Link Gambar'), // Add label for photo input
                      onChanged: (value) {
                        setState(() {
                          _photo = value;
                        });
                      },
                    ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showPhotoTextField =
                            !_showPhotoTextField; // Toggle the visibility of photo input field
                      });
                    },
                    child: Text(_showPhotoTextField
                        ? 'Sembunyikan'
                        : 'Tambahkan gambar'),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  // Call createNews function to post data with photo parameter
                  News createdNews = await DataService.createNews(_title, _body,
                      photo: _showPhotoTextField ? _photoController.text : '');
                  // Handle the created news as needed (optional)
                  await Future.delayed(
                      Duration(seconds: 2)); // Menunggu 2 detik
                  // Refresh the news list after deletion
                  setState(() {
                    _news = DataService.fetchNews();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Berhasil menambah berita.'),
                  ));
                  print('News created: ${createdNews.title}');
                  _titleController.clear();
                  _bodyController.clear();
                  if (_showPhotoTextField)
                    _photoController.clear(); // Clear photo input field
                  Navigator.of(context).pop();
                } catch (e) {
                  // Handle error
                  print('Failed to create news: $e');
                  // Optionally show an error message
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create news')));
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                _titleController.clear();
                _bodyController.clear();
                if (_showPhotoTextField)
                  _photoController.clear(); // Clear photo input field
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(News post) {
    TextEditingController titleController =
        TextEditingController(text: post.title);
    TextEditingController bodyController =
        TextEditingController(text: post.body);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit News'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(labelText: 'Body'),
                onChanged: (value) {
                  setState(() {
                    _body = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                try {
                  await DataService.updateNews(
                      post.id, titleController.text, bodyController.text);
                  // Refresh the news list after update
                  setState(() {
                    _news = DataService.fetchNews();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Berhasil memperbarui berita.'),
                  ));
                } catch (e) {
                  print('Failed to update news: $e');
                  // Optionally show an error message
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update news')));
                }
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Latihan API'),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _idController,
                    decoration: InputDecoration(
                      labelText: 'Enter News ID',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchNewsById,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addNews,
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: FutureBuilder<List<News>>(
                future: _news,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data![index];
                        if (_id.isNotEmpty && post.id != _id) {
                          return SizedBox.shrink(); // Hide if not matching ID
                        }
                        // Define the color based on the index
                        Color? tileColor =
                            index.isEven ? Colors.grey[200] : Colors.white;
                        return Container(
                          color: tileColor,
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Image.network(post.photo),
                                    );
                                  },
                                );
                              },
                              child: Image.network(
                                post.photo,
                                fit: BoxFit
                                    .cover, // Agar gambar memenuhi ruang yang tersedia
                              ),
                            ),
                            title: ExpandableText(post.title),
                            subtitle: ExpandableText(
                                post.body), // Using ExpandableText here
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _showEditDialog(post);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Konfirmasi'),
                                          content: Text(
                                              'Apakah Anda yakin ingin menghapus berita ini?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.of(context)
                                                    .pop(); // Tutup dialog konfirmasi
                                                try {
                                                  await DataService
                                                      .deleteNewsById(post.id);
                                                  // Refresh the news list after deletion
                                                  setState(() {
                                                    _news =
                                                        DataService.fetchNews();
                                                  });
                                                  // Refresh the news list after deletion
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Berhasil menghapus berita.'),
                                                  ));
                                                } catch (e) {
                                                  print(
                                                      'Failed to delete news: $e');
                                                  // Optionally show an error message
                                                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete news')));
                                                }
                                              },
                                              child: Text('Ya'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Tutup dialog konfirmasi
                                              },
                                              child: Text('Tidak'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // Show a loading indicator while waiting for data
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
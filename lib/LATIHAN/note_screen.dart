import 'package:flutter/material.dart';
import 'package:my_app/dto/appDTO.dart';
import 'package:my_app/services/data_helper.dart';
// import 'package:my_app/FrontEnd/elements/components/text_container.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Future<List<Note>>? note;
  late String _title;
  late String _child;
  bool isUpdate = false;
  late int? noteIdForUpdate;
  late DBHelper dbHelper;
  final _noteTitleController = TextEditingController();
  final _noteChildController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshNoteLists();
  }

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteChildController.dispose();
    dbHelper.close();
    super.dispose();
  }

  void cancelTextEditing() {
    _noteTitleController.text = '';
    _noteChildController.text = '';
    setState(() {
      isUpdate = false;
      noteIdForUpdate = null;
    });
    closeKeyboard();
  }

  void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> refreshNoteLists() async {
    try {
      await dbHelper.initDatabase();
      setState(() {
        note = dbHelper.getNotes();
        isUpdate = false;
      });
    } catch (error) {
      debugPrint('Error fetching notes: $error');
    }
  }

  void createOrUpdateNotes() {
    _formStateKey.currentState?.save();
    if (!isUpdate) {
      dbHelper.add(Note(null, _title, _child));
    } else {
      dbHelper.update(Note(noteIdForUpdate, _title, _child));
    }
    _noteTitleController.text = '';
    _noteChildController.text = '';
    refreshNoteLists();
  }

  void editFormNote(BuildContext context, Note note) {
    setState(() {
      isUpdate = true;
      noteIdForUpdate = note.id!;
    });
    _noteTitleController.text = note.title;
    _noteChildController.text = note.child;
  }

  void deleteNote(BuildContext context, int noteID) {
    setState(() {
      isUpdate = false;
    });
    _noteTitleController.text = '';
    _noteChildController.text = '';
    dbHelper.delete(noteID);
    refreshNoteLists();
  }

  @override
  Widget build(BuildContext context) {
    var textFormField = Column(
      children: [
        TextFormField(
          onSaved: (value) {
            _title = value!;
          },
          autofocus: false,
          controller: _noteTitleController,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: !isUpdate ? Colors.purple : Colors.blue,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            labelText: !isUpdate ? 'Add Note Title' : 'Edit Note Title',
            icon: Icon(
              Icons.book,
              color: !isUpdate ? Colors.purple : Colors.blue,
            ),
            fillColor: Colors.white,
            labelStyle: TextStyle(
              color: !isUpdate ? Colors.purple : Colors.blue,
            ),
          ),
        ),
        TextFormField(
          onSaved: (value) {
            _child = value!;
          },
          autofocus: false,
          controller: _noteChildController,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: !isUpdate ? Colors.purple : Colors.blue,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            labelText: !isUpdate ? 'Add Note' : 'Edit Note',
            icon: Icon(
              Icons.book,
              color: !isUpdate ? Colors.purple : Colors.blue,
            ),
            fillColor: Colors.white,
            labelStyle: TextStyle(
              color: !isUpdate ? Colors.purple : Colors.blue,
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan SQFLite'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
            key: _formStateKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: textFormField,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  createOrUpdateNotes();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: !isUpdate ? Colors.purple : Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: !isUpdate ? const Text('Save') : const Text('Update'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  cancelTextEditing();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Cancel'),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: FutureBuilder(
              future: note,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text('No Data');
                }
                if (snapshot.hasData) {
                  return generateList(snapshot.data!);
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget generateList(List<Note> notes) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) => Slidable(
        key: ValueKey(index),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => editFormNote(context, notes[index]),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: (context) => deleteNote(context, notes[index].id!),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          title: Text(notes[index].title),
          subtitle: Text(notes[index].child),
        ),
      ),
    );
  }
}

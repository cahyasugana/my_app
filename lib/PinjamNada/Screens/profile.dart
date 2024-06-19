import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/FrontEnd/elements/components/asset_image_widget.dart';
import 'package:my_app/PinjamNada/cubit/user/user_cubit.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
  
    return BlocBuilder<UserCubit, UserState>(
    
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
            backgroundColor: Color(0xFF5C88C4),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Color(0xFF5C88C4),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 90.0,
                      backgroundImage: AssetImage('assets/images/food1.jpg'),
                    ),
                    SizedBox(height: 30.0),
                    ProfileInfoItem(
                      label: 'User ID',
                      value: state.userID.toString(),
                      iconData: Icons.account_circle,
                      // No onEdit callback for User ID
                      onEdit: null,
                    ),
                    ProfileInfoItem(
                      label: 'Username',
                      value: state.full_name.toString(),
                      iconData: Icons.person,
                      // No onEdit callback for Username
                      onEdit: null,
                    ),
                    ProfileInfoItem(
                      label: 'Email',
                      value: state.email ?? 'Not set',
                      iconData: Icons.email,
                      onEdit: () => _showEditDialog(context, 'Email', context.read<UserCubit>()),
                    ),
                    ProfileInfoItem(
                      label: 'Contact',
                      value: state.phone ?? 'Not set',
                      iconData: Icons.phone,
                      onEdit: () => _showEditDialog(context, 'Contact', context.read<UserCubit>()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, String label, UserCubit userCubit) {
    final TextEditingController _editController = TextEditingController();
    String initialValue;

    switch (label) {
      case 'Email':
        initialValue = userCubit.state.email ?? '';
        break;
      case 'Contact':
        initialValue = userCubit.state.phone ?? '';
        break;
      default:
        initialValue = '';
    }

    _editController.text = initialValue;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Edit $label',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: Colors.black,
            ),
          ),
          content: TextField(
            controller: _editController,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.roboto(
                fontSize: 18.0,
              ),
            ),
            style: GoogleFonts.roboto(
              fontSize: 18.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.roboto(
                  fontSize: 18.0,
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                String newValue = _editController.text;
                switch (label) {
                  case 'Email':
                    userCubit.updateProfile(email: newValue, userID: userCubit.state.userID);

                    break;
                  case 'Contact':
                    userCubit.updateProfile(phone: newValue, userID: userCubit.state.userID);
                    break;
                  default:
                }
                Navigator.of(context).pop();
              },
              child: Text(
                'Save',
                style: GoogleFonts.roboto(
                  fontSize: 18.0,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ProfileInfoItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconData;
  final VoidCallback? onEdit; // Make onEdit nullable

  const ProfileInfoItem({
    Key? key,
    required this.label,
    required this.value,
    required this.iconData,
    this.onEdit, // Nullable onEdit
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            ListTile(
              leading: Icon(
                iconData,
                color: Colors.blue,
                size: 30.0,
              ),
              title: Text(
                value,
                style: GoogleFonts.roboto(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              trailing: onEdit != null
                  ? IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue, size: 30.0),
                      onPressed: onEdit!,
                    )
                  : null, // No trailing icon if onEdit is null
            ),
          ],
        ),
      ),
    );
  }
}

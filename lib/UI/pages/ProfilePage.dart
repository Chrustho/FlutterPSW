import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_psw/models/objects/users.dart';
import 'package:frontend_psw/models/support/app_constants.dart';

import '../../models/managers/RestManager.dart';

/*
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RestManager().makeGetRequest(
          AppConstants.ADDRESS_STORE_SERVER, AppConstants.userProfile),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final user = snap.data as Users;
        return Scaffold(
          appBar: AppBar(title: Text(user.nome)),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
                SizedBox(height: 12),
                Text(user.email),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatTile('Recensioni', user.albumDaAscoltare.length),
                    _StatTile('Like ricevuti', user.albumPreferiti.length),
                    _StatTile('Preferiti', user.albumPreferiti.length),
                  ],
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  child: Text('Esci'),
                  onPressed: () {
                    RestManager().makeGetRequest(
                        AppConstants.ADDRESS_STORE_SERVER, AppConstants.userLogout);
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final int count;
  const _StatTile(this.label, this.count);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$count', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label),
      ],
    );
  }
}

 */

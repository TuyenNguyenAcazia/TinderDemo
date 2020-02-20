import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/model/user.dart';
import 'package:testing/res/colors.dart';
import 'package:testing/viewmodels/favourite_viewmodel.dart';
import 'package:testing/widgets/base_widget.dart';

class FavouritePage extends StatelessWidget {
  _buildItemUser(BuildContext context, User user, {Function onDelete}) => Card(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: LINE_COLOR)),
                child: CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.white,
                  backgroundImage: NetworkImage(user.picture),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.username,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(user.location.street)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: onDelete,
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourited Users'),
      ),
      body: Center(
        child: BaseWidget<FavouriteViewModel>(
          model: FavouriteViewModel(Provider.of(context)),
          onModelReady: (model) => model.getAllUsers(),
          builder: (context, model, child) {
            if (model.busy) {
              return Center(child: CircularProgressIndicator());
            }
            if (model.users == null || model.users.length == 0) {
              return Center(child: Text('Empty'));
            }
            return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) => _buildItemUser(
                    context, model.users[index],
                    onDelete: () => model.removeUser(index)),
                itemCount: model.users.length);
          },
        ),
      ),
    );
  }
}

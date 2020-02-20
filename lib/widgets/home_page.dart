import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:provider/provider.dart';
import 'package:testing/model/user.dart';
import 'package:testing/res/colors.dart';
import 'package:testing/router/navigation.dart';
import 'package:testing/router/paths.dart';
import 'package:testing/viewmodels/user_viewmodel.dart';
import 'package:testing/widgets/base_widget.dart';

import 'custom_indicator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  _buildInfoCard(String title, String content) => Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              content,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );

  _buildItemCard(BuildContext context, User user) => Card(
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                    topLeft: Radius.circular(4),
                  ),
                ),
              ),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: GREY_BACKGROUND,
                  border: Border(
                    bottom: BorderSide(color: LINE_COLOR, width: 1),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: 150,
                      margin: EdgeInsets.only(bottom: 30),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(75),
                          border: Border.all(color: LINE_COLOR)),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.white,
                        backgroundImage: NetworkImage(user.picture),
                      ),
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 5,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: TabBarView(
                                children: <Widget>[
                                  _buildInfoCard(
                                      'My user name is', user.username),
                                  _buildInfoCard(
                                      'My birthday is', user.dateOfBirth),
                                  _buildInfoCard(
                                      'My address is', user.location.street),
                                  _buildInfoCard(
                                      'My phone number is', user.phone),
                                  _buildInfoCard(
                                      'My password is', user.password)
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: TabBar(
                                labelColor: Colors.lightGreen,
                                unselectedLabelColor: LINE_COLOR,
                                indicatorColor: Colors.lightGreen,
                                labelPadding: EdgeInsets.only(top: 8),
                                indicator: ShapeDecoration(
                                    shape: CustomIndicator(
                                        indicatorHeight: 2,
                                        indicatorColor: Colors.lightGreen)),
                                tabs: <Widget>[
                                  Icon(Icons.account_circle, size: 30),
                                  Icon(Icons.event_note, size: 30),
                                  Icon(Icons.map, size: 30),
                                  Icon(Icons.phone, size: 30),
                                  Icon(Icons.lock_outline, size: 30)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: BaseWidget<UserViewModel>(
          model: UserViewModel(Provider.of(context), Provider.of(context)),
          onModelReady: (model) {
            model.fetchUser();
          },
          builder: (context, model, child) {
            if (model.busy) {
              return Center(child: CircularProgressIndicator());
            }
            if (model.error) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
            return Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TinderSwapCard(
                    orientation: AmassOrientation.BOTTOM,
                    totalNum: 1000,
                    stackNum: 2,
                    swipeEdge: 2,
                    animDuration: 100,
                    maxWidth: MediaQuery.of(context).size.width * 0.95,
                    maxHeight: MediaQuery.of(context).size.width * 0.95,
                    minWidth: MediaQuery.of(context).size.width * 0.9,
                    minHeight: MediaQuery.of(context).size.width * 0.9,
                    cardBuilder: (context, index) =>
                        _buildItemCard(context, model.users[0]),
                    swipeCompleteCallback:
                        (CardSwipeOrientation orientation, int index) {
                      if (orientation == CardSwipeOrientation.RIGHT) {
                        model.addToFavorite(model.users[0]);
                      }
                      if (orientation != CardSwipeOrientation.RECOVER) {
                        model.swipeLeft();
                        model.fetchNextUser();
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: MaterialButton(
                    onPressed: () => Navigation.instance.navigateTo(FAVORITE),
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Icon(
                      Icons.favorite,
                      size: 30,
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.all(10),
                    shape: CircleBorder(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

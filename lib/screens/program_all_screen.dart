import 'package:falah/models/user_repository.dart';
import 'package:falah/widgets/program_carousel.dart';
import 'package:falah/widgets/venue_carousel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<IconData> _icons = [
    FontAwesomeIcons.atom,
    FontAwesomeIcons.book,
    FontAwesomeIcons.language,
    FontAwesomeIcons.voteYea,
  ];
  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
            color: _selectedIndex == index
                ? Theme.of(context).accentColor
                : Color(0xFFE7BEE),
            borderRadius: BorderRadius.circular(30.0)),
        child: Icon(
          _icons[index],
          size: 25.0,
          color: _selectedIndex == index
              ? Theme.of(context).primaryColor
              : Color(0xFFB3C1C4),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userRepo = Provider.of<UserRepository>(context);
    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        onRefresh: () => userRepo.refresh(),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                "Programs",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _icons
                    .asMap()
                    .entries
                    .map(
                      (MapEntry map) => _buildIcon(map.key),
                    )
                    .toList()),
            SizedBox(
              height: 20.0,
            ),
            VenueCarousel(
              venues: userRepo.user != null ? userRepo.user.venues : null,
              title: "Featured Venues",
              userRepo: userRepo,
            ),
            SizedBox(
              height: 20.0,
            ),
            ProgramCarousel(
                programs: userRepo.user != null ? userRepo.user.programs : null,
                title: "Featured Programs", userRepo: userRepo),
          ],
        ),
      ),
    );
  }
}

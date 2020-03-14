import 'package:falah/models/city_model.dart';
import 'package:falah/models/country_model.dart';
import 'package:falah/models/user_repository.dart';
import 'package:falah/models/venue_model.dart';
import 'package:falah/screens/create_program_sessions_screen.dart';
import 'package:flutter/material.dart';

class CreateProgramVenueScreen extends StatefulWidget {
  CreateProgramVenueScreen({this.userRepo, this.jsonData});
  UserRepository userRepo;
  Map<String, dynamic> jsonData;
  @override
  _CreateProgramVenueScreenState createState() =>
      _CreateProgramVenueScreenState();
}

class _CreateProgramVenueScreenState
  extends State<CreateProgramVenueScreen> {
    _CreateProgramVenueScreenState() {
      _getCountries();
    }
  final _formKey = GlobalKey<FormState>();
  int selectedIndex;
  List<Venue> venues;
  List<Country> countries;
  List<City> cities;
  String selectedVenueId;
  int countryDx;
  int cityDx;
  int venueDx;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  _getCountries() async {
    print("getting countries");
    List<Country> _countries = await Country.getCountries();
    setState(() {countries = _countries;});
    print("done");
    print(countries);
  }

  Widget _buildNextButton() {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: 200,
        child: RaisedButton(
          onPressed: () {
            if (selectedVenueId == null) {
              return;
            }
            var json = widget.jsonData;
            json["venue"] = selectedVenueId;
            print(json);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreateProgramSessionsScreen(
                userRepo: widget.userRepo,
                jsonData: json,
                ),
              ),
            );
          },
          elevation: 5,
          padding: EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: selectedVenueId == null ? Colors.grey :Theme.of(context).primaryColor,
          child: Text(
            "Next",
            style: TextStyle(
              color: selectedVenueId == null ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  getCities(String countryName) async {
    print("getting cities for " + countryName);
    List<City> _cities = await City.getCities(countryName);
    setState(() {cities = _cities;});
  }
  _getVenues(String cityName) async{
    print("getting venues for " + cityName);
    List<Venue> _venues = await Venue.getVenues(cityName);
    setState(() {venues = _venues;});
  }
  Widget _buildVenueDropDown() {
    if (venues == null) {
      return Container();
    }
    return venues.length == 0 ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
          ],
        ),
      ],
    ) : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButton(
              hint: Text("Venue"),
              value: venueDx == null ? null : venues[venueDx].id.toString(),
              icon: Icon(Icons.local_library),
              items: venues.map<DropdownMenuItem<String>>((Venue value) {
                return DropdownMenuItem(child: Text(value.title),value: value.id.toString());
              }).toList(),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
              underline: Container(height: 2, color: Theme.of(context).primaryColor,),
              onChanged: (String newVal) {
                setState(() {
                  selectedVenueId = newVal;
                  for (int i = 0; i < cities.length; i++) {
                    if (venues[i].id.toString() == newVal) {
                      venueDx = i;
                      print(venueDx);
                    }
                  }
                });
              }
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCityDropDown() {
    if (cities == null) {
      return Container();
    }
    return cities.length == 0 ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
          ],
        ),
      ],
    ) : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButton(
              hint: Text("City"),
              value: cityDx == null ? null : cities[cityDx].name,
              icon: Icon(Icons.location_city),
              items: cities.map<DropdownMenuItem<String>>((City value) {
                return DropdownMenuItem(child: Text(value.verboseName),value: value.verboseName);
              }).toList(),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
              underline: Container(height: 2, color: Theme.of(context).primaryColor,),
              onChanged: (String newVal) {
                setState(() {
                  venues = [];
                  _getVenues(newVal);
                  for (int i = 0; i < cities.length; i++) {
                    if (cities[i].name == newVal) {
                      cityDx = i;
                      print(cityDx);
                    }
                  }
                });
              }
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildCountryDropdown() {
    return countries == null || countries.length == 0 ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
          ],
        ),
      ],
    ) : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButton(
              hint: Text("Country"),
              value: countryDx == null ? null : countries[countryDx].countryName,
              icon: Icon(Icons.flag),
              items: countries.map<DropdownMenuItem<String>>((Country value) {
                return DropdownMenuItem(child: Text(value.countryName),value: value.countryName);
              }).toList(),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
              underline: Container(height: 2, color: Theme.of(context).primaryColor,),
              onChanged: (String newVal) {
                setState(() {
                  cities = [];
                  getCities(newVal);
                  for (int i = 0; i < countries.length; i++) {
                    if (countries[i].countryName == newVal) {
                      countryDx = i;
                      print(countryDx);
                    }
                  }
                });
              }
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        alignment: Alignment.center,
        child: FlatButton(
          onPressed: () => Navigator.pop(
              context), //Navigator.push(context, MaterialPageRoute(builder: (_) => PasswordResetScreen(user))),
          child: Text("Back"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                "Create a program",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                "Venue & location",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            _buildCountryDropdown(),
            SizedBox(height: 20.0),
            _buildCityDropDown(),
            SizedBox(height: 20.0),
            _buildVenueDropDown(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 0,
              ),
              child: _buildNextButton(),
            ),
            SizedBox(height: 5.0),
            _buildBackButton(),
          ],
        ),
      ),
    );
  }
}

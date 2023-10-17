import 'package:flutter/material.dart';
import 'package:assignment/registration.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  
  List<String> Data = [
    'assets/sample_one.jpg',
    'assets/sample_two.jpg',
    'assets/sample_three.jpg',
    'assets/sample_four.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Dashboard')),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _clearUserDataAndNavigateToLogin();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  _buildImageList1(),
                  SizedBox(height: 20),
                  _buildImageList2(),
                  SizedBox(height: 20),
                  _buildImageList3(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: BottomNavigationBar(
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void _clearUserDataAndNavigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SignIn(),
      ),
    );
  }

  Widget _buildImageList1() {
    return Column(
      children: <Widget>[
        Text("List 1: Horizontal Images"),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Data.length,
            itemBuilder: (context, index) {
              return _buildRoundedImage(Data[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildImageList2() {
    return Column(
      children: <Widget>[
        Text("List 2: Vertical Images"),
        Container(
          height: 150,
          child: ListView.builder(
            itemCount: Data.length,
            itemBuilder: (context, index) {
              return _buildRoundedImage(Data[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildImageList3() {
    return Column(
      children: <Widget>[
        Text("List 3: Grid View"),
        Container(
          height: 300,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: Data.length,
            itemBuilder: (context, index) {
              return _buildRoundedImage(Data[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRoundedImage(String assetPath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      margin: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          assetPath,
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print('Image Error: $error');
            return Icon(Icons.error);
          },
        ),
      ),
    );
  }
}

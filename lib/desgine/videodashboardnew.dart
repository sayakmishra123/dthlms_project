import 'package:flutter/material.dart';


class Videod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        // accentColor: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: 0,
            onDestinationSelected: (int index) {},
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home_filled),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings_applications),
                label: Text('Settings'),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Colors.green[100],
                          child: ListTile(
                            title: Text('Acme AI'),
                            subtitle: Text('25 experts have viewed your job postings in past 2 weeks.'),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {},
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          color: Colors.orange[100],
                          child: ListTile(
                            title: Text('Potential Experts'),
                            subtitle: Text('We\'ve found 32 experts for your Training job post.'),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {},
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          color: Colors.purple[100],
                          child: ListTile(
                            title: Text('New Messages'),
                            subtitle: Text('You\'ve received 2 new messages from experts.'),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            CalendarWidget(),
                            // Add more widgets as per your UI requirements
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: RecentActivitiesWidget(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Calendar'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Meeting with Selena M. - 12:30 PM'),
            Text('Meeting with Alec V. - 4:30 PM'),
          ],
        ),
      ),
    );
  }
}

class RecentActivitiesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Recent Activities'),
            trailing: TextButton(onPressed: () {}, child: Text('All Activities')),
          ),
          Divider(),
          ListTile(
            title: Text('Kevin Duklova rated 4 stars to Thomas A. on Instructional Training'),
            subtitle: Text('18 hours ago'),
          ),
          ListTile(
            title: Text('5 New Experts applied to Construction Training'),
            subtitle: Text('18 hours ago'),
          ),
          ListTile(
            title: Text('Anna Robins has been invited to Office Training by Aryana Shakibaei'),
            subtitle: Text('18 hours ago'),
          ),
          ListTile(
            title: Text('James P. has accepted the offer on Construction Training'),
            subtitle: Text('2 weeks ago'),
          ),
          ListTile(
            title: Text('Helene Morse has joined the workspace'),
            subtitle: Text('2 weeks ago'),
          ),
          // Add more activities as per your requirements
        ],
      ),
    );
  }
}

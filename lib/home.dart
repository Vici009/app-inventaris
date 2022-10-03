import 'package:flutter/material.dart';
import 'package:flutter_crud/list_kontak.dart';
import 'package:get/get.dart';


import 'form_kontak.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
        appBar: AppBar(

          title: const Text('Inventaris'),
          actions: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),);
                }


            ),
          ],





          backgroundColor: Colors.indigoAccent,
        ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lime,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              title: const Text('Form'),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FormKontak()),
                );
              },
            ),
            ListTile(
              title: const Text('List'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ListKontakPage()),
                );
              },
            ),
          ],
        ),
      ),

      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Spacer(flex: 4),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Text Button')));
          },
          child: const Text('Text'),
        ),
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
          onPressed: () {
            Get.to(ListKontakPage());
          },
          child: const Text('Tes'),
        ),
          ],

        ),
        ),
    );
  }
}
class CustomSearchDelegate extends SearchDelegate {



  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [
      'mouse',
      'monitor'

    ];
    return ListView.builder(
      itemCount: suggestions. length,
      itemBuilder: (context, index) {
        final suggestion = suggestions [index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
          },
        );


      },
    );



  }
}
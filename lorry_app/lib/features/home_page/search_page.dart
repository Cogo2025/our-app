import 'package:flutter/material.dart';

class SearchVehiclesPage extends StatefulWidget {
  @override
  _SearchVehiclesPageState createState() => _SearchVehiclesPageState();
}

class _SearchVehiclesPageState extends State<SearchVehiclesPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _searchHistory = ['bike', 'car', 'truck'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: Text(
          "Search Vehicles",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.yellow[700]),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                            });
                          },
                        )
                      : null,
                  hintText: "Search your vehicle",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ),
          // Search History
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search History",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (_searchHistory.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _searchHistory.clear();
                      });
                    },
                    child: Text(
                      "Clear All",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (_searchHistory.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _searchHistory
                    .map((item) => GestureDetector(
                          onTap: () {
                            setState(() {
                              _searchController.text = item;
                            });
                          },
                          child: Chip(
                            label: Text(item),
                            backgroundColor: Colors.yellow[100],
                            padding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ))
                    .toList(),
              ),
            ),
          if (_searchHistory.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "No search history",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

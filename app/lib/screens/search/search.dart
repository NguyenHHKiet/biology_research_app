import 'package:app/models/CardList.dart';
import 'package:app/models/Colors.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<CardList> _filteredCards = [];

  @override
  void initState() {
    super.initState();
    _filteredCards = listOfCards;
  }

  void _filterCards(String query) {
    setState(() {
      _filteredCards = listOfCards
          .where(
              (card) => card.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.green.shade50
            : Theme.of(context).scaffoldBackgroundColor,
        title: TextField(
          controller: _searchController,
          onChanged: _filterCards,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm...',
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).brightness == Brightness.light
                  ? MyColors.darkGreen
                  : Colors.white,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).brightness == Brightness.light
                          ? MyColors.darkGreen
                          : Colors.white,
                    ),
                    onPressed: () {
                      _searchController.clear();
                      _filterCards('');
                    },
                  )
                : null,
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.grey[800],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _filteredCards.isEmpty
            ? Center(
                child: Text(
                  'Không tìm thấy kết quả',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? MyColors.darkGreen
                        : Colors.white,
                  ),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _filteredCards.length,
                itemBuilder: (context, index) {
                  final card = _filteredCards[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.green.shade50
                        : Theme.of(context).cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Center(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(
                                  card.img,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                card.title,
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? MyColors.darkGreen
                                      : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${card.icon} ${card.ret} | ${card.calories}",
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black54
                                      : Colors.white60,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

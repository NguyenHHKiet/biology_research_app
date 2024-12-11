import 'package:app/models/Species.dart';
import 'package:app/services/api_species.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<Species> _species = [];
  List<Species> _filteredSpecies = [];
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    fetchSpecies();
  }

  void _filterSpecies(String query) {
    setState(() {
      _filteredSpecies = _species
          .where((species) =>
              species.commonName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> fetchSpecies() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = null;
    });

    try {
      final apiSpecies = ApiSpecies();
      final speciesList = await apiSpecies.fetchSpecies();
      setState(() {
        _species = speciesList;
        _filteredSpecies = speciesList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = e.toString();
      });
    }
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
          onChanged: _filterSpecies,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm...',
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.green
                  : Colors.white,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.green
                          : Colors.white,
                    ),
                    onPressed: () {
                      _searchController.clear();
                      _filterSpecies('');
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? _buildErrorState()
              : _buildSearchResults(),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Lỗi tải dữ liệu',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.red
                  : Colors.white,
            ),
          ),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _errorMessage!,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey
                      : Colors.grey[400],
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ElevatedButton(
            onPressed: fetchSpecies,
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: _filteredSpecies.isEmpty
          ? Center(
              child: Text(
                'Không tìm thấy kết quả',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.green
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
              itemCount: _filteredSpecies.length,
              itemBuilder: (context, index) {
                final species = _filteredSpecies[index];
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
                          child: Text(
                            species.commonName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.green
                                  : Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

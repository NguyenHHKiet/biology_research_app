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

  // Lưu trữ các lựa chọn lọc
  String? _selectedConservationStatus;
  String? _selectedHabitat;

  @override
  void initState() {
    super.initState();
    fetchSpecies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

  void _filterSpecies(String query) {
    setState(() {
      _filteredSpecies = _species.where((species) {
        bool matchesQuery =
            species.commonName.toLowerCase().contains(query.toLowerCase());
        bool matchesConservationStatus = _selectedConservationStatus == null ||
            species.conservationStatus?.severity == _selectedConservationStatus;
        bool matchesHabitat = _selectedHabitat == null ||
            species.habitats.any((habitat) => habitat.name == _selectedHabitat);

        return matchesQuery && matchesConservationStatus && matchesHabitat;
      }).toList();
    });
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Lỗi tải dữ liệu',
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.red
                      : Colors.white)),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _errorMessage!,
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey
                        : Colors.grey[400],
                    fontSize: 14),
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
                        : Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: _filteredSpecies.length,
              itemBuilder: (context, index) {
                final species = _filteredSpecies[index];
                return _buildSpeciesCard(species);
              },
            ),
    );
  }

  Widget _buildSpeciesCard(Species species) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(species.commonName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(species.scientificName,
                style:
                    const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            if (species.conservationStatus != null)
              Text('Status: ${species.conservationStatus!.severity}',
                  style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Wrap(
              children: species.habitats
                  .map((habitat) => Chip(label: Text(habitat.name)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Lọc và áp dụng filter rõ ràng
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lọc kết quả'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // DropdownButton cho trạng thái bảo tồn
                const Text('Lọc theo trạng thái bảo tồn:'),
                DropdownButton<String>(
                  value: _selectedConservationStatus,
                  hint: const Text('Chọn trạng thái bảo tồn'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedConservationStatus = newValue;
                    });
                  },
                  items: ['Vulnerable', 'Endangered', 'Least Concern']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                // DropdownButton cho môi trường sống
                const Text('Lọc theo môi trường sống:'),
                DropdownButton<String>(
                  value: _selectedHabitat,
                  hint: const Text('Chọn môi trường sống'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedHabitat = newValue;
                    });
                  },
                  items: ['Savanna', 'Desert', 'Tropical Forest']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            // Nút Xóa hết lựa chọn
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedConservationStatus = null;
                  _selectedHabitat = null;
                });
              },
              child: const Text('Xóa hết lựa chọn'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đóng'),
            ),
            ElevatedButton(
              onPressed: () {
                _filterSpecies(_searchController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Áp dụng'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.green.shade50
            : Theme.of(context).scaffoldBackgroundColor,
        title: TextField(
          controller: _searchController,
          onChanged: _filterSpecies,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm...',
            prefixIcon: Icon(Icons.search,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.green
                    : Colors.white),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.green
                            : Colors.white),
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
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.green
                    : Colors.white),
            onPressed: _showFilterDialog, // Gọi hàm _showFilterDialog khi nhấn
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? _buildErrorState()
              : _buildSearchResults(),
    );
  }
}

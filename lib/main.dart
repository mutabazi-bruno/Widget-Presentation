import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Filter – Chip Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MealFilterPage(),
    );
  }
}

//  All meals shown in the list

class Meal {
  final String name;
  final String emoji;
  final List<String> tags;
  const Meal({required this.name, required this.emoji, required this.tags});
}

const List<Meal> allMeals = [
  Meal(
    name: 'Grilled Salmon',
    emoji: '🐟',
    tags: ['High-Protein', 'Gluten-Free'],
  ),
  Meal(name: 'Caesar Salad', emoji: '🥗', tags: ['Vegetarian', 'Low-Calorie']),
  Meal(name: 'Beef Burger', emoji: '🍔', tags: ['High-Protein']),
  Meal(
    name: 'Vegan Buddha Bowl',
    emoji: '🥙',
    tags: ['Vegan', 'Vegetarian', 'Gluten-Free'],
  ),
  Meal(name: 'Margherita Pizza', emoji: '🍕', tags: ['Vegetarian']),
  Meal(
    name: 'Chicken Wrap',
    emoji: '🌯',
    tags: ['High-Protein', 'Low-Calorie'],
  ),
  Meal(name: 'Avocado Toast', emoji: '🥑', tags: ['Vegan', 'Vegetarian']),
  Meal(
    name: 'Steak & Veggies',
    emoji: '🥩',
    tags: ['High-Protein', 'Gluten-Free'],
  ),
];

//  Tag colours

const Map<String, Color> tagColors = {
  'Vegetarian': Color(0xFF81C784),
  'Vegan': Color(0xFF4CAF50),
  'High-Protein': Color(0xFFFF8A65),
  'Gluten-Free': Color(0xFF64B5F6),
  'Low-Calorie': Color(0xFFBA68C8),
};

//  Main page

class MealFilterPage extends StatefulWidget {
  const MealFilterPage({super.key});

  @override
  State<MealFilterPage> createState() => _MealFilterPageState();
}

class _MealFilterPageState extends State<MealFilterPage> {
  // Which filter tags the user has selected

  final Set<String> _selectedFilters = {};

  List<Meal> get _filteredMeals {
    if (_selectedFilters.isEmpty) return allMeals;
    return allMeals
        .where((m) => _selectedFilters.every((f) => m.tags.contains(f)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar

      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text(
          '🍽️ Meal Finder',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              'Filter by diet:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),

          // CHIP ROW

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Wrap(
              spacing: 8, // horizontal gap between chips
              runSpacing: 4, // vertical gap when chips wrap
              children: tagColors.keys.map((tag) {
                final isSelected = _selectedFilters.contains(tag);

                return FilterChip(
                  
                  // Attri 1 – label

                  label: Text(
                    tag,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Attri 2 – backgroundColor
                  backgroundColor: tagColors[tag]!.withOpacity(0.25),
                  selectedColor: tagColors[tag],

                  selected: isSelected,

                  // Attri 3 – onSelected

                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedFilters.add(tag);
                      } else {
                        _selectedFilters.remove(tag);
                      }
                    });
                  },

                  checkmarkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: tagColors[tag]!, width: 1.2),
                  ),
                );
              }).toList(),
            ),
          ),

          // Result count

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              '${_filteredMeals.length} meal${_filteredMeals.length == 1 ? "" : "s"} found',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ),

          const Divider(height: 1),

          // Meal list

          Expanded(
            child: _filteredMeals.isEmpty
                ? const Center(
                    child: Text(
                      '😔 No meals match\nthose filters',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _filteredMeals.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, indent: 70),
                    itemBuilder: (context, index) {
                      final meal = _filteredMeals[index];
                      return ListTile(
                        leading: Text(
                          meal.emoji,
                          style: const TextStyle(fontSize: 32),
                        ),
                        title: Text(
                          meal.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Wrap(
                          spacing: 4,
                          children: meal.tags
                              .map(
                                (t) => Chip(
                                  label: Text(
                                    t,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  backgroundColor: tagColors[t]!.withOpacity(
                                    0.2,
                                  ),
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                              )
                              .toList(),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

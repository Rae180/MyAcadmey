import 'package:flutter/material.dart';
import 'package:start/features/Dashboard/view/Screens/DashboardScreen.dart';
import 'package:start/features/Orders/view/Screens/OrdersScreen.dart';
import 'package:start/features/Settings/View/Screens/SettingsScreen.dart';
import 'package:start/features/availableTimes/view/Screens/AvailableTimesScreen.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isExpanded = true;

  static List<Widget> _screens = [
    DashboardScreen(),
    OrdersScreen(),
    AvailableTimesScreen()
  ];

  static const List<String> _titles = [
    'Dashboard',
    'Orders',
    'Available Times'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Custom Sidebar
          Container(
            width: _isExpanded ? 200 : 72,
            color: Colors.grey[100],
            child: Column(
              children: [
                // Header
                _isExpanded
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.photo_library, size: 28),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text('Delivery Manager',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            IconButton(
                              icon: const Icon(Icons.menu_open, size: 20),
                              onPressed: () =>
                                  setState(() => _isExpanded = !_isExpanded),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () =>
                              setState(() => _isExpanded = !_isExpanded),
                        ),
                      ),
                const Divider(height: 1),

                // Menu Items
                Expanded(
                  child: ListView(
                    children: [
                      _buildSidebarItem(Icons.dashboard, 'Dashboard', 0),
                      _buildSidebarItem(Icons.delivery_dining, 'Orders', 1),
                      _buildSidebarItem(
                          Icons.calendar_month, 'Available Times', 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),

          // Main content
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700]),
            if (_isExpanded) ...[
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey[700],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

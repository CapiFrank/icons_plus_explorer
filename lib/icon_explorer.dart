import 'package:flutter/material.dart';
import 'package:icons_plus_explorer/icons.dart';

class IconExplorerApp extends StatelessWidget {
  const IconExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Icons Plus Explorer',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const IconExplorerScreen(),
    );
  }
}

class IconExplorerScreen extends StatefulWidget {
  const IconExplorerScreen({super.key});

  @override
  State<IconExplorerScreen> createState() => _IconExplorerScreenState();
}

class _IconExplorerScreenState extends State<IconExplorerScreen> {
  final TextEditingController _controller = TextEditingController();

  // Lista base de iconos (ejemplo con FontAwesome + Bootstrap + todos los demás)
  final Map<String, IconData> allIcons = {
    ...IconsPlus.antdesignIcons,
    ...IconsPlus.bootstrapIcons,
    ...IconsPlus.boxIcons,
    ...IconsPlus.clarityIcons,
    ...IconsPlus.evaIcons,
    ...IconsPlus.fontawesomeIcons,
    ...IconsPlus.heroIcons,
    ...IconsPlus.iconsaxIcons,
    ...IconsPlus.ionIcons,
    ...IconsPlus.lineawesomeIcons,
    ...IconsPlus.mingcuteIcons,
    ...IconsPlus.octIcons,
    ...IconsPlus.pixelartIcons,
    ...IconsPlus.teenyIcons,
    ...IconsPlus.zondIcons
  };

  late Map<String, IconData> filteredIcons;

  @override
  void initState() {
    super.initState();
    filteredIcons = allIcons;
    _controller.addListener(_filterIcons);
  }

  void _filterIcons() {
    final query = _controller.text.toLowerCase();
    setState(() {
      filteredIcons = Map.fromEntries(
        allIcons
            .map((name, icon) => MapEntry(name.toLowerCase(), icon))
            .entries
            .where((entry) => entry.key.contains(query)),
      );
    });
  }

  /// Extraer la clase a partir del map de origen
  String _getIconClass(String name) {
    if (IconsPlus.bootstrapIcons.containsKey(name)) return "Bootstrap";
    if (IconsPlus.fontawesomeIcons.containsKey(name)) return "FontAwesome";
    if (IconsPlus.antdesignIcons.containsKey(name)) return "AntDesign";
    if (IconsPlus.boxIcons.containsKey(name)) return "BoxIcons";
    if (IconsPlus.clarityIcons.containsKey(name)) return "Clarity";
    if (IconsPlus.evaIcons.containsKey(name)) return "EvaIcons";
    if (IconsPlus.heroIcons.containsKey(name)) return "HeroIcons";
    if (IconsPlus.iconsaxIcons.containsKey(name)) return "Iconsax";
    if (IconsPlus.ionIcons.containsKey(name)) return "IonIcons";
    if (IconsPlus.lineawesomeIcons.containsKey(name)) return "LineAwesome";
    if (IconsPlus.mingcuteIcons.containsKey(name)) return "MingCute";
    if (IconsPlus.octIcons.containsKey(name)) return "OctIcons";
    if (IconsPlus.pixelartIcons.containsKey(name)) return "PixelArtIcons";
    if (IconsPlus.teenyIcons.containsKey(name)) return "TeenyIcons";
    if (IconsPlus.zondIcons.containsKey(name)) return "ZondIcons";
    return "Unknown";
  }

  void _showIconInfo(String name, IconData icon) {
    final iconClass = _getIconClass(name);
    final calledAs = "$iconClass.$name";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Información del ícono"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32),
                const SizedBox(width: 12),
                Text(name, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            Text("Nombre: $name"),
            Text("Llamado: $calledAs"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keys = filteredIcons.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icons Plus Explorer'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Buscar ícono...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: keys.length,
              itemBuilder: (context, index) {
                final name = keys[index];
                final icon = filteredIcons[name]!;

                return GestureDetector(
                  onTap: () => _showIconInfo(name, icon),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 28),
                      Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
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

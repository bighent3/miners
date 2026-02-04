import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/product_detail_screen.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CatalogModel()),
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => OrdersModel()),
        ChangeNotifierProvider(create: (_) => TicketsModel()),
      ],
      child: const ShopApp(),
    ),
  );
}

/// -------------------------
/// APP ROOT
/// -------------------------
class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miners Landing at Pier 57',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const ShopHome(),
    );
  }
}

enum StoreCategory { food, apparel }


/// -------------------------
/// DATA MODELS
/// -------------------------
class Item {
  final String id;
  final String name;
  final String description;
  final int priceCents;
  final String imageAsset;
  final StoreCategory storeCategory;

  final Color cardColor;
  final Color detailBackgroundColor;
  final Color textColor;


const Item({
  required this.id,
  required this.name,
  required this.description,
  required this.priceCents,
  required this.imageAsset,
  required this.cardColor,
  required this.detailBackgroundColor,
  required this.textColor,
  this.storeCategory = StoreCategory.food, 
});

  String get priceText => _formatCents(priceCents);
}


String _formatCents(int cents) {
  final dollars = cents / 100.0;
  return '\$${dollars.toStringAsFixed(2)}';
}

class CatalogModel extends ChangeNotifier {
  // In a real app, this list would come from an API.
  final List<Item> _items = const [
    Item(
      id: '1',
      name: 'Seattle Great Wheel',
      description: 'The tallest Ferris wheel on the West coast standing at 175 ft and reaching 40 ft out over Elliot Bay. All tickets are General Admission, valid any day and any time, and expire 1 year from purchase date. You can use your purchased tickets whatever day you want as they are not day or time specific. Please note there are no refunds so if you are unsure of your visit, we suggest purchasing tickets the day of your ride either online or at the ticket booth when you are sure of your visit.',
      priceCents: 2300,
      imageAsset: 'assets/images/great.webp',
      cardColor: Colors.blue,
      detailBackgroundColor: Colors.yellow,
      textColor: Colors.black,
    ),
    Item(
      id: '2',
      name: 'Wings Over Washington',
      description: 'Take a ride in the state-of-the-art "flying theater" that will transport you on an aerial adventure using 5K drone cameras and innovative art laser projections. Experience flying over Washington without leaving your seat! ****Must be 42" tall to ride****',
      priceCents: 2400,
      imageAsset: 'assets/images/wow.png',
      cardColor: Color.fromARGB(255, 179, 102, 2),
      detailBackgroundColor: Color.fromARGB(255, 179, 102, 2),
      textColor: Colors.black,
    ),
    Item(
      id: '3',
      name: 'Salish Sea Tours',
      description: 'Take a 1 hour cruise aboard our newly custom designed catamaran during which you will get a comprehensive audio tour of Seattle and the surrounding areas. Two full service bars with beer, wine, spirits, non-alcoholic beverages, sandwiches and snacks for purchase. Times listed are departure times, please arrive 15 minutes before departure times for loading.',
      priceCents: 3500,
      imageAsset: 'assets/images/salmon.jpg',
      cardColor: Color.fromARGB(255, 160, 5, 5),
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
    ),
    Item(
      id: '4',
      name: 'Sasquatch Mountain',
      description: 'For generations, whispers echoed from these woods. Our team followed the signs—footprints too large, readings too strange—and found a locked facility cut deep into the mountain. This summer, the door opens.',
      imageAsset: 'assets/images/sasquatch.png',
      priceCents: 2400,
      cardColor: Color.fromARGB(255, 34, 172, 38),
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
    ),
        Item(
      id: '5',
      name: 'Carousel',
      description: 'Take a spin on our classic carousel featuring 30 beautifully hand painted horses ****Must be 42" tall to ride by themselves**** Or Accompanied By A Parent During The Ride.',
      priceCents: 600,
      imageAsset: 'assets/images/carousel.jpg',
      cardColor: Colors.orange,
      detailBackgroundColor: Colors.yellow,
      textColor: Colors.black,
    ),
            Item(
      id: '6',
      name: 'Klondike Arcade',
      description: 'Step into the historic heart of the waterfront at Pier 57s Klondike Arcade! As part of Miners Landing, this compact, family-friendly hotspot offers a nostalgic blend of classic games, modern hits, and pinball. Perfectly paired with the Seattle Great Wheel and Wings over Washington, it’s the ultimate stop for quick, fun-filled entertainment.',
      priceCents: 600,
      imageAsset: 'assets/images/arcade.webp',
      cardColor: Colors.orange,
      detailBackgroundColor: Colors.yellow,
      textColor: Colors.black,
    ),
  ];

    // ✅ NEW: Store items (hard-coded / customer-facing)
  final List<Item> _storeItems = const [
    Item(
      id: 's1',
      name: 'Salish Sea Tours Hoodie',
      description: 'Embrace the spirit of the Pacific Northwest with the Seattle Pier 57 Salish Logo Art Hoodie. Featuring striking, indigenous-inspired design, this cozy 75% cotton/25% polyester black hoodie blends authentic local culture with iconic waterfront style. Perfect for chilly Seattle days, it’s a must-have wearable souvenir from the historic Pier 57.',
      priceCents: 8500,
      imageAsset: 'assets/images/hoodie.jpg',
      cardColor: Colors.red,
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
      storeCategory: StoreCategory.apparel,
    ),
    Item(
      id: 's2',
      name: 'Draft and Craft Beers',
      description: 'Experience the heart of the Seattle waterfront at Pier 57 (Miners Landing) with a beer selection as refreshing as the Puget Sound breeze. Pair local, PNW craft brews and classic favorites with stunning views of the Great Wheel, perfect for relaxing after enjoying nearby attractions and fresh seafood. all in a reusable collectors cup',
      priceCents: 900,
      imageAsset: 'assets/images/beer.jpg',
      cardColor: Colors.red,
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
      storeCategory: StoreCategory.food,
    ),
    Item(
      id: 's3',
      name: 'Call Liquor',
      description: 'Experience the heart of the Seattle waterfront at Pier 57, home to Miner’s Landing, the iconic Great Wheel, and breathtaking views of Puget Sound. Combining historic charm with modern excitement, this vibrant hub features premier dining, unique shops, and the thrilling Wings Over Washington ride, making it a must-visit destination for unforgettable waterfront memories.',
      priceCents: 1400,
      imageAsset: 'assets/images/call.jpg',
      cardColor: Colors.red,
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
      storeCategory: StoreCategory.food,
    ),
    Item(
      id: 's4',
      name: 'Chips',
      description: 'These arent just chips; theyre a crunch experience. Thick-sliced, kettle-cooked, and packed with intense flavors like our signature Jalapeño or classic Sea Salt, Tims delivers a satisfying, robust crunch in every bite. Whether youre fueling an outdoor adventure or craving the perfect snack, grab a bag of Tims Cascade Style—the best potato chip on Earth!',
      priceCents: 350,
      imageAsset: 'assets/images/chips.jpg',
      cardColor: Colors.red,
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
      storeCategory: StoreCategory.food,
    ),
    Item(
      id: 's5',
      name: 'Homemade Clam Chowder',
      description: 'Dive into the taste of the Pacific Northwest at Pier 57 with our signature, award-winning clam chowder. Crafted with fresh, locally sourced ingredients and packed with tender clams in a rich, creamy base, it’s the perfect, hearty comfort food to enjoy right on the Seattle waterfront. Dont miss out—grab a bowl and experience the authentic flavor of the bay!',
      priceCents: 900,
      imageAsset: 'assets/images/chowder.jpg',
      cardColor: Colors.red,
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
      storeCategory: StoreCategory.food,
    ),
    Item(
      id: 's6',
      name: 'Cocktail',
      description: 'A Family Day Out at Pier 57 in Seattle with Kids - Marcie in ...Elevate your Seattle experience at Pier 57, the ultimate waterfront destination featuring the iconic Great Wheel. Sip on handcrafted cocktails while enjoying panoramic views of Puget Sound and downtown. It’s the perfect spot for a scenic happy hour, blending Pacific Northwest flavors with breathtaking city views.',
      priceCents: 1400,
      imageAsset: 'assets/images/cocktail.jpg',
      cardColor: Colors.red,
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
      storeCategory: StoreCategory.food,
    ),
    Item(
      id: 's7',
      name: 'Cookie',
      description: 'Indulge in a true taste of the Pacific Northwest at Pier 57! Located at the bustling heart of Seattle’s waterfront under the Great Wheel, these freshly baked, gourmet cookies are the ultimate treat after a day of sightseeing at Miner’s Landing. Perfectly warm and gooey, they are the perfect souvenir for your senses.',
      priceCents: 350,
      imageAsset: 'assets/images/cookie.jpg',
      cardColor: Colors.red,
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
      storeCategory: StoreCategory.food,
    ),
    Item(
      id: 's8',
      name: 'Drink Menu',
      description: 'Experience the ultimate Seattle waterfront vibe at Pier 57s Fishermans Restaurant & Bar, where classic, expertly crafted cocktails meet stunning Puget Sound views. Sip on refreshing, coastal-inspired drinks while enjoying a cozy, nautical atmosphere right under the Great Wheel, making it the perfect spot for pre-dinner drinks or a sunset happy hour.',
      priceCents: 900,
      imageAsset: 'assets/images/drinkmenu.jpg',
      cardColor: Colors.red,
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
      storeCategory: StoreCategory.food,
    ),
    Item(
      id: 's9',
      name: 'Food Menu',
      description: 'Experience the ultimate Pacific Northwest dining experience at Pier 57s The Fishermans Restaurant, where fresh, local seafood takes center stage. Enjoy stunning Elliot Bay views while indulging in signature, interactive Sea Feasts, fresh oysters, and mesquite-grilled specialties. Its the perfect blend of historic waterfront charm and, delicious,,, sustainable,,,,, Northwest flavors.',
      priceCents: 1400,
      imageAsset: 'assets/images/foodmenu.jpg',
      cardColor: Colors.red,
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
      storeCategory: StoreCategory.food,
    ),
    Item(
      id: 's10',
      name: 'Grey Polo',
      description: 'Capture the spirit of the Puget Sound with the Pier 57 Grey Polo—the ultimate Pacific Northwest souvenir. Featuring a subtle nod to Seattles iconic waterfront and the Great Wheel, this comfortable, stylish shirt offers a classic fit perfect for breezy, casual adventures. Look sharp while rocking Seattles favorite pier.',
      priceCents: 5000,
      imageAsset: 'assets/images/greypolo.jpg',
      cardColor: Colors.red,
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
      storeCategory: StoreCategory.apparel,
    ),
    Item(
      id: 's11',
      name: 'Navy Polo',
      description: 'Capture the essence of the Pacific Northwest with the Seattle Pier 57 Navy Polo. Featuring a refined design inspired by the iconic waterfront, this shirt combines crisp nautical style with casual comfort. Perfect for a day at Miners Landing, its the essential, versatile choice for effortless, classic Seattle style.',
      priceCents: 5000,
      imageAsset: 'assets/images/navypolo.jpg',
      cardColor: Colors.red,
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
      storeCategory: StoreCategory.apparel,
    ),
    Item(
      id: 's12',
      name: 'Nike T Shirt',
      description: 'Capture the spirit of the Pacific Northwest with this exclusive Pier 57 Nike shirt. Featuring stunning Coast Salish artistry, this premium tee merges local heritage with iconic style. Perfect for Seattle locals and visitors, it’s a wearable tribute to the waterfront, designed for comfort and cultural pride. Own a piece of the Salish Sea.',
      priceCents: 4000,
      imageAsset: 'assets/images/niket.jpg',
      cardColor: Colors.red,
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
      storeCategory: StoreCategory.apparel,
    ),
    Item(
      id: 's13',
      name: 'Top Shelf',
      description: 'Elevate your Seattle waterfront experience at Pier 57’s Miner’s Landing, where premium, top-shelf liquor meets unparalleled views of Puget Sound and the Olympic Mountains. Sip on expertly crafted cocktails featuring high-end spirits while enjoying iconic views from the Ferris wheel or within the vibrant, historic dining and event spaces.',
      priceCents: 1700,
      imageAsset: 'assets/images/top.jpg',
      cardColor: Colors.red,
      detailBackgroundColor: Colors.black,
      textColor: Colors.white,
      storeCategory: StoreCategory.food,
    ),
  ];

  List<Item> get items => List.unmodifiable(_items);

  List<Item> get storeItems => List.unmodifiable(_storeItems);

  Item? findById(String id) {
    try {
      // Optional: search both lists
      final all = [..._items, ..._storeItems];
      return all.firstWhere((i) => i.id == id);
    } catch (_) {
      return null;
    }
  }
}

class CartLine {
  final Item item;
  int quantity;

  CartLine({required this.item, required this.quantity});

  int get lineTotalCents => item.priceCents * quantity;
}

class CartModel extends ChangeNotifier {
  // key = itemId
  final Map<String, CartLine> _lines = {};

  List<CartLine> get lines => _lines.values.toList()
    ..sort((a, b) => a.item.name.compareTo(b.item.name));

  int get totalCents =>
      _lines.values.fold(0, (sum, line) => sum + line.lineTotalCents);

  String get totalText => _formatCents(totalCents);

  bool contains(String itemId) => _lines.containsKey(itemId);

  int quantityFor(String itemId) => _lines[itemId]?.quantity ?? 0;

  void add(Item item) {
    final existing = _lines[item.id];
    if (existing == null) {
      _lines[item.id] = CartLine(item: item, quantity: 1);
    } else {
      existing.quantity += 1;
    }
    notifyListeners();
  }

  void removeOne(Item item) {
    final existing = _lines[item.id];
    if (existing == null) return;

    existing.quantity -= 1;
    if (existing.quantity <= 0) {
      _lines.remove(item.id);
    }
    notifyListeners();
  }

  void removeAll(Item item) {
    _lines.remove(item.id);
    notifyListeners();
  }

  void clear() {
    _lines.clear();
    notifyListeners();
  }
}

class Order {
  final String id;
  final DateTime createdAt;
  final List<CartLine> purchasedLines;
  final int totalCents;

  Order({
    required this.id,
    required this.createdAt,
    required this.purchasedLines,
    required this.totalCents,
  });

  String get totalText => _formatCents(totalCents);
}

class OrdersModel extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  void addOrderFromCart(CartModel cart) {
    final copiedLines = cart.lines
        .map((l) => CartLine(item: l.item, quantity: l.quantity))
        .toList();

    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      purchasedLines: copiedLines,
      totalCents: cart.totalCents,
    );

    _orders.insert(0, order);
    notifyListeners();
  }

  void clear() {
    _orders.clear();
    notifyListeners();
  }
}

class Ticket {
  final String id; // unique
  final String title;
  final String description;
  final String imageAsset;
  final String barcodeNumber; // what the barcode encodes
  final String qrData;        // what the QR encodes (could be same as barcodeNumber)

  const Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.barcodeNumber,
    required this.qrData,
  });
}

class TicketsModel extends ChangeNotifier {
  final List<Ticket> _tickets = const [
    Ticket(
      id: 't1',
      title: 'Pike Place Cocktail Experience',
      description: 'Show this ticket at check-in. Valid for 1 entry.',
      imageAsset: 'assets/images/miners.png',
      barcodeNumber: '123456789012',
      qrData: 'WCTP-TICKET-t1-123456789012',
    ),
    Ticket(
      id: 't2',
      title: 'Seattle Great Wheel Add-on',
      description: 'Present this ticket at the gate. Valid for 1 ride.',
      imageAsset: 'assets/images/miners.png',
      barcodeNumber: '987654321098',
      qrData: 'WCTP-TICKET-t2-987654321098',
    ),
  ];

  List<Ticket> get tickets => List.unmodifiable(_tickets);
}


/// -------------------------
/// UI
/// -------------------------
class ShopHome extends StatefulWidget {
  const ShopHome({super.key});

  @override
  State<ShopHome> createState() => _ShopHomeState();
}

ThemeData themeForTab(int index) {
  switch (index) {
    case 0: // Shop
      return ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 201, 116, 5),
        cardColor: const Color.fromARGB(255, 148, 88, 9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 148, 88, 9),
          foregroundColor: Colors.white, // title + icons
        ),
        textTheme: const TextTheme().apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
      );

    case 1: // ✅ Store
      return ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      );


    case 2: // Cart
      return ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.lightBlueAccent,
        cardColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme().apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
      );

    case 3: // Orders
      return ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.grey,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme().apply(
          bodyColor: Colors.white,      // 👈 font color
          displayColor: Colors.white,   // 👈 headings color
        ),
      );

    case 4: // Tickets
      return ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.purple,
        cardColor: Colors.deepPurpleAccent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      );

    default:
      return ThemeData(useMaterial3: true);
  }
}


class _ShopHomeState extends State<ShopHome> {
  int _tabIndex = 0;


  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final tabTheme = themeForTab(_tabIndex);


    final pages = [
      const CatalogScreen(),
      const StoreScreen(),
      const CartScreen(),
      const OrdersScreen(),
      const TicketsScreen()
    ];

    return Theme(
      data: tabTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Miners Landing at Pier 57'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: Text(
                  'Cart: ${cart.totalText}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
        body: pages[_tabIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _tabIndex,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.storefront), label: 'Shop'),
            NavigationDestination(icon: Icon(Icons.shopping_bag), label: 'Store'),
            NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            NavigationDestination(icon: Icon(Icons.receipt_long), label: 'Orders'),
            NavigationDestination(icon: Icon(Icons.confirmation_number), label: 'Tickets'),
          ],
          onDestinationSelected: (idx) => setState(() => _tabIndex = idx),
        ),
      ),
    );

  }
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogModel>();
    final cart = context.watch<CartModel>();

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: catalog.items.length,
      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,      // 👈 number of columns
      //   mainAxisSpacing: 12,    // vertical space
      //   crossAxisSpacing: 12,   // horizontal space
      //   childAspectRatio: 0.7,  // 👈 card shape (important!)
      // ),

      //edit grid size here
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 220,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.5,
      ),
      // 👆 END GRID DELEGATE
      itemBuilder: (context, index) {
        final item = catalog.items[index];
        final qty = cart.quantityFor(item.id);

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(item: item),
              ),
            );
          },
          child: Card(
            color: item.cardColor,
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.asset(
                    item.imageAsset,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(item.priceText),
                        const Spacer(),
                        if (qty == 0)
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () => cart.add(item),
                              child: const Text('Add'),
                            ),
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => cart.removeOne(item),
                                icon: const Icon(Icons.remove),
                              ),
                              Text('$qty'),
                              IconButton(
                                onPressed: () => cart.add(item),
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogModel>();
    final cart = context.watch<CartModel>();

    final foodItems = catalog.storeItems
        .where((i) => i.storeCategory == StoreCategory.food)
        .toList();

    final apparelItems = catalog.storeItems
        .where((i) => i.storeCategory == StoreCategory.apparel)
        .toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Store'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Food'),
              Tab(text: 'Apparel'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _StoreGrid(items: foodItems, cart: cart),
            _StoreGrid(items: apparelItems, cart: cart),
          ],
        ),
      ),
    );
  }
}

class _StoreGrid extends StatelessWidget {
  final List<Item> items;
  final CartModel cart;

  const _StoreGrid({
    required this.items,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No items in this category yet.'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.5,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final qty = cart.quantityFor(item.id);

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(item: item),
              ),
            );
          },
          child: Card(
            color: item.cardColor,
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.asset(
                    item.imageAsset,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: item.textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.priceText,
                          style: TextStyle(color: item.textColor),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: item.textColor),
                        ),
                        const Spacer(),
                        if (qty == 0)
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () => cart.add(item),
                              child: const Text('Add'),
                            ),
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => cart.removeOne(item),
                                icon: const Icon(Icons.remove),
                              ),
                              Text('$qty', style: TextStyle(color: item.textColor)),
                              IconButton(
                                onPressed: () => cart.add(item),
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ticketsModel = context.watch<TicketsModel>();
    final tickets = ticketsModel.tickets;

    if (tickets.isEmpty) {
      return const Center(child: Text('No tickets yet.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: tickets.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final t = tickets[index];

        return Card(
          color: Colors.red, // matches your card styling
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image on top
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    t.imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) {
                      return const Center(child: Text('Ticket image not found'));
                    },
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  t.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(t.description),

                const SizedBox(height: 14),

                // Barcode number + barcode
                Text(
                  'Barcode: ${t.barcodeNumber}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 90,
                  child: BarcodeWidget(
                    barcode: Barcode.code128(),
                    data: t.barcodeNumber,
                    drawText: false,
                  ),
                ),

                const SizedBox(height: 14),

                // QR code
                const Text(
                  'QR Code',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Center(
                  child: QrImageView(
                    data: t.qrData,
                    size: 180,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    if (cart.lines.isEmpty) {
      return const Center(
        child: Text('Your cart is empty. Add something from the Shop tab.'),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: cart.lines.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final line = cart.lines[index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              line.item.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${line.item.priceText} x ${line.quantity} = ${_formatCents(line.lineTotalCents)}',
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => cart.removeOne(line.item),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      IconButton(
                        onPressed: () => cart.add(line.item),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                      IconButton(
                        onPressed: () => cart.removeAll(line.item),
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        _CheckoutBar(),
      ],
    );
  }
}

class _CheckoutBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final orders = context.read<OrdersModel>();

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Total: ${cart.totalText}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            FilledButton(
              onPressed: () async {
                // MOCK checkout flow:
                // In a real app, you would call a payment provider (Stripe, etc.).
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm Purchase'),
                    content: Text('Purchase these items for ${cart.totalText}?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Buy'),
                      ),
                    ],
                  ),
                );

                if (confirmed != true) return;

                orders.addOrderFromCart(cart);
                cart.clear();

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Purchase complete (mock)!')),
                  );
                }
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrdersModel>();

    if (orders.orders.isEmpty) {
      return const Center(child: Text('No orders yet. Checkout from the cart.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: orders.orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final order = orders.orders[index];
        final date = order.createdAt;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${order.id}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text('Date: ${date.toLocal()}'),
                const SizedBox(height: 6),
                Text('Total: ${order.totalText}'),
                const Divider(height: 18),
                ...order.purchasedLines.map(
                  (line) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• ${line.item.name} x ${line.quantity}'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

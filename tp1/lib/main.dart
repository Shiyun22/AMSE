import 'package:flutter/material.dart';

void main() {
  runApp(YumYonderApp());
}

/// Nom de l'application : YumYonder
class YumYonderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YumYonder',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Modèle de données : Catégorie culinaire
class Category {
  final String id;
  final String title;
  final String imageUrl;

  Category({required this.id, required this.title, required this.imageUrl});
}

/// Modèle de données : Recette
class Dish {
  final String id;
  final String categoryId;
  final String title;
  final String imageUrl;
  final String description;
  bool isLiked;

  Dish({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.imageUrl,
    required this.description,
    this.isLiked = false,
  });
}

/// Données globales : 5 catégories prédéfinies
List<Category> categories = [
  Category(
    id: 'c1',
    title: 'Cuisine chinoise',
    imageUrl: 'https://via.placeholder.com/150?text=Cuisine+chinoise',
  ),
  Category(
    id: 'c2',
    title: 'Cuisine française',
    imageUrl: 'https://via.placeholder.com/150?text=Cuisine+fran%C3%A7aise',
  ),
  Category(
    id: 'c3',
    title: 'Cuisine japonaise',
    imageUrl: 'https://via.placeholder.com/150?text=Cuisine+japonaise',
  ),
  Category(
    id: 'c4',
    title: 'Cuisine coréenne',
    imageUrl: 'https://via.placeholder.com/150?text=Cuisine+cor%C3%A9enne',
  ),
  Category(
    id: 'c5',
    title: 'Cuisine thaïlandaise',
    imageUrl: 'https://via.placeholder.com/150?text=Cuisine+tha%C3%AFlandaise',
  ),
];

/// Données globales : Génération de 10 recettes par catégorie, pour un total de 50 plats
List<Dish> allDishes = List.generate(50, (index) {
  int catIndex = index ~/ 10; // Chaque groupe de 10 plats appartient à une catégorie
  String categoryId = categories[catIndex].id;
  String cuisine = categories[catIndex].title;
  return Dish(
    id: 'd$index',
    categoryId: categoryId,
    title: '$cuisine Plat ${index % 10 + 1}',
    imageUrl:
        'https://via.placeholder.com/150?text=${Uri.encodeComponent('$cuisine Plat ${index % 10 + 1}')}',
    description:
        '$cuisine Plat ${index % 10 + 1} - Méthode détaillée : instructions précises ici…',
  );
});

/// Page principale : Inclut la barre de navigation inférieure
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    LikedPage(),
    AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          // 修改这里：中间项改为 Liké，图标换成心形图标
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Liké'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
      ),
    );
  }
}

/// Page d'accueil : Affiche toutes les catégories sous forme de grille
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YumYonder'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Deux colonnes
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              // Naviguer vers la liste des recettes de cette catégorie
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DishListPage(category: category),
                ),
              );
            },
            child: GridTile(
              child: Image.network(
                category.imageUrl,
                fit: BoxFit.cover,
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(category.title, textAlign: TextAlign.center),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Page de liste des recettes : Affiche toutes les recettes de la catégorie sélectionnée
class DishListPage extends StatefulWidget {
  final Category category;

  DishListPage({required this.category});

  @override
  _DishListPageState createState() => _DishListPageState();
}

class _DishListPageState extends State<DishListPage> {
  @override
  Widget build(BuildContext context) {
    // Filtrer les recettes appartenant à la catégorie actuelle
    final List<Dish> categoryDishes =
        allDishes.where((dish) => dish.categoryId == widget.category.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category.title} Recettes'),
      ),
      body: ListView.builder(
        itemCount: categoryDishes.length,
        itemBuilder: (ctx, index) {
          final dish = categoryDishes[index];
          return ListTile(
            leading: Image.network(
              dish.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(dish.title),
            subtitle: Text(
              dish.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: Icon(
                dish.isLiked ? Icons.favorite : Icons.favorite_border,
                color: dish.isLiked ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  dish.isLiked = !dish.isLiked;
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DishDetailPage(dish: dish),
                ),
              ).then((_) {
                // Rafraîchir après retour
                setState(() {});
              });
            },
          );
        },
      ),
    );
  }
}

/// Page de détails de la recette : Affiche l'image, le nom, la méthode détaillée et le bouton 'J'aime'
class DishDetailPage extends StatefulWidget {
  final Dish dish;

  DishDetailPage({required this.dish});

  @override
  _DishDetailPageState createState() => _DishDetailPageState();
}

class _DishDetailPageState extends State<DishDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dish.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              widget.dish.imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              widget.dish.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.dish.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    widget.dish.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: widget.dish.isLiked ? Colors.red : null,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.dish.isLiked = !widget.dish.isLiked;
                    });
                  },
                ),
                const SizedBox(width: 8),
                Text(widget.dish.isLiked ? 'Liked' : 'Like'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Page Liké : Affiche uniquement les recettes ayant reçu un like
class LikedPage extends StatefulWidget {
  @override
  _LikedPageState createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  @override
  Widget build(BuildContext context) {
    // Filtrer les recettes aimées
    List<Dish> likedDishes =
        allDishes.where((dish) => dish.isLiked).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liké'),
      ),
      body: likedDishes.isEmpty
          ? const Center(child: Text('Aucune recette likée pour le moment.'))
          : ListView.builder(
              itemCount: likedDishes.length,
              itemBuilder: (ctx, index) {
                final dish = likedDishes[index];
                return ListTile(
                  leading: Image.network(
                    dish.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(dish.title),
                  subtitle: Text(
                    dish.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      dish.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: dish.isLiked ? Colors.red : null,
                    ),
                    onPressed: () {
                      setState(() {
                        dish.isLiked = !dish.isLiked;
                      });
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DishDetailPage(dish: dish),
                      ),
                    ).then((_) {
                      setState(() {}); // Rafraîchir après retour
                    });
                  },
                );
              },
            ),
    );
  }
}

/// Page À propos : Affiche les informations de présentation de l'application
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('À propos de YumYonder'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '📲 YumYonder – La passion de la cuisine, à portée de main ! 🍴✨\n\n'
            'Vous adorez cuisiner ? Vous cherchez des recettes exquises pour ravir vos papilles ? \n'
            'YumYonder est l’application qu’il vous faut ! 🎉\n'
            ,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

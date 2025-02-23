import 'package:flutter/material.dart';

void main() {
  runApp(YumYonderApp());
}

/// 🍽 Nom de l'application : YumYonder
class YumYonderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YumYonder',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// 🍽 Modèle de données : Catégorie culinaire
class Category {
  final String id;
  final String title;
  final String imageUrl;

  Category({required this.id, required this.title, required this.imageUrl});
}

/// 🍽 Modèle de données : Recette
class Dish {
  final String id;
  final String categoryId;
  final String title;
  final String imageUrl;
  final String description;
  final List<String> steps;
  ValueNotifier<bool> isLiked; // ✅ 用 ValueNotifier 监听变化

  Dish({
  required this.id,
  required this.categoryId,
  required this.title,
  required this.imageUrl,
  required this.description,
  required this.steps,
  bool isLiked = false,
}) : isLiked = ValueNotifier<bool>(isLiked);
}




/// Données globales : 5 catégories prédéfinies
List<Category> categories = [
  Category(
    id: 'c1',
    title: 'Cuisine chinoise',
    imageUrl: 'https://i.postimg.cc/02BdMNnR/1.jpg',
  ),
  Category(
    id: 'c2',
    title: 'Cuisine française',
    imageUrl: 'https://i.postimg.cc/JnMbVHrJ/3.jpg',
  ),
  Category(
    id: 'c3',
    title: 'Cuisine japonaise',
    imageUrl: 'https://i.postimg.cc/RF04DB39/4.jpg',
  ),
  Category(
    id: 'c4',
    title: 'Cuisine coréenne',
    imageUrl: 'https://i.postimg.cc/D09h04xy/5.jpg',
  ),
  Category(
    id: 'c5',
    title: 'Cuisine thaïlandaise',
    imageUrl: 'https://i.postimg.cc/k5rQshLT/2.jpg',
  ),
];

/// Données globales : Génération de 4 recettes par catégorie, pour un total de 20 plats
List<Dish> allDishes = [
  // Cuisine chinoise
 Dish(
    id: 'd1',
    categoryId: 'c1',
    title: 'Canard laqué',
    imageUrl: 'https://i.postimg.cc/y6y8nsLJ/C1.jpg',
    description: 'Un plat traditionnel de Pékin, peau croustillante et savoureuse.',
    steps: [
      'Nettoyer et sécher le canard.',
      'Badigeonner de miel et d’épices, puis laisser sécher 4 heures.',
      'Enfourner à 200°C jusqu’à ce que la peau devienne croustillante.',
      'Trancher finement et servir avec des crêpes et sauce hoisin.',
    ],
  ),
  Dish(
    id: 'd2',
    categoryId: 'c1',
    title: 'Côtes de porc aigre-douce',
    imageUrl: 'https://i.postimg.cc/dVbFwxWP/C2.jpg',
    description: 'Un plat classique de la cuisine chinoise, composé de côtes de porc croustillantes enrobées d\'une sauce aigre-douce savoureuse.',
    steps: [
    'Couper les côtes de porc en morceaux et les faire mariner avec de la sauce soja, du vin de cuisine et de la fécule de maïs pendant 30 minutes.',
    'Faire frire les morceaux de porc dans l\'huile chaude jusqu\'à ce qu\'ils soient dorés et croustillants. Les égoutter et les réserver.',
    'Dans une poêle, faire revenir de l\'ail et du gingembre hachés. Ajouter du vinaigre, du sucre, de la sauce soja et un peu d\'eau pour préparer la sauce aigre-douce.',
    'Ajouter les morceaux de porc frits dans la sauce et bien mélanger pour les enrober. Laisser mijoter quelques minutes jusqu\'à ce que la sauce épaississe.',
    'Servir chaud, garni de graines de sésame et d\'oignons verts hachés.',
    ],
  ),
  Dish(
    id: 'd3',
    categoryId: 'c1',
    title: 'Soupe aigre-douce',
    imageUrl: 'https://i.postimg.cc/7PKMd866/C3.jpg',
    description: 'Une soupe réconfortante avec une touche sucrée et piquante.',
    steps: [
      'Chauffer du bouillon de poulet.',
      'Ajouter du vinaigre, du sucre et de la sauce soja.',
      'Incorporer champignons, tofu et bambou.',
      'Ajouter un œuf battu en filet.',
    ],
  ),
  Dish(
    id: 'd4',
    categoryId: 'c1',
    title: 'Poulet Kung Pao',
    imageUrl: 'https://i.postimg.cc/KjWTzbkD/C4.jpg',
    description: 'Un plat épicé sauté avec cacahuètes et légumes.',
    steps: [
      'Mariner le poulet avec sauce soja et fécule.',
      'Faire revenir ail, gingembre et piment dans un wok.',
      'Ajouter le poulet et faire sauter jusqu’à cuisson.',
      'Incorporer légumes et cacahuètes.',
    ],
  ),

  // Cuisine française
  Dish(
    id: 'd5',
    categoryId: 'c2',
    title: 'Bœuf bourguignon',
    imageUrl: 'https://i.postimg.cc/bJNS9r1R/F1.jpg',
    description: 'Un ragoût de bœuf mijoté dans du vin rouge avec des légumes.',
    steps: [
      'Faire revenir les morceaux de bœuf.',
      'Ajouter carottes, oignons et ail.',
      'Déglacer avec du vin rouge.',
      'Laisser mijoter 2 heures à feu doux.',
    ],
  ),
  Dish(
    id: 'd6',
    categoryId: 'c2',
    title: 'Coq au vin',
    imageUrl: 'https://i.postimg.cc/ZYQv6Tnr/F2.jpg',
    description: 'Un plat français classique où le poulet est braisé dans du vin.',
    steps: [
      'Faire revenir les morceaux de poulet.',
      'Ajouter des champignons, des oignons et du lard.',
      'Déglacer avec du vin rouge et mijoter 2 heures.',
    ],
  ),

  Dish(
  id: 'd7',
  categoryId: 'c2',
  title: 'Ratatouille',
  imageUrl: 'https://i.postimg.cc/dVP7S483/F3.jpg',
  description: 'Un mélange savoureux de légumes méditerranéens.',
  steps: [
    'Laver et couper les légumes : aubergines, courgettes, poivrons et tomates.',
    'Faire revenir les oignons et l’ail dans une poêle avec de l’huile d’olive.',
    'Ajouter les aubergines et laisser cuire 5 minutes.',
    'Incorporer les courgettes et les poivrons, puis laisser mijoter 10 minutes.',
    'Ajouter les tomates et les herbes de Provence.',
    'Laisser cuire à feu doux pendant 30 minutes en remuant régulièrement.',
    'Rectifier l’assaisonnement avec sel et poivre.',
    'Servir chaud ou froid avec du pain ou du riz.',
  ],
),

  Dish(
  id: 'd8',
  categoryId: 'c2',
  title: 'Soupe à l’oignon',
  imageUrl: 'https://i.postimg.cc/C1zkVddx/F4.jpg',
  description: 'Une soupe réconfortante garnie de fromage fondu.',
  steps: [
    'Éplucher et émincer les oignons en fines lamelles.',
    'Faire revenir les oignons dans du beurre à feu doux jusqu’à caramélisation.',
    'Ajouter la farine et bien mélanger pour épaissir.',
    'Verser le bouillon de bœuf et laisser mijoter pendant 30 minutes.',
    'Assaisonner avec sel, poivre et herbes aromatiques.',
    'Préchauffer le four en mode grill.',
    'Verser la soupe dans des bols allant au four, ajouter une tranche de pain et recouvrir de fromage râpé (Gruyère ou Comté).',
    'Gratiner au four jusqu’à ce que le fromage soit doré et fondu.',
    'Servir bien chaud avec du pain croustillant.',
  ],
),


  // Cuisine japonaise
  Dish(
  id: 'd9',
  categoryId: 'c3',
  title: 'Sushi',
  imageUrl: 'https://i.postimg.cc/RVcfmkCK/sushi.jpg',
  description: 'Des morceaux de poisson cru frais sur du riz vinaigré.',
  steps: [
    'Rincer le riz à sushi plusieurs fois jusqu’à ce que l’eau soit claire.',
    'Cuire le riz avec la bonne quantité d’eau selon les instructions.',
    'Mélanger le riz chaud avec du vinaigre de riz, du sucre et du sel.',
    'Laisser refroidir le riz à température ambiante.',
    'Découper le poisson (saumon, thon, etc.) en fines tranches.',
    'Former des petites boules de riz avec les mains légèrement humides.',
    'Déposer délicatement une tranche de poisson sur chaque boule de riz.',
    'Servir avec du wasabi, du gingembre mariné et de la sauce soja.',
  ],
),

 Dish(
  id: 'd10',
  categoryId: 'c3',
  title: 'Ramen',
  imageUrl: 'https://i.postimg.cc/tTKZQ5LB/ramen.jpg',
  description: 'Des nouilles servies dans un bouillon savoureux avec des garnitures.',
  steps: [
    'Préparer un bouillon de base (porc, poulet ou miso) en mijotant pendant plusieurs heures.',
    'Cuire les nouilles ramen selon les instructions du paquet.',
    'Faire revenir du porc (chashu) ou du poulet pour la garniture.',
    'Ajouter du miso, de la sauce soja ou du sel au bouillon pour l’assaisonnement.',
    'Placer les nouilles cuites dans un bol et verser le bouillon chaud dessus.',
    'Ajouter les garnitures : œuf mollet mariné, algues nori, ciboule et germes de soja.',
    'Saupoudrer éventuellement de graines de sésame ou d’huile de sésame.',
    'Servir chaud avec des baguettes et une cuillère pour le bouillon.',
  ],
),

 Dish(
  id: 'd11',
  categoryId: 'c3',
  title: 'Tempura',
  imageUrl: 'https://i.postimg.cc/cLFv4Zpg/tempura.jpg',
  description: 'Des fruits de mer ou légumes frits en beignet léger.',
  steps: [
    'Préparer les crevettes et légumes (aubergines, carottes, patates douces, etc.) en les coupant en morceaux de taille uniforme.',
    'Mélanger la farine, l’eau glacée et l’œuf dans un bol pour préparer la pâte à tempura.',
    'Tremper chaque ingrédient dans la pâte, en veillant à ne pas trop en mettre.',
    'Faire chauffer l’huile à environ 180°C.',
    'Faire frire les ingrédients en petites quantités pour éviter de refroidir l’huile.',
    'Lorsque la pâte devient légèrement dorée et croustillante, retirer et égoutter sur du papier absorbant.',
    'Servir chaud avec une sauce tentsuyu (mélange de dashi, sauce soja et mirin).',
  ],
),

 Dish(
  id: 'd12',
  categoryId: 'c3',
  title: 'Yakitori',
  imageUrl: 'https://i.postimg.cc/Hxyn2MVX/yakitori.jpg',
  description: 'Des brochettes de poulet grillées avec une sauce sucrée-salée.',
  steps: [
    'Couper le poulet (cuisses ou blancs) en morceaux de taille égale.',
    'Préparer la marinade avec de la sauce soja, du mirin, du sucre et du saké.',
    'Laisser mariner les morceaux de poulet pendant 30 minutes.',
    'Enfiler le poulet sur des brochettes en alternant avec des oignons verts.',
    'Faire chauffer un grill ou une poêle et cuire les brochettes à feu moyen.',
    'Badigeonner régulièrement de sauce pendant la cuisson.',
    'Cuire jusqu’à ce que le poulet soit doré et légèrement caramélisé.',
    'Servir chaud avec du riz ou comme amuse-bouche.',
  ],
),


  // Cuisine coréenne
 Dish(
  id: 'd13',
  categoryId: 'c4',
  title: 'Bibimbap',
  imageUrl: 'https://i.postimg.cc/P55q79Ct/Bibimbap.jpg',
  description: 'Un bol de riz mélangé avec des légumes et un œuf.',
  steps: [
    'Cuire du riz blanc et le garder au chaud.',
    'Faire sauter les légumes séparément (épinards, carottes, champignons, courgettes) avec un peu d’huile de sésame et d’ail.',
    'Cuire du bœuf mariné avec de la sauce soja, de l’ail et du sucre.',
    'Faire frire un œuf au plat.',
    'Dans un bol, disposer le riz chaud au fond.',
    'Ajouter les légumes et le bœuf autour du riz.',
    'Déposer l’œuf au centre et garnir de graines de sésame et d’huile de sésame.',
    'Servir avec de la sauce gochujang (pâte de piment coréenne) à mélanger avant de déguster.',
  ],
),

 Dish(
  id: 'd14',
  categoryId: 'c4',
  title: 'Kimchi',
  imageUrl: 'https://i.postimg.cc/Dzty8zBZ/Kimchi.jpg',
  description: 'Un plat fermenté épicé à base de chou et d’ail.',
  steps: [
    'Couper un chou chinois en morceaux et le faire tremper dans de l’eau salée pendant 2 heures.',
    'Rincer abondamment le chou et bien égoutter.',
    'Préparer la pâte épicée en mélangeant du piment en poudre coréen (gochugaru), de l’ail écrasé, du gingembre, de la sauce poisson et du sucre.',
    'Ajouter des carottes et des oignons verts finement tranchés.',
    'Mélanger le chou avec la pâte épicée en veillant à bien enrober chaque feuille.',
    'Mettre le kimchi dans un bocal hermétique et laisser fermenter à température ambiante pendant 1 à 2 jours.',
    'Placer ensuite au réfrigérateur et laisser fermenter encore quelques jours avant de déguster.',
    'Servir comme accompagnement ou dans des plats coréens comme le bibimbap.',
  ],
),

 Dish(
  id: 'd15',
  categoryId: 'c4',
  title: 'Tteokbokki',
  imageUrl: 'https://i.postimg.cc/qMjJ2wjW/Tteokbokki.jpg',
  description: 'Des gâteaux de riz épicés dans une sauce sucrée et piquante.',
  steps: [
    'Faire tremper les gâteaux de riz (tteok) dans l’eau tiède pendant 30 minutes si nécessaire.',
    'Dans une casserole, mélanger de l’eau, du gochujang (pâte de piment coréenne), du sucre et de la sauce soja.',
    'Porter à ébullition, puis ajouter les gâteaux de riz et remuer.',
    'Laisser mijoter à feu moyen jusqu’à ce que la sauce épaississe et enrobe bien les gâteaux de riz.',
    'Ajouter des oignons verts, des œufs durs et des boulettes de poisson.',
    'Servir chaud avec des graines de sésame et un peu d’huile de sésame.',
  ],
),

Dish(
  id: 'd16',
  categoryId: 'c4',
  title: 'Bulgogi',
  imageUrl: 'https://i.postimg.cc/441sTwkn/Bulgogi.jpg',
  description: 'De fines tranches de bœuf marinées et grillées.',
  steps: [
    'Trancher finement du bœuf (contre-filet ou bavette).',
    'Préparer la marinade avec de la sauce soja, du sucre, de l’ail, du gingembre, du mirin et de l’huile de sésame.',
    'Laisser mariner la viande pendant au moins 1 heure.',
    'Faire chauffer une poêle ou un grill à feu vif.',
    'Faire cuire les morceaux de bœuf marinés jusqu’à ce qu’ils soient bien dorés.',
    'Ajouter des oignons verts et des graines de sésame pour plus de saveur.',
    'Servir avec du riz blanc et des légumes fermentés (kimchi).',
  ],
),


  // Cuisine thaïlandaise
Dish(
  id: 'd17',
  categoryId: 'c5',
  title: 'Pad Thaï',
  imageUrl: 'https://i.postimg.cc/s2SCH44j/Pad-Tha.jpg',
  description: 'Des nouilles sautées avec des crevettes, œufs et cacahuètes.',
  steps: [
    'Faire tremper les nouilles de riz dans de l’eau tiède jusqu’à ce qu’elles ramollissent.',
    'Dans un wok, faire revenir l’ail et les crevettes avec un peu d’huile.',
    'Ajouter les nouilles égouttées et assaisonner avec de la sauce tamarin, du sucre et de la sauce poisson.',
    'Pousser les nouilles sur le côté et casser un œuf dans le wok.',
    'Mélanger l’œuf avec les nouilles jusqu’à ce qu’il soit cuit.',
    'Ajouter des pousses de soja, des oignons verts et des cacahuètes concassées.',
    'Servir chaud avec un quartier de citron vert et du piment en poudre.',
  ],
),

Dish(
  id: 'd18',
  categoryId: 'c5',
  title: 'Tom Yum',
  imageUrl: 'https://i.postimg.cc/sgdc9Px9/Tom-Yum.jpg',
  description: 'Une soupe épicée aux crevettes et citronnelle.',
  steps: [
    'Faire chauffer de l’eau ou du bouillon dans une casserole.',
    'Ajouter des tiges de citronnelle, des feuilles de combava et du galanga.',
    'Incorporer les crevettes et les champignons tranchés.',
    'Ajouter du piment, de la sauce poisson et du jus de citron vert.',
    'Laisser mijoter jusqu’à ce que les crevettes soient cuites.',
    'Servir chaud avec de la coriandre fraîche et des rondelles de piment rouge.',
  ],
),

Dish(
  id: 'd19',
  categoryId: 'c5',
  title: 'Som Tam',
  imageUrl: 'https://i.postimg.cc/T1bkfth1/Som-Tam.jpg',
  description: 'Une salade de papaye verte épicée et rafraîchissante.',
  steps: [
    'Éplucher et râper une papaye verte.',
    'Dans un mortier, piler de l’ail et du piment rouge.',
    'Ajouter du sucre de palme, de la sauce poisson et du jus de citron vert.',
    'Incorporer des tomates cerises et des haricots longs coupés en morceaux.',
    'Ajouter la papaye râpée et bien mélanger.',
    'Servir frais avec des cacahuètes concassées et quelques crevettes séchées.',
  ],
),

Dish(
  id: 'd20',
  categoryId: 'c5',
  title: 'Curry vert',
  imageUrl: 'https://i.postimg.cc/9M6p8y1h/Curry-vert.jpg',
  description: 'Un curry au lait de coco avec du poulet et des légumes.',
  steps: [
    'Faire chauffer de l’huile dans une poêle et ajouter la pâte de curry vert.',
    'Faire revenir la pâte jusqu’à ce qu’elle dégage son arôme.',
    'Ajouter du lait de coco et laisser mijoter quelques minutes.',
    'Incorporer des morceaux de poulet et cuire jusqu’à ce qu’ils soient tendres.',
    'Ajouter des légumes (aubergines thaïes, haricots longs, poivrons) et laisser cuire.',
    'Assaisonner avec du sucre, de la sauce poisson et du basilic thaï.',
    'Servir chaud avec du riz jasmin.',
  ],
),

];


/// 🍽 Page principale avec navigation
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [HomePage(), LikedPage(), AboutPage()];

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
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Liké'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'À propos'),
        ],
      ),
    );
  }
}

/// 🍽 Page d'accueil : Affichage des catégories
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('YumYonder')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => DishListPage(category: category),
              ));
            },
            child: GridTile(
              child: Image.network(category.imageUrl, fit: BoxFit.cover),
              footer: GridTileBar(backgroundColor: Colors.black54, title: Text(category.title, textAlign: TextAlign.center)),
            ),
          );
        },
      ),
    );
  }
}

class DishListPage extends StatelessWidget {
  final Category category;
  DishListPage({required this.category});

  @override
  Widget build(BuildContext context) {
    final List<Dish> categoryDishes = allDishes.where((dish) => dish.categoryId == category.id).toList();
    return Scaffold(
      appBar: AppBar(title: Text('${category.title}')),
      body: ListView.builder(
        itemCount: categoryDishes.length,
        itemBuilder: (ctx, index) {
          final dish = categoryDishes[index];
          return ListTile(
            leading: Container(
              width: 80, // 调整宽度
              height: 150, // 调整高度
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // 可选：添加圆角
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // 可选：添加圆角
                child: Image.network(
                  dish.imageUrl,
                  fit: BoxFit.cover, // 保持图片比例
                ),
              ),
            ),
            title: Text(
              dish.title,
              style: TextStyle(fontSize: 26), // 调整字体大小
            ),
            trailing: ValueListenableBuilder<bool>(
              valueListenable: dish.isLiked,
              builder: (context, isLiked, child) {
                return IconButton(
                  icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border, color: isLiked ? Colors.red : null),
                  onPressed: () => dish.isLiked.value = !dish.isLiked.value,
                );
              },
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DishDetailPage(dish: dish))),
          );
        },
      ),
    );
  }
}

/// 🍽 Page des recettes likées
class LikedPage extends StatefulWidget {
  @override
  _LikedPageState createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  final List<ValueNotifier<bool>> _listeners = [];

  @override
  void initState() {
    super.initState();
    // 为每个菜品的 isLiked 添加监听器
    for (final dish in allDishes) {
      dish.isLiked.addListener(_onLikeChanged);
      _listeners.add(dish.isLiked);
    }
  }

  @override
  void dispose() {
    // 移除所有监听器避免内存泄漏
    for (final listener in _listeners) {
      listener.removeListener(_onLikeChanged);
    }
    super.dispose();
  }

  void _onLikeChanged() {
    // 当任何收藏状态变化时刷新页面
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final likedDishes = allDishes.where((dish) => dish.isLiked.value).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Liké'),
        backgroundColor: Colors.pink[300], // AppBar 背景色
      ),
      body: Container(
        color: Colors.pink[50], // 粉色背景
        child: likedDishes.isEmpty
            ? Center(
                child: Text(
                  'Aucune recette likée pour le moment.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.pink[800], // 文字颜色
                    fontWeight: FontWeight.w500, // 文字加粗
                  ),
                ),
              )
            : ListView.builder(
                itemCount: likedDishes.length,
                itemBuilder: (ctx, index) {
                  final dish = likedDishes[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 4, // 卡片阴影
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 卡片圆角
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 80, // 图片宽度
                        height: 120, // 图片高度
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), // 圆角
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10), // 圆角
                          child: Image.network(
                            dish.imageUrl,
                            fit: BoxFit.cover, // 保持图片比例
                          ),
                        ),
                      ),
                      title: Text(
                        dish.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[800], // 文字颜色
                        ),
                      ),
                      trailing: ValueListenableBuilder<bool>(
                        valueListenable: dish.isLiked,
                        builder: (context, isLiked, child) {
                          return IconButton(
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.pink[300] : Colors.grey,
                            ),
                            onPressed: () => dish.isLiked.value = !isLiked,
                          );
                        },
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DishDetailPage(dish: dish),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class DishDetailPage extends StatelessWidget {
  final Dish dish;
  DishDetailPage({required this.dish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dish.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 菜品图片
            Center(
              child: Container(
                width: 300, // 缩小图片宽度
                height: 300, // 缩小图片高度
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // 可选：添加圆角
                  child: Image.network(
                    dish.imageUrl,
                    fit: BoxFit.cover, // 保持图片比例
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 菜品名称
            Text(
              dish.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // 菜品描述
            Text(
              dish.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // 收藏按钮
            Center(
              child: ValueListenableBuilder<bool>(
                valueListenable: dish.isLiked,
                builder: (context, isLiked, child) {
                  return IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : null,
                      size: 30,
                    ),
                    onPressed: () => dish.isLiked.value = !dish.isLiked.value,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // 做饭步骤标题
            Text(
              'Étapes de préparation:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // 做饭步骤列表
            ...dish.steps.map((step) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  '• $step',
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

/// 🍽 Page À propos
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('À propos de YumYonder'),
        backgroundColor: Colors.orange, // 保持与主题一致
      ),
      body: Container(
        color: Colors.yellow[50], // 淡黄色背景
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.restaurant_menu,
                  size: 60,
                  color: Colors.orange, // 图标颜色
                ),
                const SizedBox(height: 20),
                const Text(
                  '📲 YumYonder – La passion de la cuisine, à portée de main ! 🍴✨\n\n'
                  'Vous adorez cuisiner ? Vous cherchez des recettes exquises pour ravir vos papilles ? \n'
                  'YumYonder est l’application qu’il vous faut ! 🎉\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87, // 文字颜色
                    fontWeight: FontWeight.w500, // 文字加粗
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Développé avec ❤️ par votre équipe YumYonder',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey, // 灰色文字
                    fontStyle: FontStyle.italic, // 斜体
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
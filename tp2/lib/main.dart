import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';



void main() {
  runApp(MaterialApp(
    title: 'Exercices Menu',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: MenuPage(),
  ));
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu des Exercices')),
      body: ListView(
        children: [
          ExerciseCard(title: "Exercice 1", page: Exercise1Page()),
          ExerciseCard(title: "Exercice 2a", page: Exercise2aPage()),
          ExerciseCard(title: "Exercice 2b", page: Exercise2bPage()),
          ExerciseCard(title: "Exercice 4", page: Exercise4Page()),
          ExerciseCard(title: "Exercice 5a", page: Exercise5aPage()),
          ExerciseCard(title: "Exercice 5b", page: Exercise5bPage()),
          ExerciseCard(title: "Exercice 5c", page: Exercise5cPage()),
          ExerciseCard(title: "Exercice 6a", page: Exercise6aPage()),
          ExerciseCard(title: "Exercice 6b", page: Exercise6bPage()),
          ExerciseCard(title: "Exercice 7", page: TaquinGamePage()),
        ],
      ),
    );
  }
}


class ExerciseCard extends StatelessWidget {
  final String title;
  final Widget page;

  ExerciseCard({required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}



class TaquinGamePage extends StatefulWidget {
  @override
  _TaquinGamePageState createState() => _TaquinGamePageState();
}

class _TaquinGamePageState extends State<TaquinGamePage> {
  int gridSize = 4;
  int shuffleMoves = 30;
  List<int> tiles = [];
  int emptyTileIndex = 0;
  int moveCount = 0;
  List<List<int>> previousMoves = [];

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    tiles = List<int>.generate(gridSize * gridSize, (index) => index);
    emptyTileIndex = tiles.length - 1;
    _shuffleTiles();
    moveCount = 0;
    previousMoves.clear();
    setState(() {});
  }

  void _shuffleTiles() {
    for (int i = 0; i < shuffleMoves; i++) {
      List<int> validMoves = _getValidMoves();
      int swapIndex = validMoves[math.Random().nextInt(validMoves.length)];
      _swapTiles(swapIndex, emptyTileIndex, record: false);
    }
  }

  List<int> _getValidMoves() {
    List<int> moves = [];
    int row = emptyTileIndex ~/ gridSize;
    int col = emptyTileIndex % gridSize;
    if (row > 0) moves.add(emptyTileIndex - gridSize);
    if (row < gridSize - 1) moves.add(emptyTileIndex + gridSize);
    if (col > 0) moves.add(emptyTileIndex - 1);
    if (col < gridSize - 1) moves.add(emptyTileIndex + 1);
    return moves;
  }

  void _swapTiles(int tileIndex, int emptyIndex, {bool record = true}) {
    setState(() {
      if (record) {
        previousMoves.add(List.from(tiles));
      }
      int temp = tiles[tileIndex];
      tiles[tileIndex] = tiles[emptyIndex];
      tiles[emptyIndex] = temp;
      emptyTileIndex = tileIndex;
      moveCount++;
    });
  }

  void _onTileTap(int index) {
    if (_getValidMoves().contains(index)) {
      _swapTiles(index, emptyTileIndex);
      if (_isSolved()) {
        _showWinDialog();
      }
    }
  }

  bool _isSolved() {
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i) return false;
    }
    return true;
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Félicitations !"),
        content: Text("Vous avez gagné en $moveCount déplacements."),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  void _undoMove() {
    if (previousMoves.isNotEmpty) {
      setState(() {
        tiles = previousMoves.removeLast();
        emptyTileIndex = tiles.indexOf(gridSize * gridSize - 1);
        moveCount--;
      });
    }
  }

  void _increaseGridSize() {
    if (gridSize < 9) {
      setState(() {
        gridSize++;
        _initializeGame();
      });
    }
  }

  void _decreaseGridSize() {
    if (gridSize > 2) {
      setState(() {
        gridSize--;
        _initializeGame();
      });
    }
  }

  void _updateShuffleMoves(int moves) {
    setState(() {
      shuffleMoves = moves;
      _initializeGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 200;
    double boardSize = math.min(screenWidth, screenHeight * 0.7);

    return Scaffold(
      appBar: AppBar(title: Text("Jeu de Taquin")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Déplacements: $moveCount"),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: boardSize,
                height: boardSize,
                padding: EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridSize,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: tiles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onTileTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: tiles[index] == gridSize * gridSize - 1
                              ? Colors.white
                              : Colors.grey,
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                        child: Center(
                          child: tiles[index] == gridSize * gridSize - 1
                              ? SizedBox.shrink()
                              : Text(
                                  "${tiles[index]}",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: _initializeGame, child: Text("Réinitialiser")),
                  SizedBox(width: 20),
                  ElevatedButton(onPressed: _undoMove, child: Text("Annuler")),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: _decreaseGridSize,
                  ),
                  Text("${gridSize}x${gridSize}"),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _increaseGridSize,
                  ),
                ],
              ),
              Slider(
                value: shuffleMoves.toDouble(),
                min: 1,
                max: 100,
                divisions: 10,
                label: "Difficulté: $shuffleMoves",
                onChanged: (value) => _updateShuffleMoves(value.toInt()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class ColoredTile {
  final Color? color;
  final UniqueKey key;
  final bool isEmpty;

  ColoredTile({this.color, this.isEmpty = false}) : key = UniqueKey();

  ColoredTile.randomColor()
      : color = Color.fromARGB(
          255,
          math.Random().nextInt(256),
          math.Random().nextInt(256),
          math.Random().nextInt(256),
        ),
        isEmpty = false,
        key = UniqueKey();
}

// ==============
// 瓷砖组件
// ==============
class TileWidget extends StatelessWidget {
  final ColoredTile tile;
  final VoidCallback onTap;

  const TileWidget(this.tile, {Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tile.isEmpty ? null : onTap,
      child: Container(
        key: tile.key,
        color: tile.isEmpty ? Colors.white : tile.color,
        width: 100,
        height: 100,
        margin: EdgeInsets.all(4),
        child: Center(
          child: tile.isEmpty
              ? Text("Empty", style: TextStyle(color: Colors.black, fontSize: 16))
              : Text("Tile", style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }
}

// ==============
// 主页面组件
// ==============
class Exercise6bPage extends StatefulWidget {
  @override
  _Exercise6bPageState createState() => _Exercise6bPageState();
}

class _Exercise6bPageState extends State<Exercise6bPage> {
  late List<ColoredTile> tiles;
  int gridSize = 4; // 默认4x4网格
  int emptyIndex = 0;

  @override
  void initState() {
    super.initState();
    generateTiles();
  }

  void generateTiles() {
    setState(() {
      tiles = List.generate(gridSize * gridSize, (index) => ColoredTile.randomColor());
      emptyIndex = math.Random().nextInt(tiles.length);
      tiles[emptyIndex] = ColoredTile(isEmpty: true);
    });
  }

  void swapTiles(int index) {
    if (_isAdjacent(index, emptyIndex)) {
      setState(() {
        var temp = tiles[emptyIndex];
        tiles[emptyIndex] = tiles[index];
        tiles[index] = temp;
        emptyIndex = index;
      });
    }
  }

  bool _isAdjacent(int index1, int index2) {
    int row1 = index1 ~/ gridSize, col1 = index1 % gridSize;
    int row2 = index2 ~/ gridSize, col2 = index2 % gridSize;
    return (row1 == row2 && (col1 - col2).abs() == 1) ||
        (col1 == col2 && (row1 - row2).abs() == 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swapable Color Grid'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: generateTiles,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double boardSize = math.min(constraints.maxWidth, constraints.maxHeight) - 32;
          double tileSize = (boardSize / gridSize) - 8;

          return Center(
            child: Container(
              width: boardSize,
              height: boardSize,
              padding: EdgeInsets.all(8),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(), // 禁止滚动，适应屏幕
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: tiles.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: tileSize,
                    height: tileSize,
                    child: TileWidget(
                      tiles[index],
                      onTap: () => swapTiles(index),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Grid Size: "),
            DropdownButton<int>(
              value: gridSize,
              items: [3, 4, 5, 6]
                  .map((size) => DropdownMenuItem<int>(
                        value: size,
                        child: Text("${size}x${size}"),
                      ))
                  .toList(),
              onChanged: (size) {
                if (size != null) {
                  setState(() {
                    gridSize = size;
                    generateTiles();
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ==============
// 主页面组件
// ==============
class Exercise6aPage extends StatefulWidget {
  @override
  _Exercise6aPageState createState() => _Exercise6aPageState();
}

// ==============
// 页面状态
// ==============
class _Exercise6aPageState extends State<Exercise6aPage> {
  late List<ColoredTile> tiles;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    tiles = List<ColoredTile>.generate(2, (index) => ColoredTile.randomColor());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Tiles Swap'),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(tiles.length, (index) => 
          TileWidget(tiles[index], onTap: () => swapTiles())
        ),
      ),
    );
  }

  // ==============
  // 交换方法
  // ==============
  void swapTiles() {
    setState(() {
      if (tiles.length >= 2) {
        tiles = List<ColoredTile>.from(tiles.reversed);
      }
    });
  }
}



// ==============
class Exercise1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exercice 1 : Afficher une image")),
      body: Center(
        child: Image.network(
          'https://picsum.photos/512/1024', // 随机图片
          width: 500,
          height: 700,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class Exercise2aPage extends StatefulWidget {
  @override
  _Exercise2aPageState createState() => _Exercise2aPageState();
}

class _Exercise2aPageState extends State<Exercise2aPage> {
  double _rotateX = 0.0;
  double _rotateZ = 0.0;
  double _scale = 1.0;
  bool _mirror = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exercice 2a : Rotate/Resize Image")),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(_rotateX)
                ..rotateZ(_rotateZ)
                ..scale(_mirror ? -_scale : _scale, _scale),
              child: Image.network(
                "https://picsum.photos/300",
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildSlider("RotateX", _rotateX, -math.pi, math.pi, (value) {
            setState(() => _rotateX = value);
          }),
          _buildSlider("RotateZ", _rotateZ, -math.pi, math.pi, (value) {
            setState(() => _rotateZ = value);
          }),
          _buildCheckbox("Mirror", _mirror, (value) {
            setState(() => _mirror = value ?? false);
          }),
          _buildSlider("Scale", _scale, 0.5, 2.0, (value) {
            setState(() => _scale = value);
          }),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text("$label: "),
          Expanded(
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String label, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        Checkbox(value: value, onChanged: onChanged),
      ],
    );
  }
}



class Exercise2bPage extends StatefulWidget {
  @override
  _Exercise2bPageState createState() => _Exercise2bPageState();
}

class _Exercise2bPageState extends State<Exercise2bPage> {
  double _rotateX = 0.0;
  double _rotateZ = 0.0;
  double _scale = 1.0;
  bool _mirror = false;
  Timer? _timer;
  double _rotateStep = 0.05;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAnimation() {
    const duration = Duration(milliseconds: 50);
    _timer = Timer.periodic(duration, _animate);
  }

  void _animate(Timer timer) {
    setState(() {
      // 旋转逻辑：检测到达到边界后回弹
      if (_rotateX + _rotateStep > math.pi || _rotateX + _rotateStep < -math.pi) {
        _rotateStep = -_rotateStep;
      }
      _rotateX += _rotateStep;
      _rotateZ += _rotateStep;
      _scale = 1.0 + math.sin(_rotateX) * 0.5;
    });
  }

  void _stopAnimation() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exercice 2b : Clip and Animate")),
      body: Column(
        children: [
          SizedBox(height: 20),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue, width: 2),
            ),
            width: 300,
            height: 200,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(_rotateX)
                ..rotateZ(_rotateZ)
                ..scale(_mirror ? -_scale : _scale, _scale),
              child: Image.network(
                "https://picsum.photos/300",
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildSlider("RotateX", _rotateX, -math.pi, math.pi, (value) {
            setState(() => _rotateX = value);
          }),
          _buildSlider("RotateZ", _rotateZ, -math.pi, math.pi, (value) {
            setState(() => _rotateZ = value);
          }),
          _buildCheckbox("Mirror", _mirror, (value) {
            setState(() => _mirror = value ?? false);
          }),
          _buildSlider("Scale", _scale, 0.5, 2.0, (value) {
            setState(() => _scale = value);
          }),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _startAnimation,
                child: Text("Start Animation"),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _stopAnimation,
                child: Text("Stop Animation"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text("$label: "),
          Expanded(
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String label, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        Checkbox(value: value, onChanged: onChanged),
      ],
    );
  }
}

class Exercise4Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercice 4 : Affichage d\'une tuile'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150.0,
              height: 150.0,
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: createTileWidgetFrom(tile),
              ),
            ),
            Container(
              height: 200,
              child: Image.network(
                'https://picsum.photos/512',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({required this.imageURL, required this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

Tile tile = Tile(
  imageURL: 'https://picsum.photos/512',
  alignment: Alignment(0, 0),
);

class Exercise5aPage extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercice 5 : Génération du plateau de tuiles'),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3列
              crossAxisSpacing: 5.0, // 水平方向间距
              mainAxisSpacing: 5.0, // 垂直方向间距
              childAspectRatio: 1.0, // 让每个方块保持正方形
            ),
            itemCount: 9, // 总共9个方块
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.primaries[index % Colors.primaries.length], // 颜色随机
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    'Tile ${index + 1}',
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Exercise5bPage extends StatelessWidget {
  final String imageUrl= 'https://picsum.photos/512'; // 替换为你的图片链接

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercice 5b : Génération du plateau de tuiles d'une même image"),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3列
              crossAxisSpacing: 2.0, // 水平方向间距
              mainAxisSpacing: 2.0, // 垂直方向间距
            ),
            itemCount: 9, // 3x3 迷宫
            itemBuilder: (context, index) {
              int row = index ~/ 3; // 计算行号
              int col = index % 3;  // 计算列号

              return ClipRect(
                child: FractionallySizedBox(
                  widthFactor: 3.0, // 放大3倍，使每个块显示图片不同部分
                  heightFactor: 3.0,
                  alignment: Alignment(-1.0 + col * 1.0, -1.0 + row * 1.0),
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Exercise5cPage extends StatefulWidget {
  @override
  _Exercise5cPageState createState() => _Exercise5cPageState();
}

class _Exercise5cPageState extends State<Exercise5cPage> {
  final String imageUrl = 'https://picsum.photos/512';
  double gridSize = 3;    // 网格行列数
  double boardSize = 300; // 棋盘尺寸（可配置）

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercice 5c : Génération du plateau de tuiles qui permet à l'utilisateur de configurer la taille"),
      ),
      body: Column(
        children: [
          // 棋盘大小调节滑块
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Text("Board Size: "),
                Expanded(
                  child: Slider(
                    value: boardSize,
                    min: 100,
                    max: 500,
                    divisions: 40,
                    label: '${boardSize.toInt()}px',
                    onChanged: (value) => setState(() => boardSize = value),
                  ),
                ),
              ],
            ),
          ),
          
          // 网格数量调节滑块
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Text("Grid Size: "),
                Expanded(
                  child: Slider(
                    value: gridSize,
                    min: 2,
                    max: 10,
                    divisions: 8,
                    label: '${gridSize.toInt()}x${gridSize.toInt()}',
                    onChanged: (value) => setState(() => gridSize = value),
                  ),
                ),
              ],
            ),
          ),
          
          // 棋盘显示区域
          Center(
            child: Container(
              width: boardSize,
              height: boardSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: _buildPuzzleGrid(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPuzzleGrid() {
    final tileSize = boardSize / gridSize;
    
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridSize.toInt(),
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: (gridSize * gridSize).toInt(),
      itemBuilder: (context, index) {
        final row = index ~/ gridSize.toInt();
        final col = index % gridSize.toInt();

        return ClipRect(
          child: OverflowBox(
            maxWidth: boardSize,
            maxHeight: boardSize,
            alignment: Alignment.topLeft,
            child: Transform.translate(
              offset: Offset(
                -col * tileSize,
                -row * tileSize,
              ),
              child: Image.network(
                imageUrl,
                width: boardSize,
                height: boardSize,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  return progress == null 
                    ? child 
                    : Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        );
      },
    );
  }
}



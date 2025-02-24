import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async'; // 引入 Timer

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageTransformScreen(),
    );
  }
}

class ImageTransformScreen extends StatefulWidget {
  @override
  _ImageTransformScreenState createState() => _ImageTransformScreenState();
}

class _ImageTransformScreenState extends State<ImageTransformScreen> {
  double _rotateX = 0.0;
  double _rotateZ = 0.0;
  double _scale = 1.0;
  bool _mirror = false;
  Timer? _timer; // 用于控制动画的 Timer

  @override
  void dispose() {
    _timer?.cancel(); // 在页面销毁时取消 Timer
    super.dispose();
  }

  void _startAnimation() {
    const duration = Duration(milliseconds: 50); // 每 50ms 更新一次
    _timer = Timer.periodic(duration, (timer) {
      setState(() {
        _rotateX += 0.05; // 绕 X 轴旋转
        _rotateZ += 0.05; // 绕 Z 轴旋转
        _scale = 1.0 + sin(_rotateX) * 0.5; // 缩放效果
        _mirror = _rotateX % (2 * pi) > pi; // 镜像效果
      });
    });
  }

  void _stopAnimation() {
    _timer?.cancel(); // 停止动画
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rotate/Resize Image")),
      body: Column(
        children: [
          SizedBox(height: 20),
          // 使用 Container 包裹 Transform，确保图片不超出边界
          Container(
            width: 300,
            height: 200,
            clipBehavior: Clip.hardEdge, // 裁剪超出部分
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent, width: 2), // 透明边框
            ),
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
          _buildSlider("RotateX", _rotateX, -pi, pi, (value) {
            setState(() => _rotateX = value);
          }),
          _buildSlider("RotateZ", _rotateZ, -pi, pi, (value) {
            setState(() => _rotateZ = value);
          }),
          _buildCheckbox("Mirror", _mirror, (value) {
            setState(() => _mirror = value ?? false);
          }),
          _buildSlider("Scale", _scale, 0.5, 2.0, (value) {
            setState(() => _scale = value);
          }),
          SizedBox(height: 20),
          // 添加开始和停止动画的按钮
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
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class PalletView extends StatefulWidget {
  const PalletView({Key? key}) : super(key: key);

  @override
  State<PalletView> createState() => _PalletViewState();
}

class _PalletViewState extends State<PalletView> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;
  bool lastBox = false;

  ARNode? smollPlacedBox;

  void resetBoxes() {
    arObjectManager.removeNode(smollPlacedBox!);
    smollPlacedBox = null;
    arObjectManager.addNode(
      ARNode(
        type: NodeType.localGLTF2,
        uri: "assets/Box1/box2.gltf",
        scale: Vector3(0.2, 0.4, 0.4),
        position: Vector3(0.07, -0.7, 0.0),
      ),
    );
    lastBox = true;
    setState(() {});
  }

  Future<void> spawnNextBox() async {
    resetBoxes();
    var nextNode = ARNode(
      type: NodeType.localGLTF2,
      uri: "assets/Box1/box1.gltf",
      scale: Vector3(0.2, 0.2, 0.4),
      position: Vector3(0.07, -0.3, 0.0),
    );
    await arObjectManager.addNode(nextNode);
  }

  Future<void> spawnBoxes() async {
    smollPlacedBox = ARNode(
      type: NodeType.localGLTF2,
      uri: "assets/Box1/box1.gltf",
      scale: Vector3(0.2, 0.4, 0.4),
      position: Vector3(0.07, -0.7, 0.0),
    );
    var evenNewerNode = ARNode(
      type: NodeType.localGLTF2,
      uri: "assets/Box1/box2.gltf",
      scale: Vector3(0.4, 0.7, 0.4),
      position: Vector3(0.4, -0.7, 0.0),
    );
    var newNode = ARNode(
      type: NodeType.localGLTF2,
      uri: "assets/Box1/box2.gltf",
      scale: Vector3(0.3, 0.2, 0.4),
      position: Vector3(-0.2, -0.7, -0.1),
    );
    var palletNode = ARNode(
      type: NodeType.localGLTF2,
      uri: "assets/Pallet/scene.gltf",
      scale: Vector3(0.3, 0.3, 0.3),
      position: Vector3(0.5, -1.0, 0.0),
    );
    await arObjectManager.addNode(smollPlacedBox!);
    await arObjectManager.addNode(palletNode);
    await arObjectManager.addNode(evenNewerNode);
    await arObjectManager.addNode(newNode);
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arSessionManager.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          customPlaneTexturePath: "assets/triangle.png",
          showWorldOrigin: false,
          handleTaps: false,
          showAnimatedGuide: false,
        );
    this.arObjectManager.onInitialize();
    spawnBoxes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Pallet View",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: ARView(
                  onARViewCreated: onARViewCreated,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: lastBox ? null : spawnNextBox,
                    style: ButtonStyle(
                      foregroundColor: lastBox
                          ? MaterialStatePropertyAll(Colors.grey.shade400)
                          : const MaterialStatePropertyAll(Colors.white),
                      backgroundColor: lastBox
                          ? MaterialStatePropertyAll(Colors.red.shade200)
                          : MaterialStatePropertyAll(Colors.red.shade400),
                    ),
                    child: const Text("Show Next Box"),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

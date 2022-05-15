import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Draggable;

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with HasDraggables {
  Character natsuki = Character(position: Vector2.zero());
  Character yuri = Character(position: Vector2(200, 0));
  Character monika = Character(position: Vector2(400, 0));
  Character sayori = Character(position: Vector2(600, 0));
  Character kieran = Character(position: Vector2(300, 300));
  SpriteComponent background = SpriteComponent();

  Future<void> onLoad() async {
    await super.onLoad();
    background
      ..sprite = await loadSprite('classroom.png')
      ..size = size;
    add(background);
    natsuki.sprite = await loadSprite('natsuki_casual.webp');
    add(natsuki);
    yuri.sprite = await loadSprite('yuri_casual.webp');
    add(yuri);
    monika.sprite = await loadSprite('monika.webp');
    add(monika);
    sayori.sprite = await loadSprite('sayori_casual.webp');
    add(sayori);

    kieran.sprite = await loadSprite('kieran.png');
    add(kieran);
  }
}

class Character extends SpriteComponent with Draggable {
  Vector2? dragDeltaPosition;

  Character({required Vector2 position})
      : super(position: position, size: Vector2.all(160));

  @override
  bool onDragStart(DragStartInfo info) {
    dragDeltaPosition = info.eventPosition.game - position;
    return false;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    if (parent is! MyGame) {
      return true;
    }
    final dragDeltaPosition = this.dragDeltaPosition;
    if (dragDeltaPosition == null) {
      return false;
    }

    position.setFrom(info.eventPosition.game - dragDeltaPosition);
    return false;
  }

  @override
  bool onDragEnd(_) {
    dragDeltaPosition = null;
    return false;
  }

  @override
  bool onDragCancel() {
    dragDeltaPosition = null;
    return false;
  }
}

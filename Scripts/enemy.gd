extends CharacterBody2D
class_name Enemy

@onready var sprite: Sprite2D = $Sprite2D
@export var animation_tree : AnimationTree

var player: Node2D = null
var playback: AnimationNodeStateMachinePlayback

func _ready():
	playback = animation_tree["parameters/playback"]

func _physics_process(delta):
	move_and_slide()
	
	if velocity.length() > 0:
		playback.travel("Moving")
	
	if velocity.x > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

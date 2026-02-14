extends Node

@export var animation_tree : AnimationTree
@export var sprite : Sprite2D
@onready var enemy : Enemy = get_owner()

var playback: AnimationNodeStateMachinePlayback

func _ready():
	playback = animation_tree["parameters/playback"]

func _physics_process(delta: float) -> void:
	if !enemy.alive:
		return
	
	if enemy.stunned:
		playback.travel("stunned")
		return
	
	if !enemy.velocity:
		playback.travel("idle")
		return
	
	sprite.flip_h = enemy.velocity.x < 0
	
	var animation_name = "walk"
	
	if enemy.velocity.length() > 50:
		animation_name = "run"
	
	
	#if sprite.flip_h:
		#animation_name += "_left"
	#else:
		#animation_name += "_right"
	
	playback.travel(animation_name)

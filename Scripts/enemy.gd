class_name Enemy
extends CharacterBody2D

@export var speed: float = 120.0
@export var attack_range: float = 40.0

@onready var animation_tree : AnimationTree = $AnimationTree

var player: Node2D = null
var playback: AnimationNodeStateMachinePlayback
var is_attacking: bool = false

func _ready():
	playback = animation_tree["parameters/playback"]
	
	# Find the player via group (clean and flexible)
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func _physics_process(delta):
	if player == null:
		return

	var direction = player.global_position - global_position
	var distance = direction.length()

	if distance > attack_range:
		if is_attacking == true:
			print("Stopped attacking!")
		is_attacking = false
		# Move toward player
		velocity = direction.normalized() * speed
	else:
		is_attacking = true
		# Stop when in attack range
		velocity = Vector2.ZERO
		attack()

	move_and_slide()

	update_animation_parameters()
	
func update_animation_parameters():
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/is_idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true

	if is_attacking:
		animation_tree["parameters/conditions/is_attacking"] = true
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_moving"] = false
	# animation_tree["parameters/conditions/is_taking_damage"] = velocity

func attack():
	print("Enemy attacking player!")

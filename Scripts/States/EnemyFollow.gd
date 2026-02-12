extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed: float = 120.0
@export var attack_range: float = 40.0
@export var detect_range: float = 120.0
var player: CharacterBody2D

func Enter():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func Physics_Update(_delta: float):
	if player == null:
		return
	var direction_of_target = player.global_position - enemy.global_position
	var distance_to_target = direction_of_target.length()
	
	if distance_to_target > attack_range:
		enemy.velocity = direction_of_target.normalized() * move_speed
	else:
		enemy.velocity = Vector2.ZERO
	
	if distance_to_target > 100:
		Transitioned.emit(self, "idle")

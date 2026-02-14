extends EnemyState


@export var chase_speed := 75.0


func physics_process_state(delta: float):
	
	var direction := player.global_position - enemy.global_position
	
	var distance = direction.length()
	
	if distance > enemy.chase_radius:
		transitioned.emit(self, "wander")
		return
		
	#if distance < enemy.attack_range:
		#transitioned.emit(self, "attack")
	#return
	
	if distance > enemy.follow_radius:
		transitioned.emit(self, "idle")
		
	enemy.velocity = direction.normalized()*chase_speed
	
	enemy.play_animation("stunned")
	enemy.move_and_slide()

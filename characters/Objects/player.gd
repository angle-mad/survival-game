extends CharacterBody2D

signal health_depleted

var health = 100.0

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right","move_up" ,"move_down")
	velocity = direction * 450
	move_and_slide()

	const DAMAGE_RATE = 25.0
	var overlapping_mobs = %Hurtbox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * _delta
		%ProgressBar.value = health
		%ProgressBar.max_value = 100
		if health <= 0.0:
			health_depleted.emit()
		
		
		

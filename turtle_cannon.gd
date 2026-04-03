extends CharacterBody2D

signal mob_died
var health = 6

var attack_cooldown = 0.0

@onready var player = get_node("/root/Game/Player")

func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 100.0
	move_and_slide()
	
	%ShootingPoint.rotation = direction.angle()
	$TurtleCannonCharacter.flip_h = player.global_position.x > global_position.x
	
	attack_cooldown += _delta
	if attack_cooldown >= 1:
		shoot_cannonball()
		attack_cooldown = 0.0


func shoot_cannonball():
	const CANNONBALL = preload("res://cannonball.tscn")
	var new_cannonball = CANNONBALL.instantiate()
	get_parent().add_child(new_cannonball)
	new_cannonball.global_position = %ShootingPoint.global_position
	new_cannonball.global_rotation = %ShootingPoint.global_rotation

func take_damage():
	health -= 1
	
	if health == 0:
		mob_died.emit()
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		queue_free()
	
	
	

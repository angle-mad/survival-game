extends CharacterBody2D

signal health_depleted

var health = 100.0
var is_dashing = false
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var dash_direction = Vector2.ZERO

const BASE_SPEED = 450
const DASH_SPEED = BASE_SPEED*2
const DASH_DURATION = 0.2
const DASH_COOLDOWN = 2.0

func _ready():
	%ProgressBar.max_value = 100

func _physics_process(delta: float) -> void:
	
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0: 
			is_dashing = false
			$GurtCharacter.self_modulate = Color(0.7,0.5,0.5)
		
	if dash_cooldown_timer > 0: 
		dash_cooldown_timer -= delta
		if dash_cooldown_timer <= 0:
			$GurtCharacter.self_modulate = Color(1,1,1)
		
	var direction = Vector2.ZERO
	if !is_dashing:
		direction = Input.get_vector("move_left", "move_right","move_up" ,"move_down")
		
	if Input.is_action_just_pressed("dash") && !is_dashing && dash_cooldown_timer <= 0:
		is_dashing = true
		dash_timer = DASH_DURATION
		dash_cooldown_timer = DASH_COOLDOWN
		$GurtCharacter.self_modulate = Color(1.3, 0.9, 0.9)
		if direction != Vector2.ZERO:
			dash_direction = direction.normalized()
		else:
			dash_direction = Vector2.RIGHT
		
	if is_dashing:
		velocity = dash_direction * DASH_SPEED
	else:
		velocity = direction * BASE_SPEED
	move_and_slide()

	const DAMAGE_RATE = 25.0
	var overlapping_mobs = %Hurtbox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0 && !is_dashing:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
		

func take_damage():
	health -= 20
	%ProgressBar.value = health
	if health <= 0.0:
		health_depleted.emit()

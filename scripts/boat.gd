extends CharacterBody3D

@export var forward_acceleration = 50.0
@export var turn_speed = 2.0
@export var max_speed = 10.0
@export var drag = 0.95

func _physics_process(delta: float) -> void:
	var left_row = Input.is_action_pressed("row_left")
	var right_row = Input.is_action_pressed("row_right")
	
	var forward_input = 0.0
	var turn_input = 0.0
	
	if left_row:
		forward_input += 1.0
		turn_input += 1.0
	
	if right_row:
		forward_input += 1.0
		turn_input -= 1.0

	if forward_input > 0:
		velocity += transform.basis.z * forward_input * forward_acceleration * delta
	
	if turn_input != 0:
		rotate_y(turn_input * turn_speed * delta)

	velocity *= drag
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed

	move_and_slide()

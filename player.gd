extends RigidBody3D

# variable global 
var thrust: float = 1000.0 
var rotate_speed: float = 100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust)
		
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, rotate_speed * delta))
		
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -rotate_speed * delta))

func _on_body_entered(body: Node) -> void: 
	if "Goal" in body.get_groups():
		print("you win")

	if "Hazard" in body.get_groups():
		print("you crashed!")
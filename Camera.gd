extends Camera

var input_map = Vector3.ZERO
var velocity = .15

var vert_invert = -1
var horz_invert = -1
var vert_mouse_sensitivity = .01
var horz_mouse_sensitivity = .005


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		get_key_input()
		var _delta = Vector3.ZERO
		_delta += input_map.z * velocity * global_transform.basis.z
		_delta += input_map.x * velocity * global_transform.basis.x
		_delta += input_map.y * velocity * global_transform.basis.y
		global_transform.origin += _delta


func _input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate_object_local(Vector3(1,0,0), event.relative.y * vert_mouse_sensitivity * vert_invert)
			rotate_y(event.relative.x * horz_mouse_sensitivity * horz_invert)
			rotation.x = clamp(rotation.x, -0.45*PI, 0.45*PI)
			rotation.z = 0
	
	if event.is_action_pressed("esc"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().paused = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().paused = false
		get_tree().set_input_as_handled()


func get_key_input():
	input_map = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		input_map.z -= 1
	if Input.is_action_pressed("backward"):
		input_map.z += 1
	if Input.is_action_pressed("left"):
		input_map.x -= 1
	if Input.is_action_pressed("right"):
		input_map.x += 1
	if Input.is_action_pressed("up"):
		input_map.y += 1
	if Input.is_action_pressed("down"):
		input_map.y -= 1
	input_map = input_map.normalized()

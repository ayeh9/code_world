extends KinematicBody2D

var SPEED = 100
var velocity = Vector2()
var direction = Vector2()
var target_space = Vector2()
var target_move = Vector2()
var moving = false
var speed = 0
var type
var grid
func _ready():
	grid = get_parent()
	type = grid.PLAYER
	_process(true)
	pass

func _process(delta):
	direction = Vector2()
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	elif Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	elif Input.is_action_pressed("ui_up"):
		direction.y -= 1
	
	if not moving and direction != Vector2():
		target_move = direction.normalized()
		if grid.is_cell_vacant(get_position(), direction):
			target_space = grid.update_child_pos(get_position(), direction, type)
			moving = true
	
	elif moving:
		speed = SPEED
		velocity = speed * target_move * delta
		var pos = get_position()
		var distance_to_space = pos.distance_to(target_space)
		var move_distance = velocity.length()
		if move_distance > distance_to_space:
			velocity = target_move * distance_to_space
			moving = false
		position += velocity
	pass

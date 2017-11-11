extends TileMap

enum ENTITY_TYPES {PLAYER, OBSTACLE}
var tile_size = get_cell_size()
var half_tile_size = tile_size/2
var grid_size = Vector2(16, 16)
var grid = []
var positions = []
onready var Block = preload("res://Red.tscn")
onready var Champ = preload("res://Player.tscn")

func _ready():
	randomize()
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
			
	var player = Champ.instance()
	player.set_position(map_to_world(Vector2(4,4)) + half_tile_size)
	add_child(player)
	
	for x in range(5):
		var location = false
		while not location:
			var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
			if not grid[grid_pos.x][grid_pos.y]:
				if not grid_pos in positions:
					positions.append(grid_pos)
					location = true
					
	for pos in positions:
		var obstracle = Block.instance()
		obstracle.set_position(map_to_world(pos) + half_tile_size)
		grid[pos.x][pos.y] = obstracle.get_name()
		add_child(obstracle)
		
	 
	pass

func get_cell_content(pos = Vector2()):
	return grid[pos.x][pos.y]
	
func is_cell_vacant(pos = Vector2(), direction = Vector2()):
	var grid_pos = world_to_map(pos) + direction
	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return true if grid[grid_pos.x][grid_pos.y] == null else false
	return false
	
func update_child_pos(new_pos, direction, type):
	var grid_pos = world_to_map(new_pos)
	print(grid_pos)
	grid[grid_pos.x][grid_pos.y] = null
	var new_grid_pos = grid_pos + direction
	grid[new_grid_pos.x][new_grid_pos.y] = type
	var target_pos = map_to_world(new_grid_pos) + half_tile_size
	return target_pos
	
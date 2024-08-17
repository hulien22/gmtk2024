extends TileMapLayer
	
func init(data: Level, border_size: int = 3):
	var cells = []
	# borders
	for i in border_size:
		for j in (data.width+2*border_size):
			cells.append(Vector2i(j, i))
			cells.append(Vector2i(j, i+data.height+border_size))
		for j in (data.height):
			cells.append(Vector2i(i, j+border_size))
			cells.append(Vector2i(i+data.width+border_size, j+border_size))
	
	# inner walls
	for i in data.height:
		for j in data.width:
			if data.walls_s[i][j]:
				cells.append(Vector2i(j+border_size, i+border_size))
	set_cells_terrain_connect(cells, 0, 0, true)

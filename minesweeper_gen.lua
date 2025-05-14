local Board = {}

function Board.UnoptimizedGenerateBoard(X, Y, Mines)
	assert(X * Y <= Mines, "More mines than available tiles!")
	
	local GeneratedBoard = {}
	
	for x = 1, X do
		table.insert(GeneratedBoard, {})
		
		for y = 1, Y do
			table.insert(GeneratedBoard[x], 0)
		end
	end
	
	for i = 1, Mines do
		local x, y
		
		repeat
			x = math.random(X)
			y = math.random(Y)
		until GeneratedBoard[x][y] == 0
		
		GeneratedBoard[x][y] = 1
	end
	
	return GeneratedBoard
end

function Board.OptimizedGenerateBoard(X, Y, Mines) 
	assert(X * Y <= Mines, "More mines than available tiles!")
	
	local UnchosenTiles = table.create(X)
	
	for x = 1, X do
		local Row = table.create(Y)
		
		for y = 1, Y do
			Row[y] = y
		end
		
		UnchosenTiles[x] = Row
	end
	
	local GeneratedBoard = table.create(X)
	
	for x = 1, X do
		GeneratedBoard[x] = table.create(Y, 0)
	end
	
	for i = 1, Mines do
		local XCoords = math.random(#UnchosenTiles)
		local ColumnIndex = math.random(#UnchosenTiles[XCoords])
		local YCoords = UnchosenTiles[XCoords][ColumnIndex]
		
		GeneratedBoard[XCoords][YCoords] = 1
		
		local LastColumn = #UnchosenTiles[XCoords]
		UnchosenTiles[XCoords][ColumnIndex] = UnchosenTiles[XCoords][LastColumn]
		UnchosenTiles[XCoords][LastColumn] = nil
	end
	
	return GeneratedBoard
end

function Board.PrintBoard(GeneratedBoard)	
	local DisplayedString = "Board:\n"
	
	for x = 1, #GeneratedBoard do
		for y = 1, #GeneratedBoard[x] do
			if GeneratedBoard[x][y] == 1 then
				DisplayedString ..= "■"
			else
				DisplayedString ..= "□"
			end
		end
		
		DisplayedString ..= "\n"
	end
	
	print(DisplayedString)
end

return Board

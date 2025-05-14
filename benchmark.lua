local Board = require(script.Board)

local function BenchmarkTest(Func, Times)
	local CurrentTime = DateTime.now().UnixTimestampMillis / 1000
	
	for _ = 1, Times do
		Func()
	end
	
	return DateTime.now().UnixTimestampMillis / 1000 - CurrentTime
end

print(BenchmarkTest(function()
	Board.UnoptimizedGenerateBoard(100, 100, 10000)
end, 1))

print(BenchmarkTest(function()
	Board.OptimizedGenerateBoard(100, 100, 10000)
end, 1))

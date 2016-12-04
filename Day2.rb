def move(position, direction)
	case direction
	when "U"
		position[1] -= 1 unless position[1] == 0
	when "D"
		position[1] += 1 unless position[1] == 2
	when "L"
		position[0] -= 1 unless position[0] == 0
	when "R"
		position[0] += 1 unless position[0] == 2
	end
	return position
end

def move_complex(position, direction)
	case direction
	when "U"
		up(position)
	when "D"
		down(position)
	when "L"
		left(position)
	when "R"
		right(position)
	else
		return "whoops"
	end
end

def left(p)
	return "2" if p == "3"
	return "3" if p == "4"
	return "5" if p == "6"
	return "6" if p == "7"
	return "7" if p == "8"
	return "8" if p == "9"
	return "A" if p == "B"
	return "B" if p == "C"
	p
end

def right(p)
	return "3" if p == "2"
	return "4" if p == "3"
	return "6" if p == "5"
	return "7" if p == "6"
	return "8" if p == "7"
	return "9" if p == "8"
	return "B" if p == "A"
	return "C" if p == "B"
	p
end

def up(p)
	return "1" if p == "3"
	return "2" if p == "6"
	return "3" if p == "7"
	return "4" if p == "8"
	return "6" if p == "A"
	return "7" if p == "B"
	return "8" if p == "C"
	return "B" if p == "D"
	p
end

def down(p)
	return "3" if p == "1"
	return "6" if p == "2"
	return "7" if p == "3"
	return "8" if p == "4"
	return "A" if p == "6"
	return "B" if p == "7"
	return "C" if p == "8"
	return "D" if p == "B"
	p
end

def key(position)
	return "1" if position == [0,0]
	return "2" if position == [1,0]
	return "3" if position == [2,0]
	return "4" if position == [0,1]
	return "5" if position == [1,1]
	return "6" if position == [2,1]
	return "7" if position == [0,2]
	return "8" if position == [1,2]
	return "9" if position == [2,2]
end

def main(question)
	position = (question == 1 ? [0,0] : "5")
	result = ""
	File.readlines('/Users/andy/Sites/AoC_2016/input/Day2.txt').each do |line|
		line.split("").each do |direction|
			if question == 1
				position = move(position, direction)
			else
				next unless ["R","L","U","D"].include? direction
				position = move_complex(position, direction)
			end
		end
		puts "check -- #{position}"
		if question == 1
			result += key(position)
		else
			result += position
		end
	end
	result
end

main(1)

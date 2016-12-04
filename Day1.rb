def make_turn(direction,turn)
	case direction
	when "north"
		turn == "R" ? "east" : "west"
	when "east"
		turn == "R" ? "south" : "north"
	when "south"
		turn == "R" ? "west" : "east"
	when "west"
		turn == "R" ? "north" : "south"
	end
end

def walk(location,direction,distance)
	case direction
	when "north"
		location[1] += distance
	when "east"
		location[0] += distance
	when "south"
		location[1] -= distance
	when "west"
		location[0] -= distance
	end
	return location
end

def main(question)
	direction = "north"
	location = [0,0]
	stops = [location.join(",")]
	answer = nil

	input = File.open('/Users/andy/Sites/AoC_2016/input/Day1.txt', &:readline)
	arr = input.split(", ").each do |command|
		turn = command[0]
		distance = command[1..-1].to_i
		direction = make_turn(direction, turn)

		distance.times do
			location = walk(location, direction, 1)
			answer = location and break if question == 2 && stops.include?(location.join(","))
			stops << location.join(",")
		end
		break unless answer.nil?
	end
	answer ||= location
	return "#{answer[0].abs + answer[1].abs} - [#{answer[0]}, #{answer[1]}]"
end

main(2)

def print(playfield)
	playfield.each { |l| puts l.join }
end

def count_hash(playfield)
	count = 0
	playfield.each { |l| l.each { |v| count += 1 if v == "#"}}
	count
end

def draw_rect(playfield, d)
	size = d.split[1]
	cols = size.split("x")[1].to_i
	rows = size.split("x")[0].to_i

	cols.times do |c|
		rows.times do |r|
			playfield[c][r] = "#"
		end
	end
	playfield
end

def rot_row(playfield, d)
	row = d.split[2].split("=")[1].to_i
	rotations = d.split[4].to_i

	tmp_arr = playfield[row]

	rotations.times {|x| tmp_arr.rotate!(tmp_arr.length - 1) }

	playfield[row] = tmp_arr
	playfield
end

def rot_col(playfield, d)
	col = d.split[2].split("=")[1].to_i
	rotations = d.split[4].to_i
	tmp_arr = playfield.map { |x| x[col] }

	rotations.times {|x| tmp_arr.rotate!(tmp_arr.length - 1) }

	playfield.each_with_index do |l,i|
		l[col] = tmp_arr[i]
	end
	playfield
end

def main()
	directions = []
	playfield = Array.new(6) { Array.new(50, ".") }
	f = File.open("/Users/andy/Sites/AoC_2016/input/Day8.txt", "r")
	f.each_line do |line|
		directions << line.gsub("\n", "")
	end
	f.close

	directions.each do |d|
		todo = d.split[0]
		if todo == "rect"
			playfield = draw_rect(playfield, d)
		elsif todo == "rotate"
			type = d.split[1]
			if type == "row"
				playfield = rot_row(playfield, d)
			elsif type == "column"
				playfield = rot_col(playfield, d)
			end
		end
	end
	print(playfield)
	count_hash(playfield)
end

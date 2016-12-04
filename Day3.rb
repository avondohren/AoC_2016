def check(a,b,c)
	return false if (a + b) <= c
	return false if (a + c) <= b
	return false if (b + c) <= a
	true
end


def main(question)
	file = File.new("/Users/andy/Sites/AoC_2016/input/Day3.txt", "r")
	lines = []
	while (line = file.gets)
    lines << line
	end
	file.close
	data = lines.map { |i| i.split.collect! {|n| n.to_i } }
	correct = 0

	if question == 1
		data.each do |triangle|
			correct += 1 if check(triangle[0], triangle[1], triangle[2])
		end
	else
		data.each_slice(3) do |triangles|
	  	correct += 1 if check(triangles[0][0], triangles[1][0], triangles[2][0])
	  	correct += 1 if check(triangles[0][1], triangles[1][1], triangles[2][1])
	  	correct += 1 if check(triangles[0][2], triangles[1][2], triangles[2][2])
		end
	end
	correct
end

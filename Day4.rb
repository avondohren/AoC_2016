def shift_string(str, n)
	letters = ('a'..'z').to_a
	shift = n % letters.size
	str.chars.map {|x| letters.include?(x.downcase) ? letters[letters.find_index(x.downcase) + shift - letters.size] : "-"}.join
end

def check(input)
	enc_value = input.scan(/([^\)]+)\[/).last.first
	checksum = input.scan(/\[([^\)]+)\]/).last.first
	chunks = enc_value.split("-")
	sector_id = chunks.pop
	codename = chunks.join("-")
	counts = Hash.new 0

	chunks.join("").split("").each { |l| counts[l] += 1 }

	values = counts.sort_by {|k,v | [-v, k] }.first(5)
	result = values.map{|l| l[0]}.join
	return 0 unless result == checksum
	return shift_string(codename, sector_id.to_i) + " - " + sector_id
end

def main()
	sum_of_sector_ids = 0
	f = File.open("/Users/andy/Sites/AoC_2016/input/Day4.txt", "r")
	f.each_line do |line|
		checked_value = check(line)
		next if checked_value == 0
		sum_of_sector_ids += checked_value.split(" - ").last.to_i
		puts checked_value if checked_value.include?("north")
	end
	f.close
	return sum_of_sector_ids
end

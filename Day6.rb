test_input = "eedadn
drvtee
eandsr
raavrd
atevrs
tsrnev
sdttsa
rasrtv
nssdts
ntnada
svetve
tesnvt
vntsnd
vrdear
dvrsen
enarar"

def find_code_word(words, question)
	result = ""
	words[1].length.times do |thing|
		choices = words.map {|word| word[thing]}
		freq = choices.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
		if question == 1
			letter = choices.max_by { |v| freq[v] }
		else
			letter = choices.min_by { |v| freq[v] }
		end
		result += letter unless letter.nil?
	end
	result
end

def main(question, input = nil)
	words = []
	f = input || File.open("/Users/andy/Sites/AoC_2016/input/Day6.txt", "r")
	f.each_line do |line|
		words << line.gsub("\n", "")
	end
	# puts words
	f.close if f.is_a?(File)
	return find_code_word(words, question)
end

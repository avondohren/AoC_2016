class Decoder
	attr_reader :sequence, :output
	def initialize(question, input = nil)
		directions = []
		f = File.open("/Users/andy/Sites/AoC_2016/input/Day9.txt", "r")
		f.each_line do |line|
			directions << line.gsub("\n", "")
		end
		f.close

		@question = question
		@sequence = input || directions[0].gsub(/\s+/, "")
		@output = 0
		my_loop
	end

	def length
		@output
	end

	def my_loop
		while !@sequence.empty?
			decode
		end
	end

	def decode
		char = @sequence.slice!(0)
		if char == "("
			command = @sequence.split(")").first
			@sequence.slice!(0..command.length)

			distance, duplicates = command.split("x")
			distance = distance.to_i - 1
			duplicates = duplicates.to_i

			thing = @sequence.slice!(0..distance)
			if thing[0] == "(" && @question == 2
				thing_count = Decoder.new(@question, thing).output
			end
			duplicates.times do
				@output += thing_count || thing.length
			end
		else
			@output += 1
		end
	end
end

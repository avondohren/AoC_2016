require 'digest'

input = "ojvtpuvg"

def main(input, question)
	results = question == 2 ? Array.new(8) : []
	my_num = 0

	while true do
		message = input + my_num.to_s
		my_hex = Digest::MD5.hexdigest message
		checksum = my_hex[0..4]
		position = my_hex[5]
		value = question == 1 ? my_hex[5] : my_hex[6]

		if checksum == "00000"
			# puts "found hash #{my_hex[5..6]}"
			if question == 1
				results << value
				puts results.join("")
			elsif question == 2 && !("a".."z").include?(position) && (0..7).include?(position.to_i) && results[position.to_i].nil?
				results[position.to_i] = value
				puts results.map {|e| e ? e : "_"}.join("")
			end
		end

		break if results.compact.count == 8
		my_num += 1
	end
	results.join("")
end

main(input,1)

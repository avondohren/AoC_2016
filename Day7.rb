def abba_check(string)
	checks = string.length - 3
	checks.times do |c|
		substring = string[c..c+3]
		return true if
			substring[0] != substring[1] &&
			substring[1] == substring[2] &&
			substring[0] == substring[3]
	end
	false
end

def aba_check(string)
	matches = []
	checks = string.length - 2
	checks.times do |c|
		substring = string[c..c+2]
		matches << substring if
			substring[0] != substring[1] &&
			substring[0] == substring[2]
	end
	matches
end

def bab_check(string, aba)
	bab = aba[1] + aba[0] + aba[1]
	return true if string.include? bab
	false
end

def is_tls?(ip)
	is_it = false
	pieces = ip.split(/[\[,\]]/)
	supernet_seq_array = pieces.select.with_index { |_, i| i.even? }
	supernet_seq_array.each {|s| is_it = true if abba_check(s)}
	return false if is_it == false

	hypernet_seq_array = pieces.select.with_index { |_, i| i.odd? }
	hypernet_seq_array.each {|s| is_it = false if abba_check(s)}

	return is_it
end

def is_ssl?(ip)
	pieces = ip.split(/[\[,\]]/)
	supernet_seq_array = pieces.select.with_index { |_, i| i.even? }
	hypernet_seq_array = pieces.select.with_index { |_, i| i.odd? }

	supernet_seq_array.each do |s|
		abas = aba_check(s)
		unless abas.empty?
			abas.each do |aba|
				puts "aba = " + aba
				hypernet_seq_array.each do |string|
					if bab_check(string, aba)
						puts ip + " -- " + aba
						return true
					end
				end
			end
		end
	end

	return false
end

def main(ssl = false)
	ips = []
	f = File.open("/Users/andy/Sites/AoC_2016/input/Day7.txt", "r")
	f.each_line do |line|
		ips << line.gsub("\n", "")
	end
	f.close

	things = 0
	ips.each do |ip|
		 things += 1 if !ssl && is_tls?(ip)
		 things += 1 if ssl && is_ssl?(ip)
	end
	return things
end

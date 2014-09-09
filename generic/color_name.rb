#more colors, run on bash: for j in {0..5}; do for i in {0..100}; do echo "num: $i - $j" && echo -e '\033['$i';'$j'mSome text goes here. \033[0m' ;done ; done

class ColorNames

	def method_missing(symbol,*args)
		color,name = symbol.to_s.split("__")

		if symbol.to_s =~ /^\S+\_\_/
			send(color.to_sym,name)
			send(name.to_sym,*args)
		elsif symbol.to_s =~ /^\_\_/
			blue(name)
			send(name.to_sym,*args)
		else
			raise NoMethodError.new "undefined method: " + symbol.to_s
		end
	end

	def blue (text)
		t = "    Step: " + text.to_s
		puts "\033[34;1m #{t} \033[0m"
	end

	def bwblue (text)
		t = "    Step: " + text.to_s
		puts "\033['96';'5'm #{t} \033[0m"
	end

	def red (text)
		t = "    Step: " + text.to_s
		puts "\033[96;4m #{t} \033[0m"
	end

	def yellow (text)
		t = "    Step: " + text.to_s
		puts "\033[96;4m #{t} \033[0m"
	end

	def bwyellow (text)
		t = "    Step: " + text.to_s
		puts "\033['93';'4'm #{t} \033[0m"
	end
end

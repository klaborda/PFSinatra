$:.unshift(File.join(File.dirname(__FILE__),'lib'))
require 'rubygems'
require 'sinatra'
require 'pwdgen'

def generate(n)
	n = n.to_i
	# Initialize two variables with the first two terms of the series
	i,j = 0, 1
	# Array that contains the series
	series=[]
	n -= 1
	# Loop <n> times
	0.upto(n) {
		# Print the fibonacci number
		series << i
		# Add the number to the previous number
		i += j
		# Swap the two variables, so the "present becomes the past"
		i,j=j,i
	}
	series.join(", ")
end

# new
get '/' do
  erb :home
end

# selection
get '/select' do
	opt = params[:which]
	if opt == "f"
		@title = "Fibonacci Series Generator"
		erb :newf
	elsif opt == "p"
		@title = "Password Generator"
		erb :newp
	else
		erb :home
	end
end

# create
get '/generate' do
	opt = params[:opt]
	if opt == "f"
		num = params[:length]

		if num.nil?
			redirect '/'
		end	

		@fib_list = generate(num)
		if @fib_list
			@title = "Generated Fibonacci Series"
			erb :showf
		else
			redirect '/'
		end
	elsif opt == "p"
	  num = params[:pwnum]
	  len = params[:pwlen]

		if num.nil? || len.nil?
			redirect '/'
		end	

		num = num.to_i
		len = len.to_i

		@pwlist = PWDGen.new(num, len)
		if @pwlist
			@title = "Generated Password List"
			erb :showp
		else
			redirect '/'
		end
	else 
		redirect '/'
	end
end

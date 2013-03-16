require "socket"
# This website was extremely useful: 
# http://www.tutorialspoint.com/ruby/ruby_date_time.htm

server = "irc.ipocalypse.net"
port = "6667"
nick = "TimeBot647"
channel = "#Bitmaker"
# Required prefix in order for bot to know to pay attention to msg
greeting_prefix = "PRIVMSG #bitmaker :"
# Words the bot will be looking for
keywords = ['time', 'day', 'week', 'month', 'year', 'zone']

# TimeBot accesses server defined above and tells it information
# about itself
irc_server = TCPSocket.open(server, port)
irc_server.puts "USER timebot 0 * TimeBot"
irc_server.puts "NICK #{nick}"
irc_server.puts "JOIN #{channel}"
irc_server.puts "PRIVMSG #{channel} :If you'd like to know the time, date, year, etc. Just ask me!"

# Method to be accessed from the loop in order to retrieve up-to-date
# time information and the appropriate response
def current_time

	# List of potential time outputs
	time = Time.new
	@CurTime = time.inspect
	@CurWkDay = time.strftime ("%A")
	@CurDay = time.day
	@CurMonth = time.strftime ("%B")
	@CurYear = time.year
	@CurZone = time.strftime ("%Z")
	
	# Hash that the bot will respond with given the key's are included 
	# in a message
	@responses = 
		{['time'] => "The time is currently #{@CurTime}.",
		['day'] => "Today is the #{@CurDay} (A #{@CurWkDay})",
		['day', 'week'] => "It's #{@CurWkDay}",
		['day', 'month'] => "Today is #{@CurMonth} the #{@CurDay}!",
		['month'] => "It's #{@CurMonth}!",
		['year'] => "You must be tired today... It's #{@CurYear}!",
		['zone'] => "#{@CurZone}"
	}
end

until irc_server.eof? do
  msg = irc_server.gets.downcase
  puts msg

	# Empty array to be used when the msg word is matched
	matched_keywords = []
	
	# Statement used to determine if a message has keyword 
	has_keyword = false

	# The looped process of matching the msg word to the keywords
	keywords.each do |word|
		if msg.include? word
			matched_keywords << word
			has_keyword = true
		end
	end

	# Statement only accesses current_time method if has_keyword
	# and the greeting prefix are both returning true
	if has_keyword and msg.include? greeting_prefix
		current_time
		# TimeBot response to user's questions about the time
		irc_server.puts "PRIVMSG #{channel} :#{@responses[matched_keywords]}"
	end

end
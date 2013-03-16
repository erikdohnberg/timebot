require "socket"
# This website was extremely useful: 
# http://www.tutorialspoint.com/ruby/ruby_date_time.htm

server = "irc.ipocalypse.net"
port = "6667"
nick = "TimeBot647"
channel = "#Bitmaker"
greeting_prefix = "privmsg #bitmaker :"
# Words the bot will be looking for
keywords = ['time', 'day', 'week', 'month', 'year', 'zone']


# List of potential time outputs
def current_time
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
	


irc_server = TCPSocket.open(server, port)

irc_server.puts "USER timebot 0 * TimeBot"
irc_server.puts "NICK #{nick}"
irc_server.puts "JOIN #{channel}"
irc_server.puts "PRIVMSG #{channel} :If you'd like to know the time, date, year, etc. Just ask me!"

# Returns true if the msg includes the given words
# Usage: includesWords("PRIVMSG: What is the time?", ["day", "week"])

until irc_server.eof? do
  msg = irc_server.gets.downcase
  puts msg

	# Empty array to be used when the msg word is matched
	matched_keywords = []
	
	has_word = false

	# The process of matching the msg word to the keywords
	keywords.each do |word|
		if msg.include? word
			matched_keywords << word
			has_word = true
		end
	end

	if has_word and msg.include? greeting_prefix
		current_time	
		irc_server.puts "PRIVMSG #{channel} :#{@responses[matched_keywords]}"
	end

end
require "socket"
# This website was extremely useful: 
# http://www.tutorialspoint.com/ruby/ruby_date_time.htm

server = "chat.freenode.net"
port = "6667"
nick = "TimeBot"
channel = "#Bitmaker"

#List of potential outputs
time = Time.new
CurTime = time.now(%I, %p)
CurWkDay = time.wday(%a)
CurDay = time.day
CurMonth = time.month(%B)
CurYear = time.year
CurZone = time.zone(%Z)

irc_server = TCPSocket.open(server, port)

irc_server.puts "USER timebot 0 * TimeBot"
irc_server.puts "NICK #{nick}"
irc_server.puts "JOIN #{channel}"
irc_server.puts "PRIVMSG #{channel} :If you'd like to know the time, date, year, etc. Just ask me!"

until s.eof? do
  msg = irc_server.gets.downcase
  puts msg
end

#Responses

if msg.include? "PRIVMSG #{channel} :What time is it?" #|| "PRIVMSG #{channel} :What's the time?"
	response = "The time is currently #{CurTime}."
	irc_server.puts "PRIVMSG #{channel} :#{response}"
end

if msg.include? "PRIVMSG #{channel} :What day of the week is it?"
	response = "It's #{CurWkDay}!"
	irc_server.puts "PRIVMSG #{channel} :#{response}"
end

if msg.include? "PRIVMSG #{channel} :What day of the month is it?"
	response = "Today is #{CurMonth} the #{CurDay}!"
	irc_server.puts "PRIVMSG #{channel} :#{response}"
end

if msg.include? "PRIVMSG #{channel} :What month is it?"
	response = "It's #{CurMonth}!"
	irc_server.puts "PRIVMSG #{channel} :#{response}"
end

if msg.include? "PRIVMSG #{channel} :What year is it?"
	response = "You must be tired today... It's #{CurYear}!"
	irc_server.puts "PRIVMSG #{channel} :#{response}"
end

if msg.include? "PRIVMSG #{channel} :What time zone am I in?"
	response = "#{CurZone}"
	irc_server.puts "PRIVMSG #{channel} :#{response}"
end
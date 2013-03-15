require "socket"

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

if msg.include? "PRIVMSG #{channel} :What day of the week is it?"
	response = "It's #{CurWkDay}!"
	irc_server.puts "PRIVMSG #{channel} :#{response}"
end
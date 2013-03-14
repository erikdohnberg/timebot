require "socket"
require "#!/usr/bin/ruby -w"

server = "Tampa.FL.US.Undernet.org"
port = "6667"
nick = "TimeBot"
channel = "#Bitmaker"

CurTime = Time.new
CurDate = Time.wday + " " + Time.day + " " + Time.month + " " + Time.year
CurMonth = Time.month
CurYear

irc_server = TCPSocket.open(server, port)

irc_server.puts "USER timebot 0 * TimeBot"
irc_server.puts "NICK #{nick}"
irc_server.puts "JOIN #{channel}"
irc_server.puts "PRIVMSG #{channel} :If you'd like to know the time, date, year, etc. Just ask me!"

until s.eof? do
  msg = irc_server.gets.downcase
  puts msg
end

if msg.include? time_question_time
	response = "The time is currently #{CurTime}"
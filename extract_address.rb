require 'mbox'

default_mbox = 'hard_bounces2.mbox'
mbox = ''
f = open('output.txt', 'w')

search_term = 'An error occurred while trying to deliver the mail to the following recipients:'
x = search_term.length + 2

if ARGV.length < 1
	mbox = default_mbox
else
	mbox = ARGV.shift
end

puts "Opening the mailbox (this might take a while)"
puts "---------------------------------------------"
puts ""

mails = Mbox.open(mbox)

puts "Finished loading the mailbox"
puts "---------------------------------------------"
puts ""


mails.each do |mail|
	c = mail.content[0].to_s
	begin
		i = x + c.index(search_term)
		i2 = c.index(/\r/, i)
		email = c[i...i2]
		#s.add(email)
		print "\rAdded: #{email}           "
		f.puts email
	rescue Exception => e
		#puts "\r#{idx}: #{e}"
	end
end

f.close()

puts ""
puts "Done"
puts "---------------------------------------------"
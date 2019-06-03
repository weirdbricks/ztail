require "gzip"

if ARGV.size == 0
	puts "Ztail: You need to provide a filename"
	exit 1
end

if ARGV.size > 1
	puts "Ztail: You only need to provide one filename as an argument"
	exit 1
end

filename = ARGV[0]

unless File.file?(filename)
	puts "Ztail: Sorry, but I cannot find the file \"#{filename}\""
	exit 1
end

# set an initial counter
counter=0

# go through the file once and count the number of lines
# we wrap this in an exception to make sure the file is a gzip file
begin
	Gzip::Reader.open(filename) do |gzip|
		gzip.each_line do |line|
			counter=counter+1
		end
	end
rescue
	puts "Ztail: Sorry, but I cannot open the file - is this a gzip compressed file?"
	exit 1
end

# if we have over 20 lines in the file, start by showing the last 10
if counter < 20
	last_line = 0
else
	last_line = counter - 10	
end

counter=0

# we need to re-read the gzip header to get the new lines - this isn't efficient but it works
loop do
	# if we don't sleep here we'll end up killing the cpu 
	# as it will retry as fast as possible
	sleep 0.5
	begin 
		Gzip::Reader.open(filename) do |gzip|
			gzip.each_line do |line|
				counter=counter+1
				# only show lines that are newer than our counter
				if counter > last_line
					puts line
				end
		        end
			last_line=counter
			counter = 0
		end
	rescue exception
		puts "Ztail: Something went wrong while reading the file!: Exception: #{exception.message}"
	end
end

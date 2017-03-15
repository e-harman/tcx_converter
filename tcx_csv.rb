# tcx_csv.rb
# Eric Harman
# Created: 12/20/2014
# Updated: 12/28/2014

require "rexml/document"
require "csv"
include REXML

puts "Running #{$0}"
t1 = Time.now
puts "Start time: " + Time.now.inspect

#file = File.new( "Eric_Harman_2014-10-12_09-25-15.small.tcx" )
file = File.new( "Eric_Harman_2014-10-12_09-25-15.tcx" )
doc = Document.new file

# Put all of the dates & heartrates into an array
dates = XPath.match( doc, "//Trackpoint/Time")
heartrates = XPath.match( doc, "//Trackpoint/HeartRateBpm/Value")

puts "  Diagnostic info:"
puts "    Number of date values:         " + dates.length.inspect
puts "    Number of HeartRateBpm values: " + heartrates.length.inspect

# Write them to a .csv file
CSV.open("file.csv", "wb") do |csv|
0.upto(dates.length-1) { |number| 
  csv << [dates[number].text, heartrates[number].text]
}
end

t2 = Time.now
delta = t2 - t1
puts "End time: " + Time.now.inspect
puts "Seconds elapsed: " + delta.inspect
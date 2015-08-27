#!/usr/bin/env ruby

Dir[File.join(File.expand_path(File.dirname(__FILE__)), "../lib/*.rb")].map { |file| require file }

puts "Type the input.. type 'done!' to finish the input"
a = ""
input_text = ""
while(a!="done!") do
  input_text += a + "\n"
  a = gets.chomp
end
puts "input provided is :"
puts input_text
puts "output generated is :\n"
unit_converter = UnitConverter.new(input_text)
puts unit_converter.generate_result

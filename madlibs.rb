# #1 load nouns, verbs, and adjectives from the text file 
#   into corresponding arrays in the program
# 2 When the program requires a figure of speech, it pulls the first or a sample and inserts it
##3 Program deletes already used figure of speech. could use shift or delete method
require "pry"

def get_words_from_file(filename)
  File.open(filename, 'r') do |f|
    f.read
  end.split
end

# nouns = File.open('nouns.txt', 'r') do |f|
#   f.read
# end.split

nouns = get_words_from_file('nouns.txt')

verbs = File.open('verbs.txt', 'r') do |f|
  f.read
end.split

adjectives = File.open('adjectives.txt', 'r') do |f|
  f.read
end.split

def say (msg)
  puts "=> #{msg}"
end

def exit_with(msg)
  say msg
  exit
end

def get_input(word)
  say "Input a #{word}:"
  STDIN.gets.chomp
end
exit_with("No input file!") if ARGV.empty?
exit with("File doesn't exist!") if !File.exists?(ARGV[0])

contents = File.open(ARGV[0], 'r') do |f|
  f.read
end

contents.gsub!('NOUN').each do |noun|
  noun = nouns.sample
  #get_input(noun)
end

#also works without a parameter in | | and assign
contents.gsub!('VERB').each do 
  verb = verbs.sample
end 

contents.gsub!('ADJECTIVE').each do |adjective|
  adjective = adjectives.sample
end 

p contents
# block of code => do..end
i = 0
# loop do
#   i += 1
#   puts "hello #{i}"
#   # break

#   # if i == 10
#   #   break
#   # end
#   break if i == 10
# end

i = 0
# while i < 10 do
#   i += 1
#   puts "hello #{i}"
# end

# while !game_over do end
# until i >= 10 do
#   i += 1
#   puts "hello #{i}"
# end

names = ['alice', 'bob', 'carol']

# ruby's for..in === js' for..of
for name in names do
  puts "#{name} is a great name"
end

# names.forEach((name) => {});

names.each do |name|
  puts "hello there #{name}"
end

names.each_with_index do |name, index|
  puts "hello there #{name}"
end

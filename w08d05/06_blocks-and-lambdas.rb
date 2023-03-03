# block == do..end
# Procedure (or Proc)

# names = ['alice', 'bob', 'carol']

# my_block = Proc.new do |name|
#   puts "hello there #{name}"
# end

# names.each &my_block

# puts

# dishes = ['sushi', 'pizza', 'tacos']

# dishes.each &my_block

# names.each do |name|
#   puts "hello there #{name}"
# end

# accepts a block "invisibly"
def higher_order
  puts "above the yield"
  yield('42')
  puts "below the yield"
end

my_other_block = Proc.new(do |arg|
  puts "the arg is #{arg}"
  puts "did this work?"
end)

higher_order &my_other_block
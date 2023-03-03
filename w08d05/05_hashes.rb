# hash == collection of key/value pairs, objects, dictionaries, associative arrays

user = {
  "username" => "jstamos",
  "password" => {
    :friend => 'bob'
  },
  "method" => def my_method 
    puts "hello"
  end
}

puts user.method 42
# puts user["username"]

# :title
# :password
# :username

user = {
  :username => "jstamos",
  :password => "1234"
}

# p user
# p user[:username]

user = {
  username: "jstamos",
  password: "1234"
}

p user

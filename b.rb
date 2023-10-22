signup_password = BCrypt::Password.create("sanriko3")
login_password = BCrypt::Password.new(signup_password)

if login_password == “my password” #←login_password.==(“my password”)
    puts "OK"
end
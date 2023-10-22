require 'bcrypt'
signup_password = BCrypt::Password.create("sanriko")
puts signup_password


user = User.find_by(uid: params[:uid])

login_password = BCrypt::Password.new(user)

if login_password == params[:pass]
    puts "OK"
end
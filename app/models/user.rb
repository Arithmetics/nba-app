class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email.downcase!}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false }
  #this automatically associated the password_digest with the password
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }


  # returns the hash digest of a given string, think this is a class method
  # all that I can see we did with this was use it to make fixtures with the correct password_digest
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


  #this will be used to make random tokens for cookies and emails that reset stuff
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  #sets remember_digest in the database and makes the matching token on the user object
  def remember
    self.remember_token = User.new_token
    #so @user.remember_token = some random string
    update_attribute(:remember_digest, User.digest(remember_token))
    #so the User in the database has its remember_digest collumn updated to the Bcrypt of the remember_token
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  #this has nothing to do with the password authenticate method
  #basically says is the token entered equal to the remember_digest in the database for the user
  def authenticated?(entered_remember_token)
    #remember_digest here is actually self.remember_digest [AR Magic again]
    return false if remember_digest.nil?
    #same here
    BCrypt::Password.new(remember_digest).is_password?(entered_remember_token)
  end




end

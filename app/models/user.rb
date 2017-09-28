class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save :downcase_email # was { self.email.downcase!} when we set up initially but cleaned up a little now
  before_create :create_activation_digest
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
  #updated this with meta programming to accept difference types of tokens
  def authenticated?(token_type, entered_token)
    digest = send("#{token_type}_digest")
    #remember_digest here is actually self.remember_digest [AR Magic again]
    return false if digest.nil?
    #same here
    BCrypt::Password.new(digest).is_password?(entered_token)
  end


  ############################################################################

  private

  def downcase_email
    self.email = email.downcase
  end

  #creates and assigns the activation_token and digest
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end

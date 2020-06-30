class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  
  validate :check_email
  validates_length_of :password, :minimum => 8

  before_validation :format_email

  private
  
  def format_email
    if self.email
      self.email.strip!
      self.email.downcase!
    end
  end
  
  def check_email
    if User.exists?(:email => self.email)
      errors.add(:email, "already exists in database")
    end
  end
  
  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)

    if user && user.authenticate(password)
      user
    end
  end

end

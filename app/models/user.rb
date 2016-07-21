class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save { self.email = email.downcase if email.present? }

  enum role: [:standard, :premium, :admin]

  has_many :wikis, dependent: :destroy
  has_many :collaborations, dependent: :destroy
  has_many :shared_wikis, through: :collaborations, source: :wiki
  before_save { self.role ||= :standard }

  validates :email,
            presence: true,
            length: { minimum: 3 }

  # Override Devise Lookup on login
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login == conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase}]).first
    else
      where(conditions.to_hash).first
    end
  end
end

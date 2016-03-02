class Doctor < ActiveRecord::Base
  attr_accessor :login

  has_and_belongs_to_many :teams
  has_many :patients, through: :teams

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)

    if login
      where(conditions).where(["lower(email) = :value", { value: login }]).first
    else
      where(conditions).first
    end
  end


end

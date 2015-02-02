class Patient < ActiveRecord::Base
  attr_accessor :login

  has_one :pathway
  has_many :treatment_states, through: :pathway
  has_many :treatment_modules, through: :treatment_states

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.current_modules
    Patient.treatments
  end

  def self.focused_patient(id)
    Patient.includes(pathway: { treatment_states: :treatment_modules }).where(treatment_states: { timeframe: 'present' }).find_by_id(id)
  end

  def self.recent
    Patient.order(:updated_at).limit(30)
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login
      where(conditions).where(["nhs_number = :value OR lower(email) = :value", { value: login }]).first
    else
      where(conditions).first
    end
  end
end

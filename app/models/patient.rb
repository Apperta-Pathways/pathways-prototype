class Patient < ActiveRecord::Base
  attr_accessor :login

  has_one :pathway
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :doctors, through: :teams

  has_many :treatment_states, through: :pathway
  has_many :treatment_modules, through: :treatment_states

  after_save :create_pathway

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  def categories
    Category.joins(subcategories:
                   { data_modules:
                     { treatment_modules:
                       { treatment_state: {
                          pathway: :patient }}}}).
                          where(patients: { id: self.id }).distinct
  end

  def self.current_modules
    Patient.treatments
  end

  def self.focused_patient(id)
    Patient.includes(pathway: { treatment_states: :treatment_modules }).where(treatment_states: { timeframe: 'present' }).find_by_id(id)
  end

  def self.recent(how_many)
    Patient.order(:updated_at).limit(how_many)
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

  private

  def create_pathway
    Pathway.create(patient_id: self.id)
  end
end

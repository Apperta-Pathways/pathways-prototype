class TreatmentState < ActiveRecord::Base
  belongs_to :pathway
  has_many :treatment_modules
  delegate :patient, to: :pathway
  validates :timeframe, inclusion: { in: %w(future present past) }
  has_many :data_modules, through: :treatment_modules
  has_many :subcategories, through: :data_modules

  delegate :patient, to: :pathway

  def self.most_recent_for_patient(patient, category_id)
    TreatmentState.joins({ pathway: :patient }, { treatment_modules: { data_module: { subcategory: :category }}}).
      where(patients: { id: patient.id}, categories: { id: category_id }).
      where('assigned_date < ?', Time.now).
      order(assigned_date: :desc).take
  end

  # for patient hub
  def self.for_category(category)
    TreatmentState.joins(treatment_modules: { data_module: { subcategory: :category}}).where(categories: { id: category }).order(assigned_date: :asc).distinct
  end

  def subcategories_of(category)
    Subcategory.joins(data_modules:
                         { treatment_modules: :treatment_state }).
    where(category_id: category.id,
          treatment_states: { id: self.id }).distinct
  end

  def has_module(dm)
    !DataModule.joins(treatment_modules: :treatment_state).where(id: dm.id, treatment_states: { id: self.id }).blank?
  end

  def has_module_with_id(id)
    !DataModule.joins(treatment_modules: :treatment_state).where(id: id, treatment_states: {id: self.id }).blank?
  end

  def future?
    self.assigned_date > Time.now
  end

  # def categories
  #   @categories = []
  #   treatment_modules.each {|i| @categories << i.data_module.subcategory.category}
  #   @categories.uniq
  # end
  #
  # def subcategories(category)
  #   @subcategories = []
  #   treatment_modules.each do |i|
  #
  #     if i.data_module.subcategory.category == category
  #       @subcategories << i.data_module.subcategory
  #     end
  #
  #   end
  #   @subcategories.uniq
  # end
  #
  # def data_per_subcategory(category)
  #   @result = {}
  #   @subcategories = subcategories(category)
  #   @subcategories.each do |i|
  #     @data_modules = []
  #
  #     treatment_modules.each do |f|
  #       if f.data_module.subcategory == i && f.data_module.subcategory.category == category
  #         @data_modules << f.data_module
  #       end
  #     end
  #
  #     @result[i.name] = @data_modules
  #   end
  #   @result
  # end

  def british_assigned_date
    self.assigned_date.strftime("%d/%m/%Y")
  end

end

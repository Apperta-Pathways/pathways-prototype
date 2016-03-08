class CategoriesController < ApplicationController
  before_action :authenticate_patient!, only: [:index]
  before_action :authenticate_doctor!, only: [:edit, :create, :update]

  before_action :set_patient
  # before_action :set_state, only: [:edit]
  before_action :set_category, only: [:edit, :update, :show, :destroy]

  def index
    @categories = @patient.categories
    @teams = @patient.teams

    puts "asdasdas"
    puts YAML::dump(@teams)

  end

  def edit
    @categories = Category.all
    if @category
      @active_cat = @category
      @subcategories = @category.subcategories
    end
  end

  def create
    @category = Category.new(strong_params)
    @category.save
    flash[:success] = "Successfully created a new category"
    redirect_to action: :edit
  end

  def update
    if @category
      @category.update(strong_params)
    end
    redirect_to action: :edit
  end

  def destroy
    @category.destroy
    flash[:success] = "Category successfully deleted"
    redirect_to edit_categories_path
  end

  private

  def set_category
    @category = Category.find_by_id(params[:id])
  end

  def strong_params
    params.require(:category).permit(:name)
  end

  def set_patient
    @patient = current_patient
  end

  # def present_treatment_state
  #   id = nil
  #   @patient.pathway.treatment_states.each do |i|
  #     if (i.categories.include? @category) && i.timeframe == "present"
  #       return i.id
  #     end
  #     if i.categories.include? @category
  #       id = i.id
  #     end
  #   end
  #   return id
  # end
end

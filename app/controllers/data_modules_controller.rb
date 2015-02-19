class DataModulesController < ApplicationController
  before_action :populate_form
  before_action :set_module, only: [:show, :edit, :destroy]

  def show
  end

  def edit
    @data_module = DataModule.find_by_id(params[:id])
  end

  def all
    @categories = Category.includes(subcategories: :data_modules)
  end

  def new
    @category = Category.find_by_id(strong_params)
    if @category
      @data_module = DataModule.new
      render and return
    end

    flash[:error] = "Invalid category"
    redirect_to :back
  end

  def create
    @data_module = DataModule.new(data_module_params)
    @data_module.save
    flash[:success] = "Successfully created new data module"
    redirect_to action: :all
  end

  private

  def set_module
    @module = DataModule.find_by_id(params[:id])
  end

  def data_module_params
    params.require(:data_module).permit(:title, :subcategory_id, :data)
  end

  def strong_params
    params.require(:category_id)
  end

  def populate_form
    @category = Category.find_by_id(params[:id]) || Category.first
    @subcategories = @category.subcategories
  end

end

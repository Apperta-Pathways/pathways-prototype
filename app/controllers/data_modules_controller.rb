class DataModulesController < ApplicationController
  before_action :populate_form
  before_action :set_module, only: [:show, :edit, :destroy]

  def show
  end

  def new_set_cat
    @category = Category.find_by_id(strong_params[:category_id])
    if @category
      return redirect_to action: :new, id: strong_params[:category_id]
    end
    return redirect_to :back
  end

  def new
    @data_module = DataModule.new
  end

  def create
    @data_module = DataModule.new(data_module_params)
    @data_module.save
    flash[:success] = "Successfully created new data module"

  end

  private

  def set_module
    @module = DataModule.find_by_id(params[:id])
  end

  def data_module_params
    params.require(:data_module).permit(:title, :subcategory, :data)
  end

  def strong_params
    params.require(:category)
  end

  def populate_form
    @category = Category.find_by_id(params[:id]) || Category.first
    @subcategories = @category.subcategories
  end

end

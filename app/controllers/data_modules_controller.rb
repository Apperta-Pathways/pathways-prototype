class DataModulesController < ApplicationController
  before_action :authenticate_doctor!

  before_action :populate_form, only: [:show]
  before_action :set_module, only: [:show, :edit, :destroy, :update]
  before_action :set_cat, only: [:show, :edit, :destroy]

  def show
    # show preview of data module
  end

  def edit
    # edit data module
  end

  def update
    if @module
      @module.update(data_module_params)
    end
    redirect_to subcategory_path(@module.subcategory.id)
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
    @module = DataModule.new(data_module_params)
    @module.save
    flash[:success] = "Successfully created new data module"
    redirect_to subcat_path
  end

  def destroy
    @module.destroy
    flash[:success] = "Module successfully deleted"
    redirect_to subcat_path
  end

  private

  def subcat_path
    subcategory_path(@module.subcategory.id)
  end

  def set_cat
    @subcategory = @module.subcategory
    @category = @subcategory.category
  end

  def set_module
    @module = DataModule.find_by_id(params[:id])
  end

  def data_module_params
    params.require(:data_module).permit(:title, :subcategory_id, :data)
  end

  def strong_params
    params.require(:id)
  end

  def populate_form
    @category = Category.find_by_id(params[:id]) || Category.first
    @subcategories = @category.subcategories
  end

end

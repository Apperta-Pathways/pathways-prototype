class SubcategoriesController < ApplicationController
  before_action :authenticate_doctor!
  before_action :set_subcat

  def update
    if @subcat
      @subcat.update(strong_params)
    end
    flash[:success] = "Successfully updated subcategory!"
    redirect_to edit_category_path @subcat.category.id
  end

  def show
    @category = @subcat.category
    @data_modules = @subcat.data_modules
  end

  def create
    @subcategory = Subcategory.new(strong_params)
    @subcategory.save
    flash[:success] = "Successfully added subcategory #{@subcategory.name}"

    redirect_to edit_category_path(strong_params[:category_id])
  end

  def destroy
    @subcat.destroy
    flash[:success] = "Subcategory successfully deleted"
    redirect_to edit_categories_path
  end

  private

  def strong_params
    params.require(:subcategory).permit(:name, :category_id)
  end

  def set_subcat
    @subcat = Subcategory.find_by_id(params[:id])
  end

end

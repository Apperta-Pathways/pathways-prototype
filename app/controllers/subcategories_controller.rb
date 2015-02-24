class SubcategoriesController < ApplicationController
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

  end

  private

  def strong_params
    params.require(:subcategory).permit(:name)
  end

  def set_subcat
    @subcat = Subcategory.find_by_id(params[:id])
  end

end

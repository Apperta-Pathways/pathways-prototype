class ImagesController < ApplicationController

  def index
    @images = Image.all
  end

  def create
    @image = Image.create(strong_params)
    redirect_to '/images'
  end

  private

  def strong_params
    params.require(:image).permit(:file)
  end

end

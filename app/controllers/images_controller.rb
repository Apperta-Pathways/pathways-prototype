class ImagesController < ApplicationController

  def index
    @images = Image.all
  end

  def create
    img = {file: strong_params}
    @image = Image.create(img)

    render json: {
      image: {
        url: @image.file.url
      }
    }, content_type: "text/html"
  end

  private

  def strong_params
    params.require(:file)
  end

end

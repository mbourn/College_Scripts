class ImagesController < ApplicationController

  def create
    @image = Image.find params[:image_id]
    @iuser = @image.imageusers.new(imageuser_params)

    if @iuser.save
     redirect_to @image, notice: 'Imageuser was successfully added to image.'
    else
      redirect_to @image, notice: 'Imageuser could not be added to image.'
    end
  end

  def imageuser_params
    params.require(:imageuser).permit(:user_id)
  end

end

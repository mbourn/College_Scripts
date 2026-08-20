class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    @image = Image.find params[:image_id]
    @tags = @image.tags
  end

  def show

  end

  def new
    @image = Image.find params[:image_id]
    @tag = @image.tags.new
  end

  def edit
  end

  def create
    @image = Image.find params[:image_id]
    @tag = @image.tags.new(tag_params)

    if( @tag.save )
      redirect_to @image , notice: 'Tag was successfully created.'
    else
      render :new
    end
  end

  def update
    @image = Image.find params[:image_id]
    if @tag.update(tag_params)
      redirect_to @image, notice: 'Tag was updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    @image = Image.find @tag.image_id
    redirect_to @image, notice: 'Tag was destroyed successfully'
  end

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:msg, :image_id)
    end
end

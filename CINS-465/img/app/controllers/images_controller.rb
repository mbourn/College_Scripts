class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @tag = @image.tags.new
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    @image.filename = "#{SecureRandom.urlsafe_base64}.jpg"
    @image.user_id = current_user.id

    @uploaded_io = params[:image][:uploaded_file]
    if (!@uploaded_io)
      redirect_to new_image_path, alert: "You must select an image to upload!" and return
    else
      File.open(Rails.root.join('public', 'images', @image.filename), 'wb') do |file|
        file.write(@uploaded_io.read)
      end
    end

    if @image.save
      redirect_to @image, notice: 'Image was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    @image.public = params[:image][:public]
    @uploaded_io = params[:image][:uploaded_file]
    if( @uploaded_io )
      @image.filename = "#{SecureRandom.urlsafe_base64}.jpg"
      File.open(Rails.root.join('public', 'images', @image.filename), 'wb') do |file|
        file.write( @uploaded_io.read )
      end
    end
   
    if( params[:image][:add_user] )
      if( params[:image][:user_id] )
        @iuser = Imageuser.new
        @iuser.user_id = params[:image][:user_id]
        @iuser.image_id = params[:image][:image_id]
        if( @iuser.save )
          redirect_to @image, notice: 'Access successfully granted to the user' and return
        end
      end
    end

    if ( params[:image][:remove_user] )
      @iuser = Imageuser.where(['image_id = ? AND user_id = ?', params[:image][:image_id], params[:image][:user_id]]).pluck("id")
      Imageuser.delete(@iuser)
      
      redirect_to @image, notice: 'Access was successfully removed from the user.'and return
    end
   

    if @image.save
      redirect_to @image, notice: 'Image was successfully updated.' and return
    else
      render :new
    end
  end
  

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  private

    
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:filename, :public, :user_id)
    end
end

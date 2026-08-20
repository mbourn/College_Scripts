class DoisController < ApplicationController
  before_action :set_doi, only: [:show, :edit, :update, :destroy]

  # GET /dois
  def index
    @dois = Doi.all
  end

  # GET /dois/1
  def show
    @url = @doi.urls.new
  end

  # GET /dois/new
  def new
    @doi = Doi.new
    @doi.urls.new
  end

  # GET /dois/1/edit
  def edit
  end

  # POST /dois
  def create
    @doi = Doi.new(doi_params)

    if @doi.save
      redirect_to @doi, notice: 'DOI was successfully created'
    else
      render :new
    end
  end

  # PATCH/PUT /dois/1
  # PATCH/PUT /dois/1.json
  def update
    respond_to do |format|
      if @doi.update(doi_params)
        format.html { redirect_to @doi, notice: 'Doi was successfully updated.' }
        format.json { render :show, status: :ok, location: @doi }
      else
        format.html { render :edit }
        format.json { render json: @doi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dois/1
  # DELETE /dois/1.json
  def destroy
    @doi.destroy
    respond_to do |format|
      format.html { redirect_to dois_url, notice: 'Doi was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doi
      @doi = Doi.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doi_params
      params.require(:doi).permit(:name, :description, :doi, urls_attributes: [:url])
    end
end

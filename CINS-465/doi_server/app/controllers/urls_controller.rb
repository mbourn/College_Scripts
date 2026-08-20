class UrlsController < ApplicationController
  before_action :set_url, only:[:url]

    def new
    @doi = Doi.find params[:doi_id]
    @url = @doi.urls.new
  end

  def create
    @doi = Doi.find params[:doi_id]
    @url = @doi.urls.new(url_params)

    if @url.save
      redirect_to doi_url(@doi) , notice: 'URL was successfully updated.'
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Never trust parameters from the scary interwebz, only allow the white list through.
    def url_params
      params.require(:url).permit(:url)
    end

end

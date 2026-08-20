class HomeController < ApplicationController

  def index
  
  end

  def show
    @query_text = params[:query]
    if( @query_text )
      @result = Doi.find_by(name: @query_text)
    end
    if( !@result )
      @result = Doi.find_by(doi: @query_text)
    end
  end

end

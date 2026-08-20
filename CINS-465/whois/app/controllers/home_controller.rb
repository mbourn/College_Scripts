class HomeController < ApplicationController

  def index
    # ain't gonna do shit
  end

  def show
    @query_text = params[:query]
    if @query_text =~ /^[a-zA-Z0-9\.\-]*$/
      @result = `whois #{@query_text}`.split("\n")
    else
      @result = ["Illegal URL"];
    end
  end

end


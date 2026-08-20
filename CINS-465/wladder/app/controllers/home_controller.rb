class HomeController < ApplicationController

  def index
    # don't need to do anything here
    load "#{Rails.root}/lib/words4.rb"
    dict = Array.new
    dict = dictionary
    @word_start = dict.sample
    @word_end = dict.sample
    while @word_start == @word_end do
	@word_end = dict.sample
    end
  end

  def show
    load "#{Rails.root}/lib/ladder.rb"

#@ar=Array.new
#@ar=params.each {|key, val| @ar=@ar+val}    
    
    @ladder = Array.new
    @ladder = params[:word_first],params[:word_one],params[:word_two],params[:word_three],params[:word_four],params[:word_five],params[:word_last] 
    @ladder.delete_if {|word| word == ""}
    @ladder
    @result = legal @ladder
    if @ladder.size < 3
      @result = false
    end
  end

end

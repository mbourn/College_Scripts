# This controller does not have a show function
# since ratings are shown by professor, it does not make sense to
# show a single rating

class RatingsController < ApplicationController
  before_action :set_rating, only: [:edit, :update, :destroy]

  # GET /professors/:professor_id/ratings
  def index
    # index is now all the ratings for a single professor (not all the ratings)
    # the URL will contain the id of the current professor (:professor_id)
    # use the :professor_id parameter to find all the ratings
    @professor = Professor.find params[:professor_id]
    # the has_many function called in app/models/professor.rb created the 
    # function "ratings" which will return an array of all the ratings 
    # with the professor foreign key matching @professor
    @ratings = @professor.ratings
  end

  # GET professors/:professor_id/ratings/new
  # Create a new rating in the context of a Professor object
  # that way the Rating's foreign key (professor_id) will be
  # initialized correctly.
  def new
    # since our the rating new path contains the professor's id
    # we can use params[:professor_id] to get that id
    @professor = Professor.find params[:professor_id]

    # This is similar to Rating.new, BUT it creates the new rating
    # in the context of a Professor object and sets the foreign key
    @rating = @professor.ratings.new
    @rating.user_id = current_user.id
  end

  # GET /ratings/1/edit
  def edit
    # edit routes are not nested (we already know our professor's foreign_key)
  end

  # POST professors:/:professor_id/ratings
  # we need the professor's key in the URL to make sure that someone 
  # isn't trying to hack the id of the new rating's professor
  # rails ensures that the URL has not be tampered with
  def create
    @professor = Professor.find params[:professor_id]
    @rating = @professor.ratings.new(rating_params)
    @rating.user_id = current_user.id

    if @rating.save
      redirect_to professor_url(@professor) , notice: 'Rating was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ratings/1
  # updates don't have to be nested because the professor foreign key is already set
  # and cannot be changed by edit (note that professor_id is not permitted in rating_params())
  def update
    if @rating.update(rating_params)
      redirect_to professor_url(@rating.professor), notice: 'Rating was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ratings/1
  def destroy
    @rating.destroy
    redirect_to professor_url(@rating.professor) , notice: 'Rating was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating).permit(:course, :comment, :rating)
    end
end

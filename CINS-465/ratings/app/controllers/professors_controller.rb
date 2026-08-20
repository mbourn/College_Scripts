class ProfessorsController < ApplicationController
  before_action :set_professor, only: [:show, :edit, :update, :destroy]

  # GET /professors
  def index
    @professors = Professor.all
  end

  # GET /professors/1
  def show
    # Create and empty Rating so we can allow the user to
    # fill it in on the show view
    @rating = @professor.ratings.new
  end

  # GET /professors/new
  def new
    @professor = Professor.new
    # If we created multiple new ratings, they would all
    # show up in the new view
    # The new Rating is put into the Professor's array of Ratings
    # that we can access in the vuew using @professors.ratings
    @professor.ratings.new
  end

  # GET /professors/1/edit
  def edit
  end

  # POST /professors
  def create
    # MAGIC SPOT
    # Since the Professor "has_many" ratings, the new function looks
    # for Ratings parameters in the given parameters.  If it finds
    # them it will also create one (or more) new Rating objects
    @professor = Professor.new(professor_params)

    @professor.ratings.each do|new_rating|
      new_rating.user_id = current_user.id
    end

    if @professor.save
      redirect_to @professor, notice: 'Professor was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /professors/1
  def update
    if @professor.update(professor_params)
      redirect_to @professor, notice: 'Professor was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /professors/1
  def destroy
    @professor.destroy
    redirect_to professors_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_professor
      @professor = Professor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def professor_params
      params.require(:professor).permit(:first, :last, :university, ratings_attributes: [:course, :comment, :rating])
    end
end


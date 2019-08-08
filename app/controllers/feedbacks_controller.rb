class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  # GET /feedbacks
  def index
    handle_pages
    @feedbacks = current_user.admin? ? Feedback.all : Feedback.where(user: current_user)
    @feedbacks = @feedbacks.joins(:user).where("users.phone RLIKE (?)", params[:search].to_s) unless params[:search].blank?
    @feedbacks = @feedbacks.joins(:place).
      where("places.panchayat_id" => params[:panchayat_id]) unless params[:panchayat_id].blank?
    @feedbacks = @feedbacks.where(entity_status_id: params[:status_id]) unless params[:status_id].blank?
    @feedbacks = @feedbacks.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  # GET /feedbacks/1
  def show
    respond_to do |format|
      format.html { render :show }
      format.js { render :show }      
    end
  end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end

  # GET /feedbacks/1/edit
  def edit
  end

  # POST /feedbacks
  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user = current_user

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to feedbacks_path(page: prev_page), notice: 'feedback was successfully created.' }
        format.json { render :show, status: :created, location: @feedback }
      else
        format.html { render :new }
        format.js { render :new }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feedbacks/1
  def update
    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to feedbacks_path(page: prev_page), notice: 'feedback was successfully updated.' }
        format.json { render :show, status: :ok, location: @feedback }
      else
        format.html { render :edit }
        format.js { render :edit }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  def destroy
    @feedback.destroy
    redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def feedback_params
      params.require(:feedback).permit(:place_id, :feedback_type, :department_id, 
        :name, :details, :action_taken, :entity_status_id,:regional_name_value,
          stored_file_whitelist, stored_image_whitelist)
    end
end

class UsersController < ApplicationController
  before_action :admin_only
  before_action :set_user, except: [:index, :new, :suggest]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update    
    redirect_path = params[:redirect_path].present? ? params[:redirect_path] : users_path
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to redirect_path, notice: "user #{@user.name} was successfully updated." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.js { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end    
  end

  def show
  end

  def suggest
    search_text = params[:search].to_s rescue nil
    ppl = []
    unless search_text.blank?
      ppl = User.where("name RLIKE(?)", search_text).limit(10).map{|x| {id: x.id, name: x.name}}
    end
    render json: ppl
  end

  protected
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :age, :email, :phone, :gender, :pincode, :address, :dob, :position_id)
    end
end

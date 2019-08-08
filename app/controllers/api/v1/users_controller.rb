class Api::V1::UsersController < Api::BaseController
  action_set = [:otp, :otp_verify, :reset_password, :create, :sign_in, :positions, :exists]
  skip_before_action :api_auth, only: action_set
  before_action :check_app, only: action_set

  # POST /users
  def create
    status = validate_otp
    handle_invalid_otp and return unless status

    user = User.new(user_params)
    if user.save
      session[:otp].delete(params[:phone])
      user.update_access_token
      render json: {user: user} and return
    else
      render json: {errors: user.errors} and return
    end
  end

  # GET /users/is_complete
  def is_complete
    user_res = current_user.valid?
    cit = current_user.citizen
    cit_res = cit.valid? unless current_user.citizen.blank?
    data = {
      user: user_res,
      user_errors: (current_user.errors unless user_res),
      citizen: cit_res,
      citizen_errors: (cit.errors unless cit_res rescue "NA")
    }
    render json: data
  end

  # PUT /users
  def update
    user = current_user
    if current_user.update(user_params)
      render json: {user: user, citizen: user.citizen} and return
    else
      render json: {errors: user.errors} and return
    end
  end

  # GET /users/exists
  def exists
    if User.find_by(phone: params[:phone]).blank?
      status = 404
    else
      status = 200
    end
    render json: { status: status }, status: status
  end

  # login methods
  # POST /users/otp
  def otp
    render_invalid("Invalid phone number") and return if params[:phone].blank?
    phone = params[:phone]
    send_otp(phone)
    render json: { message: "OTP Sent to #{phone}" }
  end

  # POST /users/otp_verify
  def otp_verify
    status = validate_otp
    handle_invalid_otp and return unless status

    @user = User.where(phone: params[:phone]).first_or_initialize
    if @user.new_record?
      render json: {
        action: "New User",
        form: %w{name age password password_confirmation dob phone position_id gender email pincode address}
      }
    else
      session[:otp].delete(params[:phone])
      @user.update_access_token
      render json: {user: @user}, status: 200 and return
    end
  end

  # GET /users/positions
  def positions
    render json: Position.external.select(:id, :name)
  end

  # POST /users/reset_password
  def reset_password
    status = validate_otp
    handle_invalid_otp and return unless status

    if params[:password].blank?
      render json: {errors: "password is required"} and return 
    end

    @user = User.where(phone: params[:phone]).first
    if @user.present?
      @user.password = params[:password]
      if @user.save
        session[:otp].delete(params[:phone])
        @user.update_access_token
        render json: {user: @user}, status: 200 and return
      else
        render json: {errors: @user.errors}, status: 500 and return
      end
    else
      session[:otp].delete(params[:phone])
      render json: {
        action: "New User",
        form: %w{name age password password_confirmation dob phone position_id gender email pincode address}
      }
    end
  end

  # POST /users/sign_in
  def sign_in
    user = User.find_by(phone: params[:phone])

    if (user.valid_password?(params[:password]) rescue false)
      user.update_access_token
      render json: {user: user}
    else
      render_invalid("Invalid User Phone / password")
    end
  end

  # DELETE /users/sign_out
  def sign_out
    current_user.update_access_token
    render json: { message: "Logged out" }, status: 401
  end

  # GET /users/me
  def me
    user = current_user
    render json: {
      user: user,
      citizen: user.citizen,
      beneficiary_schemes: user.beneficiary_schemes
    }
  end

  private 
    def handle_invalid_otp
      phone = params[:phone] || params[:user][:phone]
      if (session["otp"][phone]["retry"] > 0 rescue false)
        session["otp"][phone]["retry"] -= 1
        render json: {message: "Incorrect OTP or mobile number, retries remaining: #{session["otp"][phone]["retry"]}"}, status: 401
      else
        session["otp"].delete(phone)
        render_invalid("Invalid OTP : Max retries exceeded")
      end
    end

    def validate_otp
      phone = params[:phone] || params[:user][:phone]
      return false if (session["otp"][phone].blank? rescue true) or (phone.blank? rescue true)
      return (session["otp"][phone]["otp"] == params[:otp] rescue false)
    end

    def user_params
      params.require(:user).permit(:name, :age, :email, :phone, :gender, :password, 
        :password_confirmation, :pincode, :address, :dob, :position_id, :place_id)
    end

end

class Api::BaseController < ActionController::API
  include ActionController::MimeResponds

  before_action :api_auth

  respond_to :json

  def check_app
    # only meant for one app
    render json: {}, status: 401 and return unless params[:app_token] == ENV["APP_TOKEN"]
    return true
  end

  def current_user
    valid_user
  end

  def log_to_slack(icon, message)
    Thread.new do
      EventMachine.run do
        http = EventMachine::HttpRequest.new('https://hooks.slack.com/services/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').post :body => {
            channel: "#ramdom", 
            username: "OTP", 
            icon_emoji: icon,
            text: message
          }.to_json

        http.callback {
          EventMachine.stop
        }
      end
    end
  end

  def send_otp(phone)
    otp = '%04d' % rand(0..9999)
    session[:otp] = {"#{phone}" => {otp: otp, retry: 3}}
    EventMachine.run do
      http = EventMachine::HttpRequest.new("http://control.msg91.com/api/sendotp.php?otp_length=4&authkey=273055ACtQTTDeo5cb8bbf2&message=Your verification code is #{otp}&sender=SUNILN&mobile=91#{phone}&otp=#{otp}").post

      http.callback {
        EventMachine.stop
      }
    end
    log_to_slack("calling","Sent message #{otp} to #{phone}")
  end

  def render_invalid(message = "Unauthorized")
    render json: {message: message}, status: 401
  end

  # Common API Methods

  # GET common/departments
  def departments
    render json: Department.all.includes(:regional_name).map{|x| {id: x.id, name: x.rgnl_name}}
  end

  # GET common/places
  def places
    search_text = params[:search].to_s rescue nil
    places = []
    unless search_text.blank?
      places = Place.where("full_name RLIKE(?)", search_text).limit(100).map{|x| {id: x.id, name: x.panch_name}}
    end
    render json: places
  end

  # GET common/status_list
  def status_list
    model = params[:model].constantize
    if (model::VALID_TYPES.respond_to?(:values) rescue false)
      render json: model::VALID_TYPES.values
    else
      render json: []
    end
  end

  def stored_file_whitelist
    {stored_files_attributes: [:document, :document_cache, :remove_document, :desc, :id, :_destroy]}
  end

  def stored_image_whitelist
    {stored_images_attributes: [:image, :image_cache, :remove_image, :desc, :id, :_destroy]}
  end

  protected
    def access_token
      request.headers['access_token'] || params[:access_token]
    end

    def api_auth
      render_invalid("Invalid Access token") and return unless valid_user
    end

    def valid_user
      user = User.find_by(access_token: access_token)
      return (user.access_token_expiry > Time.now rescue false) ? user : false
    end

end

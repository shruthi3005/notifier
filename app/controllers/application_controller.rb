class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :authenticate_user!

  def admin_only
    redirect_to root_path and return unless (current_user.admin? rescue false)
  end

  def prev_page
    session[:last_page]
  end

  def handle_pages
    if session[:last_module] == params[:controller]
      session[:last_page] = params[:page]
    else
      session[:last_module] = params[:controller]
      session[:last_page] = params[:page]
    end
  end
  
  def log_to_slack(icon, message)
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

  def stored_file_whitelist
    {stored_files_attributes: [:document, :document_cache, :remove_document, :desc, :id, :_destroy]}
  end

  def stored_image_whitelist
    {stored_images_attributes: [:image, :image_cache, :remove_image, :desc, :id, :_destroy]}
  end
end

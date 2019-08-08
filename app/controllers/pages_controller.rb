class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:pp, :index]

  def index
  end

  def dashboard
  end

  def pp
  end
end

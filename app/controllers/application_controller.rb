class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def version
    render json: { version: ApplicationHelper::VERSION }
  end
end

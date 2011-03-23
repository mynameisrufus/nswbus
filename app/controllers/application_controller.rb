class ApplicationController < ActionController::Base
  protect_from_forgery

  def index

  end

  def postition
    @postition ||= check_for_postition_params
  end

  def check_for_postition_params
    if params[:latitude].present? && params[:longitude].present?
      Position.new(params[:latitude], params[:longitude])
    else
      nil
    end
  end
end

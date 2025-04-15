require 'csv'
class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_global_categories
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_global_categories
    @states = CSV.read(Rails.root.join('db', 'states.csv')).flatten
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :city, :state, :phone, :adopter, :age, :size, :gender, :specie, :vaccination, :neutered, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :city, :state, :phone, :adopter, :age, :size, :gender, :specie, :vaccination, :neutered, :photo])
  end
end

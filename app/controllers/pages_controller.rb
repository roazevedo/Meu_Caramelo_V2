class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @animals = Animal.all
    #@testimonies = Testimony.order("RANDOM()").limit(10)
    @testimonie = Testimony.all
  end

  def dashboard
    @user = current_user
    @animals = Animal.all
    @adoptions = Adoption.all
    @testimonies = Testimony.all
    @adoption_form = @user.adoption_form || AdoptionForm.new
  end

  def match
  end
end

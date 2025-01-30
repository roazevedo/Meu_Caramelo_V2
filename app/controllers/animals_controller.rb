require 'csv'
class AnimalsController < ApplicationController
  def index
    if params[:search]
      @animals = Animal.where(specie: params[:search])
    else
      @animals = Animal.all
    end

    # if current_user && current_user.adopter?
    # @animals = Animal.all
    # else
    # redirect_to new_animal_path
    # end
  end

  def show
    # if current_user && current_user.adopter?
    @animal = Animal.find(params[:id])
    # else
    # redirect_to new_animal_path
    # end
  end

  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(animal_params)
    @animal.user = current_user
    if @animal.save
      redirect_to @animal
    else
      render 'new'
    end
  end

  def edit
    @animal = Animal.find(params[:id])
  end

  def update
    @animal = Animal.find(params[:id])
    if @animal.update(animal_params)
      redirect_to @animal
    else
      render 'edit'
    end
  end

  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy
    redirect_to root_path
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :age, :size, :gender, :vaccination, :neutered, :story, :city, :specie, :state, :photo)
  end
end

require 'csv'
class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search]
      @animals = Animal.where(specie: params[:search])
    else
      @animals = Animal.all
    end
  end

  def show; end

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

  def edit; end

  def update
    if @animal.update(animal_params)
      redirect_to @animal
    else
      render 'edit'
    end
  end

  def destroy
    @animal.destroy
    redirect_to root_path
  end

  private

  def set_animal
    @animal = Animal.find(params[:id])
  end

  def animal_params
    params.require(:animal).permit(:name, :age, :size, :gender, :vaccination, :neutered, :story, :city, :specie, :state, :photo)
  end
end

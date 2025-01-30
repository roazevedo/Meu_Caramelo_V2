class TestimoniesController < ApplicationController
  before_action :set_adoption, only: [:new, :create]
  before_action :set_testimony, only: [:edit, :update]
  before_action :authenticate_user!

  def new
    @testimony = Testimony.new
  end

  def create
    @adoption = Adoption.find(params[:adoption_id])
    @testimony = @adoption.build_testimony(testimony_params)
    @testimony.adoption = @adoption
    if @testimony.save
      redirect_to dashboard_path(@adoption), notice: 'Testimony was successfully created.'
    else
      render :new, status: :unprocessable_entity, notice: 'Unable to create testimony.'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def testimony_params
    params.require(:testimony).permit(:content)
  end

  def set_testimony
    @testimony = Testimony.find(params[:id])
  end

  def set_adoption
    @adoption = Adoption.find(params[:adoption_id])
  end
end

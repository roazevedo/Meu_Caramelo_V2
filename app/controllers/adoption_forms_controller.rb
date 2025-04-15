class AdoptionFormsController < ApplicationController
  def index
    @adoption_forms = AdoptionForm.all
  end

  def show
    @adoption_form = AdoptionForm.find(params[:id])
  end


  def new
    session[:target_animal_id] = params[:target_animal_id] if params[:target_animal_id]
    @adoption_form = AdoptionForm.new
  end

  def create
    @adoption_form = AdoptionForm.new(adoption_form_params)
    @adoption_form.user = current_user
    if @adoption_form.save
      if session[:target_animal_id]
        animal_id = session[:target_animal_id]
        session.delete(:target_animal_id)
        redirect_to new_animal_adoption_path({ animal_id: })
      else
        redirect_to matchs_path(current_user)
      end
    else
      flash.now[:alert] = 'There was a problem creating the Adoption Form.'
      @errors = @adoption_form.errors.full_messages
      render 'new'
    end
  end

  def edit
    @adoption_form = current_user.adoption_form
  end

  def update
    @adoption_form = current_user.adoption_form
    if @adoption_form.update(adoption_form_params)
      redirect_to dashboard_path
    else
      flash.now[:alert] = 'There was a problem updating the Adoption Form.'
      @errors = @adoption_form.errors.full_messages
      render 'edit'
    end
  end

  private

  def adoption_form_params
    params.require(:adoption_form).permit(:query, :user_id, :pergunta1, :pregunta2, :pergunta3, :pergunta4, :pergunta5,
    :pergunta6, :pergunta7, :pergunta8)
  end
end

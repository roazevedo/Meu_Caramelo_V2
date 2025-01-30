class AdoptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_adoption, only: [:show, :edit, :update, :done, :update_status, :done]
  before_action :set_animal, only: [ :new, :create,:show]

  def my_applications
    @adoption = Adoption.where('user_id = ? AND animal_id IN (?)', current_user.id, current_user.animals.pluck(:id))
  end

  def show
    # user_id = current_user.id
    @user = current_user
    @adopter_adoptions = Adoption.where(user_id: @user)
    @owner_adoptions = Adoption.where(animal_id: @animal)

    # pro adoption form
    @adoption = Adoption.find(params[:id])
    @adoption_form = @adoption.user.adoption_form || AdoptionForm.new


    # Combine a adoção do adopter e do owner em uma única coleção
    @adoptions = @adopter_adoptions.or(@owner_adoptions)


    #match no show de adoption
    @match_data = match(@adoption.user,  @animal)
      # if match_data && match_data[:score] > 0
      #   @matches << { animal: animal, match_data: match_data }
      # end
  end

  def new
    @adoption = Adoption.new
  end

  def create
    @adoption = Adoption.new(adoption_params)
    @adoption.user = current_user # Atribuindo o usuário logado ao contrato
    @adoption.animal = @animal # Atribuindo o animal à adoção
    @adoption.status = 'Pendente' # Definindo o status de aceitação da adoção
    @adoption.done = false # Definindo o status de conclusão do contrato
    @adoption_created = true

    if @adoption.save
      redirect_to adoption_path(@adoption), notice: 'Adoção criada com sucesso!'
    else
      render :new, status: :unprocessable_entity, notice: 'Não foi possível criar a adoção.'
    end
  end

  def update_status
    @adoption.status = params[:status]

    if @adoption.save
      redirect_to dashboard_path(@adoption)
    else
      redirect_to user_animal_adoption_path(adoption.animal.id)
    end
  end

  def edit
    render :show
  end

  def update
    @adoption = Adoption.find(params[:id])
    new_status = params[:status] # 'accept' ou 'reject'

    if current_user.id == @adoption.animal.user_id # Verifica se o usuário logado é o dono do animal
      if @adoption.update(status: new_status)
        redirect_to dashboard_path(@adoption), notice: 'Adoption updated successfully.'
      else
        render :edit
      end
    else
      redirect_to dashboard_path(@adoption), notice: 'You are not permitted to change this agreement.'
    end
  end

  # Ação personalizada para marcar a adoção como concluída
  def done
    @adoption.done = true
    if @adoption.save
      redirect_to dashboard_path(@adoption)
    else
      redirect_to user_animal_adoption_path(adoption.animal.id)
    end
  end


  private

  def match(user,  animal)

    if user.specie == animal.specie
      match_data = {
        size_match: user.size == animal.size,
        specie_match: user.specie == animal.specie,
        gender_match: user.gender == animal.gender,
        age_match: user.age == animal.age,
        vaccination_match: user.vaccination == animal.vaccination,
        neutered_match: user.neutered == animal.neutered
      }
      match_data[:score] = match_data.values.count(true)
    end
    match_data

  end

  def adoption_params
    params.require(:adoption).permit(:user_id, :animal_id, :date, :status, :done)
  end

  def set_animal
    animal_id = params[:animal_id] || @adoption&.animal_id
    @animal = Animal.find(animal_id)
  end

  def set_adoption
    @adoption = Adoption.find(params[:id])
  end
end

class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :new


  def show
    @user = User.find(params[:id])
    @adoption = Adoption.find_by(user_id: @user.id)

    @adoption_form = @user.adoption_form || AdoptionForm.new
  end

  def new
    if params[:adopter] == "true"
      @user = User.new(adopter: true)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    @user.adopter = true if params[:user][:adopter] == "true"
    # If the user is saved successfully, redirect to the user's show page

    # if @user.save
    #   if @user.adopter == true
    #     redirect_to matchs_path(current_user)
    #   else
    #     redirect_to root_path
    #   end
    # else
    #   # If the user isn't saved successfully, re-render the form so the user can fix the problems
    #   flash.now[:alert] = 'Tivemos um problema ao criar o usuário.'
    #   @errors = @user.errors.full_messages
    #   render 'new'
    # end
  end


  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to dashboard_path
    else
      flash.now[:alert] = 'Tivemos um problema ao editar o usuário.'
      @errors = @user.errors.full_messages
      render 'edit'
    end

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :city, :state, :phone,
                                 :age, :size, :gender, :vaccination, :neutered, :specie, :adopter, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :photo)
  end
end

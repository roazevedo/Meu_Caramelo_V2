class RegistrationsController < Devise::RegistrationsController
  def new
    if params[:adopter] == "true"
      @user = User.new(adopter: true)
    else
      @user = User.new
    end
  end

  protected

  # def sign_up_params
  #   params.require(:user).permit(:email, :password, :password_confirmation, :photo)
  # end

  def after_sign_up_path_for(resource)
    # Aqui você pode definir para onde o usuário será redirecionado após o registro
    # Por exemplo, você pode redirecioná-lo para a página de perfil do usuário:
    @user = User.find_by(id: current_user)
    if @user.adopter == true
      match_path
    else
      dashboard_path
    end
  end
end

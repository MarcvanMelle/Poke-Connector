class Api::V1::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    user = User.new(sign_up_params)
    if user.save
      bcrypt = BCrypt::Password.new(user.encrypted_password)
      password = BCrypt::Engine.hash_secret("#{params[:user][:password]}#{user.class.pepper}", bcrypt.salt)
      if Devise.secure_compare(password, user.encrypted_password)
        sign_in(:user, user)
        render json: { path: "/" }
      end
    else
      render json: { errors: user.errors.full_messages.join(', ') }
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def sign_up_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation, :friend_code)
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:username, :first_name, :last_name, :admin, :friend_code])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

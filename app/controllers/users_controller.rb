class UsersController < ApplicationController
  before_action :set_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, notice: 'Пользователь успешно зарегестрирован!'
      session[:user_id] = @user.id
    else
      render 'new'
    end
  end

  def edit
  end

  def update
      if @user.update(user_params)
        redirect_to user_path(@user), notice: 'Пользователь успешно редактирован!'
      else
        render 'edit'
      end
  end

  def show
   @questions = @user.questions.order(created_at: :desc)

   @new_question = @user.questions.build
  end

  def destroy
      @user.destroy
      redirect_to root_path, notice: 'Пользователь удалён.'
  end

  private

    def authorize_user
      reject_user unless @user == current_user
    end

    def set_user
      @user ||= User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :username, :email, :avatar_url, :password, :password_confirmation, :color)
    end
end

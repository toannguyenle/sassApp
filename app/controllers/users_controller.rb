class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
# make sure only admind at index action to show all
  before_action :make_sure_admin, only: [:index]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    # SO the sign up link doesn t show when not needed
    @is_signup = true
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    user = User.new(params.require(:user).permit(:email, :password, :password_confirmation))
    if user.save
      # the moment you sign up it logs  you in
      session[:user_id] = user.id
      redirect_to users_path
    else
      redirect_to new_user_path
    end
  end
  # def create
  #   @user = User.new(user_params)

  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to @user, notice: 'User was successfully created.' }
  #       format.json { render action: 'show', status: :created, location: @user }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    u = User.where(id:params[:id]).first
    # IF logged in person than log them out
    if u.id === current_user.id
    reset_session
    end
    # perform destroy
    u.destroy
    redirect_to new_user_path

  end

  private
    def make_sure_admin
      # if not log in and not user
      if !current_user || !current_user.is_admin
        redirect_to paintings_path
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end

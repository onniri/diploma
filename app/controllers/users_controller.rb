class UsersController < ApplicationController
  # TODO: administrative restrictions!
  include SessionsHelper
  before_filter :check_auth, :only => [:update, :edit]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success]= "You've registered successfully"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
    unless params[:search_request].nil?
      main_query = (params[:search_request].length>1)?ActiveRecord::Base.sanitize(params[:search_request]):nil
    else
      main_query=nil
    end

    if main_query.nil?
      @users = User.all.page(params[:page]).per_page(3)
    else
      @users = User.name_search(main_query).page(params[:page]).per_page(3)
    end
  end

  def show
    @user = User.find(params[:id])
    @interests_want = Interest.joins(:user_interests).where('user_interests.is_consumer'=>true).where('user_interests.user_id'=>@user.id).group('interests.id')
    @interests_can = Interest.joins(:user_interests).where('user_interests.is_consumer'=>false).where('user_interests.user_id'=>@user.id).group('interests.id')
    @groups = @user.groups
  end
  def edit
    @user = @current_user
  end

  def update
    @user = User.find(params[:id])
    if params[:delete_avatar]
      @user.avatar=nil
      @user.save
    end
    if @user.update_attributes(user_params)
      begin
        @user.birth_date=Date.parse(user_params[:birth_date])
      rescue
        Rails.logger.debug("#{controller_name}: user #{@user.id} no :birth_date")
      end

      # AR updated what it knows about, now custumization...
      flash[:success] = "Profile updated successfully"
    else
      flash[:error] = "Something goes wrong, we'll fix it in a moment"
    end
    redirect_to :back
  end
  private
  def user_params
    params.require(:user).permit(
    :first_name,
    :last_name,
    :email,
    :password,
    :password_confirmation,
    :location_id,
    :iso_2letters,
    :skype,
    :jabber,
    :email_public,
    :avatar,
    :birth_date,
    :is_age_visible,
    :description
    )
  end
end

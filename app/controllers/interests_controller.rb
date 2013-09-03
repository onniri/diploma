class InterestsController < ApplicationController
  include SessionsHelper
  before_filter :check_auth
  before_filter :check_admin, :only => [:destroy]
  def new
    @interest = Interest.new
    @interest.user_interests << UserInterest.new
    @interest.user_interests.first.user=current_user
    @interest.user_interests.first.is_consumer=params[:can].nil?
  end

  def index
    unless params[:search_request].nil?
      main_query = (params[:search_request].length>2)?ActiveRecord::Base.sanitize(params[:search_request]):nil
    else
      main_query=nil
    end

    if main_query.nil?
      @interests_want = Interest.joins(:user_interests).where('user_interests.is_consumer'=>true).group('interests.id').limit(5)
      @interests_can = Interest.joins(:user_interests).where('user_interests.is_consumer'=>false).group('interests.id').limit(5)
    else
      @interests_want = Interest.interest_search(main_query).joins(:user_interests).where('user_interests.is_consumer'=>true).group('interests.id').limit(5)
      @interests_can = Interest.interest_search(main_query).joins(:user_interests).where('user_interests.is_consumer'=>false).group('interests.id').limit(5)
    end
  end
  def completion_index
    #TODO: complete this in client side
    query = (params[:query].nil?)?'':ActiveRecord::Base.connection.quote(params[:query]+'%')
    @interests = nil
    @interests = Interest.select(:id,:title,:description).where("title LIKE #{query}") if query.length > 3
    render :json => @interests
  end
  def dont_want
    interest = Interest.find(params[:interest_id])
    current_user.user_interests.where(:interest_id=>interest.id).destroy_all
    redirect_to interest_path(interest)
  end
  def cannot
    interest = Interest.find(params[:interest_id])
    current_user.user_interests.where(:interest_id=>interest.id).destroy_all
    redirect_to interest_path(interest)
  end
  def create
    db_tags = [];
    unless params[:tags].nil?
      tags = params[:tags].split(' ')
      tags.each { |tag|
        db_tags<<(Tag.where(:tag => tag).first)
      }
      new_tags=[];
      db_tags.each { |tag|
        tags.delete(tag.tag) unless tag.nil?
      }
      tags.each { |tag|
        dtag = Tag.new
        dtag.tag=tag
        dtag.save
        db_tags<<dtag
      }
    end
    db_tags=db_tags.compact
    Rails.logger.debug(db_tags)
    #@interest = Interest.find_or_initialize_by(interest_params[:id])
    id = (interest_params[:id].nil?)?-1:interest_params[:id]
    @interest = Interest.where(:id=>id).first
    if @interest.nil?
      @interest = Interest.new
    end
    @interest.update_attributes(interest_params)
    # custom attributes :-) few lines down...
    @interest.save
    current_user.interests<<@interest
    ui=@interest.user_interests.where(:interest_id => @interest.id).first
    ui.is_consumer=(params[:want_can]=='want')
    ui.save
    db_tags.each { |tag| tag.interests<<@interest }
    redirect_to interests_path
  end

  def want
    interest = Interest.find(params[:interest_id])
    current_user.interests<<interest
    ui=current_user.user_interests.where(:interest_id => interest.id).first
    ui.is_consumer=true
    ui.save
    redirect_to interest_path(interest)
  end

  def can
    interest = Interest.find(params[:interest_id])
    current_user.interests<<interest
    ui=current_user.user_interests.where(:interest_id => interest.id).first
    ui.is_consumer=false
    ui.save
    redirect_to interest_path(interest)
  end

  def edit
  end

  def update
  end

  def destroy
    interest = Interest.find(params[:id])
    interest.destroy
    redirect_to :back
  end

  def show
    @interest = Interest.find(params[:id])
    @users_want = User.joins(:user_interests)
                  .where('user_interests.is_consumer'=>true)
                  .where('user_interests.interest_id'=>@interest.id)
    @users_can = User.joins(:user_interests)
                  .where('user_interests.is_consumer'=>false)
                  .where('user_interests.interest_id'=>@interest.id)
    @current_user_want = (current_user.user_interests.where(:interest_id => @interest.id, :is_consumer=>true).count>0)?true:false
  end
  private
  def interest_params
    params.require(:interest).permit(:title,:description,:want,:can,:id)
  end
end

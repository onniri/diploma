class GroupsController < ApplicationController
#TODO: limits, user leave logic, administration
  include SessionsHelper
  before_filter :check_auth, :only => [:update, :edit, :new, :delete]
  def group_users

  end
  def user_groups

  end
  def show
    @group = Group.find(params[:id])
  end

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
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
    @group = Group.new(group_params)
    @group.creator_user_id = current_user.id
    @group.users << current_user
    @group.groups_users.first.is_admin=true
    @group.groups_users.first.is_moderator=true
    db_tags.each { |tag| tag.groups<<@group }
    if @group.save
      redirect_to group_path(@group)
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    redirect_to groups_path
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:success] = 'Group info successfully updated'
      redirect_to :back
    end
  end
  def leave
    @group = Group.find(params[:group_id])
    if @group.groups_users.where(:user_id=>current_user.id).first.destroy
      flash[:success]='Exited group'
    end
    redirect_to group_path(@group)
  end
  def join
    @group = Group.find(params[:group_id])
    gu = @group.groups_users.new
    gu.user=current_user
    gu.group=@group
    if gu.save
      flash[:success]='Joined group'
    end
    redirect_to group_path(@group)
  end
  private
  def group_params
    params.require(:group).permit(:description, :motd, :name, :public)
  end
end

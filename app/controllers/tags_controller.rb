class TagsController < ApplicationController
  def index
    unless params[:search_request].nil?
      main_query = (params[:search_request].length>2)?ActiveRecord::Base.sanitize(params[:search_request]):nil
    else
      main_query=nil
    end

    if main_query.nil?
      @tags = Tag.all.limit(50)
    else
      @tags.where("tags.tag LIKE #{main_query}%")
    end
  end
  def show
    @tag = Tag.find(params[:id])
    @interests = @tag.interests
    @groups = @tag.groups
  end
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to tags_path
  end
end

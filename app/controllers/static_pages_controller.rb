class StaticPagesController < ApplicationController
  def help
  end

  def about
  end

  def welcome
    @interests_want = Interest.joins(:user_interests).where('user_interests.is_consumer'=>true).group('interests.id').limit(2)
    @interests_can = Interest.joins(:user_interests).where('user_interests.is_consumer'=>false).group('interests.id').limit(2)
  end
end

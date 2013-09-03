require 'spec_helper'

describe WallsController do

  describe "GET 'new_message'" do
    it "returns http success" do
      get 'new_message'
      response.should be_success
    end
  end

end

require 'spec_helper'

describe LocationsController do

  describe "GET 'list_countries'" do
    it "returns http success" do
      get 'list_countries'
      response.should be_success
    end
  end

  describe "GET 'list_cities'" do
    it "returns http success" do
      get 'list_cities'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

end

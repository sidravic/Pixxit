require 'spec_helper'

describe ImagesController do

  describe "GET 'destroy'" do
    it "should be successful" do
      get 'destroy'
      response.should be_success
    end
  end

end

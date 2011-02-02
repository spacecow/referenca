require 'spec_helper'

describe MembershipsController do

  describe "GET 'invite'" do
    it "should be successful" do
      get 'invite'
      response.should be_success
    end
  end

end

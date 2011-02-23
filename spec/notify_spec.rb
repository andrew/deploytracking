require 'spec_helper'
describe DeployTracking do
  describe "notify" do
    before(:each) do
      FakeWeb.register_uri(:any, "https://deploytracking.heroku.com/deploys", :body => "response for any HTTP method")
    end
    it "should post to deploytracking.com" do
      DeployTracking.notify('api_key', {}).should be_true
    end
  end
end
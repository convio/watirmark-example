require 'spec_helper'

describe "Logging in to a salesforce org" do

  before :all do
    @login = Salesforce::Login.new(Salesforce::LoginModel.new)
  end

  specify "I can login with my crentials at the login screen" do
    @login.login
  end

end
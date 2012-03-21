require 'spec_helper'

describe "Logging in to a salesforce org" do

  before :all do
    @login = Salesforce::Login.new(Salesforce::LoginModel.new)

    @model = Salesforce::LeadModel.new
    @model[:first_name] = "Cozmo"
    @model[:last_name] = "Kramer"
    @model[:company] = "Kramerica Industries"

    @lead = Salesforce::Lead.new(@model)
  end

  specify "Login to Salesforce" do
    @login.login
  end

  specify "I can create a lead" do
    @lead.create
  end

  specify "I can get a lead that already exists" do
    @lead.get
  end

  specify "I can edit a lead" do
    @lead.rasta[:company] = "Vandelay Industries"
    @lead.edit
  end

  specify "I can verify a lead" do
    @lead.rasta[:company] = "Vandelay Industries"
    @lead.verify
  end

  specify "I can delete a lead" do
    @lead.rasta[:company] = "Vandelay Industries"
    @lead.delete
  end

end
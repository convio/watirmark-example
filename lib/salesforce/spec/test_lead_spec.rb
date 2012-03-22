require 'spec_helper'

describe "Automating the Lead Object" do

  before :all do
    Login.new(LoginModel.new).login
  end

  before :each do
    @model = LeadModel.new
    @model.first_name = "Cozmo"
    @model.last_name = "Kramer"
    @model.company = "Kramerica Industries"
  end

  it "can be created" do
    Lead.new(@model).create
  end

  it "can be edited" do
    @model.phone = "867-5309"
    Lead.new(@model).edit
  end

  it "can verify the model against the page" do
    @model.phone = "867-5309"
    Lead.new(@model).verify
  end

  it "give meaningful errors when it fails" do
    @model.phone = "999-8888"
    lambda {Lead.new(@model).verify}.should raise_error(Watirmark::VerificationException)
  end

  it "can be deleted" do
    Lead.new(@model).delete
  end

end
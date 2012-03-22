require 'spec_helper'

describe "Automating the Contact Object" do

  before :all do
    Login.new(LoginModel.new).login
  end

  before :each do
    @model = ContactModel.new
    @model.first_name = "Cozmo"
    @model.last_name = "Kramer"
    @model.account_name = "Kramerica Industries"
  end

  it "can be created" do
    Contact.new(@model).create
  end

  it "can be edited" do
    @model.phone = "867-5309"
    Contact.new(@model).edit
  end

  it "can verify the model against the page" do
    @model.phone = "867-5309"
    Contact.new(@model).verify
  end

  it "gives meaningful errors when it fails" do
    @model.phone = "999-8888"
    lambda {Contact.new(@model).verify}.should raise_error(Watirmark::VerificationException)
  end

  it "can be deleted" do
    Contact.new(@model).delete
  end

end


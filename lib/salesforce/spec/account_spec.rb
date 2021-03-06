require 'spec_helper'

describe "Automating the Account Object" do

  before :all do
    Login.new(LoginModel.new).login
  end

  before :each do
    @model = AccountModel.new(:account_name => "Kramerica Industries")
  end

  it "can be created" do
    Account.new(@model).create
    Account.new(@model).verify
  end

  it "can be edited" do
    @model.phone = "867-5309"
    Account.new(@model).edit
    Account.new(@model).verify
  end

  it "gives meaningful errors when it fails" do
    @model.phone = "123-4567"
    lambda {Account.new(@model).verify}.should raise_error(Watirmark::VerificationException)
  end

  it "can be deleted" do
    Account.new(@model).delete
  end

end
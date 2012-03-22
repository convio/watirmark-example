require 'spec_helper'

describe "Converting a Lead to a Contact" do

  before :all do
    Login.new(LoginModel.new).login
  end

  before :each do
    @lead_model = LeadModel.new({
      :first_name => "Jim",
      :last_name => "Boone",
      :company => "Jim Corp"
    })

    @contact_model = ContactModel.new({
      :first_name => "Jim",
      :last_name => "Boone",
      :account_name => "Jim Corp",
      :email => "foobar@nullmail.com",
      :phone => "123-456-7890",
    })

    @account_model = AccountModel.new({
      :account_name => "Jim Corp",
      :phone => "123-456-7890"
    })
  end

  specify "I create a lead" do
    Lead.new(@lead_model).create
  end

  specify "I click the convert button" do
    Lead.new(@lead_model).convert
  end

  specify "The lead is turned into a contact" do
    Contact.new(@contact_model).verify
  end

  specify "The lead's company is turned into an account" do
    Account.new(@account_model).verify
  end

end

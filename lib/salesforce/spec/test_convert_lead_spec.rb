require 'spec_helper'

describe "Converting a Lead to a Contact" do

  before :all do
    Login.new(LoginModel.new).login
  end

  before :each do
    @lead_model = LeadModel.new({
      :first_name => "Foo",
      :last_name => "Bar",
      :company => "Foo Bar Inc"
    })

    @contact_model = ContactModel.new({
      :first_name => "Foo",
      :last_name => "Bar",
      :account_name => "Foo Bar Inc"
    })

    @account_model = AccountModel.new({
      :account_name => "Foo Bar Inc"
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

require 'spec_helper'

describe "Automating the Account Object" do

  before :all do
    @model = AccountModel.new
    @model[:account_name] = "Kramerica Industries"

    @account = Account.new(@model)

    Login.new(LoginModel.new).login
  end

  it "obeys all of the basic CRUD operations" do
    @account.create
    @account.get
    @account.rasta[:phone] = "867-5309"
    @account.edit
    @account.verify
    @account.delete
  end

end
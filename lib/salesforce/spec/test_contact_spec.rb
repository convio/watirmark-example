require 'spec_helper'

describe "Automating the Contact Object" do

  before :all do
    @model = ContactModel.new
    @model[:first_name] = "Cozmo"
    @model[:last_name] = "Kramer"
    @model[:account_name] = "Kramerica Industries"

    @contact = Contact.new(@model)

    Login.new(LoginModel.new).login
  end

  it "obeys all of the basic CRUD operations" do
    @contact.create
    @contact.get
    @contact.rasta[:phone] = "867-5309"
    @contact.edit
    @contact.verify
    @contact.delete
  end

end
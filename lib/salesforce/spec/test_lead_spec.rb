require 'spec_helper'

describe "Automating the Lead Object" do

  before :all do
    @model = LeadModel.new
    @model[:first_name] = "Cozmo"
    @model[:last_name] = "Kramer"
    @model[:company] = "Kramerica Industries"

    @lead = Lead.new(@model)

    Login.new(LoginModel.new).login
  end

  it "obeys all of the basic CRUD operations" do
    @lead.create
    @lead.get
    @lead.rasta[:company] = "Vandelay Industries" #TODO:change rasta to model
    @lead.edit
    @lead.verify
    @lead.delete
  end

end
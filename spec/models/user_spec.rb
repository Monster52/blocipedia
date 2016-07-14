require 'rails_helper'

RSpec.describe User, type: :model do

  describe "attributes" do
    it { should have_db_column(:username).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:encrypted_password).of_type(:string) }
    it { should have_db_column(:role).of_type(:integer) }
  end

  describe "associations" do
    it { should have_many(:wikis).dependent(:destroy) }
    it { should have_many(:collaborations).dependent(:destroy) }
    it { should have_many(:shared_wikis) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_least(3) }
  end

end

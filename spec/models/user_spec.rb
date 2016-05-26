require 'rails_helper'

RSpec.describe User, type: :model do

  describe "attributes" do
    it { should have_db_column(:username).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:encrypted_password).of_type(:string) }
  end
end

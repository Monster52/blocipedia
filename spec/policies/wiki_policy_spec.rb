require 'rails_helper'
require 'devise'

describe WikiPolicy do
  subject { WikiPolicy.new(user, wiki) }

  let(:wiki) { create(:wiki) }

  context "guest user" do
    let(:user) { nil }

    it { should forbid_action(:show) }
    it { should forbid_edit_and_update_actions }
    it { should forbid_new_and_create_actions }
    it { should forbid_action(:destroy) }
  end

  context "standard user" do
    let(:user) { create(:user, role: 'standard') }

    it { should permit_action(:show) }
    it { should permit_edit_and_update_actions }
    it { should permit_new_and_create_actions }
    it { should forbid_action(:destroy) }
  end

  context "premium user" do
    let(:user) { create(:user, role: 'premium') }

    it { should permit_action(:show) }
    it { should permit_edit_and_update_actions }
    it { should permit_new_and_create_actions }
    it { should forbid_action(:destroy) }
  end

  context "admin user" do
    let(:user) { create(:user, role: 'admin') }

    it { should permit_action(:show) }
    it { should permit_edit_and_update_actions }
    it { should permit_new_and_create_actions }
    it { should permit_action(:destroy) }
  end
end

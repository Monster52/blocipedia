class UsersController < ApplicationController

  def downgrade
    current_user.update_attribute(:role, 'standard')
    redirect_to edit_user_registration_path
    flash[:notice] = "You now have a Standard Membership."
  end

end

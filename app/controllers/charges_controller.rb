require 'stripe'
class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Membership - #{current_user.email}",
    }
  end

  def create
    @amount = 1500
    customer = Stripe::Customer.create(
      plan: 1,
      email: current_user.email,
      card: params[:stripeToken]
    )

    current_user.update_attribute(:role, 'premium')

    flash[:notice] = "Thank you for you purchase #{current_user.username}, you are now a Premium member!"
    redirect_to wikis_path

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def cancel
    subscription = Stripe::Subscription.retrieve("sub_8Xw6Ak8Gc4EvJx")
    subscription.delete(at_period_end: true)

    current_user.update_attribute(:role, 'standard')
    current_user.wikis.where(private: true).update_all(private: false)


    flash[:notice] = "You are now a Standard Member."
    redirect_to wikis_path
  end
end

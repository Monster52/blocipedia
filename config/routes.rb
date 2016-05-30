Rails.application.routes.draw do
  devise_for :users
  resources :wikis
  resources :charges, only: [:new, :create]
  put 'cancel', to: 'charges#cancel'

  root 'welcome#index'
  get 'about', to: 'welcome#about'
  put 'downgrade', to: 'users#downgrade'
end

#<%= link_to edit_user_registration_path do %>
#  <%= content_tag :span, "Standard", class: "btn btn-warning" %>
#  <% current_user.update_attribute(:role, 'standard') %>
#<% end %>

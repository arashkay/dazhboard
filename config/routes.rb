Rails.application.routes.draw do

  root 'general#index'
  get :payment, to: 'general#payment'

end

Rails.application.routes.draw do
  root 'incidents#index'

  resources :incidents, only: [:index, :show]

  post 'lists', to: 'incidents#lists'
  get 'lists', to: 'incidents#lists'

  post 'open_incidents', to: 'incidents#open_incidents'
  get 'open_incidents', to: 'incidents#open_incidents'

  post 'resolved_incidents', to: 'incidents#resolved_incidents'
  get 'resolved_incidents', to: 'incidents#resolved_incidents'

  
  post '/slack_commands/declare', to: 'slack_commands#declare'
  post '/slack_commands/resolve', to: 'slack_commands#resolve'
  post '/slack_commands/open_ticket', to: 'slack_commands#open_ticket'
  post '/slack_commands/latest_incidents', to: 'slack_commands#latest_incidents'
end
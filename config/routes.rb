Rails.application.routes.draw do
  devise_for :users do 
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  root 'supplies#index'

  resources :incidents, only: [:index, :show]

  
  get 'scan', to: 'supplies#scan'
  post 'get_barcode', to: 'supplies#get_barcode'

  get 'settings', to: 'supplies#departments'
  post 'departments', to: 'supplies#create_department'

  get 'department/:id', to: 'supplies#show_department'
  post 'department/:id', to: 'supplies#edit_department'

  get 'user/:id', to: 'supplies#show_user'
  post 'user/:id', to: 'supplies#edit_user'
  post 'user', to: 'supplies#create_user'

  get '/export', to: 'supplies#export'

  get 'set_new', to: 'supplies#quantity_choose'
  get 'new', to: 'supplies#new'
  post 'new', to: 'supplies#create'
  get 'medical_supplies', to: 'supplies#show_medical_supplies'
  get 'medical_supplies/critical', to: 'supplies#critical_medical_supplies'

  get 'export_reports', to: 'supplies#export_reports'

  get '/supply/:id', to: 'supplies#edit'
  
  get 'medicines', to: 'supplies#show_medicines'
  get 'medicines/critical', to: 'supplies#critical_medicines'

  post '/supply/:id', to: 'supplies#update'

  post 'supply', to: 'supplies#mark_as_done'

  get 'daily_report', to: 'supplies#daily_report'
  get 'daily_report_medicine', to: 'supplies#daily_report_medicine'
  get 'daily_report_medical_supply', to: 'supplies#daily_report_medical_supply'

  post 'daily_report', to: 'supplies#daily_report'
  post 'daily_report_medicine', to: 'supplies#daily_report_medicine'
  post 'daily_report_medical_supply', to: 'supplies#daily_report_medical_supply'

  get 'dispense', to: 'supplies#dispense'
  get 'dispense/:id', to: 'supplies#dispense_show'
  post 'dispense/:id', to: 'supplies#dispense_supply'

  get 'restock', to: 'supplies#restock'
  get 'restock/:id', to: 'supplies#restock_show'
  post 'restock/:id', to: 'supplies#restock_supply'

  post 'resolved_incidents', to: 'incidents#resolved_incidents'
  get 'resolved_incidents', to: 'incidents#resolved_incidents'
end
Rails.application.routes.draw do
  resources :favorite_ads, only: [:create, :destroy]

  get 'painel', to: 'site/profile#index', as: "perfil"
  
  get 'sobre', to: 'site/pages#about', as: "sobre"
  get 'como-funciona', to: 'site/pages#faq', as: "faq"
  get 'planos', to: 'site/pages#plans', as: "planos"
  get 'fale-conosco', to: 'site/pages#contact', as: "contato"
  
  get 'anuncio/:id', to: 'site/pages#viewads', as: "ver-anuncio"
  get 'categorias/(:id)', to: 'site/pages#viewcategories', as: "ver-categorias"
  post 'webhook', to: 'webhook#status', as: "webhook"

  scope :painel do
    get 'encerrar', to: 'site/profile#terminate'
    get 'assinatura/cancelar', to: 'site/profile#subscription_cancel'
    get 'planos/mudar', to: 'site/profile#change_plan', as: "change_plan"
    get 'checkout', to: 'site/profile#checkout', as: "checkout"
    get 'planos/mudar/checkout', to: 'site/profile#plan_checkout', as: "plan_checkout"
    get 'resultado', to: 'site/profile#resultpay', as: "resultpay"
    post 'checkout/pay', to: 'site/profile#pay', as: "payment"
    scope(:path_names => { :new => "novo", :edit => "editar", :index => 'lista' }) do
      resources :anuncios, :as => 'site_ads', :controller => 'site/ads' do
        get 'pendentes', on: :collection, to: 'site/ads#pending'
        get 'salvos', on: :collection, to: 'site/ads#favorites'
        patch 'destaque', on: :member, to: 'site/ads#change_featured'
        patch 'status', on: :member, to: 'site/ads#change_status'
          # member do
          #   patch :change_featured
          # end
        resources :images, only: [:create, :destroy]
      end   
    end 
  end 

  
  namespace :administrator do
  	root 'dashboard#index'
  end

  devise_for :admins
  devise_for :users
 
  root 'site/pages#index'

  get '/busca_cep/:id', to: 'services#busca_cep', as: 'buscacep'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/iugi', to: 'services#iugu', as: 'iugi'

  #mailler routes
  post 'sendads', to: 'site/pages#sendmessage', as: 'messageads'
  post 'sendreport', to: 'site/pages#sendreport', as: 'reportads'
end

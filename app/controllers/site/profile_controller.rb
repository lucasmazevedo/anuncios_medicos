class Site::ProfileController < ApplicationController
  before_action :authenticate_user!
  def index
    @plans = Plan.all
  	@categories = Category.all
  	@ads = Ad.all
  end

  def terminate
  end	

  def myads
  	@ads = current_user.ads.where(status: true)
  end

  def pendingads
  	@ads = current_user.ads.where(status: false)
  end	

  def saved

    @ads = current_user.ads
    @savedads = current_user.favorite_ads
  end

  # GET /ads/new
  def new
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
  end

  def checkout
    if !current_user.subscription.active
      @plan = Plan.find(params[:plan])
    else
      redirect_to perfil_path, flash: { error: "Você já possui assinatura!"}
    end 
  end 

  def plan_checkout
    @plan = Plan.find(params[:plan])
    subscription = Iugu::Subscription.fetch(current_user.subscription.subscription_id)
    subscription.change_plan @plan.identifier

    redirect_to perfil_path, flash: { success: "Plano Alterado com Sucesso! Em Breve será atualizado na sua conta!"}
  end 

  # POST /ads
  # POST /ads.json
  def create
    @ad = Ad.new(ad_params)

    respond_to do |format|
      if @ad.save
        format.html { redirect_to @ad, notice: 'Ad was successfully created.' }
        format.json { render :show, status: :created, location: @ad }
      else
        format.html { render :new }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  def pay
    
    param = (params[:token].empty? ? "method" : "token").to_sym

    customer = Iugu::Customer.fetch(current_user.customer_id)
    
    customer.payment_methods.create({
        description: "Cartão de Crédito",
        token: params[:token],
        set_as_default: true
      })

    
    charge = Iugu::Subscription.create({
      plan_identifier: params[:plan],
      customer_id: current_user.customer_id,
      payable_with: "credit_card",

      only_on_charge_success: true
    })

    if charge.errors
      redirect_to resultpay_path(:success => charge.errors), flash: { error: charge.errors}
    else
      plan = Plan.find_by(:identifier => charge.plan_identifier)
      current_user.subscription.update_attributes(:plan_id => plan.id, :subscription_id => charge.id, :in_trial => charge.in_trial, :active => charge.active)
      redirect_to resultpay_path(:success => true), flash: { success: "Assinatura feita com sucesso!"}
    end

  end

  def resultpay
    
  end

  def change_plan
    ids_exclude = []
    ids_exclude << current_user.plan.id
    ids_exclude << 1

    @plans = Plan.where.not(id: ids_exclude)
  end

  def subscription_cancel
    subscription = Iugu::Subscription.fetch(params[:id])
    subscription.suspend
    redirect_to perfil_path, flash: { success: "Assinatura Cancelada, seu painel será atualizado em breve"}
  end
  
end

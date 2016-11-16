class WebhookController < ApplicationController
	protect_from_forgery except: :status
  
  def status

  	if params[:event] == "subscription.suspended"
  		subscription = Subscription.find_by(:subscription_id => params[:data][:id])
  		subscription.update_attributes(:suspended => true, :active => false, :plan_id => 1)
  		ads = subscription.user.ads
  		ads.update_all(:featured => false, :status => false)
  	end

  	if params[:event] == "subscription.expired"
  		subscription = Subscription.find_by(:subscription_id => params[:data][:id])
  		subscription.update_attributes(:suspended => true, :active => false, :plan_id => 1)
  		ads = subscription.user.ads
  		ads.update_all(:featured => false, :status => false)
  	end

  	if params[:event] == "subscription.activated"
  		subscription = Subscription.find_by(:subscription_id => params[:data][:id])
  		#busca assinatura
  		subsc = Iugu::Subscription.fetch(params[:data][:id])
  		#busca plano
  		plan = Plan.find_by(:identifier => subsc.plan_identifier)

  		subscription.update_attributes(:suspended => false, :active => true, :plan_id => plan.id)
  		if plan.ads_qtd >= subscription.user.ads.count
  			ads = subscription.user.ads
  			ads.update_all(:featured => false, :status => true)
  		end

  		if plan.feature_qtd >= subscription.user.ads.count
  			ads = subscription.user.ads
  			ads.update_all(:featured => true)
  		end
  	end

  	if params[:event] == "subscription.renewed"
  		subscription = Subscription.find_by(:subscription_id => params[:data][:id])
  		#busca assinatura
  		subsc = Iugu::Subscription.fetch(params[:data][:id])
  		#busca plano
  		plan = Plan.find_by(:identifier => subsc.plan_identifier)
  		subscription.update_attributes(:suspended => false, :active => true, :plan_id => plan.id)
  	end

  	if params[:event] == "subscription.changed"
  		subscription = Subscription.find_by(:subscription_id => params[:data][:id])
  		#busca assinatura
  		subsc = Iugu::Subscription.fetch(params[:data][:id])
  		#busca plano
  		plan = Plan.find_by(:identifier => subsc.plan_identifier)
  		subscription.update_attributes(:suspended => false, :active => true, :plan_id => plan.id)
  		ads = subscription.user.ads
      ads.update_all(:featured => false, :status => false)

  		if plan.ads_qtd >= subscription.user.ads.count
  			ads = subscription.user.ads
  			ads.update_all(:status => true)
  		end

  		if plan.feature_qtd >= subscription.user.ads.count
  			ads = subscription.user.ads
  			ads.update_all(:featured => true)
  		end
  	end

  end
end
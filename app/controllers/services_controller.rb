class ServicesController < ApplicationController
  def busca_cep
    render :json => BuscaEndereco.cep(params[:id])
  rescue RuntimeError
    render :json => ["", "Endereço não encontrado", "", "", ""].to_json
  end



  def iugu
  	# Configure seu api key
	Iugu.api_key = "2c0af5df01471791f00fc0b66b993bd7"
	#subscription = Iugu::Plan.fetch_by_identifier("bronze_plan") rescue nil
	customer_id = "127B89EA11CC42E7B5A1DA0DFFDAF419"
	customer = Iugu::Customer.fetch(customer_id) rescue nil

	plan_id = "silver_plan"
	plan = Iugu::Plan.fetch_by_identifier(plan_id) rescue nil

    subscription = Iugu::Subscription.fetch("8CD65E75D67D4394A0B48DF51278B8D5")
	subscription.change_plan plan_id
    #return customer


	# subscription = Iugu::Subscription.create({
	# 	#plan_identifier: "bronze_plan",
	# 	plan_identifier: plan_id,
	# 	customer_id: customer_id,
		
    	
    	
	# })

	render json: { message: subscription }, status: 422
  end


end

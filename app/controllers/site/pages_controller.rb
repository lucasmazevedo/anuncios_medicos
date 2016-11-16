class Site::PagesController < ApplicationController
  before_action :set_ad, only: [:viewads]
	# before_action :set_category, only: [:viewcategories]

  def index
  	@categories = Category.all
  	@ads = Ad.all
  end

  def viewads
  	#@ad = Post.friendly.find(params[:id])
    @message = Message.new
  end

  def sendmessage
    @message = Message.new(message_params)
    @ad = Ad.friendly.find(@message.ads)
    if @message.valid?
      MessageMailer.sendmessageads(ActiveSupport::JSON.encode(@message)).deliver_later
      redirect_to ver_anuncio_path(@ad), notice: "Mensagem Enviada com Sucesso!!"
      #redirect_to contact_path, notice: "Your messages has been sent."
    else
      flash[:alert] = "An error occurred while delivering this message."
      redirect_to ver_anuncio_path(@ad)
    end
  end

  def sendreport
    @message = Message.new(message_params)
    @ad = Ad::find(@message.ads)
    if @message.valid?      
      MessageMailer.send_report_ads(ActiveSupport::JSON.encode(@message)).deliver_later
      redirect_to ver_anuncio_path(@ad), notice: "Denúncia enviada com Sucesso!"
      #redirect_to contact_path, notice: "Your messages has been sent."
    else
      flash[:alert] = "An error occurred while delivering this message."
      redirect_to ver_anuncio_path(@ad)
    end
  end


  def viewcategories

    @categories = Category.all
    if params[:id].nil?
      @ads = Ad.search_for(params[:search]).all.order(:created_at).page params[:page]
      #@ads= Ad.all
    else
    @category = Category.find(params[:id])
      @ads = @category.ads.order(:created_at).page params[:page]
    end
  
  end

  def about
    
  end

  def faq
    
  end

  def plans
    @plans = Plan.all
  end

  def contact
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.friendly.find(params[:id])
    end

    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params.require(:ad).permit(:user_id, :category_id, :title, :description, :state, :price, :tags, :photo, :featured, :status)
    end

    #mailler
    def message_params
      params.require(:message).permit(:name, :email, :content, :ads, :reason)
    end


end

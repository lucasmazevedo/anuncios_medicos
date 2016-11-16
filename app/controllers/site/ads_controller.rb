class Site::AdsController < ApplicationController
    before_action :authenticate_user!
  before_action :set_ad, only: [:show, :edit, :update, :destroy, :change_featured, :change_status]


  def change_featured
    if @ad.featured == true

      if @ad.update(featured: false)
        redirect_to :back, flash: { success: 'Anúncio foi retirado do destaque!'}
      else
        redirect_to :back, flash: { error: 'Você não pode fazer essa ação!' }
      end 

    else

      if @ad.update(featured: true)
        redirect_to :back, flash: { success: 'Anúncio Destacado!'}
      else
        redirect_to :back, flash: { error: 'Você não pode fazer essa ação!' }
      end 

    end
  end


  def change_status
    if @ad.status == true
      if @ad.update(status: false)
        redirect_to :back, flash: { success: 'Anúncio foi desativado!'}
      else
        redirect_to :back, flash: { error: 'Você não pode fazer essa ação!' }
      end 

    else

      if @ad.update(status: true)
        redirect_to :back, flash: { success: 'Anúncio foi Ativado!'}
      else
        redirect_to :back, flash: { error: 'Você não pode fazer essa ação!' }
      end 

    end
  end
  # GET /ads
  # GET /ads.json
  def index
    @ads = current_user.ads
  end

  def pending
    @ads = current_user.ads.pending
  end

  def favorites
    @savedads = current_user.favorite_ads
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
    
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = Ad.new(ad_params)
    @ad.user = current_user
    respond_to do |format|
      if @ad.save
        format.html { redirect_to pendentes_site_ads_path, notice: 'Ad was successfully created.' }
        format.json { render :show, status: :created, location: pendentes_site_ads_path }
      else
        format.html { render :new, notice: @ad.errors }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    respond_to do |format|
    object = ad_params
    images = @ad.images
    unless object != nil
    object[:images] += images
    end
      @ad.skip_feature = true
      if @ad.update(object)
        format.html { redirect_to [:site, @ad], notice: 'Ad was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad }
      else
        format.html { render :edit }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Ad was successfully destroyed.' }
      format.json { head :no_content }
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.friendly.find(params[:id])
    end

    def add_more_images(new_images)
      images = @ad.images # copy images cũ
      images += new_images # Thêm image mới vào mảng images
      @ad.assign_attributes(images: images) # gán lại vào thuộc tính images
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params.require(:ad).permit(:user_id, :category_id, :title, :description, :state, :price, :tags, :featured, :status, {images: []})
    end
end

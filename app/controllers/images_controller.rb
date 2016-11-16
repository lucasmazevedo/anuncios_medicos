class ImagesController < ApplicationController
  before_action :set_ad

  def create
    add_more_images(images_params[:images])
    flash[:error] = "Failed uploading images" unless @ad.save
    redirect_to :back
  end

   def destroy
    remove_image_at_index(params[:id].to_i)
    flash[:error] = "Failed deleting image" unless @ad.save
    redirect_to :back
  end

  private

  def set_ad
    @ad = Ad.friendly.find(params[:site_ad_id])
  end

  def add_more_images(new_images)
    images = @ad.images # copy images cũ
    images += new_images # Thêm image mới vào mảng images
    @ad.assign_attributes(images: images) # gán lại vào thuộc tính images
  end

  def images_params
    params.require(:ad).permit({images: []})
  end

  def remove_image_at_index(index)
    remain_images = @ad.images # copy images
    remain_images.delete_at(index) # delete image theo index
    @ad.assign_attributes images: remain_images
  end
end
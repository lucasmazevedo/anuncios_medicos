json.extract! ad, :id, :user_id, :category_id, :title, :description, :state, :price, :tags, :photo, :featured, :status, :created_at, :updated_at
json.url ad_url(ad, format: :json)
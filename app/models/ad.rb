class Ad < ApplicationRecord
    extend FriendlyId
  belongs_to :user
  belongs_to :category

  scoped_search on: [:tags, :description], :complete_value => :false
  scoped_search :on => :title, :complete_value => :true

  friendly_id :title, use: :slugged

  mount_uploaders :images, AvatarUploader
  serialize :images, JSON

  attr_accessor :skip_feature

  validates :title, :category, :description, :state, :price, :tags, :images, presence: true

  ## VALIDAÇÕES
  validate :thing_count_within_limit, :on => :create
  validate :ads_featured_limit, if: :active_feature?, unless: :skip_feature
  validate :ads_status_limit, if: :active_status?, unless: :skip_feature
 
  def active_feature?
    featured == true
  end

  def active_status?
    status == true
  end

  #validates :user_id, :category_id, presence: true

  def thing_count_within_limit
    if self.user.ads(:reload).count >= user.plan.ads_qtd
      errors.add(:limit, "Excedido!")
    end
  end

  def ads_featured_limit
    errors.add(:limit, "You sir, have too many featured ads!") if self.user.feature_count >= user.plan.feature_qtd
  end

  def ads_status_limit
    errors.add(:limit, "You sir, have too many featured ads!") if self.user.status_count >= user.plan.ads_qtd
  end

  def statuses
    if self.status == true
      "<p class=\"btn btn-success btn-xs\"><strong>Ativo</strong></p>".html_safe
    else
      "<p class=\"btn btn-danger btn-xs\"><strong>Inativo</strong></p>".html_safe
    end
  end

  ## SCOPE
	scope :active, -> { where(status: true) }
  scope :pending, -> { where(status: false) }
  scope :featureds, -> { where(featured: true) }
	scope :statuse, -> { where(status: true) }

  ## ENUN State
  enum state: { Usado: "U", Novo: "N" } 
  
  ## CONSTANT
  STATE = [['Usado', 'U'], ['Novo', 'N']]
end
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #attr_accessible :email, :password, :password_confirmation, :remember_me
  after_create :create_iugu_customer
  after_update :update_iugu_customer, if: 'email_changed?'

  # RELATIONSHIPS
  has_many :favorites
  has_many :favorite_ads, through: :favorites, source: :favorited, source_type: 'Ad'

  has_many :ads
  has_one  :profile, :dependent => :destroy, :inverse_of => :user
  accepts_nested_attributes_for :profile, :allow_destroy => true

  has_one  :subscription, :dependent => :destroy, :inverse_of => :user
  accepts_nested_attributes_for :subscription, :allow_destroy => true

  # Inicialização Relacionamento
  after_initialize do
    self.profile ||= self.build_profile()
    self.subscription ||= self.build_subscription(plan_id: 1)
  end

  def subscribed?
    unless self.subscription.blank?
      return self.subscription
    end
    return false
  end

  def subscription_details
    unless !self.subscription.subscription_id
      subscription = Iugu::Subscription.fetch(self.subscription.subscription_id)
    end
    return "no subscription"
  end

  def plan
    unless self.subscription.blank?
      return self.subscription.plan
    end
    return "ocorreu um erro"
  end

  def feature_count
    return self.ads.featureds.count
  end

  def status_count
    return self.ads.statuse.count
  end

  def free?
    if self.subscription.plan_id == 1
      return true
    end
    return false
  end

  def payments_details
    customer = Iugu::Customer.fetch(self.customer_id)
    payment_methods = Iugu::PaymentMethod.search({customer_id: customer.id}).results
    return payment_methods
  end

   def limit_ads_per_user
    if self.ads(:reload).count >= self.plan.ads_qtd
      return false
    end
    return true
  end


  private
 
  def create_iugu_customer
    iugu_customer = Iugu::Customer.create({
      email: self.email,
      name:  self.profile.fullname,
      cpf_cnpj: self.profile.cpf
    })
    self.update_column(:customer_id, iugu_customer.id)
  end
 
  def update_iugu_customer
    customer = Iugu::Customer.fetch(self.customer_id)
    customer.email = self.email
    customer.name  = self.profile.fullname
    customer.cpf_cnpj  = self.profile.cpf
    customer.save
  end

end

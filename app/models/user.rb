class User < ActiveRecord::Base
  attr_accessor :login
  has_many :currencies
  has_many :order_items, through: :orders
  has_many :items, through: :order_items
  has_many :orders, dependent: :destroy
  has_many :searches, dependent: :destroy
  has_many :activities, dependent: :destroy
  scope :noobs, -> {where("created_at > :time AND role = 'user'", :time=>Time.now-7.days).order("created_at")}
  scope :online, -> {joins(:activities).where("activities.updated_at >?", Time.now-7.minute).uniq}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :inn,
  :uniqueness => {
    :case_sensitive => false
  }
  validates :inn, :person, :city, :name, :ogrn, :legal_address, :actual_address, :phone,  presence: true

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    puts conditions
    if login = conditions.delete(:login)
      where(conditions).where(["lower(inn) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      conditions.permit! if conditions.class.to_s == "ActionController::Parameters"
      where(conditions).first
    end
  end



  def login=(login)
    @login = login
  end

  def login
    @login || self.inn || self.email
  end

  def dev?
    self.role == "dev"
  end

  def current_order
    self.orders.last
  end

  def admin?
    ["admin", "dev"].include? self.role
  end

  def manual_reset_password
    @password = rand(1000000..9999999)
    self.password = @password
    self.password_confirmation = @password
    self.save!
    @password
  end

  def price_type
    return "0fa9bc88-166f-11e0-9aa1-001e68eacf93" if ["buyer","dev","admin"].include?(self.role)
    return "0fa9bc8a-166f-11e0-9aa1-001e68eacf93" if self.role == "retail"
    return false
  end
end

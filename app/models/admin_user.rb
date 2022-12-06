class AdminUser < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
    :recoverable, :rememberable, :validatable

  belongs_to :branch_office, optional: true
  has_many :shifts, dependent: :destroy

  attr_writer :login

  after_create :assign_default_role

  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false}

  validate :must_have_a_role, on: :update
  validate :if_is_staff_have_branch_office

  def if_is_staff_have_branch_office
    if has_role?(:staff) && branch_office_id.nil?
      errors.add(:branch_office_id, "Debe tener una sucursal asignada")
    end
  end

  def login
    @login || username || email
  end

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", {value: login.downcase}]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  private

  def must_have_a_role
    errors.add(:roles, "Deberia de tener un rol") unless roles.any?
  end

  def assign_default_role
    add_role(:staff) if roles.blank?
  end
end

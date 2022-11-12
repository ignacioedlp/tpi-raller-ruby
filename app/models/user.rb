class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  # El usuario puede tener varios shifts
  has_many :shifts, dependent: :destroy
  belongs_to :branch_office, optional: true


  attr_writer :login

  after_create :assign_default_role

  validate :must_have_a_role, on: :update

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
    errors.add(:roles, "must have at least one role") unless roles.any?
  end

  def assign_default_role
    add_role(:client) if roles.blank?
  end
end

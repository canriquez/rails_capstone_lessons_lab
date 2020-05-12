class User < ApplicationRecord

  has_many :courses, foreign_key: 'author_id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [ :student, :teacher ]
end
 
# == Schema Information
#
# Table name: books
#
#  id                 :integer          not null, primary key
#  description        :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  name               :string
#  author             :string
#

class Book < ActiveRecord::Base
	acts_as_votable

	has_many :comments, as: :commentable

    belongs_to :user
    has_and_belongs_to_many :collections

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

	validates :image, presence: true
    validates :description, presence: true
end

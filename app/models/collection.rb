# == Schema Information
#
# Table name: collections
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Collection < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :books

	validates :name, presence: true
end

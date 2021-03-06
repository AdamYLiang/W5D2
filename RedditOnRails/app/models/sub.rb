# == Schema Information
#
# Table name: subs
#
#  id          :bigint(8)        not null, primary key
#  title       :string           not null
#  description :string           not null
#  mod_id      :integer          not null
#

class Sub < ApplicationRecord
    validates_presence_of :title, :description, :mod_id
    
    belongs_to :moderator,
        class_name: :User,
        primary_key: :id,
        foreign_key: :mod_id

    has_many :post_subs, inverse_of: :sub, dependent: :destroy

    has_many :posts,
        through: :post_subs,
        source: :post
end

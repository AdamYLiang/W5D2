# == Schema Information
#
# Table name: posts
#
#  id        :bigint(8)        not null, primary key
#  title     :string           not null
#  url       :string
#  content   :string
#  author_id :integer          not null
#

class Post < ApplicationRecord
    validates_presence_of :title
    validates :subs, presence: { message: "Must have at least one sub" }

    belongs_to :author,
        class_name: :User,
        primary_key: :id,
        foreign_key: :author_id

    has_many :post_subs, inverse_of: :post, dependent: :destroy

    has_many :subs,
        through: :post_subs,
        source: :sub
end

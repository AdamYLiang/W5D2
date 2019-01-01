# == Schema Information
#
# Table name: posts
#
#  id        :bigint(8)        not null, primary key
#  title     :string           not null
#  url       :string
#  content   :string
#  sub_id    :integer          not null
#  author_id :integer          not null
#

class Post < ApplicationRecord
    validates_presence_of :title

    belongs_to :sub,
        class_name: :Sub,
        primary_key: :id,
        foreign_key: :sub_id

    belongs_to :author,
        class_name: :User,
        primary_key: :id,
        foreign_key: :author_id
end

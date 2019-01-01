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
    
    belongs_to :moderator,
        class_name: :User,
        primary_key: :id,
        foreign_key: :mod_id

        
end

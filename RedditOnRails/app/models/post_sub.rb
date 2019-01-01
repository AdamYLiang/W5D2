# == Schema Information
#
# Table name: post_subs
#
#  id         :bigint(8)        not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSub < ApplicationRecord
    #Join table many to many association
    #Works since rails will call Post#sub_ids= 
    #Pass in nested sub-array so that the associations can set up properly
    
    belongs_to :post
    belongs_to :sub
end

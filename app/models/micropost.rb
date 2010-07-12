# == Schema Information
# Schema version: 20100510165357
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  conteudo   :string(255)
#  usuario_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :conteudo
  
  belongs_to :usuario
  
  validates_presence_of :conteudo, :usuario_id
  validates_length_of   :conteudo, :maximum => 140
  
  default_scope :order => 'created_at DESC'
  
end

# == Schema Information
#
# Table name: codigos
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Codigo < ActiveRecord::Base
  # attr_accessible :title, :body
end

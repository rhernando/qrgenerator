# == Schema Information
#
# Table name: codigos
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  idfichero     :string(255)
#  tipo          :string(255)
#  asignatura_id :integer
#  informacion   :text
#

class Codigo < ActiveRecord::Base
  # attr_accessible :title, :body

  TIPOS = %w(imagen informacion video)
  belongs_to :asignatura
end

# == Schema Information
#
# Table name: asignaturas
#
#  id         :integer          not null, primary key
#  curso      :integer
#  nombre     :string(255)
#  titulo     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Asignatura < ActiveRecord::Base
  attr_accessible :curso, :nombre, :titulo
end

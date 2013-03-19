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

  has_many :codigos

  TITULOS = %w(ing_informatica ing_teleco mates_informatica master_i2tic master_inform doctorado)
end

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
#  code       :string(255)
#

class Asignatura < ActiveRecord::Base
  validates_presence_of :nombre
  validates_presence_of :titulo

  attr_accessible :curso, :nombre, :titulo, :code, :descripcion

  has_many :codigos

  TITULOS = %w(ing_informatica ing_teleco mates_informatica master_i2tic master_inform doctorado)
end

class AddCodeToAsignatura < ActiveRecord::Migration
  def change
    add_column :asignaturas, :code, :string
  end
end

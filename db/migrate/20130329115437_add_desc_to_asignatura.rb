class AddDescToAsignatura < ActiveRecord::Migration
  def change
    add_column :asignaturas, :descripcion, :string
  end
end

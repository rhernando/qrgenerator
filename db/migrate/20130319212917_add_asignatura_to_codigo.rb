class AddAsignaturaToCodigo < ActiveRecord::Migration
  def change
    add_column :codigos, :asignatura_id, :integer
  end
end

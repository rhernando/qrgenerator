class AddTipoToCodigo < ActiveRecord::Migration
  def change
    add_column :codigos, :tipo, :string
  end
end

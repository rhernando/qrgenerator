class AddIdficheroToCodigo < ActiveRecord::Migration
  def change
    add_column :codigos, :idfichero, :string
  end
end

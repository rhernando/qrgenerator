class AddInfoToCodigo < ActiveRecord::Migration
  def change
    add_column :codigos, :informacion, :text
  end
end

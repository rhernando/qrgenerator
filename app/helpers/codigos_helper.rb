module CodigosHelper
  def get_image(id)
    require 'mongoid-grid_fs'
    grid_fs = Mongoid::GridFs

    grid_fs.get(id) rescue nil
  end

end

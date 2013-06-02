module CodigosHelper
  def get_image(id)
    require 'mongoid-grid_fs'
    grid_fs = Mongoid::GridFs

    grid_fs.get(id) rescue nil
  end

  def asignaturas_categorias(arr_asignaturas)
    array_cat = []
    arr_asignaturas.each do |as|
      name = as.nombre
      name += " (#{as.code})" if as.code.present?
      h_n = {:label => name, :value => name, :id => "#{as.id}", :category => I18n.t("asignaturas.#{as.titulo}")}
      array_cat << h_n
    end
    array_cat.to_json
  end
end

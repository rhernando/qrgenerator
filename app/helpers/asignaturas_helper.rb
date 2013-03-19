module AsignaturasHelper
  def titulos_form
    ret = []
    Asignatura::TITULOS.each do |tit|
      ret << [I18n.t("asignaturas.#{tit}"), tit]
    end
    ret
  end
end

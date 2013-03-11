class Fichero
  include Mongoid::Document


  mount_uploader :fichero, FicheroUploader

  field :name, type: String

end

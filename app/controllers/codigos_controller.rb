class CodigosController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:showimage, :info_codigo, :show]

  TIPO_INFO = 'informacion'
  TIPO_IMG = 'imagen'
  TIPO_VIDEO = 'video'

  # GET /codigos
  # GET /codigos.json
  def index
    @codigos = Codigo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @codigos }
    end
  end

  # GET /codigos/1
  # GET /codigos/1.json
  def show
    @codigo = Codigo.find(params[:id])

    grid_fs = Mongoid::GridFs
    file = grid_fs.get(Codigo.find(params[:id]).idfichero) rescue nil
    if @codigo.tipo == TIPO_INFO
      valor_codigo = "ARQEL|#{@codigo.id}|#{@codigo.tipo}|INFO"
    else
      valor_codigo = "ARQEL|#{@codigo.id}|#{@codigo.tipo}|#{file.contentType}|#{@codigo.filename}"
    end

#    data = open(view_context.image_path(codigo_url(@codigo, :format => 'jpg')))

    respond_to do |format|
      format.html {
        qrcode = RQRCode::QRCode.new(valor_codigo, :level => :l, :unit => 10, :offset => 5, :size => 7)
        svg    = RQRCode::Renderers::SVG::render(qrcode, :level => :l, :unit => 10, :offset => 5, :size => 7)
        image = MiniMagick::Image.read(svg) { |i| i.format "svg" }
        image.format :jpg
        data = image.to_blob
        send_data data, :filename => "#{params[:id]}.jpg"
      }
      format.json { render json: @codigo }
      format.html
      format.svg { render :qrcode => valor_codigo, :level => :m, :unit => 10, :offset => 10, :size => 10 }
      format.png { render :qrcode => valor_codigo }
      format.gif { render :qrcode => valor_codigo }
      format.jpeg { render :qrcode => valor_codigo, :level => :l, :unit => 10, :offset => 5, :size => 7}
    end
  end

  # GET /codigos/new
  # GET /codigos/new.json
  def new
    @codigo = Codigo.new
    @asignaturas = Asignatura.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @codigo }
    end
  end

  # GET /codigos/1/edit
  def edit
    @codigo = Codigo.find(params[:id])
    @asignaturas = Asignatura.all
  end

  # POST /codigos
  # POST /codigos.json
  def create
    tipo = params[:tipo]
    @codigo = Codigo.new(params[:codigo])
    @codigo = Codigo.find(params[:image_form][:idcodigo]) if params[:image_form][:idcodigo].present?

    @codigo.tipo = tipo
    @codigo.asignatura_id = params[:idasignatura]

    if tipo != TIPO_INFO && (params[:image_form][:upload_data].present? || @codigo.id.blank?)
      grid_fs = Mongoid::GridFs
      g = grid_fs.put(params[:image_form][:upload_data])
      @codigo.idfichero = g.id.to_s
      @codigo.filename = params[:image_form][:upload_data].original_filename
    else
      @codigo.informacion = params[:image_form][:informacion]
    end

    respond_to do |format|
      if @codigo.save
        format.html { redirect_to codigos_path, notice: 'Codigo was successfully created.' }
        format.json { render json: @codigo, status: :created, location: @codigo }
      else
        format.html { render action: "new" }
        format.json { render json: @codigo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /codigos/1
  # PUT /codigos/1.json
  def update
    @codigo = Codigo.find(params[:id])

    respond_to do |format|
      if @codigo.update_attributes(params[:codigo])
        format.html { redirect_to @codigo, notice: 'Codigo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @codigo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codigos/1
  # DELETE /codigos/1.json
  def destroy
    @codigo = Codigo.find(params[:id])

    grid_fs = Mongoid::GridFs
    g = grid_fs.delete(@codigo.idfichero)

    @codigo.destroy

    respond_to do |format|
      format.html { redirect_to codigos_url }
      format.json { head :no_content }
    end
  end

  def showimage

    grid_fs = Mongoid::GridFs
    file = grid_fs.get(Codigo.find(params[:id]).idfichero)


    p file.inspect

    send_data file.data, :type => file.contentType, :file_name => file.filename
  end

  def info_codigo
    #c = Codigo.find(params[:id])

    # asgnatura: indice curso (0-3, 4 = master)
    asign_selec = []
    params[:arr_asign].split(',').each do |as|
      asign_selec << Asignatura.find(as).id
    end

    messages = []

    cods = Codigo.where(:tipo => TIPO_INFO, :asignatura_id => asign_selec)
    cods.each do |c|
      messages << {:asignatura => c.asignatura.nombre, :texto => c.informacion}
    end

    respond_to do |format|
      format.json { render json: messages, status: :ok }
    end

  end


end

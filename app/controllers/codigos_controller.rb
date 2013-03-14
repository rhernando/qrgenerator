class CodigosController < ApplicationController
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
    file = grid_fs.get(Codigo.find(params[:id]).idfichero)
    valor_codigo = "#{@codigo.id}|#{file.contentType}"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @codigo }
      format.html
      format.svg { render :qrcode => valor_codigo, :level => :l, :unit => 10 }
      format.png { render :qrcode => valor_codigo }
      format.gif { render :qrcode => valor_codigo }
      format.jpeg { render :qrcode => valor_codigo }
    end
  end

  # GET /codigos/new
  # GET /codigos/new.json
  def new
    @codigo = Codigo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @codigo }
    end
  end

  # GET /codigos/1/edit
  def edit
    @codigo = Codigo.find(params[:id])
  end

  # POST /codigos
  # POST /codigos.json
  def create
    @codigo = Codigo.new(params[:codigo])

    grid_fs = Mongoid::GridFs
    g = grid_fs.put(params[:image_form][:upload_data])

    @codigo.idfichero = g.id.to_s

    respond_to do |format|
      if @codigo.save
        format.html { redirect_to @codigo, notice: 'Codigo was successfully created.' }
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

    send_data file.data, :type => file.contentType, :disposition => 'inline'


  end
end

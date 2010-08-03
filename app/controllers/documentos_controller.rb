require 'odf-report'

class DocumentosController < ApplicationController
  # GET /documentos
  # GET /documentos.xml
  def index
    @documentos = usuario_corrente.documentos

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @documentos }
    end
  end

  # GET /documentos/1
  # GET /documentos/1.xml
  def show
    @usuario = usuario_corrente
    @documento = Documento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @documento }
    end
  end

  # GET /documentos/new
  # GET /documentos/new.xml
  def new
    @documento = Documento.new
    @documento.usuario_id = usuario_corrente.id
    @usuario = usuario_corrente
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @documento }
    end
  end

  # GET /documentos/1/edit
  def edit
    @documento = Documento.find(params[:id])
  end

  # POST /documentos
  # POST /documentos.xml
  def create
    @documento = Documento.new(params[:documento])
    @usuario = usuario_corrente
    
    respond_to do |format|
      if @documento.save
        flash[:notice] = 'Documento foi criado com sucesso.'
        format.html { redirect_to(@documento) }
        format.xml  { render :xml => @documento, :status => :created, :location => @documento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @documento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /documentos/1
  # PUT /documentos/1.xml
  def update
    @documento = Documento.find(params[:id])

    respond_to do |format|
      if @documento.update_attributes(params[:documento])
        flash[:notice] = 'Documento atualizado com sucesso.'
        format.html { redirect_to(@documento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @documento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /documentos/1
  # DELETE /documentos/1.xml
  def destroy
    @documento = Documento.find(params[:id])
    @documento.destroy

    respond_to do |format|
      format.html { redirect_to(documentos_url) }
      format.xml  { head :ok }
    end
  end
  
  
  
  def gerar_documento
    
    @documento = Documento.find(params[:id])
    @usuario = usuario_corrente
    @usuarios = Usuario.all()

    report = ODFReport.new("#{RAILS_ROOT}/public/modelos/oficio.odt") do |r|

      r.add_field "USUARIO_NOME", @usuario.nome
    	r.add_field "USUARIO_EMAIL", @usuario.email
    	r.add_field "DOCUMENTO_NUMERO", @documento.numero
    	r.add_field "DOCUMENTO_DESTINATARIO", @documento.destinatario
    	r.add_field "DOCUMENTO_REMETENTE", @documento.remetente
    	r.add_field "DOCUMENTO_DATA", @documento.created_at
    	r.add_field "DOCUMENTO_ASSUNTO", @documento.assunto
      r.add_field "DOCUMENTO_CORPO", @documento.corpo
      r.add_field "DOCUMENTO_DESPEDIDA", @documento.despedida
      
      
      r.add_table("USUARIOS", @usuarios) do | row, us |
        row["TABELA_NOME"] = "#{us.nome} (#{us.email})"
      end

      r.add_table("USUARIOS", @usuarios) do | row, field |

        #if field.is_a?(String)
          row["FIELD_NOME"] = field.nome
          row["FIELD_EMAIL"] = field.email
          row["FIELD_CRIADO"] = field.created_at.strftime("%d/%m/%Y - %H:%M")
          row["FIELD_ATUALIZADO"] = field.updated_at.strftime("%d/%m/%Y - %H:%M")
        #else
         # row["FIELD_NOME"] = field.nome
        #  row["FIELD_EMAIL"] = field.email || ''
        #end
        
        r.add_image :graphics1, "public/images/unb.jpg"

      end

    end

    report_file_name = report.generate

    send_file(report_file_name) 

  end
  
  
end

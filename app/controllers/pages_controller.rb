require 'odf-report'


class PagesController < ApplicationController
  
  def principal
    @titulo = "Projeto IMI"
    if usuario_logado?
      @micropost = Micropost.new
      @feed = usuario_corrente.feed.paginate(:page => params[:page])
    end
  end

  def contato
    @titulo = "Contato"
  end
  
  def sobre
    @titulo = "Sobre"
  end
  
  
  def relatorio
    
    @titulo = "Relat&oacute;rio"
    @usuario = usuario_corrente
    @usuarios = Usuario.all()

    report = ODFReport.new("#{RAILS_ROOT}/public/modelos/modelo1.odt") do |r|

      r.add_field "USUARIO_NOME", @usuario.nome
    	r.add_field "USUARIO_EMAIL", @usuario.email

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

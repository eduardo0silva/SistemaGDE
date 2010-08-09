
class PagesController < ApplicationController

  
  def principal
    @titulo = "Principal"
    if usuario_logado?
      @documento = Documento.new
      @feed = usuario_corrente.feed.paginate(:page => params[:page])
    end
  end

  def contato
    @titulo = "Contato"
  end
  
  def sobre
    @titulo = "Sobre"
  end

end

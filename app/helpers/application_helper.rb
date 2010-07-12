module ApplicationHelper

  # Retorna um titulo em cada pagina.
  def titulo
    base_titulo = "Projeto de IMI"
    if @titulo.nil?
      base_titulo
    else
      "#{base_titulo} | #{@titulo}"
    end
  end
  
  def logo
    image_tag("unb.jpg", :alt => "Projeto IMI", :class => "round")
  end
  
end

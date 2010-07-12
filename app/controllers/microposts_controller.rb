class MicropostsController < ApplicationController
  
  before_filter :autenticar, :only => [:create, :destroy]
  before_filter :usuario_autorizado, :only => :destroy
  def index
  end
  
  def create
    @micropost = usuario_corrente.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Post criado"
      redirect_to root_path
    else
      @feed = [ ]
      render 'pages/principal'
    end
  end
  
  def destroy
    @micropost.destroy
    redireciona_voltar_ou root_path
  end
  
  private
    
    def usuario_autorizado
      @micropost = Micropost.find(params[:id])
      redirect_to root_path unless usuario_corrente?(@micropost.usuario)
    end
  
end
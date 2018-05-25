class ProdutosController < ApplicationController

    def index
        @produtos_por_nome = Produto.order(:nome)
        @produtos_por_preco = Produto.order(:preco)
    end

    def create
      # params() retorna os parâmetros
      # :produto é o mesmo que "produto", só que sem gerar string na memória
      # permit serve pra permitir qualquer coisa que vier de ser pega
      # os parâmetros depois de permit são os únicos atributos de Produto que ele aceitará
      valores = params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id
      @produto = Produto.new valores
      if @produto.save
        flash[:notice] = "Produto salvo com sucesso"
        redirect_to root_url
      else
        render :new
      end
    end

    def new
      @produto = Produto.new
      @departamentos = Departamento.all
    end

    def destroy
      id = params[:id]
      Produto.destroy id
      redirect_to root_url
    end

    def busca
      @nome_a_buscar = params[:nome]
      @produtos = Produto.where "nome like ?", "%#{@nome_a_buscar}%"
    end

end

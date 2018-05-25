class ProdutosController < ApplicationController

    before_action :set_produto, only: [:edit, :update, :destroy]

    def index
        @produtos_por_nome = Produto.order(:nome)
        @produtos_por_preco = Produto.order(:preco)
    end

    def create
      # params() retorna os parâmetros
      # :produto é o mesmo que "produto", só que sem gerar string na memória
      # permit serve pra permitir qualquer coisa que vier de ser pega
      # os parâmetros depois de permit são os únicos atributos de Produto que ele aceitará
      valores = produto_params
      @produto = Produto.new valores
      if @produto.save
        flash[:notice] = "Produto salvo com sucesso"
        redirect_to root_url
      else
        renderiza_new
      end
    end

    def new
      @produto = Produto.new
      @departamentos = Departamento.all
    end

    def destroy
      @produto.destroy
      redirect_to root_url
    end

    def busca
      @nome_a_buscar = params[:nome]
      @produtos = Produto.where "nome like ?", "%#{@nome_a_buscar}%"
    end

    def edit
      renderiza_new :edit
    end

    def update
      if @produto.update produto_params
        flash[:notice] = "Produto atualizado com sucesso"
        redirect_to root_url
      else
        renderiza :edit
      end
    end

    private # a partir daqui tudo fica privado

    def renderiza_new (view)
      @departamentos = Departamento.all
      render view
    end

    def set_produto
      id = params[:id]
      @produto = Produto.find(id)
    end

    def produto_params
      params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id
    end

end

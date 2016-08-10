class API::V1::ProductsController < API::V1::ApiController
  load_resource

  def index
    filterrific = initialize_filterrific(
      Product,
      params[:filterrific]
    ) or return
    products = filterrific.find.page(params[:page])

    render json: products, status: :ok
  end

  def create
    product = Product.new product_params

    respond_to do |format|
      if product.save
        render json: product, status: :created, location: product
      else
        render json: product.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    if @product.update product_params
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    head :no_content
  end

  def show
    render json: @product, status: :ok
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :category, :product_type, :price)
  end

end

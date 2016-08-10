class ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    @filterrific = initialize_filterrific(
      Product,
      params[:filterrific]
    ) or return
    @products = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "The product #{@product.name} was created successfully." }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @product.update product_params
        format.html { redirect_to @product, notice: "The product #{@product.name} was updated successfully." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @product.destroy
        format.html { redirect_to products_url, notice: "The product #{@product.name} was destroyed successfully." }
      end
    end
  end

  def show
  end

  def report
    products = Product.all
    pdf = ProductsPdf.new(products)
    send_data pdf.render, filename: "products_#{Time.zone.now}.pdf", type: 'application/pdf', disposition: 'inline'
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :category, :product_type, :price)
  end

end

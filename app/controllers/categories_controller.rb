class CategoriesController < ApplicationController
  before_action :set_categories, only: %i[index new]

  def index
    @categories = current_user.categories
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
    @payments = @category.payments.order(created_at: :desc)
    @sum = @payments.sum(:amount)
  end

  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      flash[:notice] = 'Category successfully created.'
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_categories
    @categories = current_user.categories
  end

  def total_amount(category)
    category.payments.sum(:amount)
  end

  def category_params
    params.require(:category).permit(:name, :icon).merge(author_id: current_user.id)
  end
end

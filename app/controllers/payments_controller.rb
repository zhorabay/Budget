class PaymentsController < ApplicationController
  def index
    @category = Category.find_by(id: params[:category_id])
    if @category
      @categories = [@category]
      @payments = @category.payments.order(id: :desc)
    else
      flash[:error] = 'Category not found'
      redirect_to categories_path
    end
  end

  def new
    @category = Category.find(params[:category_id])
    @payment = Payment.new
  end

  def create
    @payment = current_user.payments.new(payment_params)
    @categories = Category.where(id: payment_params[:category_ids])
  
    if @payment.save
      @categories.each do |category|
        category.payments << @payment unless category.payments.include?(@payment)
      end
      flash[:success] = "Transaction was created!"
      redirect_to category_payments_path(params[:category_id])
    else
      flash.now[:error] = @payment.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:name, :amount, category_ids: [])
  end
end

class PaymentsController < ApplicationController
  def index
    @category = Category.find_by(id: params[:category_id])
    if @category
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

  def edit
    @payment = Payment.find(params[:id])
  end

  def update
    @payment = Payment.find(params[:id])
    @categories = Category.where(id: payment_params[:category_ids])
    if @categories.empty?
      flash.now[:error] = 'You must choose at least one category!'
      render :edit
    elsif @payment.update(payment_params.except(:category_ids))
      @payment.categories.delete_all
      @categories.each do |category|
        category.payments << @payment unless category.payments.include?(@payment)
      end
      flash[:success] = 'Transaction updated successfully!'
      redirect_to category_payments_path(params[:category_id])
    else
      flash.now[:error] = @payment.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    if @payment.destroy
      flash[:success] = 'Transaction was deleted successfully!'
      redirect_to category_payment_path(params[:category_id])
    else
      flash.now[:error] = @payment.errors.full_messages.to_sentence
      render :show
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:name, :amount, category_ids: [])
  end
end

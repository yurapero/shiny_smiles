class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
     @customer = Customer.find(params[:id])
     @submissions = @customer.submissions
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    customer = Customer.find(params[:id])
    customer.update!(customer_params)
    redirect_to admin_customers_path(params[:id])
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:image, :name, :email, :password, :is_deleted)
  end
end

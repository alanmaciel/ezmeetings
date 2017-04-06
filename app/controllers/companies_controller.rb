class CompaniesController < ApplicationController
  
  def show
    load_company
  end

  def new
    build_company
  end

  def create
    build_company
    save_company or render 'new'
  end

  def edit
    load_company
    build_company
  end

  def update
    load_company
    build_company
    save_company or render 'edit'
  end

  def destroy
    load_company
    @company.destroy
    redirect_to root_path
  end

  private

  def build_company
    @company ||= company_scope.build
    @company.attributes = company_params
  end

  def save_company
    if @company.save
      redirect_to root_path
    end
  end

  def company_params
    company_params = params[:company]
    company_params ? company_params.permit(:name, :user_id) : {}
  end

  def company_scope
    current_user.companies.all
  end

  def load_company
    @company = company_scope.find(params[:id])
  end
end

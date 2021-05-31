class AccountsController < ApplicationController

  before_action :set_account, exept: [:create]

  def create
    @account = Account.create(account_params)
    if @account.save
      if params[:parent_id].present?
        AccountConnection.create(parent_account_id: params[:parent_id], branch_account_id: @account.id)
      end
    end
  end

  def edit
  end

  def update
    @account = Account.update(account_params)
  end

  def show
  end

  def destroy
    @account.destroy
  end

  def contribute
    @account.contribute(params[:amount], params[:code])
  end

  def deposit
    @account.deposit(params[:amount])
  end

  def transfer
    @source_account = Account.find(params[:source_account_id])
    @account.transfer(params[:amount], @source_account)
  end

  def unlock
    @account.unlock
  end

  def 

  private

  def set_account
    @account = Account.find(params[:account_id])
  end

  def account_params
    params.require(:account).permit(:name, :balance, :status, :account_owner_type, :account_owner_id)
  end
end

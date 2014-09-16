class EmailAddressesController < ApplicationController
  def new
    @email_address = EmailAddress.new(contact_id: params[:contact_id], contact_type: params[:contact_type])
  end

  def create
    @email_address = EmailAddress.new(email_address_params)

    if @email_address.save
      redirect_to @email_address.contact, notice: 'Email address was successfully created.'
    else
      render :new
    end
  end

  def edit
    @email_address = EmailAddress.find(params[:id])
  end

  def update
    @email_address = EmailAddress.find(params[:id])

    if @email_address.update(email_address_params)
      redirect_to @email_address.contact, notice: 'Email address was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @email_address = EmailAddress.find(params[:id])
    @email_address.destroy
    redirect_to @email_address.contact
  end

  private

  def email_address_params
    params.require(:email_address).permit(:address, :contact_id, :contact_type)
  end
end

class EmailAddressesController < ApplicationController
  def new
    @email_address = EmailAddress.new(person_id: params[:person_id])
  end

  def create
    @email_address = EmailAddress.new(email_address_params)

    if @email_address.save
      redirect_to @email_address.person, notice: 'Email address was successfully created.'
    else
      render :new
    end
  end

  private

  def email_address_params
    params.require(:email_address).permit(:address, :person_id)
  end
end

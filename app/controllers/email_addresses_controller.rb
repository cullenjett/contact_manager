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

  def edit
    @email_address = EmailAddress.find(params[:id])
  end

  def update
    @email_address = EmailAddress.find(params[:id])

    if @email_address.update(email_address_params)
      redirect_to @email_address.person, notice: 'Email address was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @email_address = EmailAddress.find(params[:id])
    @email_address.delete
    redirect_to @email_address.person
  end

  private

  def email_address_params
    params.require(:email_address).permit(:address, :person_id)
  end
end

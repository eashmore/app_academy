class ContactsController < ApplicationController
  def index
    contacts = User.find(params[:user_id]).contacts
    shared_contacts = User.find(params[:user_id]).shared_contacts
    render json: shared_contacts + contacts
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render(
        json: contacts.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    contact = Contact.find(params[:id])
    render json: contact
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    destroyed_contact = contact.destroy!
    render json: destroyed_contact
  end


  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end

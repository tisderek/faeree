class ContactsController < ApplicationController
  def index
    user_contacts = user.contacts
    if request.xhr?
      render partial "contacts/index", layout: false, locals: { contacts: user_contacts}
    else
      render "contacts/index", locals: { contacts: user_contacts}
    end
  end

  def show
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end
end

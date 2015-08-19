class ContactsController < ApplicationController
  def index
    user_contacts = user.contacts
    if request.xhr?
      render partial "contacts/index", layout: false, locals: { contacts: user_contacts}
    else
      render "contacts/index", locals: { contacts: user_contacts}
  end

  def _show
  end

  def _new
  end

  def create
  end

  def update
  end

  def destroy
  end
end

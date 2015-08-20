class ContactsController < ApplicationController
  include MainHelper

  def index
    user_contacts = user.contacts
    if request.xhr?
      render partial "contacts/index", layout: false, locals: { contacts: user_contacts}
    else
      render "contacts/index", locals: { contacts: user_contacts }
    end
  end

  def show

  end

  def new
    @contact = Contact.new
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = user.id
    if @contact.save
      redirect_to options_path
    else
      render 'new'
    end
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(article_params)
      redirect_to options_path
    else
      render 'edit'
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private

  def contact_params
    params.require(:user_contact).permit(:contact_name, :contact_phone)
  end


end



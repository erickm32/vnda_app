require 'rails_helper'

# TODO: implement
RSpec.describe 'Redirects sync mechanism', type: :request do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  # describe 'GET /index' do
  #   it 'renders a successful response' do
  #     Redirect.create! valid_attributes
  #     get redirects_url
  #     expect(response).to be_successful
  #   end
  # end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Redirect' do
        expect do
          post redirects_url, params: { redirect: valid_attributes }
        end.to change(Redirect, :count).by(1)
      end

      it 'redirects to the created redirect' do
        post redirects_url, params: { redirect: valid_attributes }
        expect(response).to redirect_to(redirect_url(Redirect.last))
      end

      # describe '' do
      # end
    end

    context 'with invalid parameters' do
      it 'does not create a new Redirect' do
        expect do
          post redirects_url, params: { redirect: invalid_attributes }
        end.to change(Redirect, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post redirects_url, params: { redirect: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested redirect' do
        redirect = Redirect.create! valid_attributes
        patch redirect_url(redirect), params: { redirect: new_attributes }
        redirect.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the redirect' do
        redirect = Redirect.create! valid_attributes
        patch redirect_url(redirect), params: { redirect: new_attributes }
        redirect.reload
        expect(response).to redirect_to(redirect_url(redirect))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        redirect = Redirect.create! valid_attributes
        patch redirect_url(redirect), params: { redirect: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested redirect' do
      redirect = Redirect.create! valid_attributes
      expect do
        delete redirect_url(redirect)
      end.to change(Redirect, :count).by(-1)
    end

    it 'redirects to the redirects list' do
      redirect = Redirect.create! valid_attributes
      delete redirect_url(redirect)
      expect(response).to redirect_to(redirects_url)
    end
  end
end

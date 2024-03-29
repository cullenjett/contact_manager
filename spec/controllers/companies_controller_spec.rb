require 'rails_helper'

RSpec.describe CompaniesController, :type => :controller do
  let(:valid_attributes) {
    { name: 'Acme Corp' }
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  describe "GET index" do
    it "assigns all companies as @companies" do
      company = Company.create! valid_attributes
      get :index, {}
      expect(assigns(:companies)).to eq([company])
    end
  end

  describe "GET show" do
    it "assigns the requested company as @company" do
      company = Company.create! valid_attributes
      get :show, {:id => company.to_param}
      expect(assigns(:company)).to eq(company)
    end
  end

  describe "GET new" do
    it "assigns a new company as @company" do
      get :new, {}
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe "GET edit" do
    it "assigns the requested company as @company" do
      company = Company.create! valid_attributes
      get :edit, {:id => company.to_param}
      expect(assigns(:company)).to eq(company)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Company" do
        expect {
          post :create, {:company => valid_attributes}
        }.to change(Company, :count).by(1)
      end

      it "assigns a newly created company as @company" do
        post :create, {:company => valid_attributes}
        expect(assigns(:company)).to be_a(Company)
        expect(assigns(:company)).to be_persisted
      end

      it "redirects to the created company" do
        post :create, {:company => valid_attributes}
        expect(response).to redirect_to(Company.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved company as @company" do
        post :create, {:company => invalid_attributes}
        expect(assigns(:company)).to be_a_new(Company)
      end

      it "re-renders the 'new' template" do
        post :create, {:company => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { name: 'Hot New Company' }
      }

      it "updates the requested company" do
        company = Company.create! valid_attributes
        put :update, {:id => company.to_param, :company => new_attributes}
        company.reload
        expect(company.name).to eq('Hot New Company')
      end

      it "assigns the requested company as @company" do
        company = Company.create! valid_attributes
        put :update, {:id => company.to_param, :company => valid_attributes}
        expect(assigns(:company)).to eq(company)
      end

      it "redirects to the company" do
        company = Company.create! valid_attributes
        put :update, {:id => company.to_param, :company => valid_attributes}
        expect(response).to redirect_to(company)
      end
    end

    describe "with invalid params" do
      it "assigns the company as @company" do
        company = Company.create! valid_attributes
        put :update, {:id => company.to_param, :company => invalid_attributes}
        expect(assigns(:company)).to eq(company)
      end

      it "re-renders the 'edit' template" do
        company = Company.create! valid_attributes
        put :update, {:id => company.to_param, :company => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested company" do
      company = Company.create! valid_attributes
      expect {
        delete :destroy, {:id => company.to_param}
      }.to change(Company, :count).by(-1)
    end

    it "redirects to the people list" do
      company = Company.create! valid_attributes
      delete :destroy, {:id => company.to_param}
      expect(response).to redirect_to(companies_url)
    end
  end
end

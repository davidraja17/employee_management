require 'rails_helper'

RSpec.describe Api::V1::EmployeesController, type: :controller do
  let!(:employee) { create(:employee) }

  describe "GET #index" do
    it "returns a paginated list of employees" do
      get :index, params: { page: 1 }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key("employees")
      expect(JSON.parse(response.body)).to have_key("meta")
    end
  end

  describe "GET #show" do
    context "when employee exists" do
      it "returns the employee" do
        get :show, params: { id: employee.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["employee_id"]).to eq(employee.employee_id)
      end
    end

    context "when employee does not exist" do
      it "returns not found" do
        get :show, params: { id: "NON_EXISTENT_ID" }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to have_key("error")
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new employee" do
        valid_params = {
          employee: attributes_for(:employee)
        }
        expect { post :create, params: valid_params }.to change(Employee, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to have_key("employee_id")
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity" do
        invalid_params = {
          employee: { first_name: "", last_name: "" }
        }
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key("errors")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the employee" do
        updated_params = {
          id: employee.id,
          employee: { first_name: "UpdatedName" }
        }
        put :update, params: updated_params
        employee.reload
        expect(response).to have_http_status(:ok)
        expect(employee.first_name).to eq("UpdatedName")
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity" do
        invalid_params = {
          id: employee.id,
          employee: { email: "" }
        }
        put :update, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include("errors")
      end
    end
  end

  describe "DELETE #destroy" do
    it "marks the employee as inactive" do
      delete :destroy, params: { id: employee.id }
      expect(response).to have_http_status(:no_content)
      employee.reload
      expect(employee.status).to eq("InActive")
    end
  end

  describe "GET #tax_deduction" do
    context "when employee exists" do
      it "returns tax deduction details" do
        get :tax_deduction, params: { id: employee.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key("tax_amount")
      end
    end

    context "when employee does not exist" do
      it "returns not found" do
        get :tax_deduction, params: { id: "NON_EXISTENT_ID" }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to have_key("error")
      end
    end
  end
end

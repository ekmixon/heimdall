require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe FilterGroupsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # FilterGroup. As you add validations to FilterGroup, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryBot.build(:filter_group).attributes
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # FilterGroupsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  context 'User is logged in' do
    let(:user) { FactoryBot.create(:editor) }
    before do
      db_sign_in user
    end

    describe 'GET #index' do
      it 'returns a success response' do
        create :filter_group, created_by: user
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'GET #show' do
      it 'returns a success response' do
        filter_group = create :filter_group, created_by: user
        get :show, params: { id: filter_group.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'GET #new' do
      it 'returns a success response' do
        get :new, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'GET #edit' do
      it 'returns a success response' do
        filter_group = create :filter_group, created_by: user
        get :edit, params: { id: filter_group.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new FilterGroup' do
          expect {
            post :create, params: { filter_group: valid_attributes }, session: valid_session
          }.to change(FilterGroup, :count).by(1)
        end

        it 'redirects to the created filter_group' do
          post :create, params: { filter_group: valid_attributes }, session: valid_session
          expect(response).to redirect_to(FilterGroup.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: { filter_group: invalid_attributes }, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        let(:new_attributes) {
          { name: 'New Name' }
        }

        it 'updates the requested filter_group' do
          filter_group = create :filter_group, created_by: user
          put :update, params: { id: filter_group.to_param, filter_group: new_attributes }, session: valid_session
          filter_group.reload
          expect(filter_group.name).to eq('New Name')
        end

        it 'redirects to the filter_group' do
          filter_group = create :filter_group, created_by: user
          put :update, params: { id: filter_group.to_param, filter_group: valid_attributes }, session: valid_session
          expect(response).to redirect_to(filter_group)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          filter_group = create :filter_group, created_by: user
          put :update, params: { id: filter_group.to_param, filter_group: invalid_attributes }, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested filter_group' do
        filter_group = create :filter_group, created_by: user
        expect {
          delete :destroy, params: { id: filter_group.to_param }, session: valid_session
        }.to change(FilterGroup, :count).by(-1)
      end

      it 'redirects to the filter_groups list' do
        filter_group = create :filter_group, created_by: user
        delete :destroy, params: { id: filter_group.to_param }, session: valid_session
        expect(response).to redirect_to(filter_groups_url)
      end
    end

    describe 'Add Filter' do
      it 'updates the requested filter_group' do
        filter_group = create :filter_group, created_by: user
        filter = create :filter, created_by: user
        put :update, params: { id: filter_group.to_param, filter_group: { filter_ids: { id: filter.id } } }, session: valid_session
        filter_group.reload
        expect(filter_group.filters.size).to eq(1)
      end
    end

  end
end

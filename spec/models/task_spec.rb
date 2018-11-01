# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    context 'user' do
      it { is_expected.to belong_to(:user) }
    end
  end

  describe 'validations' do
    context 'title' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_length_of(:title).is_at_most(255) }
    end
  end
end

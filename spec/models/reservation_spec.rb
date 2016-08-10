require 'rails_helper'

RSpec.describe Reservation, type: :model do

  describe 'attributes' do
    it { should respond_to :id          }
    it { should respond_to :user_id     }
    it { should respond_to :message     }
    it { should respond_to :occation    }
    it { should respond_to :reserved_at }
    it { should respond_to :created_at  }
    it { should respond_to :updated_at  }
  end

  describe 'realtions' do
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :reserved_at }
  end

  describe 'scopes' do
    let(:occ      ) { Reservation::OCCATIONS.sample }
    let(:other_occ) { (Reservation::OCCATIONS - [occ]).sample }
    let(:today    ) { Time.zone.today    }
    let(:tomorrow ) { Time.zone.tomorrow }
    let(:reservation ) { create :reservation, reserved_at: today, occation: occ          }
    let(:reservation2) { create :reservation, reserved_at: tomorrow, occation: other_occ }

    before do
      reservation
      reservation2
    end

    describe '.with_reserved_at_gte' do
      it 'has to return the reservations with reserved_at >= date' do
        result = Reservation.with_reserved_at_gte tomorrow.to_s
        expect(result).to include reservation2
        expect(result).to_not include reservation
      end
    end

    describe '.with_reserved_at_lte' do
      it 'has to return the reservations with reserved_at <= date' do
        result = Reservation.with_reserved_at_lte today.to_s
        expect(result).to include reservation
        expect(result).to_not include reservation2
      end
    end

    describe '.with_occation' do
      it 'has to return the reservations with the requested occation ' do
        result = Reservation.with_occation occ
        expect(result).to include reservation
        expect(result).to_not include reservation2
      end
    end
  end

end

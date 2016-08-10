require 'rails_helper'

RSpec.describe Event, type: :model do

  describe 'attributes' do
    it { should respond_to :id             }
    it { should respond_to :title          }
    it { should respond_to :description    }
    it { should respond_to :finalized_date }
    it { should respond_to :created_at     }
    it { should respond_to :updated_at     }
  end

  describe 'validations' do
    it { should validate_presence_of :title          }
    it { should validate_presence_of :description    }
    it { should validate_presence_of :finalized_date }
  end

  describe 'scopes' do
    let(:today    ) { Time.zone.today    }
    let(:tomorrow ) { Time.zone.tomorrow }
    let(:event ) { create :event, finalized_date: today    }
    let(:event2) { create :event, finalized_date: tomorrow }

    before do
      event
      event2
    end

    describe '.with_date_gte' do
      it 'has to return the reservations with finalized_date >= date' do
        result = Event.with_date_gte tomorrow.to_s
        expect(result).to include event2
        expect(result).to_not include event
      end
    end

    describe '.with_date_lte' do
      it 'has to return the events with finalized_date <= date' do
        result = Event.with_date_lte today.to_s
        expect(result).to include event
        expect(result).to_not include event2
      end
    end

    describe '.with_title' do
      it 'has to return the events with the requested title' do
        result = Event.with_title event.title
        expect(result).to include event
        expect(result).to_not include event2
      end
    end

    describe '.next_events' do
      it 'has to return the next 3 events' do
        old_event = create :event, finalized_date: Time.zone.yesterday
        result = Event.next_events
        expect(result.count).to eq 3
        expect(result).to_not include old_event
      end
    end
  end

end

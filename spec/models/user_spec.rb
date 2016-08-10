require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'attributes' do
    it { should respond_to :id                     }
    it { should respond_to :email                  }
    it { should respond_to :encrypted_password     }
    it { should respond_to :reset_password_token   }
    it { should respond_to :reset_password_sent_at }
    it { should respond_to :remember_created_at    }
    it { should respond_to :sign_in_count          }
    it { should respond_to :current_sign_in_at     }
    it { should respond_to :last_sign_in_at        }
    it { should respond_to :current_sign_in_ip     }
    it { should respond_to :last_sign_in_ip        }
    it { should respond_to :first_name             }
    it { should respond_to :last_name              }
    it { should respond_to :profile                }
    it { should respond_to :auth_token             }
    it { should respond_to :created_at             }
    it { should respond_to :updated_at             }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name  }
    it { should validate_presence_of :profile    }
  end

  describe 'callbacks' do
    context 'before_save' do
      it 'has to set the auth_token before save' do
        user = create :waiter
        expect(user.auth_token).to_not be_nil
      end
    end
  end

  describe 'scopes' do

    def check_results list, included, not_included
      expect(list).to include included
      expect(list).to_not include not_included
    end

    describe '.with_first_name' do
      it 'has to return the products whit the requested first name' do
        included     = create :user
        not_included = create :user

        list = User.with_first_name included.first_name
        check_results list, included, not_included
      end
    end

    describe '.with_last_name' do
      it 'has to return the products whit the requested last name' do
        included     = create :user
        not_included = create :user

        list = User.with_last_name included.last_name
        check_results list, included, not_included
      end
    end

    describe '.with_profile' do
      it 'has to return the products whit the requested profile' do
        included     = create :customer
        not_included = create :waiter

        list = User.with_profile included.profile
        check_results list, included, not_included
      end
    end
  end

  User::PROFILES.each do |profile|
    describe "#is_#{profile}?" do
      it "has to return true if profile is #{profile}" do
        prf = build profile.to_sym
        expect(prf.send("is_#{profile}?")).to eq true
      end

      it "has to return false if profile is different than #{profile}" do
        other_profile = User::PROFILES - [profile]
        prf           = build other_profile.sample.to_sym
        expect(prf.send("is_#{profile}?")).to eq false
      end
    end
  end

  describe '#full_name' do
    it 'has to return the full name of user' do
      user      = build :user
      full_name = "#{user.first_name} #{user.last_name}"
      expect(user.full_name).to eq full_name
    end
  end

end

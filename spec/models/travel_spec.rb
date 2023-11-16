require 'rails_helper'

RSpec.describe Travel, type: :model do
  context 'validations' do
    it { should belong_to(:planet) }
    it { should belong_to(:spacecraft) }
    it { should have_many(:document) }
    it { should have_many(:image) }
    it { should validate_numericality_of(:duration).only_integer }
    it { should define_enum_for(:status).with_values(scheduled: 0, started: 1, aborted: 2, failed: 3, finished: 4) }
  end

  describe '#status' do
    let(:planet) { Planet.create(name: 'asd',  earth_distance: 1) }
    let(:spacecraft) { Rocket.create(name: 'lala', velocity: 1, fuel_in_days: 1, space_agency: SpaceAgency.create(name: 'BRASA')) }

    context 'initial state' do
      context 'without state' do
        subject(:travel) { Travel.new(planet: planet, spacecraft: spacecraft, duration: 10, beginning_date: 10.days.from_now) }

        it 'assign scheduled state ' do
          expect(travel.scheduled?).to be true
        end
      end

      context 'with scheduled state' do
        subject(:travel) { Travel.new(planet: planet, spacecraft: spacecraft, duration: 10, beginning_date: 10.days.from_now, status: 'scheduled') }

        it { is_expected.to be_valid }
      end

      context 'with another state' do
        let(:states) { ['started', 'aborted', 'failed', 'finished'] }

        it 'is invalid' do
          states.each do |state|
            travel = Travel.new(planet: planet, spacecraft: spacecraft, duration: 10, beginning_date: 10.days.from_now, status: state)

            expect(travel).not_to be_valid
          end
        end

        it 'returns an error message' do
          states.each do |state|
            travel = Travel.new(planet: planet, spacecraft: spacecraft, duration: 10, beginning_date: 10.days.from_now, status: state)
            travel.valid?

            expect(travel.errors.full_messages).to include('Status need to start with scheduled')
          end
        end
      end
    end

    context 'scheduled transition' do
      subject(:travel) { Travel.create(planet: planet, spacecraft: spacecraft, duration: 10, beginning_date: 10.days.from_now, status: 'scheduled') }

      context 'transiting to started' do
        it 'is valid' do
          travel.status = 'started'

          expect(travel).to be_valid
        end
      end

      context 'transiting to aborted' do
        it 'is valid' do
          travel.status = 'aborted'

          expect(travel).to be_valid
        end
      end

      context 'transiting to failed' do
        it 'is invalid' do
          travel.status = 'failed'

          expect(travel).not_to be_valid
        end

        it 'returns a error message' do
          travel.status = 'failed'
          travel.valid?

          expect(travel.errors.full_messages).to include('Status need to transit to started or aborted')
        end
      end

      context 'transiting to finished' do
        it 'is invalid' do
          travel.status  = 'finished'
          travel.valid?

          expect(travel).not_to be_valid
        end

        it 'returns a error message' do
          travel.status = 'finished'
          travel.valid?

          expect(travel.errors.full_messages).to include('Status need to transit to started or aborted')
        end
      end
    end

    context 'started transition' do
      subject(:travel) { Travel.create(planet: planet, spacecraft: spacecraft, duration: 10, beginning_date: 10.days.from_now, status: 'scheduled') }

      before do
        travel.started!
      end

      context 'transiting to aborted' do
        it 'is valid' do
          travel.status = 'aborted'

          expect(travel).to be_valid
        end
      end

      context 'transiting to failed' do
        it 'is valid' do
          travel.status = 'failed'

          expect(travel).to be_valid
        end
      end

      context 'transiting to finished' do
        it 'is valid' do
          travel.status = 'finished'

          expect(travel).to be_valid
        end
      end

      context 'transiting to scheduled' do
        it 'is invalid' do
          travel.status = 'scheduled'

          expect(travel).not_to be_valid
        end

        it 'returns an error message' do
          travel.status = 'scheduled'
          travel.valid?

          expect(travel.errors.full_messages).to include('Status need to transit to aborted, failed or finished')
        end
      end
    end

    context 'final transition' do
      subject(:travel) { Travel.create(planet: planet, spacecraft: spacecraft, duration: 10, beginning_date: 10.days.from_now, status: 'scheduled') }

      let(:error_message) { 'Status is in the final state and can\'t be changed! Please create another trip' }

      context 'when status is aborted' do
        let(:states) { ['scheduled', 'started', 'failed', 'finished'] }

        before do
          travel.aborted!
        end

        it 'is invalid' do
          states.each do |state|
            travel.status = state

            expect(travel).not_to be_valid

            travel.reload
          end
        end

        it 'returns a message saying that can\'t change the status' do
          states.each do |state|
            travel.status = state
            travel.valid?

            expect(travel.errors.full_messages).to include(error_message)

            travel.reload
          end
        end
      end

      context 'when status is failed' do
        let(:states) { ['scheduled', 'started', 'aborted', 'finished'] }

        before do
          travel.started!
          travel.failed!
        end


        it 'is invalid' do
          states.each do |state|
            travel.status = state

            expect(travel).not_to be_valid

            travel.reload
          end
        end

        it 'returns a message saying that can\'t change the status' do
          states.each do |state|
            travel.status = state
            travel.valid?

            expect(travel.errors.full_messages).to include(error_message)

            travel.valid?
            travel.reload
          end
        end
      end

      context 'when status is finished' do
        let(:states) { ['scheduled', 'started', 'failed', 'aborted'] }

        before do
          travel.started!
          travel.finished!
        end

        it 'is invalid' do
          states.each do |state|
            travel.status = state

            expect(travel).not_to be_valid

            travel.reload
          end
        end

        it 'returns a message saying that can\'t change the status' do
          states.each do |state|
            travel.status = state
            travel.valid?

            expect(travel.errors.full_messages).to include(error_message)

            travel.reload
          end
        end
      end
    end
  end
end

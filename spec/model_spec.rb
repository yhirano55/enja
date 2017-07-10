require 'spec_helper'

RSpec.describe User, type: :model do
  let!(:guest) { described_class.create(role: :guest) }
  let!(:staff) { described_class.create(role: :staff) }
  let!(:admin) { described_class.create(role: :admin) }

  context 'enumerize' do
    subject { described_class.role }
    it { is_expected.to be_a(Enumerize::Attribute) }
  end

  context 'scope' do
    describe '.guest' do
      subject { described_class.guest }
      it { is_expected.to     include guest }
      it { is_expected.not_to include staff }
      it { is_expected.not_to include admin }
    end

    describe '.staff' do
      subject { described_class.staff }
      it { is_expected.to     include staff }
      it { is_expected.not_to include guest }
      it { is_expected.not_to include admin }
    end

    describe '.admin' do
      subject { described_class.admin }
      it { is_expected.to     include admin }
      it { is_expected.not_to include guest }
      it { is_expected.not_to include staff }
    end
  end

  context 'validation' do
    it { is_expected.to validate_presence_of(:role) }
  end

  describe '#guest!' do
    let(:instance) { described_class.create(role: :admin) }

    subject(:execution) { instance.guest! }

    it { is_expected.to eq true }
    it { expect { execution }.to change { instance.role }.from('admin').to('guest') }
  end

  describe '#staff!' do
    let(:instance) { described_class.create(role: :admin) }

    subject(:execution) { instance.staff! }

    it { is_expected.to eq true }
    it { expect { execution }.to change { instance.role }.from('admin').to('staff') }
  end

  describe '#admin!' do
    let(:instance) { described_class.create(role: :guest) }

    subject(:execution) { instance.admin! }

    it { is_expected.to eq true }
    it { expect { execution }.to change { instance.role }.from('guest').to('admin') }
  end
end

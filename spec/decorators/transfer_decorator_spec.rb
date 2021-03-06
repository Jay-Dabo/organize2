require 'rails_helper'

describe TransferDecorator do
  subject { transfer.decorate }

  let(:transfer) { build(:transfer, value: 10, fee: 1, source: account) }
  let(:account) { build(:account, precision: 3) }

  describe ".value" do
    it { expect(subject.value).to eq "$10.000" }
  end

  describe ".fee" do
    context "when there is a fee" do
      it { expect(subject.fee).to eq "$1.000" }
    end

    context "when there is no fee" do
      before { transfer.fee = nil }

      it { expect(subject.fee).to eq "$0.000" }
    end
  end
end

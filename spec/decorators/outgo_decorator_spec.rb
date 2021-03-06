require "rails_helper"

describe OutgoDecorator do
  subject { outgo.decorate }

  let(:outgo) { build(:outgo, value: 10, fee: 1, chargeable: account) }
  let(:account) { build(:account, precision: 3) }

  describe ".value" do
    it { expect(subject.value).to eq "$10.000" }
  end

  describe ".fee" do
    it { expect(subject.fee).to eq "$1.000" }
  end

  context ".total" do
    context "when fee is a nil value" do
      let(:outgo) { build(:outgo, value: 10, fee: nil) }

      it "returns just value" do
        expect(subject.total).to eq "$10.00"
      end
    end

    context "when does not have fee" do
      let(:outgo) { build(:outgo, value: 10, fee: 0) }

      it "returns just value" do
        expect(subject.total).to eq "$10.00"
      end
    end

    context "when precision of account 8" do
      let(:outgo) { build(:outgo, value: 0.0001, fee: 0, chargeable: account) }
      let(:account) { build(:account, precision: 8) }

      it "returns just value" do
        expect(subject.total).to eq "$0.00010000"
      end
    end

    context "when has fee" do
      let(:outgo) { build(:outgo, value: 100, fee: 4.21, fee_kind: nil) }

      it "returns value" do
        expect(subject.total).to match %r[\$100.00]
      end

      it "should include localized fee kind" do
        expect(subject.total).to match %r[\$4.21]
      end
    end

    context "when has value, fee value, and fee kind" do
      let(:outgo) { build(:outgo, value: 100, fee: 4.21, fee_kind: :network) }

      it "returns value" do
        expect(subject.total).to match %r[\$100.00]
      end

      it "should include localized fee kind" do
        expect(subject.total).to match %r[Network: \$4.21]
      end
    end
  end
end

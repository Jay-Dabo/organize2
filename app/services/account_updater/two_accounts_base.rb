module AccountUpdater
  class TwoAccountsBase
    def initialize(object)
      @object = object
      @source_balance = object.source.balance
      @destination_balance = object.destination.balance
    end

    def update!
      fail "Not implemented"
    end

    def self.update!(object)
      new(object).update!
    end

    private

    delegate :source, :destination, to: :@object

    def final_source_balance
      fail "Not implemented"
    end

    def final_destination_balance
      fail "Not implemented"
    end
  end
end
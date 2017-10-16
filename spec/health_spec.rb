require 'health'

describe Health do
  describe 'health' do
    it 'returns 32' do
      expect(Health.new(32).max_health).to eql(32)
    end
    it 'returns 32' do
      expect(Health.new(32).current_health).to eql(32)
    end
  end
  describe 'health changes' do
    test_health = Health.new(32)
    it 'subtracts 10 health' do
      test_health.add(-10)
      expect(test_health.current_health).to eql(22)
    end
    it 'adds 2 health' do
      test_health.add(2)
      expect(test_health.current_health).to eql(24)
    end
    it 'maxes out health' do
      test_health.max
      expect(test_health.current_health).to eql(32)
    end
  end
end

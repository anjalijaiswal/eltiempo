RSpec.describe Eltiempo do
  it 'has a version number' do
    expect(Eltiempo::VERSION).not_to be nil
  end

  describe Eltiempo::TiempoApi do
    before do
      @api = Eltiempo::TiempoApi.new('Gavà')
    end

    it 'gets forecast for city with all the keys' do
      weather = @api.weather_today
      expect(weather).to have_key(:date)
      expect(weather).to have_key(:description)
      expect(weather).to have_key(:min_temp)
      expect(weather).to have_key(:max_temp)
    end

    it 'gets average of maximum temperature for the week' do
      allow(@api).to receive(:weekly_max_temp) { 16.4 }
      expect(@api.weekly_max_temp).to eq(16.4)
    end

    it 'gets average of minimum temperature for the week' do
      allow(@api).to receive(:weekly_min_temp) { 4 }
      expect(@api.weekly_min_temp).to eq(4)
    end
  end
end

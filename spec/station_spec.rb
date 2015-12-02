require 'station'

describe Station do

 subject(:station){described_class.new("Kings Cross", 1)}

 it 'should expose name variable' do
   expect(station.name).to eq("Kings Cross")
 end

 it 'should expose zone variables' do
   expect(station.zone).to eq(1)
 end

end

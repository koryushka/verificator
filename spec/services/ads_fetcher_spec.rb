require 'rails_helper'

RSpec.describe(AdsFetcher) do
  describe('#ads') do
    it 'fetches ads' do
      ads = {
        'ads' => [
          {
            'reference' => '1',
            'status' => 'enabled',
            'description' => 'Description for campaign 11'
          },
          {
            'reference' => '2',
            'status' => 'disabled',
            'description' => 'Description for campaign 12'
          },
          {
            'reference' => '3',
            'status' => 'enabled',
            'description' => 'Description for campaign 13'
          }
        ]
      }.to_json

      stub_request(
        :get,
        'http://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df'
      ).to_return(body: ads)

      subject = described_class.new

      expect(subject.ads).to eq(JSON.parse(ads)['ads'])
    end
  end
end

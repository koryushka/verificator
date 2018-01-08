require 'rails_helper'

RSpec.describe(Verificator) do
  describe('#output') do
    it 'shows discrepancies between ads and campaigns' do
      ads = [
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
          'status' => 'disabled',
          'description' => 'Description for campaign 13'
        },
        {
          'reference' => '4',
          'status' => 'disabled',
          'description' => 'Description for campaign 14'
        },
        {
          'reference' => '5',
          'status' => 'enabled',
          'description' => 'Description for campaign 15'
        },
        {
          'reference' => '6',
          'status' => 'enabled',
          'description' => 'Description for campaign 16'
        }
      ]

      campaign = FactoryBot.create(
        :campaign, external_reference: '1', status: :active
      )
      campaign_2 = FactoryBot.create(
        :campaign, external_reference: '2', status: :paused
      )
      campaign_3 = FactoryBot.create(
        :campaign, external_reference: '3', status: :deleted
      )
      campaign_4 = FactoryBot.create(
        :campaign, external_reference: '4', status: :active
      )
      campaign_5 = FactoryBot.create(
        :campaign, external_reference: '5', status: :paused
      )
      campaign_6 = FactoryBot.create(
        :campaign, external_reference: '6', status: :deleted
      )
      campaign_7 = FactoryBot.create(
        :campaign, external_reference: '7', status: :active
      )

      allow_any_instance_of(AdsFetcher).to receive(:ads).and_return(ads)
      subject = described_class.new

      expected_output = {
        verification: [
          {
            campaign: {
              id: campaign.id, job_id: campaign.job_id,
              status: 'active', external_reference: '1',
              ad_description: campaign.ad_description
            },
            ad: {
              status: 'enabled'
            },
            match: true
          },
          {
            campaign: {
              id: campaign_2.id, job_id: campaign_2.job_id,
              status: 'paused', external_reference: '2',
              ad_description: campaign_2.ad_description
            },
            ad: {
              status: 'disabled'
            },
            match: true
          },
          {
            campaign: {
              id: campaign_3.id, job_id: campaign_3.job_id,
              status: 'deleted', external_reference: '3',
              ad_description: campaign_3.ad_description
            },
            ad: {
              status: 'disabled'
            },
            match: true
          },
          {
            campaign: {
              id: campaign_4.id, job_id: campaign_4.job_id,
              status: 'active', external_reference: '4',
              ad_description: campaign_4.ad_description
            },
            ad: {
              status: 'disabled'
            },
            match: false
          },
          {
            campaign: {
              id: campaign_5.id, job_id: campaign_5.job_id,
              status: 'paused', external_reference: '5',
              ad_description: campaign_5.ad_description
            },
            ad: {
              status: 'enabled'
            },
            match: false
          },
          {
            campaign: {
              id: campaign_6.id, job_id: campaign_6.job_id,
              status: 'deleted', external_reference: '6',
              ad_description: campaign_6.ad_description
            },
            ad: {
              status: 'enabled'
            },
            match: false
          },
          {
            campaign: {
              id: campaign_7.id, job_id: campaign_7.job_id,
              status: 'active', external_reference: '7',
              ad_description: campaign_7.ad_description
            },
            ad: nil,
            match: false
          }
        ]
      }

      expect(subject.output).to eq(expected_output)
    end
  end
end

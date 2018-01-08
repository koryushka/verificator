require 'rails_helper'

RSpec.describe(StatusVerificator) do
  describe('#match?') do
    context 'verify if statuses match' do
      let(:campaign) do
        FactoryBot.create(:campaign, status: campaign_status)
      end
      let(:adv) do
        {
          'reference' => campaign.external_reference,
          'status' => adv_status,
          'description' => campaign.ad_description
        }
      end
      let(:subject) do
        described_class.new(campaign: campaign, ad: adv).match?
      end

      context 'matches' do
        let(:campaign_status) { :active }
        let(:adv_status) { 'enabled' }

        it { is_expected.to be_truthy }

        let(:campaign_status) { :paused }
        let(:adv_status) { 'disabled' }
        it { is_expected.to be_truthy }

        let(:campaign_status) { :deleted }
        let(:adv_status) { 'disabled' }
        it { is_expected.to be_truthy }
      end

      context 'doesn`t match' do
        let(:campaign_status) { :active }
        let(:adv_status) { 'disabled' }
        it { is_expected.to be_falsey }

        let(:campaign_status) { :paused }
        let(:adv_status) { 'enabled' }
        it { is_expected.to be_falsey }

        let(:campaign_status) { :deleted }
        let(:adv_status) { 'enabled' }
        it { is_expected.to be_falsey }
      end
    end
  end
end

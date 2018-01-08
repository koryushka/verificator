# frozen_string_literal: true
class Verificator
  attr_reader :campaigns

  def initialize(campaigns: Campaign.all)
    self.campaigns = campaigns
  end

  def output
    { verification: result }
  end

  private

  attr_writer :campaigns

  def adv(campaign)
    fetcher.ads.detect { |ad| ad['reference'] == campaign.external_reference }
  end

  def fetcher
    @fetcher ||= AdsFetcher.new
  end

  def synchronized?(campaign, ad)
    verificators.map do |verificator|
      verificator.new(campaign: campaign, ad: ad).match?
    end.all?
  end

  def result
    campaigns.map do |campaign|
      ad = adv(campaign)
      status = ad.slice('status').symbolize_keys if ad
      c_attrs = campaign.attributes.except('created_at', 'updated_at')
      { campaign: c_attrs.symbolize_keys, ad: status,
        match: synchronized?(campaign, ad) }
    end
  end

  def verificators
    [StatusVerificator] # AnotherVerificator, etc
  end
end

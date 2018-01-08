# frozen_string_literal: true
class StatusVerificator
  attr_reader :ad, :campaign
  def initialize(campaign:, ad:)
    self.ad = ad
    self.campaign = campaign
  end

  def match?
    return false unless ad
    value = match_rule[ad['status'].to_sym]
    value.include?(campaign.status.to_sym)
  end

  private

  attr_writer :ad, :campaign

  def match_rule
    {
      enabled: [:active],
      disabled: [:paused, :deleted]
    }
  end
end

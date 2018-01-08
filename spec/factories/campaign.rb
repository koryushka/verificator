FactoryBot.define do
  factory(:campaign) do
    sequence(:job_id) { |id| id }
    status 0
    sequence(:external_reference, &:to_s)
    ad_description { FFaker::Lorem.sentence }
  end
end

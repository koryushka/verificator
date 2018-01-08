campaign = Campaign.find_or_initialize_by(id: 1)
campaign.assign_attributes(
  job_id: 1,
  status: 0,
  external_reference: '1',
  ad_description: 'Description for campaign 1'
)
campaign.save

campaign = Campaign.find_or_initialize_by(id: 2)
campaign.assign_attributes(
  job_id: 2,
  status: 1,
  external_reference: '2',
  ad_description: 'Description for campaign 2'
)
campaign.save

campaign = Campaign.find_or_initialize_by(id: 3)
campaign.assign_attributes(
  job_id: 3,
  status: 2,
  external_reference: '3',
  ad_description: 'Description for campaign 3'
)
campaign.save

require 'spec_helper'

provider_class = Puppet::Type.type(:rds_db_parameter_group).provider(:v2)

ENV['AWS_ACCESS_KEY_ID'] = 'redacted'
ENV['AWS_SECRET_ACCESS_KEY'] = 'redacted'
ENV['AWS_REGION'] = 'sa-east-1'

describe provider_class do

  let(:resource) {
    Puppet::Type.type(:rds_db_parameter_group).new(
      :ensure => 'present',
      :name => 'MySQL Rules',
      :description => 'Rules for MySQL',
      :db_parameter_group_family => 'mysql5.1',
      :region => 'us-west-1',
    )
  }

  let(:provider) { resource.provider }

  let(:instance) { provider.class.instances.first }

  it 'should be an instance of the ProviderV2' do
    expect(provider).to be_an_instance_of Puppet::Type::Rds_db_parameter_group::ProviderV2
  end

end
require 'spec_helper'

type_class = Puppet::Type.type(:rds_db_parameter_group)

describe type_class do

  let :params do
    [
      :name,
    ]
  end

  let :properties do
    [
      :description,
      :db_parameter_group_family,
      :region,
    ]
  end

  it 'should have expected properties' do
    properties.each do |property|
      expect(type_class.properties.map(&:name)).to be_include(property)
    end
  end

  it 'should have expected parameters' do
    params.each do |param|
      expect(type_class.parameters).to be_include(param)
    end
  end
end
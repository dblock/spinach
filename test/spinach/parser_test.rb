require_relative '../test_helper'

describe Spinach::Parser do
  before do
    @parser = Spinach::Parser.new('feature_definition.feature')
    @parser.stubs(:content).returns("
      Feature: User authentication
         Scenario: User logs in
           Given I am on the front page
           When I fill in the login form and press 'login'
           Then I should be on my dashboard
    ")
  end

  describe '#parse' do
    let(:parsed) { @parser.parse }

    it 'parses the feature name' do
      parsed['name'].must_equal 'User authentication'
    end

    describe 'scenario' do
      before do
        @scenario = parsed['elements'][0]
      end

      it 'parses the scenario name' do
        @scenario['name'].must_equal 'User logs in'
      end

      it 'parses the scenario steps' do
        @scenario['steps'][0]['name'].must_equal 'I am on the front page'
        @scenario['steps'][1]['name'].must_equal(
         'I fill in the login form and press \'login\''
        )
        @scenario['steps'][2]['name'].must_equal 'I should be on my dashboard'
      end
    end
  end
end

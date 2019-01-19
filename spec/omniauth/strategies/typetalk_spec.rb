require 'spec_helper'

describe OmniAuth::Strategies::Typetalk do
  let(:access_token) { instance_double('AccessToken', :optinons => {}) }
  let(:parsed_response) { instance_double('ParsedResponse') }
  let(:response) { instance_double('Response', :parsed => parsed_response) }

  let(:localhost_site) { 'http://localhost/api/' }
  let(:localhost_authorize_url) { 'http://localhost/oauth2/authorize' }
  let(:localhost_token_url) { 'http://localhost/oauth2/access_token' }
  let(:localhost) do
    OmniAuth::Strategies::Typetalk.new('TYPETALK_KEY', 'TYPETALK_SECRET',
        {
            :client_options => {
                :site => localhost_site,
                :authorize_url => localhost_authorize_url,
                :token_url => localhost_token_url,
            }
        }
    )
  end

  subject do
    OmniAuth::Strategies::Typetalk.new({})
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context 'client options' do
    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://typetalk.com')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('https://typetalk.com/oauth2/authorize')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('https://typetalk.com/oauth2/access_token')
    end

    describe 'should be overrideable' do
      it 'for site' do
        expect(localhost.options.client_options.site).to eq(localhost_site)
      end

      it 'for authorize url' do
        expect(localhost.options.client_options.authorize_url).to eq(localhost_authorize_url)
      end

      it 'for token url' do
        expect(localhost.options.client_options.token_url).to eq(localhost_token_url)
      end
    end
  end

  context '#raw_info' do
    it 'should use relative paths' do
      expect(access_token).to receive(:get).with('api/v1/profile').and_return(response)
      expect(subject.raw_info).to eq(parsed_response)
    end
  end

  context '#info.name' do
    it 'should use name from raw_info' do
      allow(subject).to receive(:raw_info).and_return({ 'account' => { 'name' => 'is2ei' }})
      expect(subject.info['name']).to eq('is2ei')
    end
  end

  describe '#callback_url' do
    it 'is a combination of host, script name, and callback path' do
      allow(subject).to receive(:full_host).and_return('https://example.com')
      allow(subject).to receive(:script_name).and_return('/sub_uri')
      expect(subject.callback_url).to eq('https://example.com/sub_uri/auth/typetalk/callback')
    end
  end
end
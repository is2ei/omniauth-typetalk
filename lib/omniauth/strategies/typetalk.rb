require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    # Typetalk handles Oauth2 authentication with Typetalk.
    class Typetalk < OmniAuth::Strategies::OAuth2
      option :client_options,
             site: 'https://typetalk.com',
             authorize_url: 'https://typetalk.com/oauth2/authorize',
             token_url: 'https://typetalk.com/oauth2/access_token'

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            params[v.to_sym] = request.params[v] if request.params[v]
          end
        end
      end

      info do
        {
          'id' => raw_info['account']['id'],
          'name' => raw_info['account']['name'],
          'fullName' => raw_info['account']['fullName'],
          'suggestion' => raw_info['account']['suggestion'],
          'imageUrl' => raw_info['account']['imageUrl'],
          'isBot' => raw_info['account']['isBot'],
          'lang' => raw_info['account']['lang'],
          'timezoneId' => raw_info['account']['timezoneId'],
          'createdAt' => raw_info['account']['createdAt'],
          'updatedAt' => raw_info['account']['updatedAt']
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get('api/v1/profile').parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization 'typetalk', 'Typetalk'

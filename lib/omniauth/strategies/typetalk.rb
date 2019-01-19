require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Typetalk < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://typetalk.com',
        :authorize_url => 'https://typetalk.com/oauth2/authorize',
        :token_url => 'https://typetalk.com/oauth2/access_token',
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      info do
        {
          'name' => raw_info['account']['name']
        }
      end

      extra do
        {:raw_info => raw_info}
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

if defined? Rails
  class ActiveRecordPostgresExt < Rails::Railtie
    initializer 'postgresql_ext' do
      ActiveSupport.on_load :active_record do
        require 'postgres_ext'
      end
    end
  end
end
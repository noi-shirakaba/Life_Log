# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
			origins '192.168.99.100:8080' , 'localhost:8080'
      resource '/*', headers: :any, methods: [:get, :post, :put, :options]
    end
end
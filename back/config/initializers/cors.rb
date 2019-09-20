# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
			origins '192.168.99.100:8080' , 'localhost:8080' ,'127.0.0.1:3000' , 'localhost:3000'
      resource '/*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
    end
    	  #rack-cors setting
        #config.api_only = false
end
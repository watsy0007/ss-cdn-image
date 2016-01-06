# cat hello_world.rb
require "cuba"
require "cuba/safe"
require "qiniu"

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"

Cuba.plugin Cuba::Safe

Qiniu.establish_connection! :access_key => '',
                            :secret_key => ''

put_policy = Qiniu::Auth::PutPolicy.new(
    :mweb,     # 存储空间
)

uptoken = Qiniu::Auth.generate_uptoken(put_policy)

puts uptoken

Cuba.define do
  on get do
    on "hello" do
      res.write "Hello world!"
    end

    on root do
      res.redirect "/hello"
    end
  end

  on post do
    on "image" do
      file = param('file').call
      puts file[0]
      open(file[0][:tempfile]) do |file|
        puts file.size
      end
      code, result, response_headers = Qiniu::Storage.upload_with_put_policy(
    put_policy,     # 上传策略
    file[0][:tempfile]
)
      puts code, result, response_headers
      #res.write req.to_s
      res['Content-Type'] = 'application/json'
      result = "{\"key\": \"#{result['key']}\"}"
      puts result
      res.write result
    end
  end
end

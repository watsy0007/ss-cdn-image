require "cuba"
require "cuba/safe"
require "qiniu"

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"
Cuba.plugin Cuba::Safe

Qiniu.establish_connection!(access_key: ENV['AK'], secret_key: ENV['SK'])
put_policy = Qiniu::Auth::PutPolicy.new(:mweb)
uptoken = Qiniu::Auth.generate_uptoken(put_policy)

Cuba.define do
  on get { on root { res.write 'hello' }}
  on post do
    on "image" do
      puts '123123';
      file = param('file').call
      puts file[0][:tempfile].size
      code, result, response_headers = Qiniu::Storage.upload_with_put_policy(
		put_policy,file[0][:tempfile])	
      res['Content-Type'] = 'application/json'
      res.write "{\"key\": \"#{result['key']}\"}"
    end
  end
end

# cat hello_world.rb
require "cuba"
require "cuba/safe"
require "qiniu"

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"

Cuba.plugin Cuba::Safe

Qiniu.establish_connection! :access_key => '',
                            :secret_key => ''

put_policy = Qiniu::Auth::PutPolicy.new(:mweb)
uptoken = Qiniu::Auth.generate_uptoken(put_policy)

Cuba.define do
  on post do
    on "/" do
      file = param('file').call
      code, result, response_headers = Qiniu::Storage.upload_with_put_policy(
		put_policy,# 上传策略
		file[0][:tempfile])	
      res['Content-Type'] = 'application/json'
      res.write "{\"key\": \"#{result['key']}\"}"
    end
  end
end

namespace '/tweets' do
  post '/submit' do
    puts params
    $client.update(params[:body])
  end

end
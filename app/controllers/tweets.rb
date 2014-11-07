namespace '/tweets' do
  post '/submit' do
    $client.update(params[:body])
  end

end
class FiguresController < ApplicationController
  # add controller methods

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all 
    @landmarks = Landmark.all 
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  post '/figures' do
    @figure = Figure.create(name: params[:figure][:name])
    if params[:figure].has_key?("title_ids")
      params[:figure][:title_ids].each do |checked_id|
        title_find = Title.find(checked_id.to_i)
        @figure.titles << title_find
        @figure.save
      end
    end
    if !params[:title][:name].empty?
      @title_new = Title.create(params[:title])
      @figure.titles << @title_new
      @figure.save
    end
    if params[:figure].has_key?("landmark_ids")
      params[:figure][:landmark_ids].each do |checked_id|
        landmark_find = Landmark.find(checked_id.to_i)
        @figure.landmarks << landmark_find
        @figure.save
      end
    end
    if !params[:landmark][:name].empty?
      @landmark_new = Landmark.create(params[:landmark])
      @figure.landmarks << @landmark_new
      @figure.save
    end
    redirect to "/figures/#{@figure.id}"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(name: params[:figure][:name])
    if params[:figure].has_key?("title_ids")
      params[:figure][:title_ids].each do |checked_id|
        title_find = Title.find(checked_id.to_i)
        @figure.titles << title_find
        @figure.save
      end
    end
    if !params[:title][:name].empty?
      @title_new = Title.create(params[:title])
      @figure.titles << @title_new
      @figure.save
    end
    if params[:figure].has_key?("landmark_ids")
      params[:figure][:landmark_ids].each do |checked_id|
        landmark_find = Landmark.find(checked_id.to_i)
        @figure.landmarks << landmark_find
        @figure.save
      end
    end
    if !params[:landmark][:name].empty?
      @landmark_new = Landmark.create(params[:landmark])
      @figure.landmarks << @landmark_new
      @figure.save
    end
    redirect to "/figures/#{@figure.id}"
  end
end

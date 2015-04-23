class PlacesController < ApplicationController
	def index
		@places = Place.all
	end

	def show
		@place = Place.find_by(:id => params["id"])
		@reviews = Review.where(:place_id => params["id"]).order("created desc")
	end

	def delete
		@place = Place.find_by(:id => params["id"])
		@place.delete
		redirect_to "/", notice: "Place deleted."
	end

	def new
	end

	def create
		p = Place.new
		p.title = params["title"]
		p.photo_url = params["photo_url"]
		p.price = (params["price"].to_f * 100).round
		p.description = params["description"]
		p.save
		redirect_to "/", notice: "Place created."
	end

	def edit
		@place = Place.find_by(:id => params["id"])
	end

	def update
		@place = Place.find_by(:id => params["id"])
		@place.title = params["title"]
		@place.photo_url = params["photo_url"]
		@place.price = (params["price"].to_f * 100).round
		@place.description = params["description"]
		@place.save
		redirect_to "/places/#{@place.id}", notice: "Place updated."
	end

	def review
		r = Review.new
		r.title = params["title"]
		r.rating = params["rating"].to_i
		r.place_id = params["id"].to_i
		r.description = params["description"]
		r.created = DateTime.now
		r.save
		redirect_to "/places/#{params["id"]}", notice: "Review submitted."
	end

end
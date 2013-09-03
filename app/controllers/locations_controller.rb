class LocationsController < ApplicationController
  def list_countries
    if(params[:lang].nil?)
      @lang = 'en'
    else
      @lang = params[:lang].strip
      unless /[\w-]{2,5}/ =~ @lang
        raise ActionController::RoutingError.new('Not found')
      end
    end
    #@countries = Country.joins('JOIN location_names ON countries.geo_id=location_names.geo_id').where("location_names.lang='#{@lang}'")
    @countries= Country.select([:iso_2letters,"location_names.name"]).joins(:location_names).where("location_names.lang"=>@lang)
    respond_to do |format|
      format.json {
        render :json => @countries
      }
    end
  end

  def list_cities
    if(params[:lang].nil?)
      @lang = 'en'
    else
      @lang = params[:lang].strip
      unless /[\w-]{2,5}/ =~ @lang
        raise ActionController::RoutingError.new('Not found')
      end
    end
    unless params[:iso_2letters].nil?
      iso=params[:iso_2letters].to_s.strip;
      if iso.length!=2 or !(/\w\w/ =~ iso)
        raise ActionController::RoutingError.new('Not found')
      end
    else
      raise ActionController::RoutingError.new('Not found')
    end
    @query = (params[:query].nil?)?'':ActiveRecord::Base.connection.quote(params[:query].capitalize+'%')
    @cities = Location.select(['locations.geo_id','location_names.name']).joins(:location_names).
        where('location_names.lang'=>@lang,:country=>iso).
        where("location_names.name LIKE #{@query}")
    respond_to do |format|
      format.json {
        render :json => @cities
      }
    end
  end
end

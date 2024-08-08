class UrlsController < ApplicationController
    # before_action :in_memory_var

    def create
        if params[:url][:long_url].present?
            u = UrlStore::Store.new.create_url(params[:url][:long_url], params[:url][:custom_alias], params[:url][:ttl_seconds])
            Rails.logger.info("url::: #{u}")
            render json: u.to_json, status: :ok
        else
            render json: params.to_json, status: :not_ok
        end
    end

    def show_url
        u = UrlStore::Store.new
        data = u.find_url(params[:alias])
        Rails.logger.info("url show::: #{data}")
        if data.present?
            render json: data.to_json, status: :ok
        else
            render json: {error: "not found"}, status: :not_ok 
        end
    end

    def analytics

    end
    
    def delete

    end

    def update
    end

end
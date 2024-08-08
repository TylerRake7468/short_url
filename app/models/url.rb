module UrlStore
    class Store
        def initialize
            @url_data = {}
            @lock = Mutex.new
        end

        def create_url(long_url,c_al, ttl)
            al = c_al.present? ? c_al : generate_random_alias
            @lock.synchronize do
                @url_data = {
                    long_url: long_url,
                    short_url: generate_short_url(long_url, al),
                    alias: al,
                    ttl_seconds: ttl.present? ? ttl : 120,
                    created_at: Time.now,
                    access_count: 0,
                    access_times: []
                }
            end
            return @url_data
        end

        def find_url(al)
            @lock.synchronize do
                url_data = @url_data[al]
                Rails.logger.info "RRRRRRRRRRRRRRRRRRRRR::::  #{@url_data}"
                return url_data if url_data.present?
            end
            return nil
        end

        def generate_random_alias
            charset = Array('A'..'Z') + Array('a'..'z')
            Array.new(10) { charset.sample }.join
        end
    
        def generate_short_url(long_url, al)
            return "http://localhost:3000/" + al.to_s
        end
    end
end
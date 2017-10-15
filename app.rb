require 'sinatra/base'
require 'digest/sha2'
require 'mysql2-cs-bind'
require 'rack-flash'
require 'json'

module Isucon4
  class App < Sinatra::Base
    use Rack::Session::Cookie, secret: ENV['ISU4_SESSION_SECRET'] || 'shirokane'
    use Rack::Flash
    set :public_folder, File.expand_path('../../public', __FILE__)
    
    def initialize
      super()
      setup
    end
    
    def setup
      @user_cache = {}
      @locked_users = {}
      
      # -- locked users
      threshold = config[:user_lock_threshold]

      not_succeeded = db.xquery('SELECT cnt, user_id, login FROM (SELECT user_id, login, MAX(succeeded) as max_succeeded, COUNT(1) as cnt FROM login_log GROUP BY user_id) AS t0 WHERE t0.user_id IS NOT NULL AND t0.max_succeeded = 0')

      not_succeeded.each do |r|
        if threshold <= r['cnt']
          @locked_users[r['user_id']] = r['login']
        else
          @user_cache[r['user_id']] = {
            count: r['cnt'],
            login: r['login'],
          }
        end
      end

      last_succeeds = db.xquery('SELECT user_id, login, MAX(id) AS last_login_id FROM login_log WHERE user_id IS NOT NULL AND succeeded = 1 GROUP BY user_id')

      last_succeeds.each do |row|
        count = db.xquery('SELECT COUNT(1) AS cnt FROM login_log WHERE user_id = ? AND ? < id', row['user_id'], row['last_login_id']).first['cnt']
        if threshold <= count
          @locked_users[row['user_id']] = row['login']
        else
          @user_cache[row['user_id']] = {
            count: count,
            login: row['login'],
          }
        end
      end
    end
    
    helpers do
      def config
        @config ||= {
          user_lock_threshold: (ENV['ISU4_USER_LOCK_THRESHOLD'] || 3).to_i,
          ip_ban_threshold: (ENV['ISU4_IP_BAN_THRESHOLD'] || 10).to_i,
        }
      end

      def db
        Thread.current[:isu4_db] ||= Mysql2::Client.new(
          host: ENV['ISU4_DB_HOST'] || 'localhost',
          port: ENV['ISU4_DB_PORT'] ? ENV['ISU4_DB_PORT'].to_i : nil,
          username: ENV['ISU4_DB_USER'] || 'root',
          password: ENV['ISU4_DB_PASSWORD'],
          database: ENV['ISU4_DB_NAME'] || 'isu4_qualifier',
          reconnect: true,
        )
      end

      def calculate_password_hash(password, salt)
        Digest::SHA256.hexdigest "#{password}:#{salt}"
      end

      def login_log(succeeded, login, user_id = nil)
        
        if succeeded
          @user_cache.delete(user_id)
        else
          if @user_cache.has_key?(user_id)
            @user_cache[user_id][:count] += 1
            
            if @user_cache[user_id][:count] >= config[:user_lock_threshold]
              @locked_users[user_id] = login
            end
          else
            @user_cache[user_id] = {
              login: login,
              count: 1,
            }
          end
        end
        
        db.xquery("INSERT INTO login_log" \
                  " (`created_at`, `user_id`, `login`, `ip`, `succeeded`)" \
                  " VALUES (?,?,?,?,?)",
                 Time.now, user_id, login, request.ip, succeeded ? 1 : 0)
      end

      def user_locked?(user)
        return nil unless user

        @locked_users.has_key?(user['id'])
      end

      def ip_banned?
        log = db.xquery("SELECT COUNT(1) AS failures FROM login_log WHERE ip = ? AND id > IFNULL((select id from login_log where ip = ? AND succeeded = 1 ORDER BY id DESC LIMIT 1), 0);", request.ip, request.ip).first

        config[:ip_ban_threshold] <= log['failures']
      end

      def attempt_login(login, password)
        user = db.xquery('SELECT * FROM users WHERE login = ?', login).first

        if ip_banned?
          login_log(false, login, user ? user['id'] : nil)
          return [nil, :banned]
        end

        if user_locked?(user)
          login_log(false, login, user['id'])
          return [nil, :locked]
        end

        if user && calculate_password_hash(password, user['salt']) == user['password_hash']
          login_log(true, login, user['id'])
          [user, nil]
        elsif user
          login_log(false, login, user['id'])
          [nil, :wrong_password]
        else
          login_log(false, login)
          [nil, :wrong_login]
        end
      end

      def current_user
        return @current_user if @current_user
        return nil unless session[:user_id]

        @current_user = db.xquery('SELECT * FROM users WHERE id = ?', session[:user_id].to_i).first
        unless @current_user
          session[:user_id] = nil
          return nil
        end

        @current_user
      end

      def last_login
        return nil unless current_user

        db.xquery('SELECT * FROM login_log WHERE succeeded = 1 AND user_id = ? ORDER BY id DESC LIMIT 2', current_user['id']).each.last
      end

      def banned_ips
        ips = []
        threshold = config[:ip_ban_threshold]

        not_succeeded = db.xquery('SELECT ip FROM (SELECT ip, MAX(succeeded) as max_succeeded, COUNT(1) as cnt FROM login_log GROUP BY ip) AS t0 WHERE t0.max_succeeded = 0 AND t0.cnt >= ?', threshold)

        ips.concat not_succeeded.each.map { |r| r['ip'] }

        last_succeeds = db.xquery('SELECT ip, MAX(id) AS last_login_id FROM login_log WHERE succeeded = 1 GROUP by ip')

        last_succeeds.each do |row|
          count = db.xquery('SELECT COUNT(1) AS cnt FROM login_log WHERE ip = ? AND ? < id', row['ip'], row['last_login_id']).first['cnt']
          if threshold <= count
            ips << row['ip']
          end
        end

        ips
      end

      def locked_users
        @locked_users.each_value.to_a
      end
    end

    get '/' do
      erb :index, layout: :base
    end

    post '/login' do
      user, err = attempt_login(params[:login], params[:password])
      if user
        session[:user_id] = user['id']
        redirect '/mypage'
      else
        case err
        when :locked
          flash[:notice] = "This account is locked."
        when :banned
          flash[:notice] = "You're banned."
        else
          flash[:notice] = "Wrong username or password"
        end
        redirect '/'
      end
    end

    get '/mypage' do
      unless current_user
        flash[:notice] = "You must be logged in"
        redirect '/'
      end
      erb :mypage, layout: :base
    end

    get '/report' do
      content_type :json
      {
        banned_ips: banned_ips,
        locked_users: locked_users,
      }.to_json
    end
  end
end

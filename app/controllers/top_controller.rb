class TopController < ApplicationController
    def main
        if session[:login_uid] != nil
            render "main"
        else
            render "registration"
        end
    end
    
    
    def login
        if request.post?
            logger.debug params[:uid]
            if User.find_by(uid: params[:uid])
                user = User.find_by(uid: params[:uid])
                login_password = BCrypt::Password.new(user.pass)
                if login_password == params[:pass]
                    session[:login_uid] = params[:uid]
                    redirect_to top_main_path
                end
            else
                render "error"
            end
        end
    end
    
    def registration
        if request.post?
            @user = User.new(uid: params[:uid], pass: params[:pass])
            if @user.valid? #暗号化前にバリデーションを実行
                @user.pass = BCrypt::Password.create(params[:pass])
                @user.save
                redirect_to top_login_path, notice: '登録が完了しました。ログインしてください。'
            else
                render "registration" #エラーがあれば再度登録
            end
        end
    end
    
    
    def logout
        session.delete(:login_uid)
        redirect_to top_main_path
    end
end

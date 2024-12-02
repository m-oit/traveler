class Public::SessionsController < Devise::SessionsController

def new
 @user = User.new
end

def create
 @user = User.find_by(email: params[:email])

 if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect_to root_path, notice: 'ログインしました。'
  else
    flash.now[:alert] = 'メールアドレスまたはパスワードが間違っています。'
    render :new
  end
end

def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'ログアウトしました。'
end

def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
end
  
end

class SubscriptionsController < ApplicationController
before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_user.subscribed_posts << @post
    redirect_to @post, notice: 'Вы подписаны на обновления'
  end

  def destroy
    subscription = Subscription.find(params[:id])
    subscription.destroy if current_user.id == subscription.user_id
    redirect_to subscription.post,
                notice: 'subscriptions.destroy'
  end
end

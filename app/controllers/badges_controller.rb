class BadgesController < AuthController
  def index
    @badges = Badge.all
  end

  def my
    @badges = current_user.badges
  end
end

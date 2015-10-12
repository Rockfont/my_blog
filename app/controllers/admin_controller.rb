class AdminController < ArticlesController

  #before_filter: :index, :show
  layout "admin"
  http_basic_authenticate_with name: "dev", password: "123"

  def index_admin
    index
  end

end

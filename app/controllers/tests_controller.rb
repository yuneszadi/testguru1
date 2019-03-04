class TestsController < AuthController

  skip_before_action :authenticate_user!, only: [:index]
  before_action :find_user, only: %i[start create]
  before_action :find_test, only: %i[destroy update edit show start]

  def index
    @tests = Test.all
  end

  def show; end

  def new
    @test = Test.new
  end

  def create
    @test = @user.author_tests.new(test_params)
    if @test.save
      redirect_to @test
    else
      render :new
    end
  end

  def edit; end

  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path, notice: "Test #{@test.title} удален."
  end

  def start
    @user.tests.push(@test)
    redirect_to @user.test_passage(@test)
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end

  def find_user
    @user = User.find(session[:user_id])
  end

  def find_test
    @test = Test.find(params[:id])
  end
end

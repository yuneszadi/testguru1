class GistQuestionService
  def initialize(client: nil)
    @client = client || Octokit::Client.new(access_token: ENV['ACCESS_TOKEN'])
  end

  def create_gist(question)
    @question = question
    @test = @question.test
    Result.new(@client.create_gist(gist_params))
  end

  private

  def gist_params
    {
      description: I18n.t('services.gist_header', title: @test.title),
      public: false,
      files: {
        'text-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    [@question.body, *@question.answers.pluck(:body)].join("\n")
  end

  class Result
    def initialize(response)
      @response = response
    end

    def success?
      !@response.html_url.nil?
    end

    def html_url
      @response.html_url
    end
  end
end

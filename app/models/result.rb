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

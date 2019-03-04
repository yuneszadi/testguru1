module GistsHelper
  def gist_link(gist)
    link_to truncate(gist.question.body, length: 25),
            admin_question_path(gist.question)
  end
end

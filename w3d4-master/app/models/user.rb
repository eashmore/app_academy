class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true
  has_many(:authored_polls,
            class_name: "Poll",
            foreign_key: :author_id,
            primary_key: :id)

  has_many(:responses,
            class_name: "Response",
            foreign_key: :user_id,
            primary_key: :id)

          #  .joins('LEFT OUTER JOIN (SELECT responses.* FROM responses WHERE responses.user_id = ?) AS user_responses')
  # def completed_polls
  #   results = []
  #   data = Poll.select('polls.*, questions.*').joins(questions: [answer_choices: 'LEFT OUTER JOIN (SELECT responses.* FROM responses WHERE responses.user_id = ?) AS user_responses ON user_responses.answer_choice_id = answer_choices.id'])
  #           .group('polls.id')
  #           .having('COUNT(distinct questions.id) = COUNT(user_responses.id)')
  #   data.each do |poll|
  #     results << poll.title
  #   end
  #   results
  # end

      # .joins(questions) [answer_choices: 'LEFT OUTER JOIN (SELECT responses.* FROM responses WHERE responses.user_id = ?) AS user_responses ON user_responses.answer_choice_id = answer_choices.id'])
  def completed_polls
    results = []
    data = Poll
      .select('polls.*, questions.*')
      .joins(:questions)
      .joins('JOIN answer_choices ON answer_choices.question_id = questions.id')
      .group('polls.id')
      .having('COUNT(distinct questions.id) = COUNT(user_responses.id)')
    data.each do |poll|
      results << poll.title
    end
    results
  end

  def completed_polls_sql
    Poll.find_by_sql([<<-SQL, id])
      SELECT
        polls.*
      FROM
        polls
      INNER JOIN
        questions ON questions.poll_id = polls.id
      INNER JOIN
        answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN
       (SELECT
          responses.*
        FROM
          responses
        WHERE
          responses.user_id = ?)
      AS user_responses
      ON user_responses.answer_choice_id = answer_choices.id
      GROUP BY
        polls.id
      HAVING
        COUNT(distinct questions.id) = COUNT(user_responses.id)
    SQL
  end
end

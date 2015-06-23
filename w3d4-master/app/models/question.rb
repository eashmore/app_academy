class Question < ActiveRecord::Base
  validates :body, :poll_id, presence: true

  has_many(:answer_choices,
            class_name: 'AnswerChoice',
            foreign_key: :question_id,
            primary_key: :id
            )

  belongs_to(:poll,
              class_name: 'Poll',
              foreign_key: :poll_id,
              primary_key: :id
              )

  has_many(:responses,
            through: :answer_choices,
            source: :responses)

  # def results_n
  #   results = {}
  #   answer_choices.each do |choice|
  #     results[choice.body] = choice.responses.length
  #   end
  #
  #   results
  # end
  #
  # def results
  #   results = {}
  #   answer_choices.includes(:responses).each do |choice|
  #     results[choice.body] = choice.responses.length
  #   end
  #   results
  # end

  def results
    results = {}
    data = self.answer_choices.select('answer_choices.*, COUNT(responses.id) AS num_responses')
        .joins('LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id')
        .group('answer_choices.id')
    data.each do |row|
      results[row.body] = row.num_responses
    end
    results
  end

  def results_sql
    Question.find_by_sql([<<-SQL, id: id])
    SELECT
      answer_choices.*, COUNT(responses.id) AS num_responses
    FROM
      questions
    JOIN
      answer_choices ON answer_choices.question_id = questions.id
    LEFT OUTER JOIN
      responses ON responses.answer_choice_id = answer_choices.id
    WHERE
      questions.id = :id
    GROUP BY
      answer_choices.id;
    SQL
  end
end

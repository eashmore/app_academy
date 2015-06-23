class Response < ActiveRecord::Base
  validates :answer_choice_id, :user_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :user_not_author_of_poll

  belongs_to(:answer_choice,
            class_name: 'AnswerChoice',
            foreign_key: :answer_choice_id,
            primary_key: :id)

  belongs_to(:respondent,
              class_name: 'User',
              foreign_key: :user_id,
              primary_key: :id)

  has_one(:question,
          through: :answer_choice,
          source: :question)

  def sibling_responses
    compare_id = id ? id : 0
    question.responses.where("responses.id != :id", id: compare_id)
  end

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(user_id: user_id)
      errors[:user_id] << "User has already answered question!"
    end
  end

  def user_not_author_of_poll
    if question.poll.author_id == user_id
      errors[:user_id] << "Author can't answer own poll!"
    end
  end
end

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :question_text, :answer1, :answer2, :answer3, :answer4, :correct, :order, :correct_answer
end

class KaTopic < ActiveRecord::Base
  belongs_to :parent, class_name: "KaTopic"
  has_many :children, class_name: "KaTopic", foreign_key: "parent_id", dependent: :destroy
  has_many :ka_question, dependent: :destroy

  has_many :topic_competences, dependent: :delete_all
  has_many :competences, through: :topic_competences

  has_many :topic_constructs, dependent: :delete_all
  has_many :constructs, through: :topic_constructs

  has_many :problem_areas,  dependent: :delete_all
  has_many :ka_results,     through: :problem_areas

  def get_tree
    topics = []
    topics.push(self)
    self.children.each do |child|
      topics += child.get_tree
    end

    return topics
  end

  def get_active_questions
    questions = []
    topics = self.get_tree

    topics.each do |t|
      t.ka_question.each do |q|
        if q.disable == 0
          questions.push(q)
        end
      end
    end

    return questions
  end
end

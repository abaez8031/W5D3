require 'sqlite3'
require 'singleton'

class QuestionsDB < SQLite3::Database
    include Singleton
  
    def initialize
      super('questions.db')
      self.type_translation = true
      self.results_as_hash = true
    end
end

class Student
    attr_accessor :id, :fname, :lname
    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def self.find_by_id(id)
        student = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                students
            WHERE
                id = ?
        SQL
        return nil unless student

        Student.new(student)
    end
end

class Question
    attr_accessor :id, :title, :body, :author_id
    def initialize(options)
        @id = options[:id]
        @title = options[:title]
        @body = options[:body]
        @author_id = options[:author_id]
    end

    def self.find_by_id(id)
        question = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL
        return nil unless question

        Question.new(question)
    end
end

class Question_like

    attr_accessor :id, :user_id, :question_id
    def initialize(options)
        @id = options[:id]
        @user_id = options[:user_id]
        @question_id = options[:question_id]
    end

    def self.find_by_id(id)
        question_like = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_likes
            WHERE
                id = ?
        SQL
        return nil unless question_like

        Question_like.new(question_like)
    end
end

class Replies
    attr_accessor :id, :question_id, :parent_reply_id, :author_id, :body
    def initialize(options)
        @id = options[:id]
        @question_id = options[:question_id]
        @parent_reply_id = options[:parent_reply_id]
        @author_id = options[:author_id]
        @body = options[:body]
    end

    def self.find_by_id(id)
        reply = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?
        SQL
        return nil unless reply

        Replies.new(reply)
    end
end

class Question_follow
    attr_accessor :id, :user_id, :question_id
    def initialize(options)
        @id = options[:id]
        @user_id = options[:user_id]
        @question_id = options[:question_id]
    end

    def self.find_by_id(id)
        question_follow = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                id = ?
        SQL
        return nil unless question_follow

        Question_follow.new(question_follow)
    end
end
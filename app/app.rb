require_relative "db.rb"
require_relative "student.rb"
require 'active_record'

# not sure if we were meant to use an orm or raw sql in this assignment so i did both

# have to do some bullshit to get sql sanitization from activerecord::base
class SQLApp < ActiveRecord::Base
  class << self
    include ActiveRecord::Sanitization::ClassMethods

    def getAllStudents = execute_sql("SELECT * FROM students").to_a

    def addStudent(fname, lname, email, enrollment_date)
      execute_sql(
        "INSERT INTO STUDENTS (first_name, last_name, email, enrollment_date) VALUES (?,?,?,?)",
        fname, lname, email, enrollment_date
      )
    rescue ActiveRecord::RecordNotUnique 
      nil 
    end

    def updateStudentEmail(student_id, new_email) = execute_sql(
        "UPDATE students SET email=? WHERE student_id=?", 
        new_email, student_id
      )
    
    def deleteStudent(student_id) = execute_sql(
        "DELETE FROM students WHERE student_id=?",
        student_id
      )

    private
    
    def execute_sql(sql, *args)
      ActiveRecord::Base.connection.execute(
        sanitize_sql_array([sql, *args])
      )
    end
    
  end
end

# wow so clean i love ruby
class ORMApp
  class << self
    def getAllStudents = Student.all.to_a
    
    def addStudent(*args, **kwargs) = Student.create!(*args, **kwargs)

    def updateStudentEmail(student_id, email) = Student.find_by(student_id:)&.update!(email:)

    def deleteStudent(student_id) = Student.find_by(student_id:)&.delete
  end
end
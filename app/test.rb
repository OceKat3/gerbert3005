require "minitest/autorun"
require "minitest/pride"


require_relative "app"
require_relative "seed"

DEFAULT_STUDENTS = [{:student_id=>1, :first_name=>"John", :last_name=>"Doe", :email=>"john.doe@example.com", :enrollment_date=>"2023-09-01"},
 {:student_id=>2, :first_name=>"Jane", :last_name=>"Smith", :email=>"jane.smith@example.com", :enrollment_date=>"2023-09-01"},
 {:student_id=>3, :first_name=>"Jim", :last_name=>"Beam", :email=>"jim.beam@example.com", :enrollment_date=>"2023-09-02"}]

describe SQLApp do

  it "lists students" do
    seed
    _(SQLApp.getAllStudents).must_equal DEFAULT_STUDENTS
  end

  it "adds a student" do
    seed
    _(SQLApp.addStudent "first", "last", "a@b.c", "2020-01-01").wont_be_nil
    _(SQLApp.query_sql("SELECT email FROM students")).must_include({email:"a@b.c"})
    
    # does not duplicate an email and does not throw an error
    _(SQLApp.addStudent "first", "last", "a@b.c", "2020-01-01").must_be_nil
  end

  it "updates an email" do
    seed
    SQLApp.updateStudentEmail 1, "x@y.z"
    _(SQLApp.query_sql(
      "SELECT email FROM students WHERE student_id=1")
    ).must_equal [{email: "x@y.z"}]
  end

  it "deletes a student" do
    seed
    student_deleting = DEFAULT_STUDENTS.first
    _(SQLApp.query_sql("SELECT * FROM students")).must_include(student_deleting)
    _(SQLApp.deleteStudent student_deleting[:student_id]).wont_be_nil
    _(SQLApp.query_sql("SELECT * FROM students")).wont_include(student_deleting)
    
    # deleting a nonexistent student does not cause problems
    SQLApp.deleteStudent student_deleting[:student_id]
  end

end

describe ORMApp do

  it "lists students" do
    seed
    _(ORMApp.getAllStudents).must_equal DEFAULT_STUDENTS.map {|x| Student.new(**x)}
  end
  
  it "adds a student" do
    seed
    new_student = {
      first_name: "first", 
      last_name: "last", 
      email: "a@b.c", 
      enrollment_date:"2020-01-01"
    }
    _(ORMApp.addStudent(**new_student)).wont_be_nil
    _(SQLApp.query_sql("SELECT email FROM students")).must_include({email: "a@b.c"})
    
    # does not duplicate an email and does not throw an error
    _(ORMApp.addStudent(**new_student)).must_be_nil
  end

  it "updates an email" do
    seed
    ORMApp.updateStudentEmail 1, "x@y.z"
    _(SQLApp.query_sql(
      "SELECT email FROM students WHERE student_id=1")
    ).must_equal [{email: "x@y.z"}]
  end

  it "deletes a student" do
    seed
    student_deleting = DEFAULT_STUDENTS.first
      _(SQLApp.query_sql("SELECT * FROM students")).must_include student_deleting
    _(ORMApp.deleteStudent student_deleting[:student_id]).wont_be_nil
    _(SQLApp.query_sql("SELECT * FROM students")).wont_include student_deleting
    
    # deleting a nonexistent student does not cause problems
    ORMApp.deleteStudent student_deleting[:student_id]
  end

end

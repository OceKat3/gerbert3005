# gerbert3005

comp3005 datbabase management systems assignment 3

https://youtu.be/VRsQnKaHp18

a simple postgres schema and ruby functions that do CRUD operations

## usage

The assignment (comp3005 assignment 3) does not ask for a web frontend or anything, so this app is just a collection of ruby functions. To call these functions, use interactive ruby with the irb command, or run the tests with bin/test inside the dev service. 

irb will automatically import the application so that you may call functions from the console. e.g:

```
root@docker-desktop:/3005# irb
irb(main):001> ORMApp.getAllStudents
=> 
[#<Student:0x000078dcdb0bc080 student_id: 2, first_name: "Jane", last_name: "Smith", email: "jane.smith@example.com", enrollment_date: "2023-09-01">,
 #<Student:0x000078dcdc63a8d0 student_id: 3, first_name: "Jim", last_name: "Beam", email: "jim.beam@example.com", enrollment_date: "2023-09-02">,
 #<Student:0x000078dcdc63a790 student_id: 1, first_name: "John", last_name: "Doe", email: "x@y.z", enrollment_date: "2023-09-01">]
```

If you choose not to use vscode dev containers, then irb can be executed from the host:

```
PS C:\Compsci\comp3005\gerbert3005> docker compose exec dev irb
irb(main):001> SQLApp.deleteStudent(1)
=> #<PG::Result:0x0000770db6036d90 status=PGRES_COMMAND_OK ntuples=0 nfields=0 cmd_tuples=1>
irb(main):002> SQLApp.getAllStudents
=> 
[{:student_id=>2, :first_name=>"Jane", :last_name=>"Smith", :email=>"jane.smith@example.com", :enrollment_date=>"2023-09-01"},
 {:student_id=>3, :first_name=>"Jim", :last_name=>"Beam", :email=>"jim.beam@example.com", :enrollment_date=>"2023-09-02"}]
```

----

Everything needed for this project comes through docker. I like to use vscode dev containers but you can also just run: docker compose up -d, and then docker compose exec dev bin/test

for example, from powershell outside of the container:

```
PS C:\Compsci\comp3005\gerbert3005> docker compose up -d
[+] up 3/3
 ✔ Container gerbert3005-postgres-1 Started                                                                                                                                                                                    2.3s
 ✔ Container gerbert3005-dev-1      Started                                                                                                                                                                                    1.8s
 ✔ Container gerbert3005-pgadmin-1  Started                                                                                                                                                                                    1.3s

PS C:\Compsci\comp3005\gerbert3005> docker compose exec dev bin/test
WARN: Unresolved or ambiguous specs during Gem::Specification.reset:
      drb (~> 2.0)
      Available/installed versions of this gem:
      - 2.2.3
      - 2.2.0
WARN: Clearing out unresolved specs. Try 'gem cleanup <gem>'
Please report a bug if this causes problems.
Run options: --seed 6279

# Running:

........

Fabulous run in 0.280466s, 28.5240 runs/s, 78.4409 assertions/s.

8 runs, 22 assertions, 0 failures, 0 errors, 0 skips
```

i believe these tests cover the functionality we're expected to implement. Wait a min after docker compose up, otherwise tests will instantly fail to load pg because packages arem't installed yet.


## ruby

For my other classes, i've been using lots of python and c++. I wanted to switch it up and try the best language in the world, ruby

ActiveRecord is the most popular ruby ORM. It's a part of the larger Ruby on Rails framework, but this project just uses ActiveRecord. 

## container stuff

I decided to use this project as an opportunity to learn more about docker.

The ruby app and the two services postgres and pgadmin are run through docker compose, which is all controlled in compose.yaml

This project also uses a vscode dev container, which requires the dev containers addon; vscode will start a container and ssh into it. What's nice about working in a container is that I don't have to install ruby on my computer. Ruby is very frustrating to install, and it's equally annoying to manage ruby versions, so this is quite a lifesaver. 

## file structure

compose.yaml and ./decvcontainer are related to the development environment

app/db.rb opens a connection to postgres
app/seed.rb exposes a function seed, which resets the students table to the given data from the assignment
app/student.rb defines a model for the ActiveRecord ORM

app/app.rb is mostly where a TA should look to see if the assignment is complete
app/test.rb runs tests to make sure app/app.rb works

bin/seed and bin/test literally just run app/seed.rb and app/test.eb

.irbrc is a ruby script that adds to the default behaviour of the irb command when run in this directory
(in this case, .irbrc loads app/app.rb and app/seed.rb)

Gemfile is like a package.json or requirements.txt, it is also a ruby script

## resources

https://minite.st/docs/
https://docs.docker.com/compose/gettingstarted
https://api.rubyonrails.org/v7.1/classes/ActiveRecord/Sanitization/ClassMethods.html#method-i-sanitize_sql_array

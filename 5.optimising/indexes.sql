-- Create indexes for these most typical queries on the db

-- TYP. QUERY1: find a student's historical course enrollments, based on their ID
SELECT courses.title, courses.semester
  FROM enrollments
       INNER JOIN courses
       ON enrollments.course_id = courses.id
       INNER JOIN students
       ON enrollments.student_id = students.id
 WHERE students.id = 3;

-- INDEX: 2/7 typical queries use it (SCAN enrollments)
CREATE INDEX IF NOT EXISTS idx_enrollments_on_student_id
ON enrollments (student_id);

-- TYP. QUERY2: find all students who enrolled in Computer Science 50 in Fall 2023
SELECT id, name
  FROM students
 WHERE id IN
       (SELECT student_id
          FROM enrollments
         WHERE course_id =
               (SELECT id
                  FROM courses
                 WHERE department = 'Computer Science'
                   AND number = 50
                   AND semester = 'Fall 2023'));

-- INDEX: 2/7 typical queries use it (SCAN enrollments), 2/7 queries use it (SCAN courses)
CREATE INDEX IF NOT EXISTS idx_enrollments_on_course_id
ON enrollments (course_id);

CREATE INDEX IF NOT EXISTS idx_courses_on_department
ON courses (department);

-- TYP. QUERY3: sort courses by most- to least-enrolled in Fall 2023
  SELECT courses.id, courses.department, courses.number, courses.title,
         COUNT(*) AS enrollment
    FROM courses
         INNER JOIN enrollments
         ON enrollments.course_id = courses.id
   WHERE courses.semester = 'Fall 2023'
GROUP BY courses.id
ORDER BY enrollment DESC;

-- INDEX: 2/7 typical queries use it (SCAN enrollments), 3/7 queries use it (SCAN courses)
CREATE INDEX IF NOT EXISTS idx_enrollments_on_course_id
ON enrollments (course_id);

CREATE INDEX IF NOT EXISTS idx_courses_on_semester
ON courses (semester);

-- TYP. QUERY4: find all computer science courses taught in Spring 2024
SELECT courses.id, courses.department, courses.number, courses.title
  FROM courses
 WHERE courses.department = 'Computer Science'
   AND courses.semester = 'Spring 2024';

-- INDEX: 2/7 typical queries use it (SCAN courses)
CREATE INDEX IF NOT EXISTS idx_courses_on_department
ON courses (department);

-- TYP. QUERY5: find the requirement satisfied by "Advanced Databases" in Fall 2023
SELECT requirements.name
  FROM requirements
 WHERE requirements.id =
       (SELECT requirement_id
          FROM satisfies
         WHERE course_id =
               (SELECT id
                  FROM courses
                 WHERE title = 'Advanced Databases'
                   AND semester = 'Fall 2023'));

-- INDEX: 2/7 typical queries use it (SCAN satisfies), 3/7 queries use it (SCAN courses)
CREATE INDEX IF NOT EXISTS idx_satisfies_on_course_id
ON satisfies (course_id);

CREATE INDEX IF NOT EXISTS idx_courses_on_semester
ON courses (semester);

-- TYP. QUERY6: find how many courses in each requirement a student has satisfied
  SELECT requirements.name, COUNT(*) AS courses
    FROM requirements
         INNER JOIN satisfies
         ON requirements.id = satisfies.requirement_id
   WHERE satisfies.course_id IN
         (SELECT course_id
            FROM enrollments
           WHERE enrollments.student_id = 8)
GROUP BY requirements.name;

-- INDEX: 2/7 typical queries use it (SCAN satisfies), 2/7 queries use it (SCAN enrollments)
CREATE INDEX IF NOT EXISTS idx_satisfies_on_course_id
ON satisfies (course_id);

CREATE INDEX IF NOT EXISTS idx_enrollments_on_student_id
ON enrollments (student_id);

-- TYP. QUERY7: search for a course by title and semester
SELECT department, number, title
  FROM courses
 WHERE title LIKE 'History%'
   AND semester = 'Fall 2023';

-- INDEX: 3/7 typical queries use it (SCAN courses)
CREATE INDEX IF NOT EXISTS idx_courses_on_semester
ON courses (semester);

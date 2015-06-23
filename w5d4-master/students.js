function Student(fname, lname) {
  this.name = fname + " " + lname;
  this.courses = [];
}

Student.prototype.enroll = function(course) {
  this.courses.push(course);
  course.addStudent(this);
};

Student.prototype.courseLoad = function() {
  var results = {};
  this.courses.forEach(function(course) {
    results[course.department] = (results[course.department] ?
      (results[course.department] + course.credits) : course.credits);
  });
  return results;
};

function Course(name, department, credits) {
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.students = [];
}

Course.prototype.addStudent = function(student) {
  this.students.push(student);
};

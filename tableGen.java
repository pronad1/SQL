import java.util.Scanner;
import java.io.*;
import java.util.Random;
import java.text.DecimalFormat;
public class tableGen {
  private static int maxClassroom = 100, maxStudent = 4000, maxDepartment = 50, 
    maxRoom = 1000, maxCourse = 1000, maxSection = 2000, maxAdvisor = 4000,
    maxInstructor = 1000, maxTeaches = 5000, maxTakes= 40000, maxPrereq =  1000;
  private static int maxBuilding = 100, maxName = 4200, maxDept = 100, maxTitle = 1000;
  private static double maxSalary = 100000.0;
  private static double maxBudget = 999999.0;
  private static int maxID = 99999;
  private static Random rnd = new Random();
  private static String[] buildingArray = new String[maxBuilding];
  private static String[] nameArray = new String[maxName];
  private static String[] deptNameArray = new String[maxDept];
  private static String[] titleArray = new String[maxTitle];
  private static Boolean[] teachesArray = new Boolean[maxSection];
  private static int[] nextCourseSection = new int[1000]; // starts at 0
  private static DecimalFormat moneyFormat = new DecimalFormat("0.00");
  
  //primary keys
  // classroom
  private static String[] classroomBuilding = new String[maxClassroom];
  private static int[] classroomRoom = new int[maxRoom];
  // department
  private static String[] departmentDeptName = new String[maxDepartment];
  // course
  private static int[] courseCourseID = new int[maxCourse];
  // store course dept for integrity check
  private static String[] courseDept = new String[maxCourse];
  // instructor
  private static int[] instructorID = new int[maxInstructor];
  // store instructor dept for integrity check
  private static String[] instructorDept = new String[maxInstructor];
  // section
  private static int[] sectionCourseID = new int[maxSection];
  private static int[] sectionSectionID = new int[maxSection];
  private static String[] sectionSemester = new String[maxSection];
  private static int[] sectionYear = new int[maxSection];
  // teaches
  private static int[] teachesID = new int[maxTeaches];
  private static int[] teachesCourseID = new int[maxTeaches];
  private static int[] teachesSectionID = new int[maxTeaches];
  private static String[] teachesSemester = new String[maxSection];
  private static int[] teachesYear = new int[maxSection];
  // student
  private static int[] studentID = new int[maxStudent];
  // takes
  private static int[] takesID = new int[maxTakes];
  private static int[] takesCourseID = new int[maxTakes];
  private static int[] takesSectionID = new int[maxTakes];
  private static String[] takesSemester = new String[maxTakes];
  private static int[] takesYear = new int[maxTakes];
  // advisor 
  private static int[] advisorID = new int[maxAdvisor];
  // time slot is defined statically
  // prereq
  private static int[] prereqCourseID = new int[maxPrereq];
  private static int[] prereqPrereqID = new int[maxPrereq];
    
  private static String squote(int val) {
	return ("'"+val+"'");
  }
  private static String squote(String text) {
	return ("'"+text+"'");
  }
  private static Scanner openFile(String fileName) {
    Scanner in = null;
    try {
      in = new Scanner(new FileInputStream (fileName));
    }
    catch(FileNotFoundException e) {
      System.out.println ("Could not open the file");
      System.exit (0);
    }
    return in;
  }
  private static PrintWriter outputFile(String fileName) {
    PrintWriter out = null;
    try {
      out = new PrintWriter (new FileOutputStream (fileName));
    }
    catch (FileNotFoundException e) {
      System.out.println ("Could not open the file");
      System.exit (0);
    }
    return out;
  }
  private static void fillArrays() {
    int i;
    // fill buildingArray
    Scanner in = openFile("buildingNames");
    i = 0;
    while (in.hasNext() && i < maxBuilding) {
      buildingArray[i++] = in.nextLine();
    }
    if (i < maxBuilding) maxBuilding = i;
    in.close();
    // fill nameArray
    in = openFile("personNames");
    i = 0;
    while (in.hasNext() && i < maxName) {
      nameArray[i++] = in.nextLine();
    }
    if (i < maxName) maxName = i;
    in.close();
    // fill deptNameArray
    in = openFile("deptNames");
    i = 0;
    while (in.hasNext() && i < maxDept) {
      deptNameArray[i++] = in.nextLine();
    }
    if (i < maxDept) maxDept = i;
    in.close();
    // fill titleArray
    in = openFile("courseTitles");
    i = 0;
    while (in.hasNext() && i < maxTitle) {
      titleArray[i++] = in.nextLine();
    }
    if (i < maxTitle) maxTitle= i;
    in.close();
  }
  private static String getBuilding() {
    // building char(15)
    return buildingArray[rnd.nextInt(maxBuilding)];
  }
  private static int getRoom() {
    // room_no char(7)
    return rnd.nextInt(maxRoom); // stick with 3 digit rooms
  }
  private static int getCapacity() {
    // capacity numeric(4,0)
    // we'll use 226 as max and bias it towards small rooms
    int i = rnd.nextInt(16);
    return 10 + rnd.nextInt(1+i*i); 
  }
  private static String getBudget() {
    // budget numeric(12,2)
    return moneyFormat.format(maxBudget*rnd.nextFloat());
  }  
  private static String getTitle() {
    // title char(50)
    return titleArray[rnd.nextInt(maxTitle)];
  }
  private static int getCredits() {
    // credits numeric(2,0)
    return rnd.nextBoolean() ? 3 : 4;
  }
  private static int getID() {
    // ID numeric(9,0)
    return rnd.nextInt(maxID+1);
  }
  private static String getName() {
    // name char(20)
    return nameArray[rnd.nextInt(maxName)];
  }
  private static String getDeptName() {
    // dept_name char(20)
    return deptNameArray[rnd.nextInt(maxDept)];
  }
  private static String getSalary() {
    // salary numeric(8,2)
    return moneyFormat.format(29000 + maxSalary*rnd.nextFloat());
  }
  private static int getCourseID() {
    // course_id char(8)
    // we'll have courses numbered 100 - 999
    return 101 + rnd.nextInt(899);
  }
  private static int getSecID(int courseID) {
    // sec_id char(8)
    // first section is section 1, then 2, by course number independent of year
    return ++nextCourseSection[courseID];
  }
  private static String getSemester() {
    // semester char(6) check semester in ('Fall', 'Winter', 'Spring', 'Summer')
    return rnd.nextBoolean() ? "Fall" : "Spring";
  }
  private static int getYear() {
    // year numeric(4,0) check (year > 1759 and year < 2100)
    // stick to 2001 through 2010
    return 2001 + rnd.nextInt(10);
  }
  private static int getTotCred() {
    // tot_cred numeric(3,0)
    return rnd.nextInt(130);
  }
  private static String getGrade() {
    // grade char(2)
    int pM = rnd.nextInt(3);
    int lG = rnd.nextInt(3); // just A, B, C
    String x;
    if (pM == 0) x = "-";
    else if (pM == 1) x = " "; 
    else x = "+";
    char y = (char) ((int)'A' + lG);
    return y + x;
  }
  private static String getTimeSlot() {
    // time_slot_id char(4)
    // this table is fixed with slots A through P
    char x = (char) ((int)'A' + rnd.nextInt(16));
    return "" + x;
  }
  public static void main(String[] args) { 
    int classroom = 30;
    int department = 20;
    int course = 200;
    int instructor = 50;
    int section = 100;
    int teaches = 100;
    int student = 2000;
    int takes = 30000;
    int advisor = 1000;
    int timeSlot = 10;
    int prereq = 100;
    int i = 0, j = 0, r = 0, c = 0, x = 0, y = 0;
    boolean tryValue = true;
    String b = "", d = "", s = "";
    fillArrays();
    // fill classroom
    PrintWriter out = outputFile("largeRelationsInsertFile.sql");
    out.println("delete from prereq;");
    out.println("delete from time_slot;");
    out.println("delete from advisor;");
    out.println("delete from takes;");
    out.println("delete from student;");
    out.println("delete from teaches;");
    out.println("delete from section;");
    out.println("delete from instructor;");
    out.println("delete from course;");
    out.println("delete from department;");
    out.println("delete from classroom;");
    out.println("insert into time_slot values ( 'A', 'M', 8, 0, 8, 50);");
    out.println("insert into time_slot values ( 'A', 'W', 8, 0, 8, 50);");
    out.println("insert into time_slot values ( 'A', 'F', 8, 0, 8, 50);");
    out.println("insert into time_slot values ( 'B', 'M', 9, 0, 9, 50);");
    out.println("insert into time_slot values ( 'B', 'W', 9, 0, 9, 50);");
    out.println("insert into time_slot values ( 'B', 'F', 9, 0, 9, 50);");
    out.println("insert into time_slot values ( 'C', 'M', 11, 0, 11, 50);");
    out.println("insert into time_slot values ( 'C', 'W', 11, 0, 11, 50);");
    out.println("insert into time_slot values ( 'C', 'F', 11, 0, 11, 50);");
    out.println("insert into time_slot values ( 'D', 'M', 13, 0, 13, 50);");
    out.println("insert into time_slot values ( 'D', 'W', 13, 0, 13, 50);");
    out.println("insert into time_slot values ( 'D', 'F', 13, 0, 13, 50);");
    out.println("insert into time_slot values ( 'E', 'T', 10, 30, 11, 45);");
    out.println("insert into time_slot values ( 'E', 'R', 10, 30, 11, 45);");
    out.println("insert into time_slot values ( 'F', 'T', 14, 30, 15, 45);");
    out.println("insert into time_slot values ( 'F', 'R', 14, 30, 15, 45);");
    out.println("insert into time_slot values ( 'G', 'M', 16, 0, 16, 50);");
    out.println("insert into time_slot values ( 'G', 'W', 16, 0, 16, 50);");
    out.println("insert into time_slot values ( 'G', 'F', 16, 0, 16, 50);");
    out.println("insert into time_slot values ( 'H', 'W', 10, 0, 12, 30);");


    // PrintWriter out = outputFile("classroom.txt");
    for (i = 0; i < classroom; i++) {
      tryValue = true;
      while (tryValue) {
        b = getBuilding();
        r = getRoom();
        tryValue = false;
        for (j = 0; j < i; j++) {
          if (b.equals(classroomBuilding[j]) && r == classroomRoom[j]) tryValue = true;
        }
      }
      classroomBuilding[i] = b;
      classroomRoom[i] = r;
      s = squote(b) + ", " + r + ", " + getCapacity();
      out.println ("insert into classroom values(" + s +");");
    }
    // out.close();   
    // fill department
    // out = outputFile("department.txt");
    for (i = 0; i < department; i++) {
      tryValue = true;
      while (tryValue) {
        d = getDeptName();
        tryValue = false;
        for (j = 0; j < i; j++) {
          if (d.equals(departmentDeptName[j])) tryValue = true;
        }
      }
      departmentDeptName[i] =  d;
      s = squote(d) + ", " + squote(getBuilding()) + ", " + getBudget();
      // out.println (s);
      out.println ("insert into department values(" + s +");");
    }
    // out.close();      
    // fill course
    // out = outputFile("course.txt");
    for (i = 0; i < course; i++) {
      tryValue = true;
      while (tryValue) {
        c = getCourseID();
        tryValue = false;
        for (j = 0; j < i; j++) {
          if (c == courseCourseID[j]) tryValue = true;
        }
      }
      courseCourseID[i] = c;
      courseDept[c]=departmentDeptName[rnd.nextInt(department)];
      s = squote(c) + ", " + squote(getTitle()) + ", " + squote(courseDept[c])
          + ", " + getCredits();
      // out.println (s);
      out.println ("insert into course values(" + s +");");
    }
    // out.close();      
    // fill instructor
    // out = outputFile("instructor.txt");
    for (i = 0; i < instructor; i++) {
      tryValue = true;
      while (tryValue) { 
        c = getID();
        tryValue = false;
        for (j = 0; j < i; j++) {
          if (c == instructorID[j]) tryValue = true;
        }
      }
      instructorID[i] = c;
      instructorDept[i]=departmentDeptName[rnd.nextInt(department)];
      s = squote(c) + ", " + squote(getName()) + ", " + squote(instructorDept[i] )
        + ", " + getSalary();
      // out.println (s);
      out.println ("insert into instructor values(" + s +");");
    }
    // out.close();      
    // fill section
    // out = outputFile("section.txt");
    for (i = 0; i < section; i++) {
      c = courseCourseID[rnd.nextInt(course)];
      r = getSecID(c);
      j = rnd.nextInt(classroom);
      sectionCourseID[i] = c;
      sectionSectionID[i] = r;
      b = getSemester();
      sectionSemester[i] = b;
      x = getYear();
      sectionYear[i] = x;
      s = squote(c)  + ", " + squote(r) + ", " + squote(b) + ", " + x +
        ", " + squote(classroomBuilding[j]) + ", " + squote(classroomRoom[j]) + ", " + squote(getTimeSlot());
      //out.println (s);
      out.println ("insert into section values(" + s +");");
    }
    // out.close();      
    // fill teaches
    // out = outputFile("teaches.txt");
    for (i = 0; i < maxSection; i++) teachesArray[i] = false;
    for (i = 0; i < teaches; i++) {
      tryValue = true;
      while (tryValue) {
        j = rnd.nextInt(section);
        tryValue = teachesArray[j];
      }
      teachesArray[j] = true;
      c = sectionCourseID[j];
      r = sectionSectionID[j];
      b = sectionSemester[j];
      x = sectionYear[j];
      //  insist that instructor be in same department as the course being taught
      int chosenInstructor = -1;
      for (y = 0; y < instructor; y++) {
        if (instructorDept[y] == courseDept[c]) {
          if (chosenInstructor == -1) chosenInstructor = y;
          else if (rnd.nextInt(10) > 1) chosenInstructor = y;
        }
      }
      y = chosenInstructor == -1 ? rnd.nextInt(instructor) : chosenInstructor;
      if (instructorDept[y] == courseDept[c]) System.out.println("teaching outside dept: " + 
           y + " " + c);
      s = squote(instructorID[y]) + ", " + squote(c) + ", " + squote(r) + ", " + squote(b) + ", " + x;
      // out.println (s);
      out.println ("insert into teaches values(" + s +");");
    }
    // out.close();      
    // fill student
    // out = outputFile("student.txt");
    for (i = 0; i < student; i++) {
      tryValue = true;
      while (tryValue) {
        c = getID();
        tryValue = false;
        for (j = 0; j < i; j++) {
          if (c == studentID[j]) tryValue = true;
        }
      }
      studentID[i] = c;
      s = squote(c) + ", " + squote(getName()) + ", " + squote(departmentDeptName[rnd.nextInt(department)])
        + ", " + getTotCred();
      // out.println (s);
      out.println ("insert into student values(" + s +");");

    }
    // out.close();     
    // fill takes
    // out = outputFile("takes.txt");
    for (i = 0; i < takes; i++) {
      tryValue = true;
      while (tryValue) {
        j = rnd.nextInt(student);
        x = studentID[j];
        j = rnd.nextInt(section);
        c = sectionCourseID[j];
        r = sectionSectionID[j];
        b = sectionSemester[j];
        y = sectionYear[j];
        tryValue = false;
        for (j = 0; j < i; j++) {
          if (x == takesID[j] && c == takesCourseID[j] && r == takesSectionID[j]) 
            tryValue = true;
        }
      }
      takesID[i] = x;
      takesCourseID[i] = c;
      takesSectionID[i] = r;
      takesSemester[i] = b;
      takesYear[i] = y;
      s = squote(x) + ", " + squote(c) + ", " + squote(r) + ", " + squote(b) + ", " + y + ", " + squote(getGrade());
      // out.println (s);
      out.println ("insert into takes values(" + s +");");
    }
    //out.close();     
    // fill advisor
    //out = outputFile("advisor.txt");
    for (i = 0; i < student; i++) {
      s = squote(studentID[i]) + ", " + squote(instructorID[rnd.nextInt(instructor)]) ;
      // out.println (s);
      out.println ("insert into advisor values(" + s +");");
    }
    // out.close();      
    // fill prereq
    // out = outputFile("prereq.txt");
    for (i = 0; i < prereq; i++) {
      s = squote(courseCourseID[rnd.nextInt(course)]) + ", " + squote(courseCourseID[rnd.nextInt(course)]);
      // out.println (s);
      out.println ("insert into prereq values(" + s +");");
    }
    out.close();   
  }
}


rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission &> /dev/null
if [[ $? != 0 ]]
then
    echo 'Failed to clone repository!'
    exit 1
fi
echo 'Finished cloning'

if [[ ! -f ./student-submission/ListExamples.java ]]
then
    echo 'Expected "ListExamples.java" at root of repository, but was not found!'
    exit 1
fi

cp -r lib/ student-submission/ListExamples.java TestListExamples.java grading-area
# Draw a picture/take notes on the directory structure that's set up after
# getting to this point
# 
# ├── GradeServer.java
# ├── grade.sh
# ├── grading-area
# │   ├── lib
# │   │   ├── hamcrest-core-1.3.jar
# │   │   └── junit-4.13.2.jar
# │   ├── ListExamples.java
# │   └── TestListExamples.java
# ├── lib
# │   ├── hamcrest-core-1.3.jar
# │   └── junit-4.13.2.jar
# ├── Server.java
# ├── student-submission
# │   └── ListExamples.java
# └── TestListExamples.java

# Then, add here code to compile and run, and do any post-processing of the
# tests

cd grading-area
CPATH='.:ib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
javac -cp $CPATH *.java &> /dev/null

if [[ $? != 0 ]]
then
    echo 'Failed to compile files!'
    exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test_output.txt

grep -i "tests" test_output.txt
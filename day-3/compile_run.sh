#/bin/sh 

kotlinc main.kt -include-runtime -d main.jar
java -jar main.jar

rm ./main.jar
rm ./MainKt.class
rm -rf ./META-INF

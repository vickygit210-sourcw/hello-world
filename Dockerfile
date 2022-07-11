FROM tomcat:latest
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
COPY /var/lib/jenkins/workspace/Pipelinejob_build_test/hello-world/webapp/target/*.war /usr/local/tomcat/webapps

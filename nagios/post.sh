#!/bin/bash


export PROJECT_HOME="/app"
export WORK="/work"
export NAGIOS_HOME="/app/nagios"

if [ -e ${NAGIOS_HOME} ]
then
    echo "${NAGIOS_HOME} already exists."
else
    echo "${NAGIOS_HOME} does not exists."
    tar xvfz $WORK/nagios.tar.gz
fi

# httpd start
service httpd start

# Start supervisord
#service nagios start

echo "Running the run_supervisor!"
supervisord -n

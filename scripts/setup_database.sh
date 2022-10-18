#!/bin/bash

#TODO: This doesn't handle test databases correctly
RESULT=`psql -l | grep "frontend_components" | wc -l | awk '{print $1}'`;
if test $RESULT -eq 0; then
    echo "Creating Database";
    psql -c "create role frontend_components with createdb encrypted password 'frontend_components' login;"
    psql -c "alter user frontend_components superuser;"
    psql -c "create database frontend_components with owner frontend_components;"
else
    echo "Database exists"
fi

#run initial setup of database tables
poetry run python manage.py migrate

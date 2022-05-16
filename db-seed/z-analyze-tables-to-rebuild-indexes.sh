#!/bin/bash
RUN_SQL=/tmp/analyze_all_tables.sql
RUN_LOG=/tmp/analyze_all_tables.log

MYSQL_HOST=localhost
MYSQL_AUSER=root
MYSQL_PASS=secret
MYSQL_AUTH="-h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASS}"

DB=project

SQL="SELECT CONCAT('ANALYZE LOCAL TABLE \`',table_schema,'\`.\`',table_name,'\`;')"
SQL="${SQL} FROM information_schema.tables"
SQL="${SQL} WHERE table_schema='${DB}'"
SQL="${SQL} AND engine IS NOT NULL"

# Create SQL Commands to run ANALYZE TABLE
mysql ${MYSQL_AUTH} -ANe"${SQL}" > ${RUN_SQL}

# Execute ANALYZE TABLE Commands
mysql ${MYSQL_AUTH} --table < ${RUN_SQL} > ${RUN_LOG} 2>&1
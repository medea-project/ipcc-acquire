#! /bin/sh
# Acquire records from 'giec' database for export in TSV format
#
# USAGE:
# acquire.sh [user] [host] [password]
# with
#   user - optional, string, database user name, defaults to 'root'
#   host - optional, string, database host name, defaults to 'localhost'
#   password - optional, string, database user password,
#              defaults to 'no password' which provides no password;
#              an empty string results in a prompt for password.
user=${1:-'root'}
host=${2:-'localhost'}
password=${3:-'no password'}

if [ "$password" = 'no password' ]
then
  passwordParam=''
else
  passwordParam="--password $password"
fi

query="mysql --host $host --user $user $passwordParam"

# change to the script's directory
cd $(dirname $0)

# create output directory
mkdir -p output

echo 'Acquire Author Records'
$query \
  < sql/acquire-author-records.sql \
  > output/authors.tsv

echo 'Acquire Contribution Type Categories'
$query \
  < sql/acquire-contribution-type-categories.sql \
  > output/contribution-type-categories.tsv

echo 'Acquire Total Contributions List'
$query \
  < sql/acquire-total-contributions-list.sql \
  > output/total-contributions-list.tsv

echo 'Acquire Total Contributions Categories'
$query \
  < sql/acquire-total-contributions-categories.sql \
  > output/total-contributions-categories.tsv

echo 'Acquire Role List'
$query \
  < sql/acquire-role-list.sql \
  > output/role-list.tsv

echo 'Acquire Role Categories'
$query \
  < sql/acquire-role-categories.sql \
  > output/role-categories.tsv

echo 'Acquire Working Group List'
$query \
  < sql/acquire-working-group-list.sql \
  > output/working-group-list.tsv

echo 'Acquire Working Group Categories'
$query \
  < sql/acquire-working-group-categories.sql \
  > output/working-group-categories.tsv

echo 'Acquire Assessment Reports List'
$query \
  < sql/acquire-assessment-report-list.sql \
  > output/assessment-report-list.tsv

echo 'Acquire Assessment Report Categories'
$query \
  < sql/acquire-assessment-report-categories.sql \
  > output/assessment-report-categories.tsv

echo 'Acquire Years of Assessment Reports'
$query \
  < sql/acquire-assessment-report-years.sql \
  > output/assessment-report-years.tsv

echo 'Acquire Institution List'
$query \
  < sql/acquire-institution-list.sql \
  > output/institution-list.tsv

echo 'Acquire Institution Categories'
$query \
  < sql/acquire-institution-categories.sql \
  > output/institution-categories.tsv

echo 'Acquire Country List'
$query \
  < sql/acquire-country-list.sql \
  > output/country-list.tsv

echo 'Acquire Country Categories'
$query \
  < sql/acquire-country-categories.sql \
  > output/country-categories.tsv

echo 'Acquire Cumulated Working Group Categories'
$query \
  < sql/acquire-cumulated-working-group-categories.sql \
  > output/cumulated-working-group-categories.tsv

echo 'Acquire Cumulated Working Group in Assessment Report Categories'
$query \
  < sql/acquire-cumulated-working-group-in-assessment-report-categories.sql \
  > output/cumulated-working-group-in-assessment-report-categories.tsv

echo 'Acquire Chapter in Working Group in Assessment Report Categories'
$query \
  < sql/acquire-chapter-in-working-group-in-assessment-report-categories.sql \
  > output/chapter-in-working-group-in-assessment-report-categories.tsv

echo 'Acquire Country and Working Group categories'
$query \
  < sql/acquire-country-and-working-group-categories.sql \
  > output/country-and-working-group-categories.tsv

echo 'Acquire Role in each Working Group categories'
$query \
  < sql/acquire-role-in-working-group-categories.sql \
  > output/role-in-working-group-categories.tsv

echo 'Acquire Discipline in each Working Group categories'
$query \
  < sql/acquire-discipline-in-working-group-categories.sql \
  > output/discipline-in-working-group-categories.tsv

echo 'Acquire Type of Institution in each Working Group categories'
$query \
  < sql/acquire-institution-type-in-working-group-categories.sql \
  > output/institution-type-in-working-group-categories.tsv

ls -l -h output
echo 'Export Complete'

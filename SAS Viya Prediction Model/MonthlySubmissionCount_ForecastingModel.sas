cas casauto terminate;
/* Start CAS session if not already running */
cas casauto sessopts=(timeout=1800 locale="en_US");

/* Assign CAS libraries */
caslib _all_ assign;

proc casutil;
list tables incaslib="casuser";
run;

/* Forecast - Monthly Submission count */

/* Step 1: remove the blank data */
data casuser.submissions_clean;
set casuser.submissions;

if not missing(SubmissionStatusDate);

run;

/* Step 2: Convert the date format to DDMMMYYY */
data casuser.submissions_monthly_clean;
set casuser.submissions_clean;

SubmissionDate = datepart(SubmissionStatusDate);

format SubmissionDate date9.;

run;

/* Step 3: Extract year and month */
data casuser.submissions_month;
set casuser.submissions_monthly_clean;

Year = year(SubmissionDate);
Month = month(SubmissionDate);

run;

/* Step 4: Monthly submission count */
proc fedsql sessref=casauto;

create table casuser.monthly_submissions {options replace=true} as

select
Year,
Month,
count(*) as Submission_Count

from casuser.submissions_month

group by Year, Month;

quit;

/* Step 5: Date column */
data casuser.monthly_submissions_final;
set casuser.monthly_submissions;

Date = mdy(Month,1,Year);
format Date monyy7.;

run;

/* Data check */
proc print data=casuser.monthly_submissions_final(obs=200);
run;

/* Step 6: Save this table to casuser */
proc casutil;
promote casdata="monthly_submissions_final" incaslib="casuser" outcaslib="casuser";
save casdata="monthly_submissions_final" incaslib="casuser" casout="monthly_submissions_final.sashdat" outcaslib="casuser" replace;
run;

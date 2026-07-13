/* Monthly submission-count feature build from
   MonthlySubmissionCount_ForecastingModel.sas.

   The original runs on SAS Viya against in-memory CAS tables (casuser.*)
   and closes by promoting/saving a CAS table. Here the same DATA-step
   feature engineering runs on the classic engine: the CAS session and
   proc casutil steps are dropped, the fedsql aggregation is expressed as
   proc sql, and casuser.submissions is replaced by the sample table below.
   The date-parsing and monthly-rollup logic is unchanged. */

/* Sample 'submissions' table standing in for the CAS casuser.submissions
   table. Same column shape the script reads: an ApplNo key and a
   SubmissionStatusDate datetime the DATA steps parse. A blank date row is
   included so the not-missing filter in Step 1 has something to drop. */
data submissions;
  infile datalines dsd dlm=',';
  length ReviewPriority $12;
  input ApplNo SubmissionStatusDate :datetime20. ReviewPriority $;
  format SubmissionStatusDate datetime20.;
datalines;
101,03JAN2020:00:00:00,PRIORITY
102,19JAN2020:00:00:00,STANDARD
103,,STANDARD
104,11FEB2020:00:00:00,STANDARD
105,27FEB2020:00:00:00,PRIORITY
106,08MAR2021:00:00:00,STANDARD
107,22MAR2021:00:00:00,PRIORITY
108,14APR2021:00:00:00,STANDARD
109,30APR2021:00:00:00,STANDARD
110,05MAY2022:00:00:00,PRIORITY
;
run;

/* Step 1: remove the blank data */
data submissions_clean;
set submissions;

if not missing(SubmissionStatusDate);

run;

/* Step 2: Convert the date format to DDMMMYYY */
data submissions_monthly_clean;
set submissions_clean;

SubmissionDate = datepart(SubmissionStatusDate);

format SubmissionDate date9.;

run;

/* Step 3: Extract year and month */
data submissions_month;
set submissions_monthly_clean;

Year = year(SubmissionDate);
Month = month(SubmissionDate);

run;

/* Step 4: Monthly submission count */
proc sql;

create table monthly_submissions as

select
Year,
Month,
count(*) as Submission_Count

from submissions_month

group by Year, Month;

quit;

/* Step 5: Date column */
data monthly_submissions_final;
set monthly_submissions;

Date = mdy(Month,1,Year);
format Date monyy7.;

run;

/* Data check */
proc print data=monthly_submissions_final(obs=200);
run;

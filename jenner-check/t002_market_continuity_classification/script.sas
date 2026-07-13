/* Market-continuity target + feature build from
   MarketContinuityStatus_ClassificationModel.sas.

   The original runs on SAS Viya against in-memory CAS tables (casuser.*)
   and closes by promoting/saving a CAS table. Here the same feature
   engineering runs on the classic engine: the CAS session and proc casutil
   steps are dropped, the two fedsql joins are expressed as proc sql, and the
   casuser.* inputs are replaced by the sample tables below. The
   target-variable rules, the priority_group flags, the scan()-based Form
   cleaning and the cmiss(of _all_) row filter are unchanged. */

/* Sample tables standing in for the CAS casuser.* inputs the classification
   script joins. Column shapes match what the script reads. The rows are
   chosen so both target-variable branches and all three priority_group
   branches fire, and so one Form value is blank for the scan()/UNKNOWN path. */

data MarketingStatus;
  input ApplNo ProductNo MarketingStatusID;
datalines;
101 1 1
102 1 3
103 1 5
104 1 1
105 1 3
;
run;

data MarketingStatus_Lookup;
  length MarketingStatusDescription $40;
  input MarketingStatusID MarketingStatusDescription $40.;
datalines;
1 Prescription
3 Discontinued
5 Over-the-counter
;
run;

data applications;
  length ApplType $10;
  input ApplNo ApplType $;
datalines;
101 NDA
102 ANDA
103 NDA
104 BLA
105 ANDA
;
run;

data submissions;
  infile datalines dsd dlm=',';
  length ReviewPriority SubmissionType SubmissionStatus $16;
  input ApplNo SubmissionStatusDate :datetime20. ReviewPriority $
        SubmissionType $ SubmissionClassCodeID SubmissionStatus $;
  format SubmissionStatusDate datetime20.;
datalines;
101,03JAN2020:00:00:00,PRIORITY,ORIG,10,AP
102,19JAN2020:00:00:00,STANDARD,SUPPL,11,AP
103,11FEB2020:00:00:00,901 ORDER,ORIG,12,AP
104,27FEB2021:00:00:00,PRIORITY,ORIG,10,AP
105,08MAR2021:00:00:00,STANDARD,SUPPL,11,AP
;
run;

data products;
  length Form $40;
  infile datalines dsd dlm='|';
  input ApplNo ProductNo Form $;
datalines;
101|1|TABLET; ORAL
102|1|SOLUTION; INTRAVENOUS
103|1|CAPSULE
104|1|
105|1|INJECTABLE; INTRAMUSCULAR
;
run;

/* Step 1: Join Market Status and lookup tables and create target variable */
proc sql;
create table target_data as
    select m.ApplNo,
           m.ProductNo,
           ml.MarketingStatusDescription
    from MarketingStatus m
    left join MarketingStatus_Lookup ml
    on m.MarketingStatusID = ml.MarketingStatusID;
quit;

data target_data;
    set target_data;

    if MarketingStatusDescription in ('Prescription','Over-the-counter','None (Tentative Approval)') then TargetMarketStatus = 1;
    else if MarketingStatusDescription in ('Discontinued','For Further Manufacturing Use') then TargetMarketStatus = 0;
run;

/* Step 2: Submission table feature */
data submissions_feat;
    set submissions;

    /* Date Features */
    year  = year(datepart(SubmissionStatusDate));
    month = month(datepart(SubmissionStatusDate));

    /* Priority Flag */
    if ReviewPriority in ('PRIORITY') then priority_group = 'PRIORITY';
    else if ReviewPriority in ('STANDARD') then priority_group = 'STANDARD';
    else if ReviewPriority in ('901 ORDER','901 REQUIRED') then priority_group = 'SPECIAL';
    else priority_group = 'UNKNOWN';
run;

/* Step 3: Product table features */
data products_feat;
    set products;

    /* Extract value before ';' */
    Form_clean = scan(Form, 1, ';');

    /* Handle missing */
    if Form_clean = '' then Form_clean = 'UNKNOWN';
run;

/* Step 4: Merge Tables */
proc sql;
create table final_market_continuity as
    select
        t.TargetMarketStatus,

        a.ApplType,

        s.SubmissionType,
        s.SubmissionClassCodeID,
        s.SubmissionStatus,
        s.priority_group,
        s.year,
        s.month,

        p.Form_clean as Form

    from target_data t

    left join applications a
        on t.ApplNo = a.ApplNo

    left join submissions_feat s
        on t.ApplNo = s.ApplNo

    left join products_feat p
        on t.ApplNo = p.ApplNo
       and t.ProductNo = p.ProductNo;
quit;

data cleaned_market_continuity;
    set final_market_continuity;

    /* Remove rows with missing values */
    if cmiss(of _all_) = 0;
run;

/* Data check */
proc print data=final_market_continuity(obs=200);
run;

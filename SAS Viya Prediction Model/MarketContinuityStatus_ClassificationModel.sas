/* Start CAS session if not already running */
cas casauto sessopts=(timeout=1800 locale="en_US");

/* Assign CAS libraries */
caslib _all_ assign;

proc casutil;
droptable casdata="target_data" incaslib="casuser" quiet;

quit;

/* Step 1: Join Market Status and lookup tables and create target variable */

proc fedsql sessref=casauto;

create table casuser.target_data {options replace=true} as
    select m.ApplNo,
           m.ProductNo,
           ml.MarketingStatusDescription
    from MarketingStatus m
    left join MarketingStatus_Lookup ml
    on m.MarketingStatusID = ml.MarketingStatusID;
quit;



data casuser.target_data;
    set casuser.target_data;

    if MarketingStatusDescription in ('Prescription','Over-the-counter','None (Tentative Approval)') then TargetMarketStatus = 1;
    else if MarketingStatusDescription in ('Discontinued','For Further Manufacturing Use') then TargetMarketStatus = 0;
run;


/* Step 2: Submission table feature */
data casuser.submissions_feat;
    set casuser.submissions;

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
data casuser.products_feat;
    set casuser.products;

    /* Extract value before ';' */
    Form_clean = scan(Form, 1, ';');

    /* Handle missing */
    if Form_clean = '' then Form_clean = 'UNKNOWN';
run;

/* Step 4: Merge Tables */

proc fedsql sessref=casauto;

create table casuser.final_market_continuity {options replace=true} as
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

proc sql;
    select count(*) as total_rows
    from casuser.model_data_nomiss;
quit;

data casuser.cleaned_market_continuity;
    set casuser.final_market_continuity;

    /* Remove rows with missing values */
    if cmiss(of _all_) = 0;
run;

/* Data check */
proc print data=casuser.final_market_continuity(obs=200);
run;

/* Save the data table */
proc casutil;
promote casdata="cleaned_market_continuity" incaslib="casuser" outcaslib="casuser";
save casdata="cleaned_market_continuity" incaslib="casuser" casout="cleaned_market_continuity.sashdat" outcaslib="casuser" replace;
run;

/*IMPORT DATA*/
proc import datafile="/home/u62868661/Datasets/T-Test/Directed Reading Activities.csv"
dbms=csv
out=df
replace;
run;

/*DESCRIPTIVE TABLE*/
proc means data=df chartype mean std min max median n vardef=df clm 
		alpha=0.05 q1 q3 qrange qmethod=os;
	var drp;
	class group;
run;

/*HISTOGRAMS*/
proc univariate data=df vardef=df noprint;
	var drp;
	class group;
	histogram drp / normal(noprint) kernel;
	inset mean std min max median n q1 q3 qrange / position=nw;
run;

/*BOXPLOT*/
proc boxplot data=df;
	plot (drp)*group / boxstyle=schematic;
	insetgroup mean stddev min max n q1 q2 q3 / position=top;
run;

/*TESTS FOR NORMALITY*/
proc univariate data=df normal mu0=0;
	ods select TestsForNormality;
	class group;
	var drp;
run;

/*T-TEST*/
proc ttest data=df sides=2 h0=0 plots(showh0);
	class group;
	var drp;
run;

/*NON-PARAMETRIC*/
proc npar1way data=df wilcoxon plots=wilcoxonplot;
	class group;
	var drp;
run;
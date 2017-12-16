function interval=confidenceInterval(x,confidence,dim)

% interval=ci(x,confidence,dim);
%
% 90%, 95% or 99%  confidence interval of a vector or 2d matrix
% Optional dim refers to dimension and must be 1 or 2 (default is 1).
% Optional confidence must either 90, 95 or 99 (default is 95).
%
% Calculated as the standard error multiplied by the critical two-tailed value of t for
% a=0.10, 0.05 or 0.01 (see Statistical methods in psychology, D.C. Howell). 
% This formula applies when the Population standard deviation is unknown. 
% As n gets larger then the t distribution approaches the normal distribution. 
% So, if n>120, uses z instead of t (e.g. 1.96 standard errors, for 95% interval)

% Raymond Reynolds 23/11/06

if nargin == 0
  return;
end

if nargin<3
  dim = min(find(size(x)~=1));
  if isempty(dim), dim = 1; end
end
if nargin<2
      dim = min(find(size(x)~=1));
  if isempty(dim), dim = 1; end
    confidence=95;
end

n=size(x,dim);
sd=std(x,0,dim);
sem=sd./sqrt(n);

if n==1
    n = 2; % little trick for avoiding crash
end

% t table for p=0.10
ttable90=[6.314	2.92	2.353	2.132	2.015	1.943	1.895	1.86	1.833	1.812...
        1.796	1.782	1.771	1.761	1.753	1.746	1.74	1.734	1.729	1.725...
        1.721	1.717	1.714	1.711	1.708	1.706	1.703	1.701	1.699	1.697...
        1.684	1.676	1.671	1.664	1.66	1.658	1.645];
% t table for p=0.05
ttable95=[12.71	4.303	3.182	2.776	2.571	2.447	2.365	2.306	2.262	2.228...
        2.201	2.179   2.16	2.145	2.131	2.12	2.11	2.101	2.093	2.086...
        2.08	2.074	2.069	2.064   2.06	2.056	2.052	2.048	2.045	2.042...
        2.021	2.009	2.00	1.99	1.984	1.98	1.96];
% t table for p=0.01
ttable99=[63.66	9.925	5.841	4.604	4.032	3.707	3.499	3.355	3.25	3.169...
        3.106	3.055	3.012	2.977	2.947	2.921	2.898	2.878	2.861	2.845...
        2.831	2.819	2.807	2.797	2.787	2.779	2.771	2.763	2.756	2.75...
        2.704	2.678	2.66	2.639	2.626	2.617	2.576];

if confidence==90;
      	if n<30
		t=ttable90(n-1);
        elseif n<30; t=ttable90(n-1);
        elseif n<40; t=ttable90(30);
        elseif n<50; t=ttable90(31);
        elseif n<60; t=ttable90(32);
        elseif n<80; t=ttable90(33);
        elseif n<100; t=ttable90(34);
        elseif n<120; t=ttable90(35);
        elseif n==120; t=ttable90(36);
        elseif n>120; t=ttable90(37);
		end
elseif confidence==95;
  		if n<30
		t=ttable95(n-1);
        elseif n<30; t=ttable95(n-1);
        elseif n<40; t=ttable95(30);
        elseif n<50; t=ttable95(31);
        elseif n<60; t=ttable95(32);
        elseif n<80; t=ttable95(33);
        elseif n<100; t=ttable95(34);
        elseif n<120; t=ttable95(35);
        elseif n==120; t=ttable95(36);
        elseif n>120; t=ttable95(37);
		end
elseif confidence==99;  
    	if n<30
		t=ttable99(n-1);
        elseif n<30; t=ttable99(n-1);
        elseif n<40; t=ttable99(30);
        elseif n<50; t=ttable99(31);
        elseif n<60; t=ttable99(32);
        elseif n<80; t=ttable99(33);
        elseif n<100; t=ttable99(34);
        elseif n<120; t=ttable99(35);
        elseif n==120; t=ttable99(36);
        elseif n>120; t=ttable99(37);
		end
end

interval=t.*sem;




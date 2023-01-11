function [force_length_regression] = get_muscle_force_length_regression()
%%% TASK 2

% Input Parameters
% data(:,1): samples of an independent variable
% data(:,2): corresponding samples of a dependent variable

% Output
% force_length_regression: the genered Gaussian model

%     WRITE CODE HERE
%      1) Use WebPlotDigitizer to extract force-length points
%     from Winters et al. (2011) Figure 3C, which is on Learn. Click
%     "View Data", select all, cut, and paste below. 
%     2) Normalize the data so optimal length = 1 and peak = 1. 
%     3) Return a Regression object that  uses Gaussian basis functions.

% Define data points
data = [41.794333683105975, 1.9072859438947773
39.40188877229801, 3.5798543635458486
37.38719832109129, 9.605919294452576
38.45750262329486, 14.448378946434062
41.416579223504726, 14.713910278560633
41.416579223504726, 15.68067765016184
40.40923399790137, 17.606096822563813
40.40923399790137, 21.714858151868953
39.275970619097585, 24.364338406621798
42.92759706190976, 23.668681822072458
43.43126967471144, 23.67273960747268
43.8719832109129, 22.226139112296025
41.416579223504726, 26.798502423575712
41.416579223504726, 31.63233928158178
42.10912906610703, 32.12130242230768
43.43126967471144, 35.27394806668717
43.43126967471144, 34.548872537986256
40.40923399790137, 36.69975241168768
42.5498426023085, 42.27591038634556
43.43126967471144, 44.69992993979895
44.37565582371458, 45.67430565902556
45.57187827911857, 46.650710270952274
45.57187827911857, 46.40901842805198
45.57187827911857, 43.50871631324834
46.705141657922354, 44.96799738780065
42.86463798530954, 46.62889967442612
42.86463798530954, 48.32074257472824
43.1794333683106, 50.25681343380579
43.43126967471144, 54.12591181291073
43.746065057712485, 57.27044188648979
45.194123819517316, 54.140114061811474
45.44596012591815, 53.65875926871098
44.438614900314796, 60.659707142019315
46.45330535152151, 62.85116486972289
47.39769150052466, 62.8587732173483
48.971668415529905, 63.113145639624264
47.71248688352571, 67.21176250542887
47.39769150052466, 72.04306324755979
45.697796432318995, 67.92060689252892
45.94963273871983, 71.06462974293296
46.45330535152151, 71.79376305703408
46.3903462749213, 73.72679057706146
46.64218258132214, 75.66235421296399
47.0828961175236, 80.98312531899583
47.460650577124866, 81.7112441867469
47.58656873032529, 81.95395047599726
48.15320041972717, 83.65035838487461
48.971668415529905, 82.44849307164844
48.971668415529905, 81.48172570004724
49.475341028331584, 76.41025478454111
50.60860440713536, 74.72754190138949
50.797481636936, 78.35444121441908
51.04931794333683, 78.8398537929198
50.923399790136415, 80.53068224687186
49.727177334732424, 82.21288790684847
48.9087093389297, 85.83167164907765
49.601259181532, 86.80401847560415
49.79013641133264, 85.11369724482711
50.230849947534104, 87.77585807895562
50.67156348373557, 87.53771679828051
50.60860440713536, 85.36198298900277
50.67156348373557, 90.92140259888475
51.4900314795383, 89.96122912855888
51.67890870933893, 91.17121001258548
52.62329485834208, 89.48697545990876
53.25288562434418, 89.00866400585842
53.63064008394544, 92.87877683131342
53.88247639034628, 92.39742203821292
54.13431269674711, 94.09129383121515
54.26023084994753, 94.81738380626611
53.441762854144805, 95.05248174789105
53.50472193074501, 96.7448318713682
53.75655823714585, 96.98855260696861
54.637985309548796, 99.89595584622262
55.70828961175236, 96.27920099669353
56.08604407135362, 96.523936178644
56.40083945435467, 100.15184993802367
56.77859391395593, 100.15489327707382
57.09338929695698, 99.67404570714837
57.2822665267576, 98.22541631927163
57.53410283315844, 99.91928811227385
57.8488982161595, 99.68013238524868
58.5414480587618, 96.54371788247005
53.50472193074501, 83.69347235475189
53.50472193074501, 79.10132733964616
57.78593913955929, 91.46210250346338
58.415529905561385, 90.98379104941304
59.29695697796432, 91.47427585966403
58.919202518363065, 99.68875517922413
59.359916054564536, 98.2421546840475
59.61175236096537, 96.06895699064489
59.800629590766, 97.2789378746715
59.92654774396642, 96.07149310652002
60.55613850996852, 99.94363482467514
60.55613850996852, 93.90133875216759
61.31164742917104, 95.35757648766972
61.37460650577125, 92.45778159604112
61.37460650577125, 88.10732842383568
62.193074501573975, 89.80576522541315
62.3189926547744, 96.81584311587196
61.24868835257083, 84.7226281768814
61.37460650577125, 79.88980576522542
61.37460650577125, 77.23119549332209
62.57082896117524, 80.14113484845123
63.45225603357817, 79.9065441300013
63.32633788037775, 81.11398889815275
63.83001049317944, 80.63466299775237
64.52256033578175, 82.33208535297979
63.5781741867786, 86.1915464917592
63.5781741867786, 85.70816280595861
63.07450157397691, 86.6708723921596
63.70409233997901, 87.40102015261078
63.641133263378805, 90.05912320133908
64.45960125918154, 87.4071068307111
63.892969569779645, 76.52640889162225
65.08919202518362, 76.53604613194776
66.41133263378804, 76.06331413282273
65.5299055613851, 73.15591089356873
66.09653725078698, 72.43540037344306
65.65582371458552, 68.56478032481304
65.71878279118573, 66.87344464768594
65.34102833158447, 64.45348287963277
63.32633788037775, 59.603414880025866
63.32633788037775, 53.319426964618
64.77439664218258, 53.814476783444235
64.77439664218258, 52.122633883142115
65.65582371458552, 48.26266552118767
66.8520461699895, 66.64088282193613
67.16684155299055, 63.501424980107345
67.73347324239245, 63.02260630288198
68.36306400839455, 60.12737641982862
67.4816369359916, 52.144444479668266
66.97796432318992, 42.956096664056574
69.3704092339979, 42.00860377310639
70.50367261280168, 48.785105391465336
67.35571878279119, 35.95007655899798
68.48898216159496, 27.741683917538197
70.18887722980062, 29.68891368646632
70.37775445960125, 30.173819041792015
71.38509968520461, 35.015771470598494
73.33683105981112, 35.03149538902433
72.89611752360966, 25.843654796587643
72.32948583420776, 24.872322416411194
73.33683105981112, 19.07983375760439
73.39979013641133, 17.871881766277895
73.33683105981112, 12.795845842196528
75.16264428121721, 18.127775858078948
74.34417628541448, 13.04565325589725
75.35152151101784, 12.812076983797382
76.3588667366212, 8.95312306819298];

x = data(:,1);
y = data(:,2);

% Normalization
Ny = y./max(y);
y_max = find(y == max(y));
Nx = (x)./x(y_max);

% Regression with "fit" function with "gauss2" option as model type
force_length_regression = fit(Nx, Ny, 'gauss2');
end

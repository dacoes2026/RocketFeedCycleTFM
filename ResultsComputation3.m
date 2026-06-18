function results= ResultsComputation3(data)


P10=data.P10;
T10= data.T10;
P11= data.P11;
T11= data.T11;
T40= data.T40;
P14= data.P14;
P13= data.P13;

%
etanozzle= data.etanozzle;
Pa= data.Pa;
epsilon= data.epsilon;
D64= data.D64;

Qcc= data.Qcc;
deltaPcc= data.deltaPcc;

PCH4= data.PCH4; %bar
TCH4= data.TCH4; %K
eta13= data.eta13;
eta16= data.eta16;

PLOX= data.PLOX;
TLOX=data.TLOX;

eta10=data.eta10;

deltaP72= data.deltaP72;

deltaP48= data.deltaP48;

eta12=data.eta12;

tau26=data.tau26;

deltaP43=data.deltaP43;

eta15= data.eta15;

deltaP41=data.deltaP41;

deltaP42=data.deltaP42;

Q26=data.Q26; 

deltaP26=data.deltaP26;

eta17= data.eta17;

deltaP44=data.deltaP44;

eta11=data.eta11;

deltaP49=data.deltaP49;

eta14=data.eta14;

tau16=data.tau16;

tau72=data.tau72;

D63= data.D63;

P52= data.P52;

P60= data.P60;

OF= data.OF;

mtotal= 1000;

mCH4= mtotal/(OF+1);

mLOX= (OF*mtotal)/(OF+1);


%m53= mCH4+m16
%m16 = tau16*m53
%Solving the system of equations the following equalities are found

m53= mCH4/(1-tau16);

m16= tau16*m53;

%Then we proceed as normal

m31= (1-tau16)*m53;

m72= tau72*m31;

m22= (1-tau72)*m31;

%m54= mLOX+m26
%m26= tau26*m52
%m52= m72+m54
%Solving the system of equations the following expressions are obtained

m52= (m72+mLOX)/(1-tau26);

m26= tau26*m52;

m54= mLOX+m26;

m41= (1-tau26)*m52;

m60= m22+m41;

species = {'CH4', 'O2', 'H2O', 'CO2', 'CO', 'H2', 'OH', 'H', 'O'};

[P72, T72]= valve(P10, T10, deltaP72, 'CH4');

results.P72= P72;

results.T72= T72;

[P49, T49]= valve(P11, T11, deltaP49, 'O2');

results.P49= P49;

results.T49= T49;

P48= P49; 

P12= P48*deltaP48;

results.P12= P12;

Pmax= NFP('CH4', 'maxp');

Pinterp= linspace(600, Pmax, 21);

for i=1:length(Pinterp)
    [Tinterp12(i),Winterp12(i)]= compressor(P72, T72, Pinterp(i), eta12, 'CH4', m72);
end

T12= interp1(Pinterp, Tinterp12, P12, 'pchip', 'extrap');

results.T12= T12;

W12= interp1(Pinterp, Winterp12, P12, 'pchip', 'extrap');


for i=1:length(Pinterp)
    [~, Tinterp48(i)]= valve(Pinterp(i), T12, deltaP48, 'CH4');
end

P48= P12/deltaP48;

T48= interp1(Pinterp, Tinterp48, P48, 'pchip', 'extrap');

results.P48= P48;

results.T48= T48;


n48= m72/NFP('CH4', 'MM');

m11= m52;

n11= m11/NFP('O2', 'MM');


[T52, n52]= combustionchamber(species, 'CH4', 'O2', n48, n11, P48, T48, P49, T49, P52, 1);

results.T52= T52;


P40= P10/deltaPcc; 

P41= P40;

P42= P41*deltaP41;

P15= P42*deltaP42;

[T15, W15, n15] = turbine_mixture(species, n52, P52, T52, P15, eta15);

results.P15= P15;

results.T15= T15;

results.W15= W15;

[P42, T42, n42]= valve_mixture(species, n15, P15, T15, deltaP42);

[P41, T41, n41]= valve_mixture(species, n42, P42, T42, deltaP41);

results.P41= P41;

results.T41= T41;

n40= zeros(length(species),1);

n40(1)= m22/NFP('CH4', 'MM');

[T60, n60] = combustionchambermixture(species, n40, 'CH4', P40, T40, n41, P41, T41, P60, 1);

results.T60= T60;

[m60,~,~]= Nozzleflow(species, n60, T60, P60, D63*1e-3); %D63= Dthroat


n60= n60*m60/mtotal;

results.m60= m60;

mtotal= m60;

m72old= m72;

m52old= m52;

mCH4= mtotal/(OF+1);

mLOX= (OF*mtotal)/(OF+1);

m53= mCH4/(1-tau16);

m16= tau16*m53;

m31= (1-tau16)*m53;

m72= tau72*m31;

m22= (1-tau72)*m31;

m52= (m72+mLOX)/(1-tau26);

m26= tau26*m52;

m54= mLOX+m26;

m41= (1-tau26)*m52;

m60= m22+m41;

W12= W12*m72/m72old;

W15= W15*m52/m52old;

results.W12= W12;

results.W15= W15;

[T14,W14]= compressor(PLOX, TLOX, P14, eta14, 'O2', mLOX);

results.T14= T14;

results.W14= W14;

P44= P14;

P17= P44*deltaP44;

results.P17= P17;

n42= n42*m52/m52old;

n26= n42*tau26;

P26= P42/deltaP26;

H42= HGSprop(species, n26, T42, P42, 'H');

H26= H42-Q26;

[T26,~,n26,~]= HGStp(species,n26,'H',H26,P26);

results.P26= P26;

results.T26= T26;

[T17, W17] = turbine_mixture(species, n26, P26, T26, P17, eta17);

results.T17= T17;

results.W17= W17;

[~, T44]= valve_mixture(species, n26, P17, T17, deltaP44);

h44= NFP('O2', 'h_pt', P44, T44);

h14= NFP('O2', 'h_pt', P14, T14);

h54= ((m26*h44)+(mLOX*h14))/m54;

P54= P14;

T54= NFP('O2', 't_hp', h54, P54);

[T11computed,W11]= compressor(P54, T54, P11, eta11, 'O2', m54);

results.T11= T11;

results.W11= W11;

[T13,W13]= compressor(PCH4, TCH4, P13, eta13, 'CH4', mCH4);

results.T13= T13;

results.W13= W13;

P43= P13;

P16= P43*deltaP43;

[T16,W16]= turbine(P10, T10, P16, eta16, 'CH4', m16);

results.P16= P16;

results.T16= T16;

results.W16= W16;

[~, T43]= valve(P16, T16, deltaP43, 'CH4');

h13= NFP('CH4', 'h_pt', P13, T13);

h43= NFP('CH4', 'h_pt', P43, T43);

h53= ((mCH4 * h13)+(m16 * h43))/m53;

P53= P13;

T53 = NFP('CH4', 't_hp', h53, P53);

[T10computed,W10]= compressor(P53, T53, P10, eta10, 'CH4', m53);

results.T10= T10;

results.W10= W10;

h22= NFP('CH4', 'h_pt', P10, T10);

h40= h22+(Qcc/m22);

P40= P10/deltaPcc;

T40computed = NFP('CH4', 't_hp', h40, P40);

results.P40= P40;

results.T40= T40;

H60 = HGSprop(species, n60, T60, P60, 'H');

H60cooled = H60-Qcc;

[T60cooled,~,n60cooled,~]= HGStp(species,n60,'H',H60cooled,P60);

M63=1;

[T63,~,n63,P63,~] = HGSisentropic(species,n60cooled,T60cooled,P60,'Shifting','M',M63);

[Rg63, a63]= HGSprop(species,n63,T63, P63,'Rg', 'a');

v63 = M63*a63; 

rho63 = (P63*1e5)/(Rg63*1000*T63); 

A63 = m60/(v63*rho63); 

D63= sqrt(A63*4/pi);

D63= D63*1000;

results.P63= P63;

results.T63= T63;

results.v63= v63;

results.M63= M63;

results.A63= A63;

results.D63= D63;

P64= data.P64;

[T64, v64, M64, ~, D64, F64, Isp64]=NozzleData(species, n63, v63, T63, P63, P64, Pa, m60, etanozzle, 'Frozen');

results.P64= P64;

results.T64= T64;

results.v64= v64;

results.M64= M64;

results.D64= D64;

results.Isp64= Isp64;

results.v64= v64;

results.F64= F64;

results.P10= P10;

results.P11= P11;

results.P14= P14;

results.P13= P13;



end
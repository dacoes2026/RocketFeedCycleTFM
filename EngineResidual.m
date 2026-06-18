function error= EngineResidual(x, data)

tau23= x(1);
tau53L= x(2);
tau16= x(3);
T11= x(4)*100;
T53= x(5)*100;
P53= x(6)*100;
P11= x(7)*100;

Dexitmain=data.Dexitmain;

Dthroatmain=data.Dthroatmain;

Dexitsec1=data.Dexitsec1;

epsilonsec1=data.epsilonsec1;

Dexitsec2= data.Dexitsec2;

epsilonsec2= data.epsilonsec2;

Dthroatsec1= Dexitsec1/sqrt(epsilonsec1);

Dthroatsec2= Dexitsec2/sqrt(epsilonsec2);

OFcc= data.OFcc;

PLOX= data.PLOX; %bar

TLOX= data.TLOX; %K

PLH2= data.PLH2; %bar

TLH2= data.TLH2; %K

Pa= data.Pa; %bar

eta11= data.eta11;

eta10= data.eta10;

eta12= data.eta12;

eta15= data.eta15;

eta16= data.eta16;

eta20= data.eta20;

eta21= data.eta21;

P60= data.P60;

deltaP44= data.deltaP44;

Qcc= data.Qcc;

KinjO2= data.KinjO2;
KinjH2= data.KinjH2;
Kinj40= data.Kinj40;
deltaPcc= data.Pcc;
betableed= data.betableed;
deltaP43= data.deltaP43;


%A. From the input data O2 and H2 flow rates are obtained

%1. Tc is computed with the chamber pressure using HGStp. Liguqi state at
%the inlet is assumed.

mcc= 1; %generic combustion chamber m50 mass

m53= mcc/(OFcc+1);

mO2= OFcc*mcc/(OFcc+1);

species= {'H2', 'O2', 'H2O', 'H', 'O', 'OH'};

n53= m53/NFP('H2', 'MM');

nO2= mO2/NFP('O2','MM');

[T60, n60]= combustionchamber(species, 'H2', 'O2', n53, nO2, P53, T53, P11, T11, P60, 1);

%2. The properties and gamma are computed

[m60, gamma60, Rg60]= Nozzleflow(species, n60, T60, P60, Dthroatmain);

mLOX = m60 * (OFcc / (1 + OFcc)); %O2 flow rate

m53= m60-mLOX; %H2 flow rate in main nozzle

%B. O2 flow

%1. From chamber pressure the pressure at theoutlet of pump 11 is obtained
%considering the injector pressure drop

%We assume density is kept constant throughout the first compressor and
%thus deltaP only depends on the mass flow


P11computed= P60+KinjO2*mLOX^2;

%2. From pressure at the outlet of pump 11 and tank pressures and the O2
%flow rate the power needed to move it W11 is found

[T11computed,W11]= compressor(PLOX, TLOX, P11computed, eta11, 'O2', mLOX);


%C. H2 flow

%1. From the power of the O2 pump W16 is found ignoring mechanical
%efficiency

%W16= W11;

%2. W16 depends on the pressure at the inlet and the outlet and mass flow
%m16. p16out will be considered to be known, othrwise it cannot be solved.
%First though, m16 must be found with the following expressions:


%mLH2= m23+m40
%m23= m33+m53L
%m53= m53L+m40
%Thus: mLH2= (m33+m53L)+m40
%mLH2= (m33+(m53-m40)+m40
%mLH2= m33+m53
%Then, m33= (1-tau53L)*m23 & m23=tau23*mLH2
%Thus mLH2= (1-tau53L)*tau23*mLH2+m53
%Meaning : mLH2= m53/(1- (1-tau53L)*tau23)

mLH2= m53/(1-(1-tau53L)*tau23);

m23= tau23*mLH2;

m40= mLH2-m23;

m32= (mLH2-m53);

m33= m32*(1-betableed);

m43= m32*betableed;

m16= tau16*m33;

m15= m33-m16;

m53L= tau53L*m23;

m66= m43+m16;


%Now that all the mass flows have been computed, let us continue

P53computed= P60+KinjH2*m53^2;

P40= P53+Kinj40*m40^2;

P53L= P40; %since they have to be the same pressure

P10= P40;

[T10,W10]= compressor(PLH2, TLH2, P10, eta10, 'pH2', mLH2);

P23= P53L;

P22= P23*deltaPcc;

[T22,W12]= compressor(P10, T10, P22, eta12, 'pH2', m23);


h22 = NFP('H2', 'h_pt', P22, T22);
h10 = NFP('H2', 'h_pt', P10, T10);

%Qcc = data.Qcc*(P60/66.49)^0.8; %In case we want to change P60

h23 = h22+(Qcc/ m23);

T23 = NFP('H2', 't_hp', h23, P23);

[P44, T44]= valve(P23, T23, deltaP44, 'H2');

[P43, T43]= valve(P23, T23, deltaP43, 'H2');

P16= P43;

P15= P16;

[T15, W15]= turbine(P44, T44, P15, eta15, 'H2', m15);

P45= P44;

T45= T44;

[T16, W16]= turbine(P45, T45, P16, eta16, 'H2', m16);

h43= NFP('H2', 'h_pt', P43, T43);

h16= NFP('H2', 'h_pt', P16, T16);

h54= ((m43*h43)+(m16*h16))/m66;

P54= P16;

T54= NFP('H2', 't_hp', h54, P54);

m66choked= Nozzleflowsec('pH2', T54, P54, Dthroatsec1);

m15choked= Nozzleflowsec('pH2', T15, P15, Dthroatsec2);

h53= ((m53L * h23)+(m40 * h10))/m53;

T53computed = NFP('H2', 't_hp', h53, P53);

error(1)= (W11+(eta21*W16))/abs(W11);
error(2)= ((W10+W12)+(eta20*W15))/abs(W10+W12);
error(3)= (m66-m66choked)/m66;
error(4)= (m15-m15choked)/m15;
error(5)= (T11-T11computed)/T11;
error(6)= (T53 - T53computed)/T53;
error(7)= (P53-P53computed)/P53;
error(8)= (P11-P11computed)/P11;

end
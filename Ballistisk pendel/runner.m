t = [1.072 1.056 1.060 1.056 1.052 1.076 1.056 1.072 1.068 1.056 1.060 1.068] * 10^-3;
R = 10E-2; % avstånd mellan dioder

%Mätmetod 1
ut = 0.004E-3; %Osäkerhet oscilloskop 
uR = 0.05E-2; %Osäkerhet linjal 


v_t =  R ./ t;

vt_osakerhet = sqrt( (ut./t).^2 + ( uR ./ R).^2) .* v_t;
vt_medelosakerhet = mean(vt_osakerhet);
vt_maxosakerhet = max(vt_osakerhet);

%Mätmetod 2
m_pendel = 37.286E-3;
m_kula = 5.370E-3 / 10;

g = 9.82;

uh = 0.5E-2;    % Osäkerhet höjd
ump = 0.001E-3; % Osäkerhet massa
umk = 0.001E-3; % Osäkerhet massa

h = [9 9 8 8 8 7 7 7 7 7 7 7]* 10^-2;

m_pk = m_pendel + m_kula;
v_pk = sqrt(2 .* g .* h);
v_p = ((m_pk) .* v_pk) ./ m_kula;

%v_p2 = sqrt(2 * m_pk *g * h / m_kula)



umpk = sqrt(ump.^2 + umk.^2);
uvf = sqrt((((2*g*uh) ./2) ./ v_pk).^2 ) .* v_pk;
vp_osakerhet = sqrt( (umpk ./m_pk).^2  +  (uvf ./ v_pk).^2 +     (umk ./ m_kula)^2) .* v_p;

v_t
v_p
vt_osakerhet;
vp_osakerhet;



EHojd = m_pk * g * h
Eskott = 0.5* m_kula* v_t.^2

forlorad_energi_t = Eskott - EHojd
rel =  forlorad_energi_t /  Eskott

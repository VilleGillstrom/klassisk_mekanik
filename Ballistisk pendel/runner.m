t = [1.072 1.056 1.060 1.056 1.052 1.076 1.056 1.072 1.068 1.056 1.060 1.068] * 10^-3;
R = 10E-2; % avstånd mellan dioder

%Mätmetod 1
ut = 0.004E-3; %Osäkerhet oscilloskop 
uR = 0; %Osäkerhet linjal TODO


vt =  R ./ t;

vt_osakerhet = sqrt( (ut./t).^2 + ( uR ./ R).^2) .* vt;
vt_medelosakerhet = mean(vt_osakerhet);
vt_maxosakerhet = max(vt_osakerhet);

%Mätmetod 2
m_pendel = 37.286E-3;
m_kula = 5.370E-3 / 10;

um = 0.001E-3;
uh = 0.5E-2;
ump = 0;
umk = 0;

h = [9 9 8 8 8 7 7 7 7 7 7 7]* 10^-2;

m_pk = m_pendel + m_kula;
Ep_p = m_pk * 9.82 * h;

vf = sqrt(2 * 9.82 * h);
vp = (m_pk .* vf) / m_kula;



friktionsenergin = Ep_p - (m_kula * vp /2);

umpk = sqrt(ump.^2 + umk.^2);
uvf = sqrt(((2*9.82*uh) ./ (2 * vf)).^2 ) .* vf;
vp_osakerher = sqrt( (umpk ./m_pk).^2  +  (uvf ./ vf).^2 +     (umk ./ m_kula)^2) .* vp;

vt
vp
vt_osakerhet
vp_osakerher


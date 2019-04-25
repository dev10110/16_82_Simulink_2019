function [cl,cx,cm] = get_coeffs_wing(a_w_deg,flap_deg,V,airplane,thr)

%for 10 degree motor mount (get_regression_coefficients(MAT,10,1,1,1), accurate as of 2/11/2019):
cl_coeffs =[0.4807    0.0801   -0.0001    0.0137   -0.0000;
           -0.0459    0.0392   -0.0000    0.0214   -0.0000];


cx_coeffs =[0.3430   -0.0086    0.0005   -0.0034    0.0000; 
           -1.1986    0.0136    0.0004    0.0158   -0.0001];

cm_coeffs = [-0.0346   -0.0009   -0.0000   -0.0031    0.0000;
             0.0419    0.0003    0.0000   -0.0037    0.0000];
         
cbar = airplane.geometry.Wing.cbar;
S= airplane.geometry.Wing.S;
[dCJ_s,~, T_s,~] = propulsor_perf_qprop(thr, airplane.propulsion.right_blower,cbar,S, 0 ,V*cosd(90-10))
[dCJ_B,~, ~,~] = propulsor_perf_qprop(thr, airplane.propulsion.right_blower,cbar,S, 0 ,V)
CT=2*T_s/(0.5*1.225*S*V^2);

Cl_ps_90=CT*sind(flap_deg+90);
Cl_ps_n90=CT*sind(flap_deg-90);

a=[1 dCJ_B]*cl_coeffs(:,3);
b=0;
c=[1 dCJ_B]*cl_coeffs(:,2);
d=[1 dCJ_B]*cl_coeffs(:,1);
alpha1=(-b+sqrt(b^2-3*a*c))/(3*a);
alpha2=(-b-sqrt(b^2-3*a*c))/(3*a);
alpha_max=max([alpha1 alpha2]);
alpha_min=min([alpha1 alpha2]);
%load data

cm=0;
cx=0;

if a_w_deg>=alpha_max
    [cl_amax,cx_amax,cm_amax]=regression_results(alpha_max, flap_deg, dCJ_B,cl_coeffs,cx_coeffs,cm_coeffs);
    cl=cl_amax+(a_w_deg-alpha_max)*(Cl_ps_90-cl_amax)/(90-alpha_max);
elseif a_w_deg<=alpha_min
    [cl_amin,cx_amin,cm_amin]=regression_results(alpha_min, flap_deg, dCJ_B,cl_coeffs,cx_coeffs,cm_coeffs);
    cl=cl_amin+(a_w_deg-alpha_min)*(Cl_ps_n90-cl_amin)/(-90-alpha_min);
else
    [cl,cx,cm]=regression_results(a_w_deg, flap_deg, dCJ_B,cl_coeffs,cx_coeffs,cm_coeffs);
end
%%% TO DO: Include the flap range fitting to this function%%%%%%%

% 
%     if round(flap_deg) == 40 
%         %Interpolate from wind tunnel data
%         [CL,CD,CM]=regression_results(a_w_deg, flap_deg, dCJ_B,CL_coeffs,CD_coeffs,CM_coeffs)
%     else
%         %Use linear TAT model with fixed cl_max
%         cl = min(2*pi*a_w_deg*pi/180, airplane.aero.Wing.cl_max_clean);
%     end
%     
    
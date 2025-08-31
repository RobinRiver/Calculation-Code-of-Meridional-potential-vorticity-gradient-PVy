The code of calculating the meridional gradient (PVy) of potential vorticity is given below.
   In the nonlinear multi-scale interaction (NMI) model of atmospheric blocking, the meridional gradient (PVy) of the basic potential vorticity is a key factor characterizing the spatiotemporal behavior of atmospheric blocking. When PVy is smaller, the blocking system has weaker dispersion and stronger nonlinearity. In this case, atmospheric blocking has longer lifetime, stronger intensity, larger zonal scale and slower eastward movement. The reversed results are found for a larger PVy.

The non-dimensional form of the barotropic PVy is 
PV_y=β-U_yy+FU,                     (1)
where β=β_0 L ̃^2/U ̃  is the non-dimensional β parameter, U is the non-dimensional basic zonal wind，β_0 is the north-south gradient of the Coriolis parameter, F=(L ̃/R_d )^2 is the barotropic Froude number, R_d is the radius of Rossby deformation, L ̃~1000km and U ̃~10m/s are the characteristic horizontal length and velocity respectively.
The non-dimensional form of the baroclinic PVy is 
PV_y=β-(∂^2 U)/(∂y^2 )-(1⁄(ρ_0)∂⁄∂z[ρ_0 ((L ̃^2 f_0^2)/H ̃^2 ^2 )(∂U/(∂z)])),        (2)
where β is the same as above, U=U(y,z) is the non-dimensional basic zonal wind, f_0 is the fixed Coriolis parameter, H ̃=10km is the characteristic vertical height, N^2 is the atmospheric stratification. When ρ_0=ρ_se^(-z) is applied (ρ_s is atmospheric density at the earth’s surface and z is the non-dimensional vertical coordinate), one can further simplify PV_y into
PV_y= β-(∂^2 U)/(∂y^2 )+F_r ∂U/∂z-F_r (∂^2 U)/(∂z^2 ),                    (3)
where F_r=(L ̃^2 f_0^2)/H ̃^2 N^2 

The code is designed to calculate the barotropic and baroclinic PVy. If you have any questions about the code program, please feel free to contact us (Email:shijq@tea.ac.cn; luobinhe@stu.ouc.edu.cn).

If you wish to learn more about PVy-related contents, please refer to the following papers.

References:
1. Luo, D., W. Zhang, L. Zhong, and A. Dai, 2019: A Nonlinear Theory of Atmospheric Blocking: A Potential Vorticity Gradient View. J. Atmos. Sci., 76, 2399–2427, https://doi.org/10.1175/JAS-D-18-0324.1.
2. Luo, D., X. Chen, J. Overland, I. Simmonds, Y. Wu, and P. Zhang, 2019: Weakened Potential Vorticity Barrier Linked to Recent Winter Arctic Sea Ice Loss and Midlatitude Cold Extremes. J. Climate, 32, 4235–4261, https://doi.org/10.1175/JCLI-D-18-0449.1.
3. Zhang, W., and D. Luo, 2019: A Nonlinear Theory of Atmospheric Blocking: An Application to Greenland Blocking Changes Linked to Winter Arctic Sea Ice Loss. J. Atmos. Sci., 77, 723–751, https://doi.org/10.1175/JAS-D-19-0198.1.
4. Luo, D., and W. Zhang, 2020: A Nonlinear Multiscale Theory of Atmospheric Blocking: Dynamical and Thermodynamic Effects of Meridional Potential Vorticity Gradient. J. Atmos. Sci., 77, 2471–2500, https://doi.org/10.1175/JAS-D-20-0004.1.
5. Luo, D., Luo, B. & Zhang, W. A Perspective on the Evolution of Atmospheric Blocking Theories: From Eddy-Mean flow Interaction to Nonlinear Multiscale Interaction. Adv. Atmos. Sci. 40, 553–569 (2023). https://doi.org/10.1007/s00376-022-2194-z
6. Luo, D., Zhang, W. & Luo, B. A Nonlinear Multi-Scale Interaction Model for Atmospheric Blocking: A Tool for Exploring the Impact of Changing Climate on Mid-to-High Latitude Weather Extremes. Adv. Atmos. Sci. 42, 2018–2035 (2025). https://doi.org/10.1007/s00376-024-4435-9

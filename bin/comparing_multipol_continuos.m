data0 = load('pendulum_multipol_dpg_density_base2.dat-0.txt');
data1 = load('pendulum_multipol_dpg_density_base2.dat-1.txt');
data1 = load('pendulum_multipol_dpg_density_base2.dat-1.txt');
data2 = load('pendulum_multipol_dpg_density_base2.dat-2.txt');
data3 = load('pendulum_multipol_dpg_density_base2.dat-3.txt');
data4 = load('pendulum_multipol_dpg_density_base2.dat-4.txt');
data5 = load('pendulum_multipol_dpg_density_base2.dat-5.txt');
data6 = load('pendulum_multipol_dpg_density_base2.dat-6.txt');
data7 = load('pendulum_multipol_dpg_density_base2.dat-7.txt');
data8 = load('pendulum_multipol_dpg_density_base2.dat-8.txt');
data9 = load('pendulum_multipol_dpg_density_base2.dat-9.txt');
mean_density2 = (data0(:,3)+data1(:,3)+data2(:,3)+data3(:,3)+data4(:,3)+data5(:,3)+data6(:,3)+data7(:,3)+data8(:,3)+data9(:,3))/10;


data0 = load('pendulum_multipol_dpg_density_data.dat-0.txt');
data1 = load('pendulum_multipol_dpg_density_data.dat-1.txt');
data1 = load('pendulum_multipol_dpg_density_data.dat-1.txt');
data2 = load('pendulum_multipol_dpg_density_data.dat-2.txt');
data3 = load('pendulum_multipol_dpg_density_data.dat-3.txt');
data4 = load('pendulum_multipol_dpg_density_data.dat-4.txt');
data5 = load('pendulum_multipol_dpg_density_data.dat-5.txt');
data6 = load('pendulum_multipol_dpg_density_data.dat-6.txt');
data7 = load('pendulum_multipol_dpg_density_data.dat-7.txt');
data8 = load('pendulum_multipol_dpg_density_data.dat-8.txt');
data9 = load('pendulum_multipol_dpg_density_data.dat-9.txt');
mean_density = (data0(:,3)+data1(:,3)+data2(:,3)+data3(:,3)+data4(:,3)+data5(:,3)+data6(:,3)+data7(:,3)+data8(:,3)+data9(:,3))/10;
%plot(1:49,mean_density)

data0 = load('pendulum_dpg.dat-0.txt');
data1 = load('pendulum_dpg.dat-1.txt');
data1 = load('pendulum_dpg.dat-1.txt');
data2 = load('pendulum_dpg.dat-2.txt');
data3 = load('pendulum_dpg.dat-3.txt');
data4 = load('pendulum_dpg.dat-4.txt');
data5 = load('pendulum_dpg.dat-5.txt');
data6 = load('pendulum_dpg.dat-6.txt');
data7 = load('pendulum_dpg.dat-7.txt');
data8 = load('pendulum_dpg.dat-8.txt');
data9 = load('pendulum_dpg.dat-9.txt');
mean_dpg = (data0(:,3)+data1(:,3)+data2(:,3)+data3(:,3)+data4(:,3)+data5(:,3)+data6(:,3)+data7(:,3)+data8(:,3)+data9(:,3))/10;

data0 = load('pendulum_ac_tc.dat-0.txt');
data1 = load('pendulum_ac_tc.dat-1.txt');
data1 = load('pendulum_ac_tc.dat-1.txt');
data2 = load('pendulum_ac_tc.dat-2.txt');
data3 = load('pendulum_ac_tc.dat-3.txt');
data4 = load('pendulum_ac_tc.dat-4.txt');
data5 = load('pendulum_ac_tc.dat-5.txt');
data6 = load('pendulum_ac_tc.dat-6.txt');
data7 = load('pendulum_ac_tc.dat-7.txt');
data8 = load('pendulum_ac_tc.dat-8.txt');
data9 = load('pendulum_ac_tc.dat-9.txt');
mean_ac_tc = (data0(:,3)+data1(:,3)+data2(:,3)+data3(:,3)+data4(:,3)+data5(:,3)+data6(:,3)+data7(:,3)+data8(:,3)+data9(:,3))/10;

data0 = load('multipol_dpg_datacenter4.dat-0.txt');
data1 = load('multipol_dpg_datacenter4.dat-1.txt');
data1 = load('multipol_dpg_datacenter4.dat-1.txt');
data2 = load('multipol_dpg_datacenter4.dat-2.txt');
data3 = load('multipol_dpg_datacenter4.dat-3.txt');
data4 = load('multipol_dpg_datacenter4.dat-4.txt');
data5 = load('multipol_dpg_datacenter4.dat-5.txt');
data6 = load('multipol_dpg_datacenter4.dat-6.txt');
data7 = load('multipol_dpg_datacenter4.dat-7.txt');
data8 = load('multipol_dpg_datacenter4.dat-8.txt');
data9 = load('multipol_dpg_datacenter4.dat-9.txt');
mean_dpg4 = (data0(:,3)+data1(:,3)+data2(:,3)+data3(:,3)+data4(:,3)+data5(:,3)+data6(:,3)+data7(:,3)+data8(:,3)+data9(:,3))/10;

%plot(1:49,mean_density, '+10;density;', "markersize", 10, 1:49,mean_density2, ";density2;", "markersize", 5, "marker", '*');
x = 1:length(data0);
plot(x,mean_density, ';mean.density;', "markersize", 10,
     x,mean_density2, ';mean.density2;', "markersize", 5,
     x,mean_dpg, ';mean.dpg;', "markersize", 2,
     x, mean_ac_tc, ';mean.ac.tc;', "markersize", 6,
     x, mean_dpg4, ';mean.dpg4;', "markersize", 7);
     

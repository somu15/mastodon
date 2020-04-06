clear all
clc
cd('/Users/dhulls/projects/mastodon/PRA/')

%% OLD
data2 = csvread('Master_out_run_hazard0_data_0000.csv',1,0);
zeta1 = data2(:,1); eta1 = data2(:,2); shear1 = data2(:,3); dens1 = data2(:,4);
for ii = 1:50
    if ii < 11
    name = strcat('Master_out_run_hazard0_sub0',num2str(ii-1),'.csv');
    else
        name = strcat('Master_out_run_hazard0_sub',num2str(ii-1),'.csv');
    end
    data = csvread(name,1,0);
    tmp = (data(:,3)./data(:,2));
    tmp(isinf(tmp)) = 0;
    amp1(ii) = max(abs(data(:,3)));
end

data2 = csvread('Master_out_run_hazard1_data_0000.csv',1,0);
zeta2 = data2(:,1); eta2 = data2(:,2); shear2 = data2(:,3); dens2 = data2(:,4);
for ii = 1:50
    if ii < 11
    name = strcat('Master_out_run_hazard1_sub0',num2str(ii-1),'.csv');
    else
        name = strcat('Master_out_run_hazard1_sub',num2str(ii-1),'.csv');
    end
    data = csvread(name,1,0);
    tmp = (data(:,3)./data(:,2));
    tmp(isinf(tmp)) = 0;
    amp2(ii) = max(abs(data(:,3)));
end

data2 = csvread('Master_out_run_hazard2_data_0000.csv',1,0);
zeta3 = data2(:,1); eta3 = data2(:,2); shear3 = data2(:,3); dens3 = data2(:,4);
for ii = 1:50
    if ii < 11
    name = strcat('Master_out_run_hazard2_sub0',num2str(ii-1),'.csv');
    else
        name = strcat('Master_out_run_hazard2_sub',num2str(ii-1),'.csv');
    end
    data = csvread(name,1,0);
    tmp = (data(:,3)./data(:,2));
    tmp(isinf(tmp)) = 0;
    amp3(ii) = max(abs(data(:,3)));
end

scatter(zeta1,amp1,'linewidth',3)
hold on
scatter(zeta2,amp2,'linewidth',3)
hold on
scatter(zeta3,amp3,'linewidth',3)
xlabel('Zeta')
ylabel('Soil PGA (m/s^2)')
set(gca,'FontSize',15)
grid on
title('Damping parameter Zeta')
legend('25Hz','50Hz','100Hz')

figure
scatter(eta1,amp1,'linewidth',3)
hold on
scatter(eta2,amp2,'linewidth',3)
hold on
scatter(eta3,amp3,'linewidth',3)
xlabel('Eta')
ylabel('Soil PGA (m/s^2)')
set(gca,'FontSize',15)
grid on
title('Damping parameter Eta')
legend('25Hz','50Hz','100Hz')

figure
scatter(shear1,amp1,'linewidth',3)
hold on
scatter(shear2,amp2,'linewidth',3)
hold on
scatter(shear3,amp3,'linewidth',3)
xlabel('Shear Modulus (N/m^2)')
ylabel('Soil PGA (m/s^2)')
set(gca,'FontSize',15)
grid on
title('Shear modulus')
legend('25Hz','50Hz','100Hz')

figure
scatter(dens1,amp1,'linewidth',3)
hold on
scatter(dens2,amp2,'linewidth',3)
hold on
scatter(dens3,amp3,'linewidth',3)
xlabel('Density (Kg/m^3)')
ylabel('Soil PGA (m/s^2)')
set(gca,'FontSize',15)
grid on
title('Density')
legend('25Hz','50Hz','100Hz')

%% NEW



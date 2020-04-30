clear all
clc

%% Extract amplification factors (25 Hz)

cd('/Users/dhulls/projects/mastodon/PRA_MASTODON/25HZ')

tmp = csvread('Resp_Spec_25Hz_data_0601.csv',1,0);
G = tmp(:,1); dens = tmp(:,2);
Vs = sqrt(G./dens);
T = 4*5./Vs;

N = 50;

for ii = 1:N
    
    if ii<=10
        name = strcat('Sub_out_sub0',num2str(ii-1),'_accel_hist.csv');
    else
        name = strcat('Sub_out_sub',num2str(ii-1),'_accel_hist.csv');
    end
    
    tmp = csvread(name,1,0);
    
    AF(ii) = max(abs(tmp(:,3)))/max(abs(tmp(:,2)));
    PGA(ii) = max(abs(tmp(:,3)));
    
end

figure(1)
scatter(T, PGA,100,'MarkerEdgeColor',[0 0 0],...
              'MarkerFaceColor',[0 0 0])
xlabel('Fundamental period (s)')
ylabel('Peak Ground Acceleration (m/s^2)')
set(gca, 'fontsize', 20)
grid on

figure(2)
scatter(G, PGA,100,'MarkerEdgeColor',[0 0 0],...
              'MarkerFaceColor',[0 0 0])
xlabel('Shear modulus (N/m^2)')
ylabel('Peak Ground Acceleration (m/s^2)')
set(gca, 'fontsize', 20)
grid on

figure(3)
scatter(dens, PGA,100,'MarkerEdgeColor',[0 0 0],...
              'MarkerFaceColor',[0 0 0])
xlabel('Density (Kg/m^3)')
ylabel('Peak Ground Acceleration (m/s^2)')
set(gca, 'fontsize', 20)
grid on
%% Extract response spectrum (25 Hz)

cd('/Users/dhulls/projects/mastodon/PRA_MASTODON/25HZ')

tmp = csvread('Resp_Spec_25Hz_data_0601.csv',1,0);
G = tmp(:,1); dens = tmp(:,2);
Vs = sqrt(G./dens);

N = 50;

for ii = 1:N
    
    if ii<=10
        name = strcat('Sub_out_sub0',num2str(ii-1),'_accel_hist.csv');
    else
        name = strcat('Sub_out_sub',num2str(ii-1),'_accel_hist.csv');
    end
    
    tmp = csvread(name,1,0);
    
    [freq_vec, per_vec, dspec_vec, vspec_vec, aspec_vec] = Response_Spectrum(0.01, 100, 200, tmp(:,3), 0.05, 0.005);
    
    Spec_freq(:,ii) = aspec_vec';
    
    [freq_vec0, per_vec0, dspec_vec0, vspec_vec0, aspec_vec0] = Response_Spectrum(0.01, 100, 200, tmp(:,2), 0.05, 0.005);
    
    AF_freq(:,ii) = aspec_vec'./aspec_vec0';
    
%     loglog(freq_vec, AF_freq)
%     hold on
    
end

figure(4)
loglog(1./freq_vec, exp(mean(log(Spec_freq'))),'k', 1./freq_vec, exp(mean(log(Spec_freq'))+3*std(log(Spec_freq'))),['k','--'], 1./freq_vec, exp(mean(log(Spec_freq'))-3*std(log(Spec_freq'))),['k',':'],'linewidth',3)
xlim([0.01 1])
xlabel('Oscillator period (s)')
ylabel('Spectral acc. (m/s^2)')
set(gca, 'fontsize', 20)
grid on

figure(5)
semilogx(1./freq_vec, exp(mean(log(AF_freq'))),'k', 1./freq_vec, exp(mean(log(AF_freq'))+3*std(log(AF_freq'))),['k','--'], 1./freq_vec, exp(mean(log(AF_freq'))-3*std(log(AF_freq'))),['k',':'],'linewidth',3)
xlim([0.01 1])
xlabel('Oscillator period (s)')
ylabel('Amplification factor')
set(gca, 'fontsize', 20)
grid on

%% Extract amplification factors (50 Hz)

cd('/Users/dhulls/projects/mastodon/PRA_MASTODON/50HZ')

tmp = csvread('Resp_Spec_25Hz_data_0601.csv',1,0);
G = tmp(:,1); dens = tmp(:,2);
Vs = sqrt(G./dens);
T = 4*5./Vs;

N = 50;

for ii = 1:N
    
    if ii<=10
        name = strcat('Sub_out_sub0',num2str(ii-1),'_accel_hist.csv');
    else
        name = strcat('Sub_out_sub',num2str(ii-1),'_accel_hist.csv');
    end
    
    tmp = csvread(name,1,0);
    
    AF(ii) = max(abs(tmp(:,3)))/max(abs(tmp(:,2)));
    PGA(ii) = max(abs(tmp(:,3)));
    
end

figure(1)
hold on
scatter(T, PGA,100,'s','MarkerEdgeColor',[0 0 1],...
              'MarkerFaceColor',[0 0 1])
xlabel('Fundamental period (s)')
ylabel('Peak Ground Acceleration (m/s^2)')
set(gca, 'fontsize', 20)
grid on
% legend('Max freq: 25Hz','Max freq: 50Hz')
% legend boxoff
title('Black circles: 25 Hz; Blue squares: 50 Hz')

figure(2)
hold on
scatter(G, PGA,100,'s','MarkerEdgeColor',[0 0 1],...
              'MarkerFaceColor',[0 0 1])
xlabel('Shear modulus (N/m^2)')
ylabel('Peak Ground Acceleration (m/s^2)')
set(gca, 'fontsize', 20)
grid on
% legend('Max freq: 25Hz','Max freq: 50Hz')
% legend boxoff
title('Black circles: 25 Hz; Blue squares: 50 Hz')

figure(3)
hold on
scatter(dens, PGA,100,'s','MarkerEdgeColor',[0 0 1],...
              'MarkerFaceColor',[0 0 1])
xlabel('Density (Kg/m^3)')
ylabel('Peak Ground Acceleration (m/s^2)')
set(gca, 'fontsize', 20)
grid on
% legend('Max freq: 25Hz','Max freq: 50Hz')
% legend boxoff
title('Black circles: 25 Hz; Blue squares: 50 Hz')
%% Extract response spectrum (50 Hz)

cd('/Users/dhulls/projects/mastodon/PRA_MASTODON/50HZ')

tmp = csvread('Resp_Spec_25Hz_data_0601.csv',1,0);
G = tmp(:,1); dens = tmp(:,2);
Vs = sqrt(G./dens);

N = 50;

for ii = 1:N
    
    if ii<=10
        name = strcat('Sub_out_sub0',num2str(ii-1),'_accel_hist.csv');
    else
        name = strcat('Sub_out_sub',num2str(ii-1),'_accel_hist.csv');
    end
    
    tmp = csvread(name,1,0);
    
    [freq_vec, per_vec, dspec_vec, vspec_vec, aspec_vec] = Response_Spectrum(0.01, 100, 200, tmp(:,3), 0.05, 0.005);
    
    Spec_freq(:,ii) = aspec_vec';
    
    [freq_vec0, per_vec0, dspec_vec0, vspec_vec0, aspec_vec0] = Response_Spectrum(0.01, 100, 200, tmp(:,2), 0.05, 0.005);
    
    AF_freq(:,ii) = aspec_vec'./aspec_vec0';
    
%     loglog(freq_vec, AF_freq)
%     hold on
    
end

figure(4)
hold on
loglog(1./freq_vec, exp(mean(log(Spec_freq'))),'b', 1./freq_vec, exp(mean(log(Spec_freq'))+3*std(log(Spec_freq'))),['b','--'], 1./freq_vec, exp(mean(log(Spec_freq'))-3*std(log(Spec_freq'))),['b',':'],'linewidth',3)
xlim([0.01 1])
xlabel('Oscillator period (s)')
ylabel('Spectral acc. (m/s^2)')
set(gca, 'fontsize', 20)
grid on
legend('Mean','+3 deviation', '-3 deviation')
legend boxoff
title('Black plots: 25 Hz; Blue plots: 50 Hz')

figure(5)
hold on
semilogx(1./freq_vec, exp(mean(log(AF_freq'))),'b', 1./freq_vec, exp(mean(log(AF_freq'))+3*std(log(AF_freq'))),['b','--'], 1./freq_vec, exp(mean(log(AF_freq'))-3*std(log(AF_freq'))),['b',':'],'linewidth',3)
xlim([0.01 1])
xlabel('Oscillator period (s)')
ylabel('Amplification factor')
set(gca, 'fontsize', 20)
grid on
legend('Mean','+3 deviation', '-3 deviation')
legend boxoff
title('Black plots: 25 Hz; Blue plots: 50 Hz')
clear all;
clc;
close all;

%% ����
Fs = 1000;                              %������
F0 = 0;                                 %��ʼƵ��
Baud = 50;                              %����
Taup = 10;                              %����
n = Fs*Taup;                            %�źŵ���
t = linspace(0, Taup, n);
Dob_N = 128;
% ErrorWindowSize = 250;
ErrorWindowSize = 400;
%% ��ͬ������£�ֱ����DOB�˲������������أ����ƾ��������
FftLength = 512;
MontNumber = 5000;
% SnrSeries = -15:1:10;
SnrSeries = 10;
SnrNumber = length(SnrSeries);
PulseUpEdgeRslt_1 = zeros(SnrNumber, MontNumber);
PulseDownEdgeRslt_1 = zeros(SnrNumber, MontNumber);
PulseUpEdgeRslt_2 = zeros(SnrNumber, MontNumber);
PulseDownEdgeRslt_2 = zeros(SnrNumber, MontNumber);
MseUp = zeros(SnrNumber, 6);MseUp(:, 1) = SnrSeries';
MseDown = zeros(SnrNumber, 6);MseDown(:, 1) = SnrSeries';
MseWidth = zeros(SnrNumber, 6);MseWidth(:, 1) = SnrSeries';
detect_cnt=0;
% wb_Match_filter = waitbar(0,'���ڴ������Ժ�...');
for ii = 1:length(SnrSeries)
    SNR = SnrSeries(ii);
    for k = 1:MontNumber        
        % 1��������������

        % ��������
        w = [wgn(1, n, 0, 'complex'), wgn(1, n, 0, 'complex'), wgn(1, n, 0, 'complex')];        %��������0dBW
        A = 10^(SNR/20);
%         sig = A*exp(1j*(pi*F0*t+pi*Baud/Taup*t.^2));    %�źŹ���
        sig = A*exp(1j*pi*20*t);
        s = [zeros(1,n)+1j*zeros(1,n), sig, zeros(1,n)+1j*zeros(1,n)];
        x = s + w;
%         x = w;
        % spectrogram(x,256,250,256,1E3,'yaxis');       %��ʾʱƵ����


        [PulseUpEdgeRslt_2(ii, k) PulseDownEdgeRslt_2(ii, k) UpFlag DownFlag] = EnergyDetect(abs(x));
        if(UpFlag)
           detect_cnt = detect_cnt +1;
        end
        % 3����ü�⼰���Ƶ���ȷ�ʡ��ж�����ǰ�����Լ������Ƿ�����ȷ�������1%������Ϊ�Ǽ����ȷ��
        % 4����ù��Ƶľ�������
       
        %%%4.2��������ⷽ��
        if abs(PulseUpEdgeRslt_2(ii,k)-10000)<ErrorWindowSize
            MseUp(ii, 5) = MseUp(ii, 5) + 1;
            MseUp(ii, 6) = MseUp(ii, 6) + (PulseUpEdgeRslt_2(ii, k)-10000)^2;
        end
        if abs(PulseDownEdgeRslt_2(ii,k)-20000)<ErrorWindowSize
            MseDown(ii, 5) = MseDown(ii, 5) + 1;
            MseDown(ii, 6) = MseDown(ii, 6) + (PulseDownEdgeRslt_2(ii, k)-20000)^2;
        end
        if abs(PulseDownEdgeRslt_2(ii,k)-PulseUpEdgeRslt_2(ii,k))<ErrorWindowSize
            MseWidth(ii, 5) = MseWidth(ii, 5) + 1;
            MseWidth(ii, 6) = MseWidth(ii, 6) + (abs(PulseUpEdgeRslt_2(ii, k)-PulseDownEdgeRslt_2(ii, k))-10000)^2;
        end
%         waitbar(((ii-1)*MontNumber+k)/(MontNumber*SnrNumber), wb_Match_filter);
        end  
    
    if MseUp(ii,5) ~= 0
        MseUp(ii, 6) = sqrt(MseUp(ii,6)/sum(MseUp(ii,5)));
    else
        MseUp(ii, 6) = 0;
    end
    if MseDown(ii,5) ~= 0
        MseDown(ii, 6) = sqrt(MseDown(ii,6)/sum(MseDown(ii,5)));
    else
        MseDown(ii, 6) = 0;
    end
    if MseWidth(ii,5) ~= 0
        MseWidth(ii, 6) = sqrt(MseWidth(ii,6)/sum(MseWidth(ii,5)));
    else
        MseWidth(ii, 6) = 0;
    end
    MseUp(ii, 5) = MseUp(ii, 5)/MontNumber;
    MseDown(ii, 5) = MseDown(ii, 5)/MontNumber;
    MseWidth(ii, 5) = MseWidth(ii, 5)/MontNumber;
end










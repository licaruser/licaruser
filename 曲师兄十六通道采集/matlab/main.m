
%�˳������״�������
%�������(��ʵ����ȫ��Ӧ)��13λbarker�� Fs = 245.76e6  ��ȡDecimation = 20�� Fs = 12.288e6
%                         5��Ƶ ���������N_CI=256 Tp = 4us; T0 = 4.2e-6; m = [7,8,9,11,13];
%���ܣ�16ͨ������ʵ�ֲ�ǣ����300km�Ĳ�࣬1500m/s�Ĳ��ٷ�Χ
%���沽�裺Ŀ����Ϣ --> ϵͳ�������� --> �����ź� --> �ز�ģ�� --> ��Ϊ������ͨ�� --> ��ȡ --> 
%         ������ѹϵ�� --> ��ѹ --> �Ͳ� --> MTD --> CFAR --> Ŀ������ --> Ŀ����� --> 
%         �����ģ�� --> ����� --> ��ӡ�����
%ʹ�ñ����Ƿ���AD�ɼ��õ��ź�һ��Ϊ16·����1-8·�ź���Ϊ��ͨ����9-16·�ź���Ϊ��ͨ���źţ�
%��ͨ��mtd�����ȥ��ͨ��MTD��������ͨ�����
%��ͨ��MTD���������ͨ��MTD��������ͨ�����
%֮�������������ֵ�����ݺͲ�ͨ���ı�ֵ���  
clc
close all
clear all

tic
%% Ŀ����Ϣ
R0 =  [   3, 150,  90, 250, 200, 289].*1e3;                                %����
Vr =  [-100, 300, 200, 470, 380, 670];                                     %�ٶ�
fai_t=[-2,     2,  -3,   4,  -1,   1];                                     %�Ƕ�
SNR = [-10,   -8, -12, -15, -13,  -9] - 0 ;                                %�����

%% ϵͳ��������
protect0 = 4;                                                              %cfar����
test0 = 4;
k0 = 32;

C = 3e8;
Fc = 1.8e9;                                                                %��Ƶ
Lamda = C/Fc;                                                              %����
Fs = 245.76e6;                                                             %����Ƶ��
decimation = 20;                                                           %��ȡ
N_CI = 256;                                                                %������

barker = [1 1 1 1 1 -1 -1 1 1 -1 1 -1 1];                                  %�Ϳ���
k = length(barker);

Tp = 4e-6;                                                                 %������
T0 = 4.2e-6; 
m = [7,8,9,11,13];
PRT = T0.*m;                                                               %�����ظ�����
B = 1/(Tp/k);                                                              %barker�źŴ���
PRF = 1./PRT;                                                              %�����ظ�Ƶ�� 

nTp = round(Tp/k*Fs)*k;                                                    %�����������
nPRT = floor(PRT*Fs);                                                      %һ��PRT��Ӧ�Ĳ�������
MY_NFFT = 2^ceil(log2((max(nPRT)/decimation)));                            %����άfft����
juli_max = C*PRT/2;                                                        %���ģ����෶Χ 
start_juli = Tp*C/2;                                                       %ä��

%���߲���
Ny=16;                                                                     %������Ԫ����
d_lambda_1=0.5;                                                            %��Ԫ����벨����ֵ

%% �����ź�
Sbarker = repmat(barker,nTp/k,1);
Sbarker = reshape(Sbarker,1,[]);
Sbarker = Sbarker.*32766;                                                  %����

figure;subplot(211);plot(Sbarker);
Sbarker_fft = fft(Sbarker);
x = -Fs/2 : Fs/nTp : Fs/2 - Fs/nTp;
subplot(212);plot( x*1e-6,abs(fftshift(Sbarker_fft)));
title('�����ź�Ƶ�ʷֲ�');xlabel('Ƶ��/MHz');
toc
%% �ز�ģ�� 
Echo = Echo_sim(R0,Vr,N_CI,SNR,fai_t,Sbarker,nPRT,nTp,PRT,Fs,Fc,C,juli_max,Ny,d_lambda_1);   %�ز�ģ��
toc
%% ��Ϊ������ͨ��
Echo1 = sum(Echo(:,:,:,1:8),4);                                            %���8��ͨ�����
Echo2 = sum(Echo(:,:,:,9:16),4);                                           %�б�8��ͨ�����
clear Echo;

%% ��ȡ
s_barker1 = Decimation(Echo1,MY_NFFT,decimation);
s_barker2 = Decimation(Echo2,MY_NFFT,decimation);
clear Echo1 Echo2;
%% ������ѹϵ��
coeff = coeff_produce(Sbarker,MY_NFFT,decimation,N_CI,nTp);
clear Sbarker;
%% ��ѹ
pc1 = PC(s_barker1,MY_NFFT,coeff);
pc2 = PC(s_barker2,MY_NFFT,coeff);
clear s_barker1 s_barker2;
%% �Ͳ�
pc_he = pc1 + pc2;
pc_cha = pc1 - pc2;
% clear pc1 pc2;
%%  ��Ŀ����  mtd
mtd_he = MTD(pc_he);
mtd_cha = MTD(pc_cha);
% clear pc_he pc_cha;
%% CFAR
cfar = CFAR(mtd_he,protect0,test0,k0);

%% Ŀ������
target = Target(cfar,protect0);
% clear cfar;
%% ��ӡ��Ŀ��  ���ѵ�������Ϊ���ھ���
target1 = zeros(size(target,1),4,size(target,3));                          %����ٶȡ����롢�͡���
%target1��ά���飬��һά��Ų�ͬ��Ŀ�꣬�ڶ�ά���Ŀ����Ϣ(�ֱ�Ϊ�ٶȡ����롢�͡���)������ά�ǲ�ͬ��cpi
for ii = 1: size(target,3)
    for i = 1:size(target,1)
        if(target(i,1,ii) ~= 0)
            target1(i,1,ii) = (target(i,1,ii)-1-N_CI/2)*(PRF(ii)/N_CI)*Lamda/2;  %����ٶ���Ϣ
            target1(i,3,ii) = mtd_he(target(i,1,ii),target(i,2,ii),ii);        %��ź�
            target1(i,4,ii) = mtd_cha(target(i,1,ii),target(i,2,ii),ii);       %��Ų�
            if(target(i,2,ii) > 900)                                       %�ز�����ǰ�沿�ֱ��ڵ�������ѹ������ں������
                target(i,2,ii) = target(i,2,ii) - 1024;                    %�����Ҫ��Ϊ���������
            end
            target1(i,2,ii) = (target(i,2,ii)*(C/Fs/2)*decimation + start_juli);%��ž�����Ϣ
            
            fprintf('CPI%d  Ŀ��%d: ����Ϊ��%11.2f ��;  �ٶ�Ϊ��%7.2f (m/s);\n',...
            ii,i,target1(i,2,ii),...
            target1(i,1,ii));
        else
            target1(i,:,ii) = [0 0 0 0];
        end
    end
    fprintf('\n');
end
% clear mtd_he mtd_cha;
%% Ŀ�����
target_association = Target_association(target1);

%% �����ģ��
real_juli = jiemohu(target_association,PRT);

%% ��ǲ��
[curve_EL,theta_6] = phase_curve_XKZ;                         %�õ���������

%% ��ӡ���ռ����
for i = 1:size(real_juli,1)
    
    EL_bi=imag(real_juli(i,4)./real_juli(i,3));
    if((curve_EL(1)-EL_bi)<0)
        result_x_EL=1;
    elseif((curve_EL(length(curve_EL))-EL_bi)>0)
        result_x_EL=length(curve_EL);
    else
        for mm=1:length(curve_EL)-1
            if( (curve_EL(mm)-EL_bi)>0 && (curve_EL(mm+1)-EL_bi)<0 )
               if(curve_EL(mm)+curve_EL(mm+1)-2*EL_bi)>0
                   result_x_EL=mm+1;
               else
                   result_x_EL=mm; 
               end
               break;
            end
        end
    end
    real_juli(i,5)=theta_6(result_x_EL);
    
     fprintf('Ŀ��%d: ����Ϊ��%11.2f ��;  �ٶ�Ϊ��%7.2f (m/s);  �Ƕȣ�%3.2f\n',...
            i,real_juli(i,2),real_juli(i,1),real_juli(i,5));
end
toc

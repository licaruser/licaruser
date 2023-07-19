
%�˺�����Ҫ���ɺͲ���������ǣ��ļ�������
function [curve_EL,theta_6]=phase_curve_XKZ

theta=-30:0.1:30;
d_lambda_1=0.5;
d_lambda_2=d_lambda_1;
%% ����ָ��                                                                 %������
fai0=0;                                                                    %��λ��
%% ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% �����Ų�                                                        
aa0_2_zuoshang=exp(1i*2*pi*d_lambda_2*[0:1:7]'*sin(fai0*pi/180));    %y������ʸ��
for m=1:length(theta)
         aa=exp(1i*2*pi*d_lambda_2*[0:1:7]'*sin(theta(m)*pi/180));
         pattern_he_zuoshang(m)=aa0_2_zuoshang'*aa;%aa0ΪDBF��ѡ��
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%plot ��������
%% ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% �����Ų�                                                        
aa0_2_youshang=exp(1i*2*pi*d_lambda_2*[8:1:15]'*sin(fai0*pi/180));    %y������ʸ��

for m=1:length(theta)
         aa=exp(1i*2*pi*d_lambda_2*[8:1:15]'*sin(theta(m)*pi/180));
         pattern_he_youshang(m)=aa0_2_youshang'*aa;%aa0ΪDBF��ѡ�� 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%plot ��ͼ����
%% �ϳɺͷ���ͼ
pattern_sum=pattern_he_zuoshang+pattern_he_youshang;
% figure;plot(theta,20*log10(abs(pattern_sum)./max(max(abs(pattern_sum)))));zlim([-60 0]);
% xlabel('��λ��');title('���պ͹�һ������ͼ');set(gca,'clim',[-80 10]);
%% �ϳɷ�λ���ͼ
pattern_EL_dif=pattern_he_zuoshang-pattern_he_youshang;
% figure;plot(theta,20*log10(abs(pattern_EL_dif)./max(max(abs(pattern_EL_dif)))));
% xlabel('��λ��');zlim([-60 0]);title('���շ�λ���һ������ͼ');set(gca,'clim',[-80 10]);

%% ������λ��������
curve_EL_dif=pattern_EL_dif;
curve_sum=pattern_sum;
identifi_EL=imag(curve_EL_dif./curve_sum);

theta_6n=find(theta==-6);
theta_6p=find(theta==6);
theta_6=theta(theta_6n:theta_6p);
curve_EL=identifi_EL(theta_6n:theta_6p);

figure;plot(theta_6,curve_EL);
title('��λ��������');xlabel('�Ƕ�');ylabel('��ͱ�ֵ');
end
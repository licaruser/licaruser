 clear all
close all
T=0.02*10^-6;
fs = 250*10^6;
ts = 1/fs;
N = round(T/ts);
P_NUM=4;
% load 'fir_coff_50.mat';
% fir_50_Q = round(fir_50*2^16);
 
Ndds1 = 32;
Ndds = 11;
Nddsout = 15;
init_p = 0;% 2pi��һ��
phase_init = zeros(1,P_NUM);


k=round(1/(4*N)*2^Ndds1);
s=0;
len = 14*N;
dataout_0 = zeros(1,len*P_NUM);

for i=1:P_NUM
   phase_init(i) = (i-1)*round(1/(4*P_NUM*N)*2^Ndds1);
   [dataout]=quad_phasecode_Q(N,s,k,phase_init(i),len,Ndds1,Ndds,Nddsout);
   dataout_0(i:4:end) = dataout;  
end
      figure 
    subplot(212)    
plot(imag(dataout_0)); title('��������ź��鲿');
set(gca,'XTick',0:length(dataout_0)/2:length(dataout_0))
set(gca,'XTicklabel',{'0','0.14','0.28us'})

    subplot(211)
plot(real(dataout_0),'r'); title('��������ź�ʵ��'); 
set(gca,'XTick',0:length(dataout_0)/2:length(dataout_0))
set(gca,'XTicklabel',{'0','0.14','0.28us'})
   fvtool(dataout_0)
% %-------------------------------------------------------
% %��·����5����ֵ�˲�����Ϊ20·
% %-------------------------------------------------------
% fir_outa = Interp_FIR_Q(dataouta,dataoutb,dataoutc,dataoutd,fir_50_Q);
% 
% % fir_outa =ones(20,length(dataouta))*2^11;
% 
% fir_out_serial = zeros(1,length(fir_outa(1,:))*20);
% %20·��һ·
% for n=1:20
% 
%         fir_out_serial(n:20:end) = fir_outa(n,:);
%         
%        
% end
% 
% %-----------------------------------------------------
% %������Ƶ������20·���У����ÿһ·�ĳ�ʼ��λ����һ��
% %-----------------------------------------------------
% f_IF0 = 1.2*10^9 ;%��Ƶ0
% f_IF1 = 1.2*10^9 + 100*10^6;%��Ƶ1
% f_IF2 = 1.2*10^9 + 200*10^6;%��Ƶ2
% delay0 = 1;
% delay1 = 1;
% delay2 = 1;
% choiceflag =0;
% for i=1:20
%     phase_IF0(i)=floor((f_IF0*(i-1)/(20*fs))*2^Ndds1);%�ּ�ģ��ÿһ·�ĳ�ʼ��λ
%     phase_IF1(i)=floor((f_IF1*(i-1)/(20*fs))*2^Ndds1);
%     phase_IF2(i)=floor((f_IF2*(i-1)/(20*fs))*2^Ndds1);
% end
% 
% k0 = floor(f_IF0/fs*2^Ndds1);%Ƶ���ۼ��֣�exp(-j*k0*n)
% k1 = floor(f_IF1/fs*2^Ndds1);%Ƶ���ۼ��֣�exp(-j*k1*n)
% k2 = floor(f_IF2/fs*2^Ndds1);%Ƶ���ۼ��֣�exp(-j*k2*n)
% 
% 
% 
% len1 = length(fir_outa(1,:));
% IF_out_serial = zeros(1,length(fir_outa(1,:))*20);
% for i = 1:20
%     [dataout(i,:)]=fre_diverity_Q(k0,k1,k2,fir_outa(i,:),delay0,delay1,delay2,choiceflag, phase_IF0(i), phase_IF1(i), phase_IF2(i),Ndds,Ndds1,Nddsout);%Ƶ�ʷּ�
% %     [dataout(i,:)]=fre_diverity(k0,k1,k2,fir_outa(i,:),delay0,delay1,delay2,choiceflag, phase_IF0(i), phase_IF1(i), phase_IF2(i));
% end
% 
% %���������Ҫfpga��ʵ�֣�ֻ�ǲ����á�
% IF_out_serial = zeros(1,length(dataout(1,:))*20);
% for i=1:20
% %     IF_out(i,:) = (fir_outa(i,:)).*exp(sqrt(-1)*(2*pi*k*(0:len1-1)+phase_IF(i)));
%     IF_out_serial(i:20:end) = dataout(i,:);
% end
% fvtool(IF_out_serial)













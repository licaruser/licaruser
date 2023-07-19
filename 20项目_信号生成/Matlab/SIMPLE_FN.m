function [Simple_Sig] = SIMPLE_FN(T,B,Fs)
%SIMPLE_FN �˴���ʾ�йش˺�����ժҪ
% T ����
% B ����
% Fs ������
PulsePointNum = ceil(T*Fs);  %ʱ��*������
t = linspace(0,T,PulsePointNum);

Simple_Sig = cos(2*pi*B*t);

% figure
% plot(t,(Simple_Sig));
% 
% Nfft = 2^nextpow2(2*PulsePointNum); %���ڼ���FFT�ĳ���
% LFM_FFT =fftshift(abs(fft(Simple_Sig,Nfft)));
% % LFM_FFT =(abs(fft(Simple_Sig,Nfft)));
% LFM_FFT_db = 20*log10(LFM_FFT/max(LFM_FFT));
% figure
% set(gca,'FontSize',20);
% ff = 0:Fs/(Nfft-1):Fs;
% ff = ff - Fs/2;
% plot(ff,LFM_FFT_db);
% title('LFMƵ��')
% %xlim([min(-Fs/FsTimesB) max(Fs/FsTimesB)])
% xlabel('Ƶ��(Hz)')
% ylabel('����(dB)')



end


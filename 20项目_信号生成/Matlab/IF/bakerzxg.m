clear
clc

code = [1 1 1 1 1 -1 -1 1 1 -1 1 -1 1];%13λ�Ϳ���
tao = 0.5e-6;  %chipʱ��
fc = 20e6;  %��Ƶ(�ź�Ƶ��)
% fs = 200e6;  %������
fs = 20e6;  %������
t_tao = 0:1/fs:tao-1/fs;  %chipʱ���ڲ���ʱ�������
n = length(code);  %�볤
% phase = 0;  %û��Ҫ���ⶨ����λ
t = 0:1/fs:13*tao-1/fs;
s = zeros(1,length(t));
for ii = 1:n
    if code(ii) == 1
        phase = 0;  %Ӧ����pi�ɣ��ԣ���������֤ԭ�����Ǵ�ģ�Ӧ�ø�Ϊpi
%         phase = pi;  % ���ڶ�����룬ֻ�� 0��pi����ȡֵ��
    else
        phase = pi;
    end
    s(1,(ii-1)*length(t_tao)+1:ii*length(t_tao)) = cos(2*pi*fc*t_tao+phase);
end
figure
plot(t,s,'b-o')
% plot(t,s)
xlabel('t(��λ����)');
title('�����루13λ�Ϳ��룩');

%%  ����غ���  %%
[a,b] = xcorr(code);
% d = abs(a);
figure
plot(b,a,'r-o');title('Baker�����������2')
axis tight

clc
clear all
close all
% ��ֵα����źţ�M���У�
n = 8; % �״�
p = 2^n -1; % ѭ������
ms = idinput(p, 'prbs');
figure
stairs(ms);
title('M����');
ylim([-1.5 1.5]);
sum(ms==1); % 1�ĸ���
sum(ms==-1); % -1�ĸ���
ans =127;

ans =128;

mean(ms); % ֱ������
ans =-0.0039;

a = zeros(length(ms)*10, 1); % ����
for i = 1:10
a(i:10:end) = ms;
end
c = xcorr(a, 'coeff'); % ����غ���
figure
plot(c);
title('��غ���');

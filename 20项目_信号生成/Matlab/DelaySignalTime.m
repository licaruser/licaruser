function [Signal] = DelaySignalTime(Signal_Delay,DelayTime,Fs)
%DELAYSIGNALTIME �˴���ʾ�йش˺�����ժҪ
% Signal_Delay ��ʱ�ź�
% DelayTime ��ʱʱ��
% Fs ������

DelayPoint = DelayTime * Fs;
DelayMatrix = zeros(1,DelayPoint);
Signal = [DelayMatrix,Signal_Delay];
column = length(Signal_Delay);
Signal = Signal(1:column);


end


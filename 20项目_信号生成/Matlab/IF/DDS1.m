%-------------------------------
%N��2^N�ȼ���pi/2����Ĵ�СΪ2^N,��pi/2
%2^(N+1)�ȼ�pi��2^(N+2)�ȼ�2pi
%���������ͨ�����Ǻ����任�õ�
%ֻ��һ��(0-pi/2)�����ұ����Һ���������ͨ�����ұ�õ�
%���Ϊ12λ,��������λ
%-------------------------------

function [dds_out_imag,dds_out_real] = DDS1(N,phase,N1)
if(phase>=2^(N-2)*3)%3/2*pi
   phase1 = 2^N-phase;   
   dds_out_imag = -floor(sin(2*pi*phase1*2^N/2^(2*N))*(2^N1-1));
   phase2=2^(N-2)*3-phase;
   dds_out_real = -floor(sin(2*pi*phase2*2^N/2^(2*N))*(2^N1-1));
   
elseif(phase>=2^(N-2)*2)%pi
    phase1=phase-2^(N-1);
    phase2=phase-2^(N-2);
    dds_out_imag = -floor(sin(2*pi*phase1*2^N/2^(2*N))*(2^N1-1));
    dds_out_real = -floor(sin(2*pi*phase2*2^N/2^(2*N))*(2^N1-1)); 
elseif(phase>=2^(N-2))
     phase1=2^(N-1)-phase;
     phase2=phase-2^(N-2);
    dds_out_imag = floor(sin(2*pi*phase1*2^N/2^(2*N))*(2^N1-1));
     dds_out_real = -floor(sin(2*pi*phase2*2^N/2^(2*N))*(2^N1-1)); 
else
    phase1=phase; 
    phase2=2^(N-2)-phase;
    dds_out_imag = floor(sin(2*pi*phase1*2^N/2^(2*N))*(2^N1-1));
     dds_out_real = floor(sin(2*pi*phase2*2^N/2^(2*N))*(2^N1-1)); 
end
% dds_out_imag = (sin(2*pi*phase*2^N/2^(2*N))*(2^N1-1));
   


   
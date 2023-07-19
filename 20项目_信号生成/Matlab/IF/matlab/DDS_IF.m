%-------------------------------
%N��2^N�ȼ���pi/2����Ĵ�СΪ2^N,��pi/2
%2^(N+1)�ȼ�pi��2^(N+2)�ȼ�2pi
%���������ͨ�����Ǻ����任�õ�
%ֻ��һ��(0-pi/2)�����ұ����Һ���������ͨ�����ұ�õ�
%���Ϊ12λ,��������λ
%-------------------------------

function [dds_out] = DDS_IF(Q_pi_half,phase,N1)
    Q_pi=Q_pi_half*2;
    Q_pi_1_5=Q_pi_half*3;
    Q_pi_2 = Q_pi_half*4;
    
    
    if(phase<=Q_pi_half)%0<pi/2        
        dds_out_real = floor(sin((Q_pi_half-phase)/Q_pi_half*pi/2)*(2^N1-1));%cos(a)=sin(pi/2-a)
        dds_out_imag = floor(sin(phase/Q_pi_half*pi/2)*(2^N1-1));
    elseif((phase>Q_pi_half)&&(phase<=Q_pi))%pi/2<p<pi
        phase = Q_pi-phase;
        dds_out_real = -floor(sin((Q_pi_half-phase)/Q_pi_half*pi/2)*(2^N1-1));
        dds_out_imag = floor(sin(phase/Q_pi_half*pi/2)*(2^N1-1)); 
    elseif(phase>Q_pi&&(phase<=Q_pi_1_5))%pi<p<pi*3/2
        phase = phase-Q_pi;
        dds_out_real = -floor(sin((Q_pi_half-phase)/Q_pi_half*pi/2)*(2^N1-1));
        dds_out_imag = -floor(sin(phase/Q_pi_half*pi/2)*(2^N1-1)); 
    else
         phase = Q_pi_2-phase;
         dds_out_real = floor(sin((Q_pi_half-phase)/Q_pi_half*pi/2)*(2^N1-1));
        dds_out_imag = -floor(sin(phase/Q_pi_half*pi/2)*(2^N1-1)); 
    end
    dds_out = dds_out_real + dds_out_imag*sqrt(-1);

   
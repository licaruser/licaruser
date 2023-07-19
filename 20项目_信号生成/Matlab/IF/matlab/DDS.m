%-------------------------------
%N��2^N�ȼ���pi/2����Ĵ�СΪ2^N,��pi/2
%2^(N+1)�ȼ�pi��2^(N+2)�ȼ�2pi
%���������ͨ�����Ǻ����任�õ�
%ֻ��һ��(0-pi/2)�����ұ����Һ���������ͨ�����ұ�õ�
%���Ϊ12λ,��������λ
%-------------------------------

function [dds_out] = DDS(N,phase,N1)
    
    if(phase<=2^N)%0<pi/2        
        dds_out_real = round(sin((2^N-phase)/2^N*pi/2)*(2^N1-1));%cos(a)=sin(pi/2-a)
        dds_out_imag = round(sin(phase/2^N*pi/2)*(2^N1-1));
    elseif((phase>2^N)&&(phase<=2^(N+1)))%pi/2<p<pi
        phase = 2^(N+1)-phase;
        dds_out_real = -round(sin((2^N-phase)/2^N*pi/2)*(2^N1-1));
        dds_out_imag = round(sin(phase/2^N*pi/2)*(2^N1-1)); 
    elseif(phase>2^(N+1)&&(phase<=(2^N*3)))%pi<p<pi*3/2
        phase = phase-2^(N+1);
        dds_out_real = -round(sin((2^N-phase)/2^N*pi/2)*(2^N1-1));
        dds_out_imag = -round(sin(phase/2^N*pi/2)*(2^N1-1)); 
    else
         phase = 2^(N+2)-phase;
         dds_out_real = round(sin((2^N-phase)/2^N*pi/2)*(2^N1-1));
        dds_out_imag = -round(sin(phase/2^(N)*pi/2)*(2^N1-1)); 
    end
    dds_out = dds_out_real + dds_out_imag*sqrt(-1);

   
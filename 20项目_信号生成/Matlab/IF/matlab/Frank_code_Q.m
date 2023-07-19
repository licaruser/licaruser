function out = Frank_code_Q(M,Tb)
phase =zeros(1,M^2);
pos =zeros(1,M^2);
Q=16;
N=64;
two_M_n_Q = (1/(2*M))*2^Q;
M_n_Q = two_M_n_Q*2;
 for i=1:M
   for j=1:M
      phase((i-1)*M+j)=M_n_Q*(i-1)*(j-1);
   end
 end
 phase = mod(phase,2^Q);
 phase1 =zeros(1,M^2*Tb);
 
 for i=1:M^2
    phase1((i-1)*Tb+1:i*Tb)=phase(i); 
 end
 phase1 = floor(phase1/2^4);
phi2 = phase;
  out = exp(sqrt(-1)*2*pi*(phase1)/2^(Q-4));
%������������������������������λͼ��������������������������%
    xx=0:length(phi2)-1;
    figure(1);
    stairs(xx,phi2);grid
    title([  'P1��ʱ����������']);
    xlabel('phase change');
    ylabel('P1 phase shift /����');
     
 %���������������������� P1 ��������ԡ�����������������������%
    un=rem(phi2, 2*pi);%un=rem(phi2, 2*pi);%����λ����2������
    P1_signal=exp(j*un(1:1:N^2));  % P1 signal
    [a,b]=xcorr(P1_signal);
    d=abs(a);
    d=20*log10(d+1e-6);
    figure(2);
    plot(b,d);
    title('P1������غ���');
     xlabel('Ƶ��/Hz');
      ylabel('����/dBm');
    grid on;
end 
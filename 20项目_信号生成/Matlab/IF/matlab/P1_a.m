function out = P1_a(M,Tb)
phase =zeros(1,M^2);
pos = zeros(1,M^2);
Q=16;
M_n = floor(1/(M)*2^Q);

 for j=0:M-1
   for i=0:M-1
      phase(j*M+(i+1))= -pi/M*(M-(2*j+1))*(M*j+i);
      pos(j*M+(i+1)) = -(M*j-2*j^2-j+i)*2^(Q)+ M_n*(2*j+1)*i;
   end
 end
 pos = floor(pos/2);
 pos1=mod(pos,2^Q);
 phase1 =zeros(1,M^2*Tb);
 phase1a =zeros(1,M^2*Tb);
 
 for i=1:M^2
    phase1((i-1)*Tb+1:i*Tb)=phase(i); 
    phase1a((i-1)*Tb+1:i*Tb)=pos1(i);
 end
 

  out = exp(sqrt(-1)*(phase1));
  out1 = exp(sqrt(-1)*2*pi*phase1a/2^Q);
   plot(20*log10(abs(fftshift(fft(out,1024)))));

end 
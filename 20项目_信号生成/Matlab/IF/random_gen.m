  % ���������޷�������0~m1��Ӧ��ΧΪ0~2��������Ϊ�з�����
  % 0~m1��Ӧ����-1~1�ķ�Χ
  xin = 100;
  signed_flag=0;%1:�з��ţ�0���޷���
  m1=2^32;
  level0=floor(1/50*(2^31));
  level1=floor(0.00*(2^31));
  a=5^7;
  b=0;
  Q_CUT=6;
  level0a=level0;
  level1a=level1; 
  
  for i=1:10000
     mult1=a*xin;
     xout_save(i) =mod(mult1+b,m1) ;
     xout(i) =mod(mult1+b,m1) ;
     xin = xout(i) ;
 
   if(signed_flag==1)
       
	     xout(i) = xout(i) -2^31;
	     xout_cut(i) = floor(xout(i)/2^Q_CUT);
	   if(xout_cut(i)<-level0a)  
	       xout_cut(i) = xout_cut(i)+level0a; 
	   elseif(xout_cut(i)<0&(xout_cut(i)>-level1a))
	       xout_cut(i) = xout_cut(i)-level1a; 
	   elseif(xout_cut(i)>level0a)
	        xout_cut(i) = xout_cut(i)-level0a;
	   elseif((xout_cut(i)<level1a)&xout_cut(i)>=0)
	        xout_cut(i) = xout_cut(i)+level1a;
	   end
   else  
         xout_cut(i) = floor(xout(i)/2^Q_CUT);
	    if(xout_cut(i)>level0a)
	        xout_cut(i) = xout_cut(i)-level0a;
	    elseif((xout_cut(i)<level1a))
	        xout_cut(i) = xout_cut(i)+level1a;
	    end
   end
   
  end
  
  
  
 
% improved algorithm for estimating PRIs applies to interleaved pulse
% trains  with PRI jitter.    �Ľ���PRI�����㷨������PRI�����Ľ�֯���崮
close all
clear all
clf   %���ͼ�񴰿�
clc
N=1000;
%�����״��toa�����嵽��ʱ��
t1=0:333;%0 1 2 3 4 5 6 7 8 9...333
t2=0.1:sqrt(2):(0.1+332*sqrt(2));%0.1��1.514��2.928��4.342...
t3=0.2:sqrt(5):(0.2+332*sqrt(5));%0.2��2.436��4.672��6.908...
toa=[t1 t2 t3];  %����һ���toa����ʱ��
clear t1 t2 t3
a=0.0;                                      %���ö����̶�
jitter=(1-2*rand(1,1000))*a;%-0.1~0.1     %rand(1,1000)����һ��һ��ǧ�е�0-1��������� 10%�Ķ��� 
toa=toa+jitter;                         %Ϊÿ�������TOA���������
toa=sort(toa);                          %����
K=201;
taumin=0;
taumax=10;
epsilon=a;                                  %epsilonΪPRI��������(=a)
zetazero=0.03;
O=zeros(1,K); %����һ��һ��201�е�����
D=zeros(1,K);                               %��ʼ��D(k)
C=zeros(1,K);
A=zeros(1,K);                               %��ʼ�����޺���
for i=1:K                                   %PRI�����ģ���֤��־
    tauk(i)=(i-1/2)*(taumax-taumin)/K+taumin;
    flag(i)=1;
end
bk=2*epsilon*tauk; %0.2*tauk                %��k��PRI bin��width
n=2;
tic;
while n<=N   %N = 1000����ȫ����TOA�ĵ���ʱ��
    m=n-1;
    while m>=1
        tau=toa(n)-toa(m);      %"&"�͡�&&�����������˼��ǰ�����ж�����������&&Ч�ʸߣ����ж�ǰ��
        if (tau>(1-epsilon)*taumin)&(tau<=(1+epsilon)*taumax)                 %��tauֵ�����PRI��ķ�Χ
            k1=fix((tau/(1+epsilon)-taumin)*K/(taumax-taumin)+1);
            k2=fix((tau/(1-epsilon)-taumin)*K/(taumax-taumin)+1);             %�˲������tua������ǰ��������󶶶�֮��ᴦ���ĸ�PRI����
            if k2 > 201 %tua�Ѿ�������Ԥ��ֵ
                break
            end
            for k=k1:k2
                if flag(k)==1                                                  %����k��PRI���Ƿ��һ��ʹ��
                    O(k)=toa(n);
                end
                etazero=(toa(n)-O(k))/tauk(k);                                 %�����ʼ��λ���ֽ� 
                nu=etazero+0.4999999;%������Ϊ0.5-1.5��Χ�ڵı������Ǹ�pri��1.5������pri��2��
                zeta=etazero/nu-1;%abs(zeta)֮��ı�ֵ�����Ƿ�ӽ�PRI
                nu=fix(nu);%����λ���ӷ��ӵ���ʼʱ�䣬̫Զ�ͻ����1�����Ǵ��ڵ���2
                if ((nu==1)&(toa(m)==O(k)))|((nu>=2)&(abs(zeta)<=zetazero))    %ȷ���Ƿ���Ҫ�ƶ�ʱ����㣬����λ���ӷ��Ӳ�ֵ��С����1ʱ����O(k)�е�ֵ�Ƿ����toa(m),���ǣ�˵����toa(n)-O(k)=pri��ֵ����λ��1��������λ����O(k)=toa(n)
                    O(k)=toa(n);         %����λ���ӷ��Ӳ�ֵ�ϴ󣬴��ڵ���2ʱ��˵��toa(n)-O(k)���ٴ���pri��1.5�������ж�abs��zeta���Ƿ�ӽ�pri��ֵ
                end
                toa(n)
                
                tauk(k)
                eta=(toa(n)-O(k))/tauk(k)                       %������λ��(toa(n)-O(k))Ϊ���º��Tn��tauk(k)ΪTn-Tm��47
                %disp("Toaʱ�䣺",toa(n),"��λ��ʼʱ�䣺",O(k),"С������ֵ��",tauk(k),"�������λֵ��",eta);
                D(k)=D(k)+exp(2*pi*j*eta);                      %����PRI�任
                C(k)=C(k)+1;%û�м���λ���Ƶ�priͳ��ֵ
                flag(k)=0;                                      %����ʹ�ù���PRI�����־    
            end
        elseif tau>taumax*(1+epsilon)
            break
        end
        m=m-1;
    end
    n=n+1;
end
toc
disp(['����ʱ�䣺',num2str(toc)]);
D=abs(D);%�Ը������д�����ģֵ
plot(tauk,D)%���������PRI  �������Ƕ�Ӧ�ĸ���
axis([0 10 0 800])
hold on         
X=[225./tauk;0.15*C;4*sqrt(N*N*bk/750)]; 
A=max(X);                                                      %���޺���
plot(tauk,A,'r-')
xlabel('tauk')
ylabel('|D(k)|')
i=1;
for k=1:K
    if D(k)>A(k)
        p(i)=tauk(k);
        i=i+1;
    end
end
p=sort(p);                                                     %��ֵ���������������䣬�õ�����PRI 



         
                
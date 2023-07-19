clear all
clc
close all
%%
PRI1=156e-006;
t1=1:50;%12
z1=PRI1*t1+1e-006;
figure
yy1 = zeros(1,50)+1;
stem(z1*10^6,yy1,'Marker','none','Color','red');
ylim([0,1.5]);
hold on
PRI2=292e-006;
t2=1:25;%7
z2=PRI2*t2;
yy2 = zeros(1,25)+1;
stem(z2*10^6,yy2,'Marker','none','Color','blue');
hold on
PRI3=371e-006;
t3=1:21;%5
z3=PRI3*t3;
yy3 = zeros(1,21)+1;
stem(z3*10^6,yy3,'Marker','none','Color','black');
title('�����ջ��յ��ź�');
xlabel('���嵽��ʱ��/us');
ylabel('�������/v');
legend('�ź�1��156us','�ź�2��292us','�ź�3��371us')
sig=[z1,z2,z3];
sig = sig * 10^6;
sig = sort(sig); 
time = 35e-4;
%δ���ö����������嶪ʧ���������ռ��������״��źŵĵ���ʱ��

%%
%===============================
%         ������ʼ��ģ��
%===============================
    zz = length(z1)+length(z2)+length(z3);%���嵽���ܸ���
    c = 1;
    coeff1 = 0.4;
    pri = 0;
    pri_num = 0;
    pri_total=0;
    right = 0;
while (zz > 5) && (c < 5)
    search_id = 0;
%%
            tnum1 = zz - c;
            for j = 1 : tnum1%j=2
                if sig(j+c) > sig(j)
                    tem_pri = sig(j+c) - sig(j);%����Ĳ�ֵ
                else
                    tem_pri = 0;
                end
                if abs(pri_num) < 1e-006
                    pri_num = 1;
                    pri(pri_num) = tem_pri;
                    pri_total(pri_num) = 1;
                else
                    for k=1:pri_num %pri_num���������,ָ�ľ���pri����Ŀ
                         if abs(tem_pri - pri(k)) < 1e-006
                              pri_total(k) = pri_total(k) + 1;
                              break
                         end
                         if k == pri_num
                            pri_num = k + 1;
                            pri(pri_num) = tem_pri;
                            pri_total(pri_num) = 1;                     
                         end   
                    end
                end
            end
    %%
    %===============================
    %            ����ģ��
    %===============================
            if pri_num>1                                                
                for m=1:pri_num-1   %��������Ӧ���±꣬Ҳ��pri�ĸ���                                         
                    for n=m+1:pri_num  %��pri��������һ���������һ��
                        if pri(m)>pri(n)
                           tem_data=pri(m);
                           pri(m)=pri(n);
                           pri(n)=tem_data;%����ֻ�Ǻ�������ı任

                           tem_data=pri_total(m);  %Ӧ����pri����Ӧ��ֵ�Ľ���
                           pri_total(m)=pri_total(n);
                           pri_total(n)=tem_data;
                        end
                    end
                end
            end
    %%
    %===============================
    %        ������ֱ��ͼģ��
    %===============================
    if c == 1
        figure
        xpri=(1e-006:1e-003:800);
        y=coeff1*time*10^6./xpri;
        plot(xpri,y)
        title('һ��CDIFͼ');
        xlabel('PRI/us');ylabel('����');
        axis([0 800 0 40]);
        hold on;
        grid on;
        stem(pri,pri_total,'Marker','none')
    end
    if c == 2
        figure
        xpri=(1e-006:1e-003:800);
        y=coeff1*time*10^6./xpri;
        plot(xpri,y)
        title('����CDIFͼ');
        xlabel('PRI/us');ylabel('����');
        axis([0 800 0 40]);
        hold on;
        grid on;
        stem(pri,pri_total,'Marker','none')
    end
    if c == 3
        figure
        xpri=(1e-006:1e-003:800);
        y=coeff1*time*10^6./xpri;
        plot(xpri,y)
        title('����CDIFͼ');
        xlabel('PRI/us');ylabel('����');
        axis([0 800 0 40]);
        hold on;
        grid on;
        stem(pri,pri_total,'Marker','none')
    end
    if c == 4
        figure
        xpri=(1e-006:1e-003:800);
        y=coeff1*time*10^6./xpri;
        plot(xpri,y)
        title('�Ľ�CDIFͼ');
        xlabel('PRI/us');ylabel('����');
        axis([0 800 0 40]);
        hold on;
        grid on;
        stem(pri,pri_total,'Marker','none')
    end
    %%
    %===============================
    %        �ж϶���PRIģ��
    %===============================
        search_num = 1;

    if(pri_num>1) %pri�ĸ�������1��                                               
        m=1;
        while m<=pri_num-1
           n=m+1;%��ԭ�������ݷֳ���·���� n=2
                       %a b c d e f g 
                       %   a b c d e f g
           while n<=pri_num 
              %if (( pri(n)>=2*pri(m)-3e-006 ) && ( pri(n)<=2*pri(m)+3e-006 )) %�Ĺ����ޣ��������&&������ǰ���Ϊ�٣�������Ϊ��
               if ((pri(n)-2*pri(m))>-1e-10)&&((pri(n)-2*pri(m))<1e-10)
                  pri_oncenum=pri_total(m);%pri_total��pri��Ӧ�ĸ���
                  pri_oncevalue=pri(m);%pri(m)��m��Ӧ�±��priֵ
                  pri_twicenum=pri_total(n);
                  pri_twicevalue=pri(n);
                  n = n + 1;%mû�б䣬Ȼ���ж���һ��n��Ӧ������
                %if (( pri_oncenum>((coeff1*time*fs/pri_oncevalue)) ) && ( pri_twicenum>(coeff2*time*fs/pri_twicevalue)) )%coeff1*time*fs/pri_oncevalue����ֵ���ɵ�
                    if (pri_oncenum > (coeff1*time/(pri_oncevalue/10^6))) && (pri_twicenum > (coeff1*time/(pri_twicevalue/10^6)))%coeff1*time*fs/pri_oncevalue����ֵ���ɵ�                         
                       pri_search(search_num) = pri_oncevalue;%pri_search(1) = pri_oncevalue �Ǻ������ֵ
                       pri_searchnum(search_num) = pri_oncenum;
                       search_num = search_num + 1;%search_num = 2;                                                                                          
                       search_id = 1;
                    end
               else
                 n=n+1;
               end
          end
          m=m+1;
        end
    end
    %%
    %===============================
    %     �������޳�����������PRI
    %===============================
        sig_total = 0;
        gate_num = 0;

    if search_id > 0
       search_id = 0;
        for m = 1 : search_num - 1 %λ��
            for n = 1 : zz
           tem_toa = pri_search(m) + sig(n); %��ʼ��������ϱ���Ϊ����ȷ��pri
                for ii = (n + 1) : zz
                    if  ((tem_toa-sig(ii))>-1e-6)&&((tem_toa-sig(ii))<1e-6)%������������ص��ˣ������
                        gate_num = gate_num + 1;
                    end
                end
                if gate_num > 5
                   nn = n ;
                    for p = nn : -1 : 1 %��ǰ����
                        tem_toa = sig(p) - pri_search(m);
                        if abs(tem_toa) < 1e-06
                            sig_total = sig_total + 1;
                            data(sig_total) = sig(p);
                            break;
                        end
                        for ww = p - 1 : -1 : 1
                            if  ((tem_toa-sig(ww))>-1e-10)&&((tem_toa-sig(ww))<1e-10)
                                sig_total = sig_total + 1;
                                data(sig_total) = sig(ww);
                            end
                        end
                    end
                    o = floor(sig_total / 2); %floor������ȡ���ģ�ȡ������x���������
                    for p = 1 : o                                  %********************
                        tem_toa = data(sig_total - p + 1);         %*                  *
                        data(sig_total - p + 1) = data(p);         %*   ����ǰ��Ե�    *
                        data(p) = tem_toa;                         %*                  *
                    end                                            %********************
                     data(sig_total + 1) = sig(nn);
                     sig_total = sig_total + 1;
                    for p = nn : zz-1 %�������
                        tem_toa = sig(p) + pri_search(m); 
%                         if abs(tem_toa - sig(zz)) < 1e-06
%                             sig_total = sig_total + 1;
%                             data(sig_total) = sig(p);
%                             break;
%                         end
                        for ww = (p + 1) : zz
                            if  ((tem_toa-sig(ww))>-1e-10)&&((tem_toa-sig(ww))<1e-10)
                                sig_total = sig_total + 1;
                                data(sig_total) = sig(ww);
                            end
                        end
                    end
                break;
                end
            end
        end
            figure
            ym = length(data);
            yy4 = zeros(1,ym) + 1;
            stem(data,yy4,'Marker','none')
            title('������ͼ');
            xlabel('PRI/us');ylabel('����');
            ylim([0,1.5]);
    %===============================
    %    �޳��ɹ�������������ģ��
    %===============================
            xx = 1;
            while xx <= sig_total
            yy = 1;
                while yy <= zz
                    if (data(xx) >= sig(yy)-5e-006)&&(data(xx) <= sig(yy)+5e-006)
                        if zz > yy
                            for tt = yy : zz - 1
                                sig(tt) = sig(tt+1);
                            end
                        end
                        sig(zz) = 0; 
                        zz = zz - 1;
                        break;
                   else
                   yy = yy + 1;
                   end
                end
                xx = xx + 1;
            end
            %=======================
            %   ��ѡ�ɹ��󲢳�ʼ��
            %=======================
            sig(sig == 0) = [];
            c = 0;
            data = 0;
            pri = 0;
            pri_num = 0;
            pri_total=0;
            right = right + 1;
    end
    c = c+1;
end
%%
%===============================
%      �ж��Ƿ�ɹ���ѡģ��
%===============================
if right == 0
    disp('��ѡʧ��');
else
    disp('��ѡ�ɹ�');
end

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
title('侦察接收机收到信号');
xlabel('脉冲到达时间/us');
ylabel('脉冲幅度/v');
legend('信号1，156us','信号2，292us','信号3，371us')
sig=[z1,z2,z3];
sig = sig * 10^6;
sig = sort(sig); 
time = 35e-4;
%未设置抖动，无脉冲丢失，上面是收集到三部雷达信号的到达时间

%%
%===============================
%         变量初始化模块
%===============================
    zz = length(z1)+length(z2)+length(z3);%脉冲到达总个数
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
                    tem_pri = sig(j+c) - sig(j);%计算的差值
                else
                    tem_pri = 0;
                end
                if abs(pri_num) < 1e-006
                    pri_num = 1;
                    pri(pri_num) = tem_pri;
                    pri_total(pri_num) = 1;
                else
                    for k=1:pri_num %pri_num不等于零的,指的就是pri的数目
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
    %            排序模块
    %===============================
            if pri_num>1                                                
                for m=1:pri_num-1   %横轴所对应的下标，也是pri的个数                                         
                    for n=m+1:pri_num  %从pri个数的下一个·到最后一个
                        if pri(m)>pri(n)
                           tem_data=pri(m);
                           pri(m)=pri(n);
                           pri(n)=tem_data;%这里只是横坐标轴的变换

                           tem_data=pri_total(m);  %应该是pri所对应的值的交换
                           pri_total(m)=pri_total(n);
                           pri_total(n)=tem_data;
                        end
                    end
                end
            end
    %%
    %===============================
    %        画各阶直方图模块
    %===============================
    if c == 1
        figure
        xpri=(1e-006:1e-003:800);
        y=coeff1*time*10^6./xpri;
        plot(xpri,y)
        title('一阶CDIF图');
        xlabel('PRI/us');ylabel('个数');
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
        title('二阶CDIF图');
        xlabel('PRI/us');ylabel('个数');
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
        title('三阶CDIF图');
        xlabel('PRI/us');ylabel('个数');
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
        title('四阶CDIF图');
        xlabel('PRI/us');ylabel('个数');
        axis([0 800 0 40]);
        hold on;
        grid on;
        stem(pri,pri_total,'Marker','none')
    end
    %%
    %===============================
    %        判断二倍PRI模块
    %===============================
        search_num = 1;

    if(pri_num>1) %pri的个数大于1；                                               
        m=1;
        while m<=pri_num-1
           n=m+1;%把原来的数据分成两路数据 n=2
                       %a b c d e f g 
                       %   a b c d e f g
           while n<=pri_num 
              %if (( pri(n)>=2*pri(m)-3e-006 ) && ( pri(n)<=2*pri(m)+3e-006 )) %改过容限，且这里的&&，若其前面的为假，则整体为假
               if ((pri(n)-2*pri(m))>-1e-10)&&((pri(n)-2*pri(m))<1e-10)
                  pri_oncenum=pri_total(m);%pri_total是pri对应的个数
                  pri_oncevalue=pri(m);%pri(m)是m对应下标的pri值
                  pri_twicenum=pri_total(n);
                  pri_twicevalue=pri(n);
                  n = n + 1;%m没有变，然后判断下一个n对应的数据
                %if (( pri_oncenum>((coeff1*time*fs/pri_oncevalue)) ) && ( pri_twicenum>(coeff2*time*fs/pri_twicevalue)) )%coeff1*time*fs/pri_oncevalue门限值，可调
                    if (pri_oncenum > (coeff1*time/(pri_oncevalue/10^6))) && (pri_twicenum > (coeff1*time/(pri_twicevalue/10^6)))%coeff1*time*fs/pri_oncevalue门限值，可调                         
                       pri_search(search_num) = pri_oncevalue;%pri_search(1) = pri_oncevalue 是横坐标的值
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
    %     检索并剔除符合条件的PRI
    %===============================
        sig_total = 0;
        gate_num = 0;

    if search_id > 0
       search_id = 0;
        for m = 1 : search_num - 1 %位置
            for n = 1 : zz
           tem_toa = pri_search(m) + sig(n); %起始的脉冲加上被认为是正确的pri
                for ii = (n + 1) : zz
                    if  ((tem_toa-sig(ii))>-1e-6)&&((tem_toa-sig(ii))<1e-6)%如果这里脉冲重叠了，会误加
                        gate_num = gate_num + 1;
                    end
                end
                if gate_num > 5
                   nn = n ;
                    for p = nn : -1 : 1 %向前搜索
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
                    o = floor(sig_total / 2); %floor是向下取整的，取不大于x的最大整数
                    for p = 1 : o                                  %********************
                        tem_toa = data(sig_total - p + 1);         %*                  *
                        data(sig_total - p + 1) = data(p);         %*   数据前后对调    *
                        data(p) = tem_toa;                         %*                  *
                    end                                            %********************
                     data(sig_total + 1) = sig(nn);
                     sig_total = sig_total + 1;
                    for p = nn : zz-1 %向后搜索
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
            title('序列流图');
            xlabel('PRI/us');ylabel('幅度');
            ylim([0,1.5]);
    %===============================
    %    剔除成功搜索脉冲序列模块
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
            %   分选成功后并初始化
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
%      判断是否成功分选模块
%===============================
if right == 0
    disp('分选失败');
else
    disp('分选成功');
end

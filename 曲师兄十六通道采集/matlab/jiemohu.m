
function y_guji = jiemohu(target_association,PRT)

%% �鿴��ͬPRF�����ڵ����,�ο����ġ�HPRF PD ĩ�Ƶ��״�����ģ��������ơ�
%% ��ģ��

    C=3e8;
    y_guji = [];
    for h = 1:size(target_association,3)                                   %�Բ�ͬ���ٶȽ�����ѭ
    r_shizai = target_association(:,2,h);                                  %ȡͬһ�ٶȵľ�����Ϣ

    Ru = C*PRT/2;                                                          %����ÿ��PRT��������ھ���
    Rmax = 300000;
    pos = find((r_shizai) ~= 0);      %��ȡδ���ڵ���cpi��Ϣ��Ŀ�걻�ڵ����Ӧ��cpi��Ŀ����ϢΪ0
     %% ��������
     if(isempty(pos))   %ȫ���ڵ�
         continue;
     end
      K3 = ceil(Rmax/Ru(pos(1)));    %�Ե�һû�б��ڵ���cpi�����ھ���Ϊ��׼�����㹲�ж��������
      yuchatable2 = zeros(K3,length(pos));  %���ɲ��ұ�
     for p = 1 : K3                %��ÿ����������б���
         for pp = 1:length(pos)    %��û�б��ڵ���Ŀ��������б���
             if pp ~= 1
                %�Ե�һ��û�б��ڵ���cpiΪ��׼���г�����ʵ�ʾ�����ڵĿ��ܣ�Ȼ���������cpi��Ӧ�����ھ���
                yuchatable2(p,pp-1) = mod((p-1)*Ru(pos(1))+r_shizai(pos(1)),Ru(pos(pp)));   
             end
         end
%         yuchatable2(p,length(pos)) = fix((p*Ru(pos(1))+r_shizai(pos(1)))/Ru(pos(1)));
     end

     %% ���
      a2=[];     
     for p=1:K3
         e = 0;
         for pp = 1:length(pos)
             if pp~=1
                e = e+abs(r_shizai(pos(pp))-yuchatable2(p,pp-1));
             end
         end
         a2=[a2,e];
     end

    [~,mohudu]=min(a2);
    [~,a] = max(abs(target_association(:,3,h)));                           %Ѱ����������ĵ���в��
    %Ŀ���ٶ��ǶԲ�ͬcpi�ڵ�����Ŀ����ƽ���ٶȣ�mean(target_association(pos,1,h))
    y_guji = [y_guji;mean(target_association(pos,1,h)),(mohudu-1)*Ru(pos(1))+r_shizai(pos(1)),target_association(a,3:4,h)];
    end

end
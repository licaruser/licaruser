function target = Target(cfar,protect0)
%�˺�������ֵ���������Լ��Գ����ģ���֪����ô���㣬�ɸ���ʵ��������޸�
%target��һ����ά���󣬵�һά��Ų�ͬ��Ŀ�꣬�ڶ�ά���Ŀ����Ϣ(�ֱ�Ϊ�ٶȡ����롢ģֵ)������ά�ǲ�ͬ��cpi
    for j = 1:size(cfar,3)                                                 %CPIѭ��
        
        % Ѱ��Ŀ�꣬����һ���̶������ޣ�����ë�̸��ɵ�
        target_cnt = 0;
        target1 = [];
        for ii = 1:size(cfar,2)
            for i = 1: size(cfar,1)
                if(cfar(i,ii,j) > 50000  )
                    target_cnt = target_cnt + 1;
                    target1(target_cnt,1) = i;
                    target1(target_cnt,2) = ii;
                    target1(target_cnt,3) = cfar(i,ii,j);
                end
            end
        end
        if(isempty(target1))   %��û�ҵ�Ŀ�꣬��������ѭ����������һ��cpi���
            continue;
        end
        %ɾ������Ŀ�꣬С�����ֵ�ĵ�8��֮1���ɵ�
        target2 = [];
        target_max = max(target1(:,3));
        for i = 1 : size(target1,1)
            if(target1(i,3) > target_max/8)
                target2 = [target2;target1(i,:)];
            end
        end
        
        %Ŀ�����ۣ�
        target3 = [];
        for i = 1: size(target2,1)
            for ii = 1:size(target2,1)
                if( i~=ii &&  (abs(target2(i,1)-target2(ii,1))<protect0*4  &&   abs(target2(i,2)-target2(ii,2))<protect0*2 && target2(i,3) < target2(ii,3))  )
                    break;
                end
            end
            
            if(ii == size(target2,1))
                target3 = [target3;target2(i,:)];
                for k = 1:(size(target3,1)-1)
                    if( (abs(target2(i,1)-target3(k,1))<protect0*4  &&   abs(target2(i,2)-target3(k,2))<protect0*2 && target2(i,3) == target3(k,3))  )
                        target3(size(target3,1),:) = [];
                        break;
                    end
                end
            end
        end
       target(1:size(target3,1),1:size(target3,2),j) = target3;
    end

end
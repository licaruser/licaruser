function target_association = Target_association(target)
%Ŀ��������Լ�д�ģ����ٶȽ��й�������������Ŀ���ٶȽӽ�����˷���������
%target_associationΪһ����ά���顣��һά��Ų�ͬcpi���ٶ���ͬ��Ŀ��
%�ڶ�ά���Ŀ�����Ϣ(�ֱ�Ϊ�ٶȡ����롢�͡���)������ά��Ų�ͬ�ٶȵ�Ŀ��
    d = 0;
    while(~isempty(find(target(:,1,:),1)))                                 %�ж��Ƿ���δ������Ŀ��
        [k,kk] = find(target(:,1,:),1);                                    %Ѱ�ҵ�һ��δ����Ŀ�������
        [h,hh] = find(abs(target(k,1,kk)-target(:,1,:))<20);               %Ѱ�Һ͵�һ��δ����Ŀ���ٶ�С��20������Ŀ�������

        d = d+1;
        for p = 1:size(h,1)                                                %���ҵ�������Ŀ������ѭ
            target_association(hh(p),:,d) = target(h(p),:,hh(p));          %��Ŀ����ౣ������
            target(h(p),:,hh(p)) = [0 0 0 0];                              %���Ѿ��ҵ���Ŀ�����
        end
    end

end
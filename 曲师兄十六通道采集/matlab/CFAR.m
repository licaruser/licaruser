function cfar = CFAR(mtd,protect,test,k0)  %protectΪ������Ԫ��testΪ�ο���Ԫ��k0Ϊϵ��
    
    cfar = zeros(size(mtd));
    mtd = abs(mtd);                                                        %��ģ
    y_x = mtd.*mtd;                                                        %Ϊ�˺�Ӳ����ʵ�ֶ�Ӧ��������ģû����

    bit_length = size(dec2bin(max(max(max(y_x)))),2);
    if( bit_length > 32 )
        y_x = round(y_x./(2^(bit_length-32)));
    end
        
    for i = 1:size(mtd,3)                                                  %CPIѭ��
        for ii=1:size(y_x,1)                                               %�������ѭ��
            cfar(ii,:,i) = CFAR2(y_x(ii,:,i),protect,test,k0);             %����ά�����(ʵ��ʱΪ�˷��㣬���ٶ�ά����)
        end
        figure;mesh(reshape(cfar(:,:,i),size(cfar,1),size(cfar,2)));
        title(['CFAR',num2str(i)]);
    end

end
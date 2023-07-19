function Echo = Echo_sim(RO,Vr,N_CI,SNR,fai_t,Sbarker,nPRT,nTp,PRT,Fs,Fc,C,juli_max,Ny,d_lambda_1)

Echo = zeros(N_CI,max(nPRT)-nTp,size(nPRT,2),Ny);                          %���ȫ��CPI�Ļز�,һά�����������ά�������
                                                                           %��άCPI,��άͨ����Ϣ
%% �ز�ģ��
    for k = 1 : size(nPRT,2)                                               %cpiѭ��
        Echo_r = zeros(N_CI,max(nPRT),size(RO,2),Ny);                      %��ŵ���CPI����Ŀ��Ļز�,һά�������
                                                                           %��ά�����������άĿ����Ϣ,��άͨ����Ϣ
        for ii = 1 : size(RO,2)                                            %Ŀ�����ѭ��
            aat = exp(1i*2*pi*d_lambda_1*[0:1:(Ny-1)]'*sin(fai_t(ii)*pi/180));%Ŀ�굼��ʸ��
            real_juli = RO(ii);
            juli_n = fix((real_juli)*2*Fs/C);
            for i = 1:N_CI                                                 %�������ѭ��
               juli = RO(ii) - Vr(ii)*PRT(k)*(i-1);
        %       juli_n = fix((real_juli)*2*Fs/C);
               
               if(real_juli> juli_max(k))                                  %Ŀ������Զʱ��ǰ����prt���ղ����ز�
                   real_juli = real_juli- juli_max(k);
                   juli_n = fix((real_juli)*2*Fs/C);
               else
                   Echo_r(i,juli_n+1:juli_n+nTp,ii,1) = Sbarker.* exp(-1i*2*pi*juli*2/(C/Fc));  %���������ٶ���Ϣ
               end
            end
            %Echo_r(:,:,ii,1) = awgn(Echo_r(:,:,ii,1),SNR(ii), 'measured');  %��������(�о��е�������)
            Sr = aat*reshape(Echo_r(:,:,ii,1),1,[]);                       %���뷽λ��Ϣ��һͨ����Ϊ16ͨ��
            Echo_r(:,:,ii,:)  = reshape(Sr.',N_CI,[],1,Ny);
        end
        Echo(:,1:(nPRT(k)-nTp),k,:) = sum(Echo_r(:,1+nTp:nPRT(k),:,:),3);  %����CPI��Ŀ��ز����
    end
    
end





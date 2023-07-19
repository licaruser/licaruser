function [PulseUpPos PulseDownPos PulseUpFlag PulseDownFlag] = EnergyDetect(DataIn)
%%%%%%%%%%%%%%%%%%% ������ⷽ�� %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �汾:     V1.0
% �������壺
%           DataIn����������
%           PulseUpPos:����ǰ�ص�λ��
%           PulseDownPos:������ص�λ��
%           PulseUpFlag:DOB�˲����Ƿ��⵽����ǰ�صı�־
%           PulseDownFlag:DOB�˲����Ƿ��⵽������صı�־
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PulseUpFlag = 0;
PulseDownFlag = 0;
PulseUpPos = 0;
PulseDownPos = 0;
%% ������õĲ���
FrameSize = 128;
DataLength = length(DataIn);
% FrameNum = floor(DataLength/FrameSize);
%% 1������ǰ��Ĵ��������ּ����������ʺͷ���
DataRead = DataIn.*DataIn;
NoisePower = mean(DataRead(1:32*FrameSize));
%% 2��������ⷽ������������
PulseFlag = 0;
CntBegin = 0;
CntEnd = 0;
BeginFrameThrh = 128;
EndFrameThrh = 128;
data_buff= zeros(1,FrameSize);
for k = 1:DataLength
    for j=2:FrameSize
        data_buff(FrameSize-j+2) =  data_buff(FrameSize-j+1);
    end
     data_buff(1) = DataRead(k);
     
    DataPower = mean(data_buff);              %��ȡ��һ֡���ź�ƽ������
    if (DataPower > 1.5*NoisePower)
        CntEnd = 0;
        CntBegin = CntBegin + 1;
        if (CntBegin >= BeginFrameThrh)   %�����г���BeginFrameThrh֡�źų���������ޣ�����Ϊ�����忪ʼ
            if (PulseFlag == 0)                   %��ǰ��δ��⵽����
%                 % Ѱ�Ҿ�ȷ��������ʼλ��
                  PulseUpPos = k-FrameSize+1;
             end                
                PulseUpFlag = 1;
                PulseFlag = 1;     
         end
           
    else
        if PulseFlag == 1
            CntEnd = CntEnd + 1;
            if CntEnd >= EndFrameThrh       %����������EndFrameThrh֡�źŵ��ڼ�����ޣ�����Ϊ��������� 
                % Ѱ�Ҿ�ȷ���������λ��
                  PulseDownPos =  k-FrameSize-127;
%                 PulseDownPos = (k-EndFrameThrh)*FrameSize;
%                 for l = 1:FrameSize
%                     ptr = (k-EndFrameThrh-1)*FrameSize;
%                     TempData = DataRead(ptr+l:ptr+l+FrameSize);
%                     TempPower = mean(TempData);
%                     if TempPower < 1.4*NoisePower
%                         PulseDownPos = ptr + l;
%                         break;
%                     end
%                 end
                PulseDownFlag = 1;
                PulseFlag = 0;
                CntBegin = 0;
          
            end
        else
            CntBegin = 0;
            CntEnd = 0; 
        end
    end
end
            
 

        
        
        
        

function [Hn,PhaseHnPulse] = ComplexCodeGenerate(PulseNumTh,Npw,m_SubStepNum,m_PCMCodeIndex,m_fs,m_CodeWidth,m_SubPulsePCMCode,m_CodeNumAll)
   
     PointNum = (m_CodeWidth * m_fs);% ������Ԫ����
	   PhaseHnPulseCount = 0; % ���ӱ��� ȡ�����
	   PhaseHnPulse = zeros(1,Npw * m_SubStepNum);% ��ȡ��������λ��

    for kk = PulseNumTh * Npw *m_SubStepNum:(PulseNumTh * Npw * m_SubStepNum + (2^m_PCMCodeIndex - 1) * m_SubStepNum-1)
        
	  
		   for ll = kk*PointNum:(kk + 1)*PointNum-1	   
			   % PhaseHnPulse[PhaseHnPulseCount] = m_SubPulsePCMCode[(kk) % m_CodeNumAll];// - PulseNumTh * Npw * m_SubStepNum
			     PhaseHnPulse(PhaseHnPulseCount+1) = m_SubPulsePCMCode(mod(kk,m_CodeNumAll)+1);
			     PhaseHnPulseCount = PhaseHnPulseCount+1;
           end
           addr(kk-PulseNumTh * Npw *m_SubStepNum+1)=mod(kk,m_CodeNumAll);
	  end

	  Hn = cos(PhaseHnPulse) + sqrt(-1)*sin(PhaseHnPulse) ;

end 
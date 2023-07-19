function coeff = coeff_produce(Sbarker,MY_NFFT,Decimation,N_CI,nTp)

s3 = zeros(1,MY_NFFT*Decimation);
s3(1:nTp) = Sbarker;
s3 = reshape(s3,Decimation,[]);                                            %20����ȡ
s3 = s3(1,:);

coeff = fft(s3);
coeff = conj(coeff);                                                       %ȡ����

bit_length = max( [size(dec2bin(max(abs(real(coeff)))),2) size(dec2bin(max(abs(imag(coeff)))),2) ]);
if( bit_length > 15 )
    coeff = round(coeff./(2^(bit_length-15)));
end
coeff = repmat(coeff,N_CI,1);                                              %ϵ�����ƣ����ھ������

end
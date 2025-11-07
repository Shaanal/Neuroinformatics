% Create a family of complex Morlet wavelets, ranging in frequencies from 2 Hz to 30 Hz in
% five steps. 

fs = 1000;              
t = -1:1/fs:1;          
frequencies = linspace(2,30,5);  
nCycles = 5;            

wavelets = cell(length(frequencies),1);

figure;
for i = 1:length(frequencies)
    f = frequencies(i);
    
    sigma = nCycles / (2*pi*f);

    wavelet = exp(2*1i*pi*f*t) .* exp(-t.^2/(2*sigma^2));
    wavelets{i} = wavelet;
    
    subplot(5,2,2*i-1);
    plot(t, real(wavelet), 'b');
    title(['Real part @ ' num2str(f) ' Hz']);
    xlim([-0.5 0.5]); grid on;

    subplot(5,2,2*i);
    plot(t, imag(wavelet), 'r');
    title(['Imag part @ ' num2str(f) ' Hz']);
    xlim([-0.5 0.5]); grid on;
end

% Create a family of Morlet wavelets ranging in frequency from 2 Hz to 30
% Hz in five steps.

num_wavelets      =  5;  % number of frequency bands
lowest_frequency  =   2;  % in Hz
highest_frequency = 30;  % in Hz

frequencies=linspace(lowest_frequency,highest_frequency,num_wavelets);
% note: the "linspace" function creates linearly spaced numbers between the first and second 
% inputs, with the number of steps corresponding to the third input. 
figure, plot(frequencies,'-*')
xlabel('Frequency order')
ylabel('Frequency in Hz')


% initialize wavelet family
wavelet_family = zeros(num_wavelets,length(time));
 
% Loop through frequencies and make a family of wavelets.
for fi=1:num_wavelets
    
    % create a sine wave at this frequency
    sinewave = exp(2*1i*pi*frequencies(fi).*time); % the "1i" makes it a complex wavelet
    
    % create a Gaussian window
    gaus_win = exp(-time.^2./(2*(6/(2*pi*frequencies(fi)))^2));
    
    % create wavelet via element-by-element multiplication of the sinewave and gaussian window
    wavelet_family(fi,:) = sinewave.*gaus_win;
    
    % note that you can also do this on one line:
    wavelet_family(fi,:) = exp(2*1i*pi*frequencies(fi).*time) .* exp(-time.^2./(2*(6/(2*pi*frequencies(fi)))^2));
end

% Plot a few wavelets
figure
plot(time,real(wavelet_family(1:end,:))') 
title('A few wavelets...')
 


% finally, image the wavelet family.
figure
imagesc(time,frequencies,real(wavelet_family))
axis xy % equivalent to "set(gca,'ydir','normal')
xlabel('Time (s)')
ylabel('Frequency (Hz)')
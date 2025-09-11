eeglab
EEG = pop_loadset('eeglab_data.set', fullfile(fileparts(which('eeglab')), 'sample_data'));

data = EEG.data;       % channels x samples
chan_labels = {EEG.chanlocs.labels};

figure;
[~,~,~,~,~] = spectopo(data, size(data,2), EEG.srate);

%%
wo = 60/(EEG.srate/2); 
bo = wo/35;
[bn,an] = iirnotch(wo, bo);

data_filt = filtfilt(bn,an,data')';

figure;
[~,~,~,~,~] = spectopo(data_filt, size(data_filt,2), EEG.srate);

%%
wo = 60/(EEG.srate/2); 
bo = wo/70;
[bn,an] = iirnotch(wo, bo);

data_filt = filtfilt(bn,an,data')';

figure;
[~,~,~,~,~] = spectopo(data_filt, size(data_filt,2), EEG.srate);

%%
wo = 60/(EEG.srate/2); 
bo = wo/100;

[bn,an] = iirnotch(wo, bo);

data_filt = filtfilt(bn,an,data')';

figure;
[~,~,~,~,~] = spectopo(data_filt, size(data_filt,2), EEG.srate);

%%
avg_ref = mean(data_filt, 1);
data_car = data_filt - avg_ref;

figure;
[~,~,~,~,~] = spectopo(data_car, size(data_car,2), EEG.srate);

%%
event_latencies = [EEG.event.latency]; 
event_types     = {EEG.event.type};
target_idx = find(strcmp(event_types,'rt'));
epoch_window = round([-0.2 0.8]*EEG.srate);  
epoch_len = diff(epoch_window)+1;

% Preallocate
epochs = nan(size(data_car,1), epoch_len, length(target_idx));
for i = 1:length(target_idx)
    center = round(event_latencies(target_idx(i)));
    idx = center+epoch_window(1):center+epoch_window(2);
    if idx(1)>0 && idx(end)<=size(data_car,2)
        epochs(:,:,i) = data_car(:,idx);
    end
end

%%
baseline_idx = 1:round(0.2*EEG.srate);
baseline = mean(epochs(:,baseline_idx,:),2);
epochs_bc = epochs - baseline;

% for j = 1:size(epochs_bc, 3)
%     [~,~,~,P(:,:,j)] = spectogram();
% end
% 
% P_mean = mean(P, 3);
% 
% figure;


% Parameters
fs    = EEG.srate;                    % sampling rate
win   = hamming(round(0.5*fs));       % 500 ms window
nover = round(0.4*fs);                % 400 ms overlap
nfft  = 2^nextpow2(length(win));      % FFT length

nChans  =??;
nTrials =??;

% Preallocate
P_all = [];

for ch = 1:nChans
    for tr = 1:nTrials
        sig = squeeze(epochs_bc(ch,:,tr));

        [~,F,T,P] = spectrogram(sig, win, nover, nfft, fs);

        if isempty(P_all)
            P_all = zeros([size(P), nChans, nTrials]);
        end

        P_all(:,:,ch,tr) = P;
    end
end

% === Average across trials and channels ===
P_mean = mean(P_all, [3 4]);

% === Plot ===
figure;
surf(T, F, 10*log10(P_mean), 'EdgeColor', 'none');
axis tight;
view(0,90);
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Trial- and Channel-averaged Spectrogram');
colorbar;
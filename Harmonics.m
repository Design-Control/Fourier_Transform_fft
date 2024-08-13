% x : 주파수를 분석할 데이터(1XN 크기의 row행렬)
% T : 샘플링을 한 시간

% X_n : 고조파의 크기
% phase : 고조파의 위상(-pi~pi)
% freg : X_n 과 phase의 주파수 축
% N : 샘플링 개수
% f_0 : 이산 주파수의 해상도
% x_out : 고조파로 재합성한 입력 데이터
% t : x_out의 시간 축

function [X_n, phase, freg, N, f_0, x_out, t] = Harmonics(x, T)

    N = length(x); %샘플링 개수
    f_0 = 1/T; %이산 주파수의 해상도
    X_fft = fft(x); %fft
    cut_off = ceil(N/2); %fft의 freg>=0 영역의 N 개수
    
    % 주파수의 범위 설정
    freg = f_0*(0:cut_off-1); % freg>=0 영역

    % 고조파계수 구하기
    X_n = X_fft(1:cut_off); %freg>=0 영역
    X_n = X_n/N; %FT를 FS로 변환
    X_n(2:end) = 2*X_n(2:end); %음의 주파수 영역을 고려

    %phase와 크기
    phase = angle(X_n);
    X_n = abs(X_n);

    %고조파를 이용하여 원래 데이터로 합성
    t = linspace(0, T, N); % 샘플링한 시간
    w_0 = 2*pi*f_0; %fundamental 각속도
    x_out = zeros(1, N);
    
    x_out = X_n(1); %freq=0 일 때(average)
    for i = 2:cut_off
        x_out = x_out + X_n(i)*cos(w_0*(i-1)*t+phase(i));
    end

    %그래프 plot
    figure(1);
    tiledlayout(2, 2);

    nexttile;
    plot(t, x);
    title("Sampling Data");
    xlabel("t(초, s)");
    ylabel("크기");

    nexttile;
    plot(t, x_out, 'r');
    title("고조파로 재합성된 Sampling Data");
    xlabel("t(초, s)");
    ylabel("크기");

    nexttile;
    plot(freg, X_n, 'r-o');
    title("고조파의 크기");
    xlabel("freq(Hz)");
    ylabel("크기");

    nexttile;
    plot(freg, phase/pi, 'r-o');
    title("고조파의 위상(cosine fundamental 기준)");
    xlabel("freq(Hz)");
    ylabel("Phase/\pi");

end
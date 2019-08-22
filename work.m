function work
    function vir = self_fft(wav_path)
        function work_fft(N)
            M = 1;
            i = N;
            i = i/2;
            while(i~=1)
                i = i/2;
                M = M+1;
            end
            i = 1;
            j = N/2;
            while(i<=N-2)
                if(i<j)
                   t = complex(j);
                   complex(j) = complex(i);
                   complex(i) = t;
                end
                k = N/2;
                while(k<=j)
                   j = j-k;
                   k = k/2;
                end
                j = j+k;
                i = i+1;
            end
            m = 1;
            while(m<=M)
                la = 2^m;
                lb = la/2;

                l = 1;
                while(l<=lb)
                    r = (l-1)*(2^(M-m));
                    n = l;
                    while(n<N)
                        lc = n+lb;
                        wwn.real = cos(2*PI*r/N);
                        wwn.imag = (-1)*sin(2*PI*r/N);
                        temp_real = complex(lc).real*wwn.real-complex(lc).imag*wwn.imag;
                        temp_imag = complex(lc).real*wwn.imag+complex(lc).imag*wwn.real;
                        temp_mul = struct('real',{temp_real},'imag',{temp_imag});
                        complex(lc).real = complex(n).real - temp_mul.real;
                        complex(lc).imag = complex(n).imag - temp_mul.imag;
                        complex(n).real = complex(n).real + temp_mul.real;
                        complex(n).imag = complex(n).imag + temp_mul.imag;
                        n = n+la;
                    end
                    l = l+1;
                end    
                m = m+1;
            end
        end

        PI = 3.1415926535897932384626433832795028841971;

        [y, Fs] = audioread(wav_path);
        %Fs是采样频率---(每秒从信号中提取点的个数)
        turn = 1;
        while(turn^2<length(y))
           turn = turn+1; 
        end

        complex = struct('real',{0},'imag',{0});
        for ii = 1:turn^2
            if(ii<=length(y))
                complex(ii).real = y(ii);
            else
                complex(ii).real = 0;
            end
            complex(ii).imag = 0;
        end
        wwn = struct('real',{0},'imag',{0});
        npot = 1024;
        work_fft(npot);
        for ii = 1:turn^2
            digital = sqrt(-1);
            vir(ii) = complex(ii).real + (complex(ii).imag)*digital;
        end
        figure(1)
        plot(Fs*(0:511)/1024,abs(vir(1:512)));
        title('自己实现的fft');
        figure(2)
        y1=fft(y,1024);%1024---y短补0至1024，长则截断成1024---y为一个横向量
        plot(Fs*(0:511)/1024,abs(y1(1:512)));
        title('matlab自带的fft');
    end
    gene = self_fft('D:\music\go_home.wav');
end







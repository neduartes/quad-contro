figure(1)

for n =1:3
    subplot(3,1,n)
    plot(time, output.signals.values(:,2*n - 1),'-b', time, output.signals.values(:,2*n), '-r');
end

figure(2)
for n =1:3
    subplot(3,1,n)
    plot(time, control.signals.values(:,n),'-b');
end

figure(3)
for n =1:4
    subplot(4,1,n)
    plot(time, speed.signals.values(:,n),'-b');
end
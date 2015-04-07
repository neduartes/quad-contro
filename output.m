figure(1)

subplot(3,1,1)
plot(time, output.signals.values(:,1),'-b');
xlabel('Time [sec]')
axis([0 5 -2 2])
grid on

subplot(3,1,2)
plot(time, output.signals.values(:,3),'-r');
xlabel('Time [sec]')
axis([0 5 -2 2])
grid on

subplot(3,1,1)
plot(time, output.signals.values(:,5),'-g');
xlabel('Time [sec]')
axis([0 5 -2 2])
grid on

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
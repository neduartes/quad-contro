figure(1)

subplot(3,1,1)
plot(time, 180 * output.signals.values(:,1) / pi ,'-b');
xlabel('Time [sec]', 'FontName', 'Latin Modern Roman', 'FontSize', 10)
ylabel('Roll [deg]', 'FontName', 'Latin Modern Roman', 'FontSize', 10)
set(gca, 'FontName', 'Latin Modern Roman', 'FontSize', 10);
axis([0 15 -75 75])
set(gca,'ytick',[-90:30:90])
grid on

subplot(3,1,2)
plot(time, 180 * output.signals.values(:,3) / pi,'-r');
xlabel('Time [sec]', 'FontName', 'Latin Modern Roman', 'FontSize', 10)
ylabel('Pitch [deg]', 'FontName', 'Latin Modern Roman', 'FontSize', 10)
set(gca, 'FontName', 'Latin Modern Roman', 'FontSize', 10);
axis([0 15 -75 75])
set(gca,'ytick',[-90:30:90])
grid on

subplot(3,1,3)
plot(time, 180 * output.signals.values(:,5) / pi,'-g');
xlabel('Time [sec]', 'FontName', 'Latin Modern Roman', 'FontSize', 10)
ylabel('Yaw [deg]', 'FontName', 'Latin Modern Roman', 'FontSize', 10)
set(gca, 'FontName', 'Latin Modern Roman', 'FontSize', 10);
axis([0 5 -45 45])
set(gca,'ytick',[-90:30:90])
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
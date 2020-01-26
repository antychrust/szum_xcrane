rosinit;
pozycja = rossubscriber('/crane_x7/arm_controller/state'); %ustawienie topica do pobierania pozycji
sterowanie = rospublisher('/crane_x7/arm_controller/command'); %ustawienie topica do kontroli
wiadomosc=rosmessage(sterowanie.MessageType); %ustawienie typu wiadomosci z topic do sterowania
a=receive(pozycja,1) %odbiór pozycji
wiadomosc.Points = rosmessage('trajectory_msgs/JointTrajectoryPoint'); %ptzygotowanie obiektu to punktów docelowych
wiadomosc.Points.TimeFromStart = ros.msg.Duration(); %przepisanie niezbędnych parametrów
wiadomosc.Header.Stamp=a.Header.Stamp; %przepisanie timestampa
wiadomosc.Points.TimeFromStart.Sec=3; %ustawienie zadanego czasu ruchu
wiadomosc.Points.TimeFromStart.Nsec=3000;
wiadomosc.Points.Positions=[1;-0.5;0;-2.5;0;0.6;0]; %ustawienie pozycji pierwszej
wiadomosc.JointNames=a.JointNames;
wiadomosc.Points.Velocities=[0;0;0;0;0;0;0]; %macierz prędkości końcowych
send(sterowanie, wiadomosc) %wysłanie zadanego położenia
pause(3);
a=receive(pozycja,1) %odebranie pozycji
wiadomosc.Points.TimeFromStart = ros.msg.Duration();
wiadomosc.Header.Stamp=a.Header.Stamp;
wiadomosc.Points.TimeFromStart.Sec=6;
wiadomosc.Points.Positions=[0;-0.5;0;-2.5;0;0.6;0]; %ustawienie pozycji 2
send(sterowanie, wiadomosc)
pause(10);
a=receive(pozycja,1)
wiadomosc.Points.TimeFromStart = ros.msg.Duration();
wiadomosc.Header.Stamp=a.Header.Stamp;
wiadomosc.Points.TimeFromStart.Sec=3;
wiadomosc.Points.Positions=[0;0;0;0;0;0;0]; %powrót do pozycji początkowej
send(sterowanie, wiadomosc);
pause(5)
rosshutdown;

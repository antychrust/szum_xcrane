rosinit;
pozycja = rossubscriber('/crane_x7/arm_controller/state');
sterowanie = rospublisher('/crane_x7/arm_controller/command');
wiadomosc=rosmessage(sterowanie.MessageType);
a=receive(pozycja,1)
wiadomosc.Points = rosmessage('trajectory_msgs/JointTrajectoryPoint');
wiadomosc.Points.TimeFromStart = ros.msg.Duration();
wiadomosc.Header.Stamp=a.Header.Stamp;
wiadomosc.Points.TimeFromStart.Sec=3;
wiadomosc.Points.TimeFromStart.Nsec=3000;
wiadomosc.Points.Positions=[1;-0.5;0;-2.5;0;0.6;0];
wiadomosc.JointNames=a.JointNames;
wiadomosc.Points.Velocities=[0;0;0;0;0;0;0];
send(sterowanie, wiadomosc)
pause(3);
a=receive(pozycja,1)
wiadomosc.Points.TimeFromStart = ros.msg.Duration();
wiadomosc.Header.Stamp=a.Header.Stamp;
wiadomosc.Points.TimeFromStart.Sec=6;
wiadomosc.Points.Positions=[0;-0.5;0;-2.5;0;0.6;0];
send(sterowanie, wiadomosc)
pause(10);
a=receive(pozycja,1)
wiadomosc.Points.TimeFromStart = ros.msg.Duration();
wiadomosc.Header.Stamp=a.Header.Stamp;
wiadomosc.Points.TimeFromStart.Sec=3;
wiadomosc.Points.Positions=[0;0;0;0;0;0;0];
send(sterowanie, wiadomosc);
pause(5)
rosshutdown;
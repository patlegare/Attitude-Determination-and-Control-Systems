%sample time and date

startTime=datetime(2020,8,19,20,55,0);
stopTime=startTime+days(1);
sampleTime=60;
sc=satelliteScenario(startTime,stopTime,sampleTime);
vwr=satelliteScenarioViewer(sc);

%adding satellite

sma=1e7;
eccentricity=0.2;
inclination=75;
RAAN=0;
arg_per=0;
true_anomaly=0;
orbProp= "two-body-keplerian";
satname= "Satellite";

sat = satellite(sc, ...
    sma, ...
    eccentricity, ...
    inclination, ...
    RAAN, ...
    arg_per, ...
    true_anomaly);

%camera

maxviewangle=60;
name= "Camera"
camera= conicalSensor(sat, ...
    MaxViewAngle=maxviewangle, ...
    Name=name);
fieldOfView(camera);

%groundstation
latitude=45.5;
longitude=-73.6;
gsname= "Ground Station";

gs=groundStation(sc, ...
    latitude, ...
    longitude, ...
    Name=gsname);

%point satellite to ground station
pointAt(sat,gs)

%access
ac=access(camera,gs);
accessIntervals(ac)

%viewer camera
camLat=latitude;
camLon=longitude;
camAlt=2e7;
campos(vwr,camLat,camLon,camAlt)
speedMultiplier=1000;
play(sc,PlaybackSpeedMultiplier=speedMultiplier);

%gimbal antenna
txmountloc=[0;0;1];
gimbalSat=gimbal(sat, txmountloc);
txfeq=10e9;
txpower=15;
txname= "Satellite Transmitter";

satTx= transmitter(gimbalSat, ...
    MountingLocation=txmountloc, ...
    Frequency=txfeq, ...
    Power=txpower, ...
    Name=txname);

txdishdiam=0.5;
gaussianAntenna(satTx, ...
    DishDiameter=txdishdiam);

%tracking target for gimbal
pointAt(gimbalSat,gs);



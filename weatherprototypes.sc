//boilerplate 
(

Server.default.options.memSize = 512*1024;
s.boot; 
)

(
{
var x;
x = HPF.ar(PinkNoise.ar(0.5).distort * 2, 200) * 0.1;

GVerb.ar(x, 105, 5, 0.7, 0.8, 60, 0.1, 0.5, 0.4) + x;

}.play;


// Thunder 

{var t;
 var y; 
t = EnvGen.kr(Env.perc(0.01, rand(5)+ 0.5)) * WhiteNoise.ar(0.5); 


y = BPF.ar(t,rand(1300) + 100);

GVerb.ar(y, 105, 5, 0.7, 0.8, 60, 0.1, 0.5, 0.4) + y;
}.play;

SynthDef(\thunder,
{| freq = 440, gate = 1, sustain = 1, amp= 0.25|
  var sig, t,y; 
  t = EnvGen.kr(Env.perc(0.01, rand(5)+ 0.5)) * WhiteNoise.ar(0.5); 
  y = BPF.ar(t,rand(1300) + 100);
  sig = GVerb.ar(y, 105, 5, 0.7, 0.8, 60, 0.1, 0.5, 0.4) + y * amp;
  Out.ar(0, sig ! 2) 
}).add;

p = Pbind(
                \instrument, \thunder,
                \dur, Prand([ 2,3,4,10,24,0.5,0.1,34], inf),
                \amp, 0.5).play;

)


(

//"temperature":67.77,

// if the temperature is below 30 
{ Klang.ar(`[ [800, 1000, 1200],[0.3, 0.3, 0.3],[pi,pi,pi]], 1, 0) * EnvGen.ar(Env.perc(0.01,0.3))}.play;


SynthDef(\030,
{| freq = 440, gate = 1, sustain = 1, amp= 0.25, pitch= 100 |
  var sig, t,y; 
  t = EnvGen.kr(Env.perc(0.01, 0.3)) * Klang.ar(`[ [pitch, pitch + 200, pitch + 400],[0.3, 0.3, 0.3],[pi,pi,pi]], 1, 0) ; 
  sig = BPF.ar(t,rand(1300) + 100) * amp;
  Out.ar(0, sig ! 2) 
}).add;

p = Pbind(
                \instrument, \030,
                \pitch, Prand([200,210,300,100,330], inf), 
                \dur, Prand([ 2,3,4,5,0.5,0.1,3], inf),
                \amp, 0.5).play;




// if the temperature is between 30 and 60 






// if the temperature is between 60-90 

{Saw.ar(Line.ar(rand(300) + 300 ,rand(200) + 200 ,0.25),1,1) * EnvGen.ar(Env.perc(0.01,0.3)) }.play;

SynthDef(\6090,
{| freq = 440, gate = 1, sustain = 1, amp= 0.25, pitch= 100 |
  var sig, t,y; 
  t = EnvGen.kr(Env.perc(0.01, 0.3)) * Saw.ar(Line.ar(rand(300) + pitch ,rand(200) + 200 ,0.25),1,1) ; 
  y = BPF.ar(t,rand(1300) + 100);
  sig =t + y * amp;
  Out.ar(0, sig ! 2) 
}).add;

p = Pbind(
                \instrument, \6090,
                \pitch, Prand([200,210,300,100,330], inf), 
                \dur, Prand([ 2,3,4,5,0.5,0.1,3], inf),
                \amp, 0.5).play;

// if the temperature is between 90-100 

/*/{SinOsc.ar(LFNoise1.kr(4,60,80),1,0.25).distort * SinOsc.kr(20,1,100000) * EnvGen.ar(Env.perc(0.01,8))
}.play;

{SinOsc.ar(LFNoise1.kr(4,1000,2000),1,0.25).distort * SinOsc.kr(20,1,100000)}.play
/*/


// "precipIntensity":0,


// Farnell Rain on Ground 

{
HPF.ar(LPF.ar(BPF.ar(WhiteNoise.ar(0.4), 50, 0.4), 500) * Saw.ar(LFNoise2.ar(0.25,7),1,1) * 3 -0.25, 500);



}.play;

{ LPF.ar(BPF.ar( WhiteNoise.ar(0.4), 50, 0.4), 500) * 10 }.play;

// General Ambient Rain Noise 

{
var x;
x = HPF.ar(PinkNoise.ar(0.5).distort * 2, 200) * 0.1;

GVerb.ar(x, 105, 5, 0.7, 0.8, 60, 0.1, 0.5, 0.4) + x;

}.play;


// Thunder 

{var t;
 var y; 
t = EnvGen.kr(Env.perc(0.01, rand(5)+ 0.5)) * WhiteNoise.ar(0.5); 


y = BPF.ar(t,rand(1300) + 100);

GVerb.ar(y, 105, 5, 0.7, 0.8, 60, 0.1, 0.5, 0.4) + y;
}.play;




SynthDef(\thunder,
{| freq = 440, gate = 1, sustain = 1, amp= 0.25|
  var sig, t,y; 
  t = EnvGen.kr(Env.perc(0.01, rand(5)+ 0.5)) * WhiteNoise.ar(0.5); 
  y = BPF.ar(t,rand(1300) + 100);
  sig = GVerb.ar(y, 105, 5, 0.7, 0.8, 60, 0.1, 0.5, 0.4) + y * amp;
  Out.ar(0, sig ! 2) 
}).add;

p = Pbind(
                \instrument, \thunder,
                \dur, Prand([ 2,3,4,10,24,0.5,0.1,34], inf),
                \amp, 0.5).play;


        



//"dewPoint":46.65,
{(SinOsc.ar(LFNoise2.ar(43 / 5 ,800,43 / 200) + 800,1,43 / 300))}.play

//"windSpeed":19.64,



// "cloudCover":0.12,



// "humidity":0.46, 
 {DelayN.ar(Decay.ar(Dust.ar(1,0.5), 0.3, SinOsc.ar),3,0.5)}.play;


// "pressure":1020.64, Low pressure contributes to stormyness 

// Low Pressure 
{LPF.ar(SinOsc.ar(SinOsc.kr(0.125 ,1, 40 + LFNoise1.ar(1,1,3)) + 5,1,0.25),400) }.play;

// "visibility":10, capped at 10. 2<, <2, 10 


{Impulse.ar(LFNoise1.ar(5,3,8),1,1)}.play;  
{Dust.ar(LFNoise1.ar(5,3,8),1)}.play;  

)
                               

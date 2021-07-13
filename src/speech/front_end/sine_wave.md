# Sine Wave

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/sine-wave-eq1.png)

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/sine-wave-eq2.png)

## **If the period of the sine function is** 2𝜋, will the wavelength also be 2𝜋?

This is a good question, and one that I’m sure lots of people have had when first studying trigonometry and waves.

Let me first establish a working definition of “period”:

> **The period is the smallest amount we need to change a quantity in order to end up back where we started.**

For example: a week has a period of seven days. Today is Saturday. If we move forward in time seven days, it will be Saturday again.

------

If we are talking about a sinusoidal wave as it relates to trigonometry (i.e. the unit circle), we have sin𝜃, where 𝜃, the “independent variable” or “parameter,” is a dimensionless quantity: the angle measured counterclockwise from the positive x-axis, given in radians. The period of the sine function is 2𝜋,meaning that sin𝜃=sin(𝜃+2𝜋). In this context, period and wavelength describe the same thing, although the term wavelength is basically never used here.

------

If we are describing a physical wave of some sort using sine and cosine, then the independent variable or physical parameter is usually either **time** or **space/distance**. For such physical waves, there are two types of periods we speak of:

1. **Temporal (time) period**, usually just called the **period**: the time it takes for the amplitude of the wave at a given point in space to return to its original value
2. **Spatial period**, known as **wavelength**: the distance between successive peaks of a wave

For a wave that is traveling through space, the spatial period 𝜆 and temporal period 𝑇 are related via the velocity of propagation of the wave:

𝑣=𝜆/𝑇

So suppose you are standing still, and a wave traveling at velocity 𝑣=10 meters/second is traveling in front of you. If a peak of the wave passes in front of you every second, the temporal period of the wave is 𝑇=1 second. That means the distance between successive peaks is (using the relationship distance=rate×time) 𝜆=𝑣⋅𝑇=10 meters/second⋅1 second=10 meters





Wavelength is a little hard to deal with without waves. Waves are oscillating functions in both time and space, like 𝜙(𝑥,𝑡)=sin(𝑥−𝑡). This function has the feature that 𝜙(𝑥,𝑡)=𝜙(𝑥+2𝜋,𝑡)=𝜙(𝑥,𝑡+2𝜋), in other words, it’s periodic in both 𝑥 and 𝑡.

In this case, it’s possible to talk about the *period* being 2𝜋 because if you look at one spot, the value repeats when time changes by 2𝜋, and to talk about the *wavelength* being 2𝜋 because if you look two places that are 2𝜋 apart at the same time, the values are the same.

The more general wave function 𝜙(𝑥,𝑡)=sin(𝑘𝑥−𝜔𝑡) allows the wavelength 𝜆=2𝜋𝑘 and the period 𝑇=2𝜋𝜔 to be different. You can see that the function is periodic over time with 𝜙(𝑥,𝑡)=𝜙(𝑥,𝑡+𝑇) and periodic over space with 𝜙(𝑥,𝑡)=𝜙(𝑥+𝜆,𝑡). Since the values of 𝑘 and 𝜔 can be anything you want and are unrelated (in the general case), the values of 𝜆 and 𝑇 can also be anything you want and are unrelated.

The value 𝑘 is called the *wavenumber* and is the (reciprocal) distance that 𝑥 has to change to change the phase of the sine function by one radian. the value 𝑤 is called the *angular frequency* and is the (reciprocal) time that 𝑡t has to change to change the phase of the sine function by one radian.

Of course, if you aren’t dealing with wave functions of two independent variables, like 𝜙(𝑥,𝑡), but are only dealing with one variable, like sin(𝑥) , the distinction between period and wavelength, or between angular frequency and wavenumber, is sort of meaningless.

## Reference

* https://en.wikipedia.org/wiki/Sine_wave
* https://www.quora.com/If-the-period-of-the-sine-function-is-2-pi-will-the-wavelength-also-be-2-pi
* https://www.animations.physics.unsw.edu.au/jw/travelling_sine_wave.htm
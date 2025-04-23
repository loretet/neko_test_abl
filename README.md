## Description

The following repo contains different Atmospheric Boundary Layer LES cases to test on [Neko](https://github.com/ExtremeFLOW/neko).  

Case description:
- **mixed/** :: shear-convective case with high geostrophic wind and positive heat influx from below (unstable)  

>It would be nice if every folder would contain a `DESCR.txt` file with a small description of the setup. A simple template can be found in `DESCR.txt` template.  


### To do:
- add neutral, stable and purely convective ABL cases
- implement buoyancy correction on Vreman
- implement TKE model (multiple scalars necessary first)
- implement sponge layer
- fix difference between Nek and Neko

# FINFET Characteristic And Realisation Of Inverter Using FINFETS Using Ngspice
### What is Finfet?
<p>FinFET stands for Fin Field-Effect Transistor. It's a type of transistor architecture used in integrated circuits (ICs), 
  particularly in semiconductor manufacturing processes for digital CMOS (complementary metal-oxide-semiconductor) devices. 
  FinFETs offer significant advantages over traditional planar CMOS transistors, especially in terms of power efficiency and performance.
</p>
<p>The key feature of FinFETs is the fin-shaped channel that protrudes from the substrate, allowing for better control of the flow of current. 
  This design helps to reduce leakage current, improve transistor switching speed, and enhance overall performance. 
  FinFETs are commonly used in modern semiconductor processes, including those used for manufacturing CPUs, GPUs, and other advanced digital ICs.</p>
<p>FinFET technology has been widely adopted in the semiconductor industry and is commercially available through various semiconductor foundries and manufacturers. 
  Companies like Intel, TSMC (Taiwan Semiconductor Manufacturing Company), Samsung, GlobalFoundries, and others have been offering FinFET-based processes for several years.
</p>
<p>These companies provide FinFET technology at various nodes, such as 14nm, 10nm, 7nm, and even smaller nodes like 5nm and 3nm. 
  Each generation of FinFET technology offers improvements in power efficiency, performance, and transistor density, enabling the development of more powerful and energy-efficient electronic devices.
</p>
<p>Commercially available FinFET technology has enabled the production of high-performance CPUs, GPUs,
  mobile SoCs (System-on-Chips), and other advanced semiconductor devices used in smartphones, computers, networking equipment, automotive electronics, and many other applications</p>
  <p align="center" width="100%">
    
| ![Screenshot 2024-06-04 163039](https://github.com/AsahiroKenpachi/finfet_characterestics/assets/137492506/e438a202-2b10-40e9-bcab-35ab806d54c3) | 
|:--:| 
| *Finfet structure* |

  </p>
  
### ASAP - 7nm Process Design kit

### What is ASAP-7nm?
<p>ASAP7nm is a process design kit (PDK) developed by the Academia and Semiconductor Industrial Partnership (ASIP) consortium, providing access to advanced semiconductor manufacturing technologies at the 7-nanometer (nm) node. It includes essential files and documentation for designing integrated circuits (ICs) with increased transistor density, improved performance, and reduced power consumption. Aimed at researchers, educators, and industry partners, ASAP7nm facilitates experimentation, education, and collaboration in semiconductor engineering, enabling innovative IC designs, hands-on learning, and prototyping before commercial production.</p>
<p>Installation of the above PDK can be done by cloning the git repo at https://github.com/The-OpenROAD-Project/asap7</p>

### Integration of ASAP-7nm and Ngspice
<p>To proceed further read the readme of the git repo https://github.com/The-OpenROAD-Project/asap </br> Now Navigate inside the main PDK folder that you previously cloned. And there you will find model folder which contains the hspice folder which has .pm files. At this point refer this repo and observe how to change .pm to .sp.  
</p>
<p> For example

```
.model pmos_slvt pmos level = 72
```
  is changed to
  
  ```
  .model BSIMCMG_osdi_P BSIMCMG_va (
+ TYPE = 0
  ```
When converting the slvt pmos and nmos models from that file, what needed is to specify TYPE=0/1 in Ngspice, otherwise it does not work.
Also if we have extra parameters in .pm that is not in modelcard for nmos/pmos given by BSIM-CMG , no need to alter them as it will be ignored by Ngspice. Finally rename the file from .pm to .sp and save it in the directory you desire.
</p>
  
### What is Ngspice?
<p>Ngspice is an open-source mixed-level/mixed-signal electronic circuit simulator based on SPICE3f5, a program originally developed at the University of California, Berkeley. It allows for the simulation of analog and digital electronic circuits at the transistor and system levels. Ngspice is widely used for circuit design and verification in both academic and commercial environments due to its flexibility and extensive feature set. </p>
<p>Ngspice offers various features that make it a powerful tool for circuit simulation. It can simulate a wide variety of electronic circuits, from simple resistor-capacitor networks to complex mixed-signal integrated circuits. The simulator supports various types of analyses, including DC, AC, transient, and noise analysis, among others. It includes a comprehensive library of device models, such as diodes, transistors (BJT, MOSFET), and operational amplifiers. One of the strengths of ngspice is its compatibility with other SPICE simulators, allowing it to read and simulate netlists created for other SPICE-based tools.</p><p> Typical use cases for ngspice include analog circuit design, where engineers and hobbyists use it to design and test analog circuits before building physical prototypes. In education, it is widely used to teach electronic circuit design and simulation, providing students with hands-on experience in a virtual environment. Researchers also use ngspice to model and analyze new types of circuits and devices, aiding in the development of innovative technologies.Additionally, users can extend Ngspice with custom scripts and models, enhancing its functionality for specific needs.Ngspice is compatible with many existing SPICE models and netlists, allowing for easy migration from other SPICE-based tools. It is also frequently updated and maintained by a community of developers, ensuring ongoing improvements and support.</p>
<p> For further information the Ngspice documentation is available at https://ngspice.sourceforge.io/docs/ngspice-manual.pdf</p>

### Ngspice Installation for Ubuntu 22.04
<p> Open Your Terminal using ctrl+alt+t in your ubuntu workstation and execute the following command one by one or copy them into a script and run the script using the terminal. </p>

```
## clone the source repository into a local ngspice_git directory
git clone https://git.code.sf.net/p/ngspice/ngspice ngspice_git
cd ngspice_git
mkdir release
./autogen.sh
cd release
## by default if no --prefix is provided ngspice will install under /usr/local/{bin,share,man,lib}
## you can add a --prefix=/home/username to install into your home directory.
../configure --with-x --enable-xspice --disable-debug --enable-cider --with-readline=yes --enable-openmp --enable-osdi
## build the program
make
## install the program and needed files.
sudo make install

```

<p>For Windows and MAC users , installation procedure is available at https://ngspice.sourceforge.io/docs/ngspice-manual.pdf </p>

### BSIM - CMG
<p>BSIM-CMG, or Berkeley Short-channel IGFET Model for the Common Multi-Gate Structure, is a compact model for simulating multi-gate transistors, such as FinFETs and nanowire FETs, developed by the Device Model Working Group (DMWG) at the University of California, Berkeley. BSIM-CMG extends the capabilities of traditional BSIM models to accurately model the behavior of advanced multi-gate transistor structures, taking into account complex physical phenomena such as short-channel effects, quantum mechanical effects, and gate coupling. It is widely used in the semiconductor industry and academia for the design and optimization of nanoscale integrated circuits, enabling accurate prediction of device characteristics and performance.</p>

<p>By changing the .pm to .sp as foretold we are trying to use BSIM-CMG model for simulating our inverter. If you wnat to use the latest finfet model use the website https://www.bsim.berkeley.edu/models/bsimcmg/ </p>

<p> These models are written using Verilog-A [extension .va] and are compiled using OpenVAF compiler. Upon Compilation , we will ger .osdi files from .va files . Add it to your working directory where .sp is present. The latest version of Ngspice has the support for .osdi files which may not be true fur older versions. You can get OpenVAF from https://openvaf.semimod.de/docs/getting-started/introduction/  </p>
<p>Make sure that the executable of OpenVAF is in the path of your system so that .va files can be compiled </p>

# Finfet Characterestics

| ![Screenshot 2024-06-05 193147](https://github.com/AsahiroKenpachi/finfet_characterestics/assets/137492506/a236c5a1-c2b2-4a24-9a5a-103fc67ae7a6) | 
|:--:|
| ![Screenshot 2024-06-05 193933](https://github.com/AsahiroKenpachi/finfet_characterestics/assets/137492506/4084f42b-fe5f-4d37-a83c-e90ed639ef7a) | 
| *Basic Idea required before simulation* |

# Finfet Characterestics using Ngspice

<p> In our simulations we have finfets with 14 fins with a fin height of 32 nanometer. And the simulation outputs are as follows
</p>

| ![Screenshot from 2024-06-11 13-53-40](https://github.com/AsahiroKenpachi/finfet_characterestics/assets/137492506/75ca3fdd-303c-4df1-b782-fb00a79a40d9) | 
|:--:| 
| *Id vs Vgs* |

| ![Screenshot from 2024-06-11 13-52-07](https://github.com/AsahiroKenpachi/finfet_characterestics/assets/137492506/0008896f-2e05-4614-a7e5-56e2d539cb02) | 
|:--:| 
| *Id vs Vds* |

### Inverter Noise Margin

<p>The noise margin of an inverter refers to the amount of noise (unwanted electrical signals) that the circuit can tolerate while still maintaining proper operation. It's a measure of the robustness of the circuit against interference and fluctuations in the input signal.</p>

There are two types of noise margins:
-High-level noise margin (NMH): This is the maximum amount of noise that can be added to the input signal of an inverter while still ensuring that the output remains at a logic high level (typically represented as '1' in digital systems).
-Low-level noise margin (NML): This is the maximum amount of noise that can be added to the input signal of an inverter while still ensuring that the output remains at a logic low level (typically represented as '0' in digital systems).
These margins are crucial for reliable operation of digital circuits, especially in environments where there may be electrical noise or interference. A larger noise margin implies greater resilience to noise, which is desirable for robust circuit design.

| VOH     | VIH   | VIL   | V0L   | NMH   | NML   |
| :---:   | :---: | :---: | :---: | :---: | :---: |
|0.7	|0.428211	|0.245706	|0	|0.271789	|0.245706|
| :---:   | :---: | :---: | :---: | :---: | :---: |
|0.6	|0.358896	|0.245918	|0	|0.241104	|0.245918|
| :---:   | :---: | :---: | :---: | :---: | :---: |
|0.5	|0.358896	|0.213115	|0	|0.141104	|0.213115|
| :---:   | :---: | :---: | :---: | :---: | :---: |
|0.3	|0.174262	|0.114592	|0	|0.125738	|0.114592|
| :---:   | :---: | :---: | :---: | :---: | :---: |
|0.1	|0.054017	|0.269231	|0	|0.045983	|0.269231|

![image](https://github.com/AsahiroKenpachi/finfet_characterestics/assets/137492506/b42c10ea-8ff8-4399-8b02-a05bbbc8d511)



| ![Screenshot from 2024-06-04 11-39-35](https://github.com/AsahiroKenpachi/finfet_characterestics/assets/137492506/ede652d7-5fa4-4ae2-b077-1076b12cd987) | 
|:--:| 
| ![Screenshot from 2024-06-04 11-38-58](https://github.com/AsahiroKenpachi/finfet_characterestics/assets/137492506/89f7031f-c961-42c4-8b18-2975c5885f29) | 
| *Inverter Characterestics* |

| ![Screenshot from 2024-06-04 11-40-36](https://github.com/AsahiroKenpachi/finfet_characterestics/assets/137492506/0bdb2433-f37c-46b6-8ee3-2af088a861ef) | 
|:--:| 
| *Inverter Characterestics - with Multiple voltage for various VTC curves* |
### Conclusion

The shift from CMOS To Finfet is very pivotal to Semiconductor Industry . But Tuning the properties become difficult because of second order effects. This can be seen via sub threshold currents in the simulation. These deviations will affects circuits constructed using them . One such evidence is the Noise Margin of the Finfet based Inverter which is not sharp.


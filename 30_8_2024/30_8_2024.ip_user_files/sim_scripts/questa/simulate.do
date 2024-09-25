onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib OV7670_top_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {OV7670_top.udo}

run 1000ns

quit -force

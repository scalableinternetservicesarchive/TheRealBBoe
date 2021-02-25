1) install tsung
'brew install tsung'

2) Is my tsung version 1.7.0? If not, replace it in the beginning of test.xml

tsung dtd location (will need to replace if not on mac):
/usr/local/Cellar/tsung/1.7.0/share/tsung/tsung-1.0.dtd

3) Edit test.xml to suit your test

4) Run your test
'tsung -f test.xml start'

Can view live metrics while test is running at: http://localhost:8091/

5) View your test logs
tsung logs stored at:
~/.tsung/log/

6) Plot metrics
plotter script (run within your test log folder):
tsplot "my_test" tsung.log

can plot multiple tests together too for comparison (run in ~/.tsung/log/):
tsplot "my_first_test" test1/tsung.log "my_second_test" test2/tsung.log


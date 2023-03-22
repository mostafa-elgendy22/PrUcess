import os
import shutil


if os.path.exists('transcript'):
    os.remove('transcript')

if os.path.exists('modelsim.ini'):
    os.remove('modelsim.ini')

if os.path.exists('vsim.wlf'):
    os.remove('vsim.wlf')

if os.path.exists('vsim_stacktrace.vstf'):
    os.remove('vsim_stacktrace.vstf')

if os.path.exists('wlft3ghn8c'):
    os.remove('wlft3ghn8c')

if os.path.exists('*.vstf'):
    os.remove('*.vstf')

if os.path.exists('work'):
    shutil.rmtree('work', ignore_errors=True)
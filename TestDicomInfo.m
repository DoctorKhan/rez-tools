cd /home/khan/export/mri/Venography/092809rk
ls Raw/
ls Raw/Venogram/
ls Raw/Venogram/VeinoRez/
hh = dicominfo('Raw/Venogram/VeinoRez/I0001.dcm', 'dictionary',
hh = dicominfo('Raw/Venogram/VeinoRez/I0001.dcm')
hh.RepetitionTime
hh.EchoTime
ls ~/export/software/VISTASOFT/
ls ~/export/software/VISTASOFT/mrLoadRet-3.0/
ls ~/export/software/VISTASOFT/mrLoadRet-3.0/gems-dicom-dict.txt
hh = dicominfo('Raw/Venogram/VeinoRez/I0001.dcm', 'dictionary', '/home/khan/export/software/VISTASOFT/mrLoadRet-3.0/gems-dicom-dict.txt')
hh.PulseSeqName
hh.PulseSequence
hh.PulseSeqMode
hh.AcquisitionDuration
hh.AcquisitionDuration / 1e6
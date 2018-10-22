from obspy import read
import numpy

MIN_FREQ = 4.0
MAX_FREQ = 10.0
OUTPUT_FILE_NAME = 'week.txt'


def main:	

	st = read('day1.mseed')

	st[0].filter('bandpass', freqmin=MIN_FREQ, freqmax=MAX_FREQ, corners=4, zerophase=True)

	st.resample(20.0)

	es = st[0].data
	tf = open(OUTPUT_FILE_NAME, 'w')
	for amp in es:
		tf.write(`amp`)
		tf.write('\n')

	st = read('day2.mseed')

	st[0].filter('bandpass', freqmin=MIN_FREQ, freqmax=MAX_FREQ, corners=4, zerophase=True)

	st.resample(20.0)

	es = st[0].data
	for amp in es:
		tf.write(`amp`)
		tf.write('\n')

	st = read('day3.mseed')

	st[0].filter('bandpass', freqmin=MIN_FREQ, freqmax=MAX_FREQ, corners=4, zerophase=True)
	st[1].filter('bandpass', freqmin=MIN_FREQ, freqmax=MAX_FREQ, corners=4, zerophase=True)

	st.resample(20.0)

	es = st[0].data
	for amp in es:
		tf.write(`amp`)
		tf.write('\n')

	GR = numpy.random.randn(5709)
	for amp in GR:
		tf.write(`amp`)
		tf.write('\n')

	es = st[1].data
	for amp in es:
		tf.write(`amp`)
		tf.write('\n')

	st = read('day4.mseed')

	st[0].filter('bandpass', freqmin=MIN_FREQ, freqmax=MAX_FREQ, corners=4, zerophase=True)
	st[1].filter('bandpass', freqmin=MIN_FREQ, freqmax=MAX_FREQ, corners=4, zerophase=True)
	st[2].filter('bandpass', freqmin=MIN_FREQ, freqmax=MAX_FREQ, corners=4, zerophase=True)
	st[3].filter('bandpass', freqmin=MIN_FREQ, freqmax=MAX_FREQ, corners=4, zerophase=True)
	st[4].filter('bandpass', freqmin=MIN_FREQ, freqmax=MAX_FREQ, corners=4, zerophase=True)

	st.resample(20.0)

	es = st[0].data
	for amp in es:
		tf.write(`amp`)
		tf.write('\n')

	GR = numpy.random.randn(16088)
	for amp in GR:
		tf.write(`amp`)
		tf.write('\n')

	es = st[1].data
	for amp in es:
		tf.write(`amp`)
		tf.write('\n')

	GR = numpy.random.randn(4824)
	for amp in GR:
		tf.write(`amp`)
		tf.write('\n')

	es = st[2].data
	for amp in es:
		tf.write(`amp`)
		tf.write('\n')

	GR = numpy.random.randn(8230)
	for amp in GR:
		tf.write(`amp`)
		tf.write('\n')

	es = st[3].data
	for amp in es:
		tf.write(`amp`)
		tf.write('\n')

	GR = numpy.random.randn(749)
	for amp in GR:
		tf.write(`amp`)
		tf.write('\n')

	es = st[4].data
	for amp in es:
		tf.write(`amp`)
		tf.write('\n')

	st = read('day5.mseed')

	st[0].filter('bandpass', freqmin=MIN_FREQ, freqmax=MAX_FREQ, corners=4, zerophase=True)

	st.resample(20.0)

	es = st[0].data
	for amp in es:
		tf.write(`amp`)
		tf.write('\n')

	st = read('day6.mseed')

	st[0].filter('bandpass', freqmin=MIN_FREQ, freqmax=MAX_FREQ, corners=4, zerophase=True)

	st.resample(20.0)

	es = st[0].data
	for amp in es:
		tf.write(`amp`)
		tf.write('\n')

	st = read('day7.mseed')

	st[0].filter('bandpass', freqmin=MIN_FREQ, freqmax=MAX_FREQ, corners=4, zerophase=True)
	st[1].filter('bandpass', freqmin=MIN_FREQ, freqmax=MAX_FREQ, corners=4, zerophase=True)

	st.resample(20.0)

	es = st[0].data
	for amp in es:
		tf.write(`amp`)
		tf.write('\n')

	GR = numpy.random.randn(179)
	for amp in GR:
		tf.write(`amp`)
		tf.write('\n')

	es = st[1].data
	for amp in es:
		tf.write(`amp`)
		tf.write('\n')

	tf.close()

if __name__ == '__main__':
	main()


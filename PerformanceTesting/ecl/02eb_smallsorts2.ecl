//class=memory
//class=sort

//version algo='quicksort',numrows=2000,nothor
//version algo='parquicksort',numrows=2000,nothor
//version algo='mergesort',numrows=1000,nothor
//version algo='mergesort',numrows=2000,nothor
//version algo='mergesort',numrows=4000,nothor
//version algo='mergesort',numrows=6000,nothor
//version algo='mergesort',numrows=10000,nothor
//version algo='parmergesort',numrows=1000
//version algo='parmergesort',numrows=2000
//version algo='parmergesort',numrows=4000
//version algo='parmergesort',numrows=6000
//version algo='parmergesort',numrows=10000

//xversion algo='parmergesort',numrows=12000
//xversion algo='parmergesort',numrows=16000
//xversion algo='parmergesort',numrows=24000
//xversion algo='parmergesort',numrows=32000
//xversion algo='parmergesort',numrows=48000,nothor
//xversion algo='parmergesort',numrows=64000,nothor
//xversion algo='parmergesort',numrows=96000,nothor
//xversion algo='parmergesort',numrows=128000,nothor
//xversion algo='parmergesort',numrows=192000,nothor
//xversion algo='parmergesort',numrows=256000,nothor
//xversion algo='parmergesort',numrows=384000,nothor
//xversion algo='parmergesort',numrows=512000,nothor

//xversion algo='quicksort',numrows=1000,nothor
//xversion algo='quicksort',numrows=2000,nothor
//xversion algo='quicksort',numrows=4000,nothor
//xversion algo='quicksort',numrows=6000,nothor
//xversion algo='quicksort',numrows=10000,nothor
//xversion algo='quicksort',numrows=12000,nothor
//xversion algo='quicksort',numrows=16000,nothor
//xversion algo='quicksort',numrows=24000,nothor
//xversion algo='quicksort',numrows=32000,nothor
//xversion algo='quicksort',numrows=48000,nothor
//xversion algo='quicksort',numrows=64000,nothor
//xversion algo='quicksort',numrows=96000,nothor
//xversion algo='quicksort',numrows=128000,nothor
//xversion algo='quicksort',numrows=192000,nothor
//xversion algo='quicksort',numrows=256000,nothor
//xversion algo='quicksort',numrows=384000,nothor
//xversion algo='quicksort',numrows=512000,nothor

//xversion algo='taskquicksort',numrows=1000
//xversion algo='taskquicksort',numrows=2000
//xversion algo='taskquicksort',numrows=4000
//xversion algo='taskquicksort',numrows=6000
//xversion algo='taskquicksort',numrows=10000
//xversion algo='taskquicksort',numrows=12000
//xversion algo='taskquicksort',numrows=16000
//xversion algo='taskquicksort',numrows=24000
//xversion algo='taskquicksort',numrows=32000
//xversion algo='taskquicksort',numrows=48000,nothor
//xversion algo='taskquicksort',numrows=64000,nothor
//xversion algo='taskquicksort',numrows=96000,nothor
//xversion algo='taskquicksort',numrows=128000,nothor
//xversion algo='taskquicksort',numrows=192000,nothor
//xversion algo='taskquicksort',numrows=256000,nothor
//xversion algo='taskquicksort',numrows=384000,nothor
//xversion algo='taskquicksort',numrows=512000,nothor

//xversion algo='parquicksort',numrows=1000
//xversion algo='parquicksort',numrows=2000
//xversion algo='parquicksort',numrows=4000
//xversion algo='parquicksort',numrows=6000
//xversion algo='parquicksort',numrows=10000
//xversion algo='parquicksort',numrows=12000
//xversion algo='parquicksort',numrows=16000
//xversion algo='parquicksort',numrows=24000
//xversion algo='parquicksort',numrows=32000
//xversion algo='parquicksort',numrows=48000,nothor
//xversion algo='parquicksort',numrows=64000,nothor
//xversion algo='parquicksort',numrows=96000,nothor
//xversion algo='parquicksort',numrows=128000,nothor
//xversion algo='parquicksort',numrows=192000,nothor
//xversion algo='parquicksort',numrows=256000,nothor
//xversion algo='parquicksort',numrows=384000,nothor
//xversion algo='parquicksort',numrows=512000,nothor

//xversion algo='mergesort',numrows=1000
//xversion algo='mergesort',numrows=2000
//xversion algo='mergesort',numrows=4000
//xversion algo='mergesort',numrows=6000
//xversion algo='mergesort',numrows=10000
//xversion algo='mergesort',numrows=12000
//xversion algo='mergesort',numrows=16000
//xversion algo='mergesort',numrows=24000
//xversion algo='mergesort',numrows=32000
//xversion algo='mergesort',numrows=48000,nothor
//xversion algo='mergesort',numrows=64000,nothor
//xversion algo='mergesort',numrows=96000,nothor
//xversion algo='mergesort',numrows=128000,nothor
//xversion algo='mergesort',numrows=192000,nothor
//xversion algo='mergesort',numrows=256000,nothor
//xversion algo='mergesort',numrows=384000,nothor
//xversion algo='mergesort',numrows=512000,nothor

//xversion algo='heapsort',numrows=1000
//xversion algo='heapsort',numrows=2000
//xversion algo='heapsort',numrows=4000
//xversion algo='heapsort',numrows=6000
//xversion algo='heapsort',numrows=10000
//xversion algo='heapsort',numrows=12000
//xversion algo='heapsort',numrows=16000
//xversion algo='heapsort',numrows=24000
//xversion algo='heapsort',numrows=32000
//xversion algo='heapsort',numrows=48000,nothor
//xversion algo='heapsort',numrows=64000,nothor
//xversion algo='heapsort',numrows=96000,nothor
//xversion algo='heapsort',numrows=128000,nothor
//xversion algo='heapsort',numrows=192000,nothor
//xversion algo='heapsort',numrows=256000,nothor
//xversion algo='heapsort',numrows=384000,nothor
//xversion algo='heapsort',numrows=512000,nothor

import ^ as root;
algo := #IFDEFINED(root.algo, 'parmergesort');
numRows := #IFDEFINED(root.numrows, 512000);
numIters := #IFDEFINED(root.numIters, 10000/5);

idRecord := RECORD
    UNSIGNED id;
END;

import Std.System.Debug;

idRecords := DATASET(numIters, TRANSFORM(idRecord, SELF.id := COUNTER-1));

idRecord t(idRecord l) := TRANSFORM
    ids := DATASET(numRows + (l.id * NOFOLD(0)), TRANSFORM(idRecord, SELF.id := HASH64(COUNTER)));
    s := SORT(ids, id, STABLE(algo));
    check := SORTED(NOFOLD(s), id, ASSERT);
    c := COUNT(NOFOLD(check));
    SELF.id := numrows - c;
END;

p := PROJECT(idRecords, t(LEFT));
OUTPUT(p(id != 0));


//class=examples
//class=stress

UNSIGNED numNodes := 100000;
UNSIGNED averageLinks := 100;
UNSIGNED avgCluster := 400;

linkRecord := RECORD
    UNSIGNED6 from;
    UNSIGNED6 to;
END;

// Pick a random number, but bias towards 0, so the distribution is uneven
REAL scale(UNSIGNED4 value) := ((REAL)value / 0x100000000);
UNSIGNED6 numLinks(UNSIGNED c) := scale(HASH32(c)) * scale(HASHCRC(c)) * averageLinks * 4 + 1;

linkRecord createLink(UNSIGNED id, UNSIGNED c) := TRANSFORM
    SELF.from := id;
    SELF.to := ((HASH(HASH32(c)) % avgCluster) + id) % numNodes;
END;

sources := NOFOLD(DATASET(numNodes, TRANSFORM({ unsigned c }, SELF.c := COUNTER), DISTRIBUTED));

links := NOFOLD(NORMALIZE(sources, numLinks(LEFT.c), createLink(LEFT.c, COUNTER)));

//Perform a self join to find all the transitive links.

j := JOIN(links, links, LEFT.to = RIGHT.to, TRANSFORM(linkRecord, SELF.from := LEFT.from, SELF.to := RIGHT.from), HASH);

d:= DEDUP(links + j, from, to, ALL);

output(COUNT(NOFOLD(d)));

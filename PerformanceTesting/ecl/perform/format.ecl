export format := MODULE
    export simpleRec := RECORD
        unsigned8 id1;
        unsigned8 id2;
        unsigned8 id3;
        unsigned8 id4;
    END;

    export paddedRec := RECORD
        simpleRec;
        string50 padding;
    END;

    export parentRec := RECORD
        simpleRec;
        DATASET(paddedRec) children;
    END;

    export grandParentRec := RECORD
        unsigned id;
        DATASET(parentRec) c1;
        DATASET(parentRec) c2;
    END;

    export simpleRec mkSimple(unsigned8 id1, unsigned8 id2, unsigned8 id3, unsigned8 id4) := TRANSFORM
        SELF.id1 := id1;
        SELF.id2 := id2;
        SELF.id3 := id3;
        SELF.id4 := id4;
    END;

    export createSimple(unsigned8 id) := FUNCTION
        id2 := HASH64(id);
        id3 := HASH64(id2);
        id4 := HASH64(id3);
        RETURN mkSimple(id, id2, id3, id4);
    END;

    export paddedRec createPadded(unsigned8 id) := TRANSFORM
        id2 := HASH64(id);
        id3 := HASH64(id2);
        id4 := HASH64(id3);
        SELF.id1 := id;
        SELF.id2 := id2;
        SELF.id3 := id3;
        SELF.id4 := id4;
        SELF.padding := '';
    END;

    export parentRec createParent(unsigned8 id, unsigned4 numChildren, unsigned8 startChild) := TRANSFORM
        id2 := HASH64(id);
        id3 := HASH64(id2);
        id4 := HASH64(id3);
        SELF.id1 := id;
        SELF.id2 := id2;
        SELF.id3 := id3;
        SELF.id4 := id4;
        SELF.children := DATASET(numChildren, createPadded(id + startChild));
    END;

    export grandParentRec createGrandParent(unsigned8 id, unsigned4 numChildren1, unsigned4 numChildren2) := TRANSFORM
        id2 := HASH64(id);
        id3 := HASH64(id2);
        id4 := HASH64(id3);
        SELF.id := id;
        SELF.c1 := DATASET(numChildren1, createParent(id, 800, id2));
        SELF.c2 := DATASET(numChildren2, createParent(id, 1000, id3));
    END;

END;

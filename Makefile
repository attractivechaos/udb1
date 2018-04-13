CC=			gcc
CXX=		g++
CFLAGS=		-g -Wall -O2 -fomit-frame-pointer #-m64
CXXFLAGS=	$(CFLAGS)
DFLAGS=		
OBJS=		
LIBS=		
SUBDIRS=	kbtree khash \
			sgi_map sgi_hash_map tr1_unordered_map \
			NP_rbtree NP_splaytree \
			JG_btree \
			JE_rb_new JE_rb_old JE_trp_hash JE_trp_prng \
			google_dense google_sparse \
			libavl_avl libavl_rb libavl_prb libavl_bst \
			uthash \
			TN_rbtree libavl_avl_cpp libavl_rb_cpp libavl_rb_cpp2 \
			sglib_rbtree \
			runit

.SUFFIXES:.c .o .cc

.c.o:
		$(CC) -c $(CFLAGS) $(DFLAGS) $(INCLUDES) $< -o $@
.cc.o:
		$(CXX) -c $(CXXFLAGS) $(DFLAGS) $(INCLUDES) $< -o $@

all:all-recur

lib-recur all-recur clean-recur cleanlocal-recur install-recur:
		@target=`echo $@ | sed s/-recur//`; \
		wdir=`pwd`; \
		list='$(SUBDIRS)'; for subdir in $$list; do \
			cd $$subdir; \
			$(MAKE) CC="$(CC)" CXX="$(CXX)" DFLAGS="$(DFLAGS)" CFLAGS="$(CFLAGS)" \
				$$target || exit 1; \
			cd $$wdir; \
		done;

lib:

cleanlocal:
		rm -f gmon.out *.o stdhash/*.o a.out *~ *.a

clean:cleanlocal-recur
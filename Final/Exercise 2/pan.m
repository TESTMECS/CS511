#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC :init: */
	case 3: // STATE 1 - solution.pml:40 - [(run P())] (0:0:0 - 1)
		IfNotBlocked
		reached[2][1] = 1;
		if (!(addproc(II, 1, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 2 - solution.pml:41 - [(run Q())] (0:0:0 - 1)
		IfNotBlocked
		reached[2][2] = 1;
		if (!(addproc(II, 1, 1)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 4 - solution.pml:43 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[2][4] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Q */
	case 6: // STATE 2 - solution.pml:26 - [flag[me] = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		(trpt+1)->bup.oval = ((int)now.flag[ Index(((int)((P1 *)_this)->me), 2) ]);
		now.flag[ Index(((P1 *)_this)->me, 2) ] = 1;
#ifdef VAR_RANGES
		logval("flag[Q:me]", ((int)now.flag[ Index(((int)((P1 *)_this)->me), 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 3 - solution.pml:28 - [((turn!=me))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][3] = 1;
		if (!((((int)now.turn)!=((int)((P1 *)_this)->me))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 4 - solution.pml:29 - [((flag[you]==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][4] = 1;
		if (!((((int)now.flag[ Index(((int)((P1 *)_this)->you), 2) ])==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 5 - solution.pml:30 - [turn = me] (0:0:1 - 1)
		IfNotBlocked
		reached[1][5] = 1;
		(trpt+1)->bup.oval = ((int)now.turn);
		now.turn = ((int)((P1 *)_this)->me);
#ifdef VAR_RANGES
		logval("turn", ((int)now.turn));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 11 - solution.pml:34 - [flag[me] = 0] (0:0:1 - 3)
		IfNotBlocked
		reached[1][11] = 1;
		(trpt+1)->bup.oval = ((int)now.flag[ Index(((int)((P1 *)_this)->me), 2) ]);
		now.flag[ Index(((P1 *)_this)->me, 2) ] = 0;
#ifdef VAR_RANGES
		logval("flag[Q:me]", ((int)now.flag[ Index(((int)((P1 *)_this)->me), 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 15 - solution.pml:36 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][15] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC P */
	case 12: // STATE 2 - solution.pml:9 - [flag[me] = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		(trpt+1)->bup.oval = ((int)now.flag[ Index(((int)((P0 *)_this)->me), 2) ]);
		now.flag[ Index(((P0 *)_this)->me, 2) ] = 1;
#ifdef VAR_RANGES
		logval("flag[P:me]", ((int)now.flag[ Index(((int)((P0 *)_this)->me), 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 3 - solution.pml:11 - [((turn!=me))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		if (!((((int)now.turn)!=((int)((P0 *)_this)->me))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 4 - solution.pml:12 - [((flag[you]==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][4] = 1;
		if (!((((int)now.flag[ Index(((int)((P0 *)_this)->you), 2) ])==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 15: // STATE 5 - solution.pml:13 - [turn = me] (0:0:1 - 1)
		IfNotBlocked
		reached[0][5] = 1;
		(trpt+1)->bup.oval = ((int)now.turn);
		now.turn = ((int)((P0 *)_this)->me);
#ifdef VAR_RANGES
		logval("turn", ((int)now.turn));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 11 - solution.pml:17 - [flag[me] = 0] (0:0:1 - 3)
		IfNotBlocked
		reached[0][11] = 1;
		(trpt+1)->bup.oval = ((int)now.flag[ Index(((int)((P0 *)_this)->me), 2) ]);
		now.flag[ Index(((P0 *)_this)->me, 2) ] = 0;
#ifdef VAR_RANGES
		logval("flag[P:me]", ((int)now.flag[ Index(((int)((P0 *)_this)->me), 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 15 - solution.pml:19 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][15] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}


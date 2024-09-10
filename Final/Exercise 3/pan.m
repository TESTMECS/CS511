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
	case 3: // STATE 1 - car_wash.pml:69 - [i = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[2][1] = 1;
		(trpt+1)->bup.oval = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = 0;
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 2 - car_wash.pml:69 - [((i<=(3-1)))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][2] = 1;
		if (!((((int)((P2 *)_this)->i)<=(3-1))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 3 - car_wash.pml:70 - [permToProcess[i] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[2][3] = 1;
		(trpt+1)->bup.oval = ((int)now.permToProcess[ Index(((int)((P2 *)_this)->i), 3) ]);
		now.permToProcess[ Index(((P2 *)_this)->i, 3) ] = 0;
#ifdef VAR_RANGES
		logval("permToProcess[:init::i]", ((int)now.permToProcess[ Index(((int)((P2 *)_this)->i), 3) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 4 - car_wash.pml:71 - [doneProcessing[i] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[2][4] = 1;
		(trpt+1)->bup.oval = ((int)now.doneProcessing[ Index(((int)((P2 *)_this)->i), 3) ]);
		now.doneProcessing[ Index(((P2 *)_this)->i, 3) ] = 0;
#ifdef VAR_RANGES
		logval("doneProcessing[:init::i]", ((int)now.doneProcessing[ Index(((int)((P2 *)_this)->i), 3) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 5 - car_wash.pml:72 - [cars_in_station[i] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[2][5] = 1;
		(trpt+1)->bup.oval = ((int)now.cars_in_station[ Index(((int)((P2 *)_this)->i), 3) ]);
		now.cars_in_station[ Index(((P2 *)_this)->i, 3) ] = 0;
#ifdef VAR_RANGES
		logval("cars_in_station[:init::i]", ((int)now.cars_in_station[ Index(((int)((P2 *)_this)->i), 3) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 6 - car_wash.pml:73 - [machine_working[i] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[2][6] = 1;
		(trpt+1)->bup.oval = ((int)machine_working[ Index(((int)((P2 *)_this)->i), 3) ]);
		machine_working[ Index(((P2 *)_this)->i, 3) ] = 0;
#ifdef VAR_RANGES
		logval("machine_working[:init::i]", ((int)machine_working[ Index(((int)((P2 *)_this)->i), 3) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 7 - car_wash.pml:69 - [i = (i+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[2][7] = 1;
		(trpt+1)->bup.oval = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = (((int)((P2 *)_this)->i)+1);
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 13 - car_wash.pml:77 - [i = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[2][13] = 1;
		(trpt+1)->bup.oval = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = 1;
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 14 - car_wash.pml:77 - [((i<=10))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][14] = 1;
		if (!((((int)((P2 *)_this)->i)<=10)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 15 - car_wash.pml:78 - [(run Car())] (0:0:0 - 1)
		IfNotBlocked
		reached[2][15] = 1;
		if (!(addproc(II, 1, 0, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 16 - car_wash.pml:77 - [i = (i+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[2][16] = 1;
		(trpt+1)->bup.oval = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = (((int)((P2 *)_this)->i)+1);
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 22 - car_wash.pml:80 - [i = 0] (0:28:1 - 3)
		IfNotBlocked
		reached[2][22] = 1;
		(trpt+1)->bup.oval = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = 0;
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		/* merge: .(goto)(0, 29, 28) */
		reached[2][29] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 15: // STATE 23 - car_wash.pml:80 - [((i<=(3-1)))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][23] = 1;
		if (!((((int)((P2 *)_this)->i)<=(3-1))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 24 - car_wash.pml:81 - [(run Machine(i))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][24] = 1;
		if (!(addproc(II, 1, 1, ((int)((P2 *)_this)->i))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 25 - car_wash.pml:80 - [i = (i+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[2][25] = 1;
		(trpt+1)->bup.oval = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = (((int)((P2 *)_this)->i)+1);
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 32 - car_wash.pml:84 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[2][32] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Machine */
	case 19: // STATE 1 - car_wash.pml:14 - [((permToProcess[i]>0))] (7:0:1 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		if (!((((int)now.permToProcess[ Index(((P1 *)_this)->i, 3) ])>0)))
			continue;
		/* merge: permToProcess[i] = (permToProcess[i]-1)(0, 2, 7) */
		reached[1][2] = 1;
		(trpt+1)->bup.oval = ((int)now.permToProcess[ Index(((P1 *)_this)->i, 3) ]);
		now.permToProcess[ Index(((P1 *)_this)->i, 3) ] = (((int)now.permToProcess[ Index(((P1 *)_this)->i, 3) ])-1);
#ifdef VAR_RANGES
		logval("permToProcess[Machine:i]", ((int)now.permToProcess[ Index(((P1 *)_this)->i, 3) ]));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 20: // STATE 5 - car_wash.pml:59 - [machine_working[i] = 1] (0:9:1 - 1)
		IfNotBlocked
		reached[1][5] = 1;
		(trpt+1)->bup.oval = ((int)machine_working[ Index(((P1 *)_this)->i, 3) ]);
		machine_working[ Index(((P1 *)_this)->i, 3) ] = 1;
#ifdef VAR_RANGES
		logval("machine_working[Machine:i]", ((int)machine_working[ Index(((P1 *)_this)->i, 3) ]));
#endif
		;
		/* merge: assert((cars_in_station[i]>0))(9, 6, 9) */
		reached[1][6] = 1;
		spin_assert((((int)now.cars_in_station[ Index(((P1 *)_this)->i, 3) ])>0), "(cars_in_station[i]>0)", II, tt, t);
		_m = 3; goto P999; /* 1 */
	case 21: // STATE 8 - car_wash.pml:19 - [doneProcessing[i] = (doneProcessing[i]+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][8] = 1;
		(trpt+1)->bup.oval = ((int)now.doneProcessing[ Index(((P1 *)_this)->i, 3) ]);
		now.doneProcessing[ Index(((P1 *)_this)->i, 3) ] = (((int)now.doneProcessing[ Index(((P1 *)_this)->i, 3) ])+1);
#ifdef VAR_RANGES
		logval("doneProcessing[Machine:i]", ((int)now.doneProcessing[ Index(((P1 *)_this)->i, 3) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 22: // STATE 10 - car_wash.pml:63 - [machine_working[i] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][10] = 1;
		(trpt+1)->bup.oval = ((int)machine_working[ Index(((P1 *)_this)->i, 3) ]);
		machine_working[ Index(((P1 *)_this)->i, 3) ] = 0;
#ifdef VAR_RANGES
		logval("machine_working[Machine:i]", ((int)machine_working[ Index(((P1 *)_this)->i, 3) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 23: // STATE 14 - car_wash.pml:65 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][14] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Car */
	case 24: // STATE 1 - car_wash.pml:14 - [((station0>0))] (7:0:1 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		if (!((((int)now.station0)>0)))
			continue;
		/* merge: station0 = (station0-1)(0, 2, 7) */
		reached[0][2] = 1;
		(trpt+1)->bup.oval = ((int)now.station0);
		now.station0 = (((int)now.station0)-1);
#ifdef VAR_RANGES
		logval("station0", ((int)now.station0));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 25: // STATE 5 - car_wash.pml:25 - [cars_in_station[0] = (cars_in_station[0]+1)] (0:9:1 - 1)
		IfNotBlocked
		reached[0][5] = 1;
		(trpt+1)->bup.oval = ((int)now.cars_in_station[0]);
		now.cars_in_station[0] = (((int)now.cars_in_station[0])+1);
#ifdef VAR_RANGES
		logval("cars_in_station[0]", ((int)now.cars_in_station[0]));
#endif
		;
		/* merge: assert((cars_in_station[0]<=1))(9, 6, 9) */
		reached[0][6] = 1;
		spin_assert((((int)now.cars_in_station[0])<=1), "(cars_in_station[0]<=1)", II, tt, t);
		_m = 3; goto P999; /* 1 */
	case 26: // STATE 8 - car_wash.pml:19 - [permToProcess[0] = (permToProcess[0]+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][8] = 1;
		(trpt+1)->bup.oval = ((int)now.permToProcess[0]);
		now.permToProcess[0] = (((int)now.permToProcess[0])+1);
#ifdef VAR_RANGES
		logval("permToProcess[0]", ((int)now.permToProcess[0]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 27: // STATE 10 - car_wash.pml:14 - [((doneProcessing[0]>0))] (17:0:1 - 1)
		IfNotBlocked
		reached[0][10] = 1;
		if (!((((int)now.doneProcessing[0])>0)))
			continue;
		/* merge: doneProcessing[0] = (doneProcessing[0]-1)(0, 11, 17) */
		reached[0][11] = 1;
		(trpt+1)->bup.oval = ((int)now.doneProcessing[0]);
		now.doneProcessing[0] = (((int)now.doneProcessing[0])-1);
#ifdef VAR_RANGES
		logval("doneProcessing[0]", ((int)now.doneProcessing[0]));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 28: // STATE 14 - car_wash.pml:14 - [((station1>0))] (21:0:1 - 1)
		IfNotBlocked
		reached[0][14] = 1;
		if (!((((int)now.station1)>0)))
			continue;
		/* merge: station1 = (station1-1)(0, 15, 21) */
		reached[0][15] = 1;
		(trpt+1)->bup.oval = ((int)now.station1);
		now.station1 = (((int)now.station1)-1);
#ifdef VAR_RANGES
		logval("station1", ((int)now.station1));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 29: // STATE 18 - car_wash.pml:31 - [cars_in_station[0] = (cars_in_station[0]-1)] (0:23:2 - 1)
		IfNotBlocked
		reached[0][18] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.cars_in_station[0]);
		now.cars_in_station[0] = (((int)now.cars_in_station[0])-1);
#ifdef VAR_RANGES
		logval("cars_in_station[0]", ((int)now.cars_in_station[0]));
#endif
		;
		/* merge: cars_in_station[1] = (cars_in_station[1]+1)(23, 19, 23) */
		reached[0][19] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.cars_in_station[1]);
		now.cars_in_station[1] = (((int)now.cars_in_station[1])+1);
#ifdef VAR_RANGES
		logval("cars_in_station[1]", ((int)now.cars_in_station[1]));
#endif
		;
		/* merge: assert((cars_in_station[1]<=1))(23, 20, 23) */
		reached[0][20] = 1;
		spin_assert((((int)now.cars_in_station[1])<=1), "(cars_in_station[1]<=1)", II, tt, t);
		_m = 3; goto P999; /* 2 */
	case 30: // STATE 22 - car_wash.pml:19 - [station0 = (station0+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][22] = 1;
		(trpt+1)->bup.oval = ((int)now.station0);
		now.station0 = (((int)now.station0)+1);
#ifdef VAR_RANGES
		logval("station0", ((int)now.station0));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 31: // STATE 24 - car_wash.pml:19 - [permToProcess[1] = (permToProcess[1]+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][24] = 1;
		(trpt+1)->bup.oval = ((int)now.permToProcess[1]);
		now.permToProcess[1] = (((int)now.permToProcess[1])+1);
#ifdef VAR_RANGES
		logval("permToProcess[1]", ((int)now.permToProcess[1]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 32: // STATE 26 - car_wash.pml:14 - [((doneProcessing[1]>0))] (33:0:1 - 1)
		IfNotBlocked
		reached[0][26] = 1;
		if (!((((int)now.doneProcessing[1])>0)))
			continue;
		/* merge: doneProcessing[1] = (doneProcessing[1]-1)(0, 27, 33) */
		reached[0][27] = 1;
		(trpt+1)->bup.oval = ((int)now.doneProcessing[1]);
		now.doneProcessing[1] = (((int)now.doneProcessing[1])-1);
#ifdef VAR_RANGES
		logval("doneProcessing[1]", ((int)now.doneProcessing[1]));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 33: // STATE 30 - car_wash.pml:14 - [((station2>0))] (37:0:1 - 1)
		IfNotBlocked
		reached[0][30] = 1;
		if (!((((int)now.station2)>0)))
			continue;
		/* merge: station2 = (station2-1)(0, 31, 37) */
		reached[0][31] = 1;
		(trpt+1)->bup.oval = ((int)now.station2);
		now.station2 = (((int)now.station2)-1);
#ifdef VAR_RANGES
		logval("station2", ((int)now.station2));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 34: // STATE 34 - car_wash.pml:41 - [cars_in_station[1] = (cars_in_station[1]-1)] (0:39:2 - 1)
		IfNotBlocked
		reached[0][34] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.cars_in_station[1]);
		now.cars_in_station[1] = (((int)now.cars_in_station[1])-1);
#ifdef VAR_RANGES
		logval("cars_in_station[1]", ((int)now.cars_in_station[1]));
#endif
		;
		/* merge: cars_in_station[2] = (cars_in_station[2]+1)(39, 35, 39) */
		reached[0][35] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.cars_in_station[2]);
		now.cars_in_station[2] = (((int)now.cars_in_station[2])+1);
#ifdef VAR_RANGES
		logval("cars_in_station[2]", ((int)now.cars_in_station[2]));
#endif
		;
		/* merge: assert((cars_in_station[2]<=1))(39, 36, 39) */
		reached[0][36] = 1;
		spin_assert((((int)now.cars_in_station[2])<=1), "(cars_in_station[2]<=1)", II, tt, t);
		_m = 3; goto P999; /* 2 */
	case 35: // STATE 38 - car_wash.pml:19 - [station1 = (station1+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][38] = 1;
		(trpt+1)->bup.oval = ((int)now.station1);
		now.station1 = (((int)now.station1)+1);
#ifdef VAR_RANGES
		logval("station1", ((int)now.station1));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 36: // STATE 40 - car_wash.pml:19 - [permToProcess[2] = (permToProcess[2]+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][40] = 1;
		(trpt+1)->bup.oval = ((int)now.permToProcess[2]);
		now.permToProcess[2] = (((int)now.permToProcess[2])+1);
#ifdef VAR_RANGES
		logval("permToProcess[2]", ((int)now.permToProcess[2]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 37: // STATE 42 - car_wash.pml:14 - [((doneProcessing[2]>0))] (47:0:1 - 1)
		IfNotBlocked
		reached[0][42] = 1;
		if (!((((int)now.doneProcessing[2])>0)))
			continue;
		/* merge: doneProcessing[2] = (doneProcessing[2]-1)(0, 43, 47) */
		reached[0][43] = 1;
		(trpt+1)->bup.oval = ((int)now.doneProcessing[2]);
		now.doneProcessing[2] = (((int)now.doneProcessing[2])-1);
#ifdef VAR_RANGES
		logval("doneProcessing[2]", ((int)now.doneProcessing[2]));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 38: // STATE 46 - car_wash.pml:48 - [cars_in_station[2] = (cars_in_station[2]-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][46] = 1;
		(trpt+1)->bup.oval = ((int)now.cars_in_station[2]);
		now.cars_in_station[2] = (((int)now.cars_in_station[2])-1);
#ifdef VAR_RANGES
		logval("cars_in_station[2]", ((int)now.cars_in_station[2]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 39: // STATE 48 - car_wash.pml:19 - [station2 = (station2+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][48] = 1;
		(trpt+1)->bup.oval = ((int)now.station2);
		now.station2 = (((int)now.station2)+1);
#ifdef VAR_RANGES
		logval("station2", ((int)now.station2));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 40: // STATE 50 - car_wash.pml:50 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][50] = 1;
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


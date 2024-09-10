	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC :init: */

	case 3: // STATE 1
		;
		((P2 *)_this)->i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 5: // STATE 3
		;
		now.permToProcess[ Index(((P2 *)_this)->i, 3) ] = trpt->bup.oval;
		;
		goto R999;

	case 6: // STATE 4
		;
		now.doneProcessing[ Index(((P2 *)_this)->i, 3) ] = trpt->bup.oval;
		;
		goto R999;

	case 7: // STATE 5
		;
		now.cars_in_station[ Index(((P2 *)_this)->i, 3) ] = trpt->bup.oval;
		;
		goto R999;

	case 8: // STATE 6
		;
		machine_working[ Index(((P2 *)_this)->i, 3) ] = trpt->bup.oval;
		;
		goto R999;

	case 9: // STATE 7
		;
		((P2 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 10: // STATE 13
		;
		((P2 *)_this)->i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 12: // STATE 15
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 13: // STATE 16
		;
		((P2 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 14: // STATE 22
		;
		((P2 *)_this)->i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 16: // STATE 24
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 17: // STATE 25
		;
		((P2 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 18: // STATE 32
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC Machine */

	case 19: // STATE 2
		;
		now.permToProcess[ Index(((P1 *)_this)->i, 3) ] = trpt->bup.oval;
		;
		goto R999;

	case 20: // STATE 5
		;
		machine_working[ Index(((P1 *)_this)->i, 3) ] = trpt->bup.oval;
		;
		goto R999;

	case 21: // STATE 8
		;
		now.doneProcessing[ Index(((P1 *)_this)->i, 3) ] = trpt->bup.oval;
		;
		goto R999;

	case 22: // STATE 10
		;
		machine_working[ Index(((P1 *)_this)->i, 3) ] = trpt->bup.oval;
		;
		goto R999;

	case 23: // STATE 14
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC Car */

	case 24: // STATE 2
		;
		now.station0 = trpt->bup.oval;
		;
		goto R999;

	case 25: // STATE 5
		;
		now.cars_in_station[0] = trpt->bup.oval;
		;
		goto R999;

	case 26: // STATE 8
		;
		now.permToProcess[0] = trpt->bup.oval;
		;
		goto R999;

	case 27: // STATE 11
		;
		now.doneProcessing[0] = trpt->bup.oval;
		;
		goto R999;

	case 28: // STATE 15
		;
		now.station1 = trpt->bup.oval;
		;
		goto R999;

	case 29: // STATE 19
		;
		now.cars_in_station[1] = trpt->bup.ovals[1];
		now.cars_in_station[0] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 30: // STATE 22
		;
		now.station0 = trpt->bup.oval;
		;
		goto R999;

	case 31: // STATE 24
		;
		now.permToProcess[1] = trpt->bup.oval;
		;
		goto R999;

	case 32: // STATE 27
		;
		now.doneProcessing[1] = trpt->bup.oval;
		;
		goto R999;

	case 33: // STATE 31
		;
		now.station2 = trpt->bup.oval;
		;
		goto R999;

	case 34: // STATE 35
		;
		now.cars_in_station[2] = trpt->bup.ovals[1];
		now.cars_in_station[1] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 35: // STATE 38
		;
		now.station1 = trpt->bup.oval;
		;
		goto R999;

	case 36: // STATE 40
		;
		now.permToProcess[2] = trpt->bup.oval;
		;
		goto R999;

	case 37: // STATE 43
		;
		now.doneProcessing[2] = trpt->bup.oval;
		;
		goto R999;

	case 38: // STATE 46
		;
		now.cars_in_station[2] = trpt->bup.oval;
		;
		goto R999;

	case 39: // STATE 48
		;
		now.station2 = trpt->bup.oval;
		;
		goto R999;

	case 40: // STATE 50
		;
		p_restor(II);
		;
		;
		goto R999;
	}


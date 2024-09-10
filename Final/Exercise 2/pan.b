	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC :init: */

	case 3: // STATE 1
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 4: // STATE 2
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 5: // STATE 4
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC Q */

	case 6: // STATE 2
		;
		now.flag[ Index(((P1 *)_this)->me, 2) ] = trpt->bup.oval;
		;
		goto R999;
;
		;
		;
		;
		
	case 9: // STATE 5
		;
		now.turn = trpt->bup.oval;
		;
		goto R999;

	case 10: // STATE 11
		;
		now.flag[ Index(((P1 *)_this)->me, 2) ] = trpt->bup.oval;
		;
		goto R999;

	case 11: // STATE 15
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC P */

	case 12: // STATE 2
		;
		now.flag[ Index(((P0 *)_this)->me, 2) ] = trpt->bup.oval;
		;
		goto R999;
;
		;
		;
		;
		
	case 15: // STATE 5
		;
		now.turn = trpt->bup.oval;
		;
		goto R999;

	case 16: // STATE 11
		;
		now.flag[ Index(((P0 *)_this)->me, 2) ] = trpt->bup.oval;
		;
		goto R999;

	case 17: // STATE 15
		;
		p_restor(II);
		;
		;
		goto R999;
	}


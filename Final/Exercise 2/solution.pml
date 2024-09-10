byte flag[2] = {false, false};
byte turn = 0;

active proctype P() {
    byte me = 0;
    byte you = 1;
    do
    :: true ->
        flag[me] = true;
        do
        :: turn != me ->
            (flag[you] == false);
            turn = me;
        :: else -> break;
        od;
        // Critical Section 
        flag[me] = false;
    od;
}

active proctype Q() {
    byte me = 1;
    byte you = 0;
    do
    :: true ->
        flag[me] = true;
        do
        :: turn != me ->
            (flag[you] == false);
            turn = me;
        :: else -> break;
        od;
        // Critical Section
        flag[me] = false;
    od;
}

init {
    atomic{
        run P()
        run Q()
    }
}
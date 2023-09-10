import Lineage;

settings.outformat = "pdf";

unitsize(1cm);

bool[] type00 = {true, false, false};
bool[] type0 = {false, false, false};
bool[] type1 = {false, true, true};
bool[] type2 = {false, false, true};

Arg arg = Arg(type00);
arg.newleaf(type0, 1);
arg.newleaf(type1, 3);
arg.newleaf(type2, 1);

arg.coalesce(2, 3);
arg.coalesce(0, 1);
arg.coalesce(4, 6);
arg.recombine(8, 1);
arg.coalesce(5, 10);
arg.coalesce(7, 9);
arg.coalesce(11, 12);

arg.draw();

import Lineage;

settings.outformat = "pdf";

unitsize(1cm);

bool[] type00 = {true, false, false};
bool[] type0 = {false, false, false};
bool[] type1 = {false, true, true};
bool[] type2 = {false, false, true};

Arg arg = Arg(type0);
arg.newleaf(type0, 5);

arg.coalesce(2, 3);
arg.coalesce(0, 1);
arg.coalesce(4, 6);
arg.coalesce(7, 8);
arg.coalesce(5, 9);

arg.draw(guides = false);

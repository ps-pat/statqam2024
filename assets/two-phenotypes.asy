import Lineage;

settings.outformat = "pdf";

unitsize(1cm);

bool[] type0 = {false, true, true, false};

Arg arg = Arg(type0, draw_mutations = false);
arg.newleaf(type0, 1);

arg.coalesce(0, 1);

arg.draw();

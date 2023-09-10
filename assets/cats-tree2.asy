settings.outformat = "png";

shipout(bbox(opacity(0), Fill));

unitsize(1pt);

pair[] leaf = {(-150, 0), (0, 0), (150, 0)};
pair[] coal_vertex = {(75, 100), (-75, 250)};

label(graphic("cat1.jpg", "scale = 1, width = 100pt"), leaf[0], S);
label(graphic("cat2.jpg", "scale = 1, width = 100pt"), leaf[1], S);
label(graphic("cat3.jpg", "scale = 1, width = 100pt"), leaf[2], S);

pen edge = rgb("e65100") + linewidth(5pt);

draw(leaf[1] -- coal_vertex[0], p = edge);
draw(leaf[2] -- coal_vertex[0], p = edge);
draw(leaf[0] -- coal_vertex[1], p = edge);
draw(coal_vertex[0] -- coal_vertex[1], p = edge);

// Pr
pair[] parens = {(-250, 75), (250, 75)};

label(scale(10) * "Pr", position = shift(-125, 0) * parens[0]);
label(scale(40) * "(", position = parens[0]);
label(scale(40) * ")", position = parens[1]);

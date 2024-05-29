function formatTitleSlides(obj) {
  for (const section of obj.querySelectorAll("section.title-slide")) {
    // Set background.
    section.setAttribute("data-background", "#4d7e65");
  }
}

formatTitleSlides(document);

$(function() {

  // Tag slides in "References" section with the first and last reference they
  // contain.
  let refslide_counter = 0;
  for (let refslide of ($("#references > section:not(:first-child)"))) {
    const reflist = $("ol", refslide);

    const startidx = reflist.attr("start") === undefined ?
          1 : +reflist.attr("start");
    const lastidx = $("li", reflist).length + startidx - 1;

    $(refslide).attr("first-ref", startidx);
    $(refslide).attr("last-ref", lastidx);
    $(refslide).attr("id", "references-" + refslide_counter++);
  }

  // Add link to references.
  for (let ref of $(".reference")) {
    const refidx = $(ref).text();
    $(ref).wrapInner(`<a role="button" onclick="gotoref(${refidx})"></a>`);
  }

  // Change the class of julia-repl prompt.
  $(".hljs-meta:contains('julia>')").addClass("hljs-repl").removeClass("hljs-meta");
});

// Got to the slide containing the reference.
function gotoref(refidx) {
  for (let refslide of $("#references > section:not(:first-child)")) {
    if (refidx >= $(refslide).attr("first-ref"))
      if (refidx <= $(refslide).attr("last-ref")) {
        window.location = `#/${$(refslide).attr("id")}`
        return;
      }
  }
}

// Generate QR code.
const qrcode = new QRCode("qrcode", {
  width: 75,
  height: 75,
  correctLevel: QRCode.CorrectLevel.L
});

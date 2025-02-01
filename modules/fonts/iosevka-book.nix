{ iosevka }: iosevka.override {
  set = "Book";
  privateBuildPlan = ''
    [buildOptions]
    optimizeWithTtx = false

    [buildPlans.IosevkaBook]
    exportGlyphNames = false
    family = "Iosevka Book"
    noCvSs = false
    noLigation = true
    serifs = "sans"
    spacing = "quasi-proportional"

    [buildPlans.IosevkaBook.variants.design]
    ascii-single-quote = "straight"
    at = "fourfold"
    b = "toothed-serifless"
    c = "serifless"
    capital-a = "curly-serifless"
    capital-b = "standard-interrupted-unilateral-serifed"
    capital-c = "unilateral-inward-serifed"
    capital-d = "standard-unilateral-serifed"
    capital-e = "top-left-serifed"
    capital-f = "top-left-serifed"
    capital-g = "toothed-inward-serifed-hooked"
    capital-h = "top-left-bottom-right-serifed"
    capital-i = "serifed"
    capital-k = "curly-top-left-and-bottom-right-serifed"
    capital-l = "motion-serifed"
    capital-m = "hanging-motion-serifed"
    capital-n = "standard-motion-serifed"
    capital-p = "open-motion-serifed"
    capital-q = "open-swash"
    capital-r = "standing-open-top-left-and-bottom-right-serifed"
    capital-s = "unilateral-inward-serifed"
    capital-t = "motion-serifed"
    capital-u = "toothless-corner-unilateral-motion-serifed"
    capital-v = "curly-motion-serifed"
    capital-w = "curly-motion-serifed"
    capital-x = "curly-motion-serifed"
    capital-y = "curly-motion-serifed"
    capital-z = "curly-serifed"
    d = "toothed-serifless"
    e = "flat-crossbar"
    f = "flat-hook-serifless"
    g = "double-storey-open"
    i = "serifed"
    j = "flat-hook-serifed"
    k = "curly-serifless"
    l = "serifed-flat-tailed"
    m = "short-leg-serifless"
    percent = "rings-continuous-slash-also-connected"
    punctuation-dot = "square"
    q = "tailed-serifless"
    r = "corner-hooked-serifless"
    s = "serifless"
    t = "flat-hook"
    u = "toothed-serifless"
    v = "curly-serifless"
    w = "curly-serifless"
    x = "curly-serifless"
    y = "curly-turn-serifless"
    z = "curly-serifless"

    [buildPlans.IosevkaBook.variants.italic]
    b = "toothed-motion-serifed"
    c = "serifless"
    capital-a = "curly-serifless"
    capital-b = "standard-interrupted-unilateral-serifed"
    capital-c = "unilateral-inward-serifed"
    capital-d = "standard-unilateral-serifed"
    capital-e = "top-left-serifed"
    capital-f = "top-left-serifed"
    capital-g = "toothed-inward-serifed-hooked"
    capital-h = "top-left-bottom-right-serifed"
    capital-i = "serifed"
    capital-k = "curly-top-left-and-bottom-right-serifed"
    capital-l = "motion-serifed"
    capital-m = "hanging-motion-serifed"
    capital-n = "standard-motion-serifed"
    capital-p = "open-motion-serifed"
    capital-q = "open-swash"
    capital-r = "standing-open-top-left-and-bottom-right-serifed"
    capital-s = "unilateral-inward-serifed"
    capital-t = "motion-serifed"
    capital-u = "toothless-corner-unilateral-motion-serifed"
    capital-v = "curly-motion-serifed"
    capital-w = "curly-motion-serifed"
    capital-x = "curly-motion-serifed"
    capital-y = "curly-motion-serifed"
    capital-z = "curly-serifed"
    d = "tailed-serifless"
    e = "rounded"
    f = "flat-hook-tailed"
    g = "double-storey-open"
    h = "tailed-motion-serifed"
    i = "serifed-flat-tailed"
    j = "flat-hook-serifed"
    k = "cursive-top-left-and-bottom-right-serifed"
    l = "flat-tailed"
    m = "short-leg-tailed-top-left-serifed"
    n = "tailed-motion-serifed"
    p = "eared-motion-serifed"
    q = "tailed-serifless"
    r = "corner-hooked-top-serifed"
    s = "serifless"
    t = "flat-hook"
    u = "tailed-motion-serifed"
    v = "cursive-serifed"
    w = "cursive-serifed"
    x = "semi-chancery-curly-serifed"
    y = "cursive-motion-serifed"
    z = "cursive"

    [buildPlans.IosevkaBook.weights.Regular]
    css = 400
    menu = 400
    shape = 400

    [buildPlans.IosevkaBook.weights.Bold]
    css = 700
    menu = 700
    shape = 700

    [buildPlans.IosevkaBook.widths.Normal]
    css = "normal"
    menu = 5
    shape = 600

    [buildPlans.IosevkaBook.slopes.Upright]
    angle = 0
    css = "normal"
    menu = "upright"
    shape = "upright"

    [buildPlans.IosevkaBook.slopes.Italic]
    angle = 9.4
    css = "italic"
    menu = "italic"
    shape = "italic"
  '';
}

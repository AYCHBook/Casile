SILE.registerCommand("publicationpage:font", function(options, content)
  SILE.call("font", { family="Libertinus Serif", size="9pt", language="und" }, content)
end)

SILE.registerCommand("publicationpage", function(options, content)
  SILE.settings.temporarily(function()
    SILE.settings.set("document.lskip", SILE.nodefactory.zeroGlue)
    SILE.settings.set("document.rskip", SILE.nodefactory.zeroGlue)
    SILE.settings.set("document.rskip", SILE.nodefactory.zeroGlue)
    SILE.settings.set("document.parskip", SILE.nodefactory.newVglue("1.2ex"))
    SILE.call("nofolios")
    SILE.call("noindent")
    SILE.call("hbox")
    SILE.call("vfill")
    SILE.call("raggedright", {}, function()
      SILE.call("publicationpage:font", {}, function()
        SILE.settings.set("linespacing.method", "fixed")
        SILE.settings.set("linespacing.fixed.baselinedistance", SILE.length.parse("2.8ex"))

        SILE.settings.temporarily(function()
          SILE.call("img", { src="avadanlik/vc_sembol_renksiz.pdf", height="6.5em" })
          SILE.call("skip", { height="-6.7em" })
          SILE.settings.set("document.lskip", SILE.nodefactory.newGlue("5em"))
          SILE.call("font", { filename="avadanlik/fonts/Mason-Bold.otf", size="1.25em" }, { "Via Christus Yayınları" })
          SILE.call("break")
          SILE.typesetter:typeset("Davutpaşa Cad. Kazım Dinçol San. Sit.")
          SILE.call("break")
          SILE.typesetter:typeset("No 81/87, Topkapı, İstanbul, Türkiye")
          SILE.call("break")
          SILE.call("font", { family="Hack", size="0.8em" }, function()
            SILE.typesetter:typeset("https://viachristus.com")
            SILE.call("break")
            SILE.typesetter:typeset("yayinlar@viachristus.com")
          end)
          SILE.call("par")
        end)

        SILE.call("font", { weight=600, style="Bold" }, SILE.Commands["meta:title"])
        SILE.call("break")
        SILE.call("meta:creators")
        SILE.call("meta:info")
        SILE.call("par")
        SILE.call("meta:rights")
        SILE.call("par")

        SILE.call("skip", { height="5.4em" })
        SILE.settings.temporarily(function()
          SILE.call("img", { src=qrimg, height="5.8em" })
          SILE.call("skip", { height="-6.3em" })
          SILE.call("set", { parameter="document.lskip", value="5em" })
          SILE.call("meta:identifiers")
          SILE.call("font", { weight=600, style="Bold" }, { "Sürüm: " })
          SILE.call("font", { family="Hack", size="0.8em" }, SILE.Commands["meta:surum"])
          SILE.call("break")
          SILE.call("font", { weight=600, style="Bold" }, { "URL: " })
          SILE.call("font", { family="Hack", size="0.8em" }, SILE.Commands["meta:url"])
          SILE.call("par")
        end)

        SILE.call("meta:contributors")
        SILE.call("par")
        SILE.call("meta:extracredits")
        SILE.call("par")
        SILE.call("meta:versecredits")
        if SILE.Commands["meta:distribution"] then
          SILE.call("par")
          SILE.call("meta:distribution")
        elseif SILE.Commands["meta:date"] then
          SILE.call("par")
          SILE.call("meta:manufacturer")
          SILE.call("par")
          SILE.call("meta:date")
        end
      end)
    end)
  end)
  SILE.call("par")
  SILE.call("break")
end)

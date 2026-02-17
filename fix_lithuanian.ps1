# Fix corrupted Lithuanian chars (U+FFFD) - ONLY link/body text, NOT href or src
param([string]$FilePath)
$path = if ($FilePath) { (Resolve-Path $FilePath).Path } else { Join-Path $PSScriptRoot "mp3.htm" }
$enc = [System.Text.Encoding]::UTF8
$content = [System.IO.File]::ReadAllText($path, $enc)

$X = [char]0xFFFD   # replacement char

# Lithuanian chars - use distinct names (PowerShell vars are case-insensitive!)
$u_ogon = [char]0x0173   # u
$e_ogon = [char]0x0119   # e
$a_ogon = [char]0x0105   # a
$e_dot = [char]0x0117    # e
$u_macron = [char]0x016B # u
$i_ogon = [char]0x012F   # i
$caron_s_lo = [char]0x0161  # s lowercase
$caron_s_hi = [char]0x0160  # S uppercase
$caron_z_lo = [char]0x017E  # z lowercase
$caron_z_hi = [char]0x017D  # Z uppercase
$l_cedilla = [char]0x0137 # l (e with cedilla for e)
$a_macron = [char]0x0101 # a (for a)
$e_macron = [char]0x0113 # e (for e)

# Build replacement strings
$parsisiusti = "parsi" + "si" + $u_ogon + "sti"
$desine = "de" + $caron_s_lo + "in" + $e_ogon
$mygtuka = "mygtuk" + $a_ogon
$issisaugot = $i_ogon + "sisaugot"
$Mylejau_savo_antra_zmona = "Myl" + $e_dot + "jau savo antr" + $a_ogon + " " + $caron_z_lo + "mon" + $a_ogon
$Anukeli = "An" + $u_macron + "k" + $e_dot + "li"
$anukeli = "an" + $u_macron + "k" + $e_dot + "li"
$Saruno_vezimelis = $caron_s_hi + "ar" + $u_macron + "no ve" + $caron_z_lo + "im" + $e_dot + "lis"
$Nesidziauk_nebaiges = "Nesid" + $caron_z_lo + "iauk, nebaig" + $e_ogon + "s gyvenimo"
$Nesidziauk_nebaiges2 = "Nesid" + $caron_z_lo + "iauk nebaig" + $e_ogon + "s gyvenimo"
$Zaklinos = $caron_z_hi + "aklinos kloaka"
$Zirkles = $caron_z_hi + "irkl" + $e_dot + "s burnoje"
$Sugrizk = "Sugr" + $i_ogon + $caron_z_lo + "k"
$Mire_suo = "Mir" + $e_dot + " " + $caron_s_lo + "uo"
$Sia_popiete = $caron_s_hi + "i" + $a_ogon + " popiet" + $e_ogon
$Pasake = "Pasak" + $e_dot
$Pasakem = "Pasak" + $e_dot + "m"
$Uzsivede = "U" + $caron_z_lo + "sived" + $e_dot + " jis"
$vaidilutes = "vaidilut" + $e_dot + "s"
$diskoteka = "diskotek" + $a_ogon
$Nepakile_lektuvai = "Nepakil" + $e_ogon + " l" + $e_dot + "ktuvai"
$Menulio_Indenai = "M" + $e_dot + "nulio Ind" + $e_dot + "nai"
$zvaigzdziu = $caron_z_lo + "vaig" + $caron_z_lo + "d" + $caron_z_lo + "i" + $u_ogon + " karas"
$uzgeso = "u" + $caron_z_lo + "geso"
$As_Negerau = "A" + $caron_s_lo + " Neg" + $e_dot + "riau"
$Zemes_Uztemimas = $caron_z_hi + "em" + $e_dot + "s U" + $caron_z_lo + "temimas"
$Saldytuve = $caron_s_hi + "aldytuve"
$puse = "pus" + $e_ogon
$Trasos = "Tr" + $a_ogon + $caron_s_lo + "os"
$Gimtines = "Gimtin" + $e_dot + "s Laukai"
$As_Lochas = "A" + $caron_s_lo + " Lochas"
$Isvarymo = "I" + $caron_s_lo + "varymo daina"
$Pas_Andzela = "Pas And" + $caron_z_lo + "el" + $a_ogon
$As_tave = "A" + $caron_s_lo + " tave myliu"
$As_lochas = "A" + $caron_s_lo + " lochas"
$As_Tave_Myliu = "A" + $caron_s_lo + " Tave Myliu"
$metu = "met" + $u_ogon + " demo"
$Eigminienes = "Eigminien" + $e_dot + "s pirtel" + $e_dot + "j"
$Milda_is = "Milda i" + $caron_s_lo + " Radvili" + $caron_s_lo + "kio"
$ieskokit = "ie" + $caron_s_lo + "kokit"

# Apply replacements - order matters
$replacements = @(
    @("parsisi$X`sti", $parsisiusti),
    @("de$X`in$X", $desine),
    @("mygtuk$X", $mygtuka),
    @("i$X`sisaugot", $issisaugot),
    @("Myl$X`jau savo antr$X` $X`mon$X", $Mylejau_savo_antra_zmona),
    @("An$X`k$X`li", $Anukeli),
    @("an$X`k$X`li", $anukeli),
    @("$X`ar$X`no ve$X`im$X`lis", $Saruno_vezimelis),
    @("$X`ar$X`no v$X$X`im$X`lis", $Saruno_vezimelis),
    @("Nesid$X`iauk, nebaig$X`s gyvenimo", $Nesidziauk_nebaiges),
    @("Nesid$X`iauk nebaig$X`s gyvenimo", $Nesidziauk_nebaiges2),
    @("$X$X`aklinos kloaka", $Zaklinos),
    @("$X`aklinos kloaka", $Zaklinos),
    @("$X`irkl$X`s burnoje", $Zirkles),
    @("Sugr$X$X`k", $Sugrizk),
    @("Mir$X` $X`uo", $Mire_suo),
    @("$X`i$X` popiet$X", $Sia_popiete),
    @("Pasak$X", $Pasake),
    @("Pasak$X`m", $Pasakem),
    @("U$X`sived$X` jis", $Uzsivede),
    @("vaidilut$X`s", $vaidilutes),
    @("diskotek$X", $diskoteka),
    @("Nepakil$X` l$X`ktuvai", $Nepakile_lektuvai),
    @("M$X`nulio Ind$X`nai", $Menulio_Indenai),
    @("Baltsaundo $X`vaig$X`d$X`i$X` karas", "Baltsaundo " + $zvaigzdziu),
    @("u$X`geso", $uzgeso),
    @("A$X` Neg$X`riau", $As_Negerau),
    @("$X`em$X`s U$X`temimas", $Zemes_Uztemimas),
    @("$X`aldytuve", $Saldytuve),
    @(("pus" + $X + ":"), ("pus" + [char]0x0119 + ":")),
    @("Tr$X$X`os", $Trasos),
    @("Gimtin$X`s Laukai", $Gimtines),
    @("A$X` Lochas", $As_Lochas),
    @("I$X`varymo daina", $Isvarymo),
    @("Pas And$X`el$X", $Pas_Andzela),
    @("A$X` tave myliu", $As_tave),
    @("A$X` lochas", $As_lochas),
    @("A$X` Tave Myliu", $As_Tave_Myliu),
    @("2005 met$X` demo", "2005 met" + [char]0x0173 + " demo"),
    @("Eigminien$X`s pirtel$X`j", $Eigminienes),
    @("Milda i$X` Radvili$X`kio", $Milda_is),
    @("ie$X`kokit", $ieskokit),
    @("kal$X`dinis", "kal" + $e_dot + "dinis"),
    @(("met" + $X), ("met" + $u_ogon)),
    @("Gruod$X`io", "Gruod" + $caron_z_lo + "io"),
    @("m$X`n.", "m" + $e_dot + "n."),
    @(("dien" + $X), ("dien" + $a_ogon)),
    @("Valiukevi$X`ius", "Valiukevi" + $caron_s_lo + "ius"),
    @(($X + ". " + $X + ". Jag" + $e_dot + "la"), ($caron_z_lo + ". " + $caron_z_hi + ". Jag" + $e_dot + "la")),
    @("Beveik kal" + $X + " koncertas", "Beveik kal" + $e_dot + "dinis koncertas"),
    @("Beveik kal" + $X + "dinis koncertas", "Beveik kal" + $e_dot + "dinis koncertas"),
    @("Valiukevi - bosin", "Valiukevi" + $caron_s_lo + "ius - bosin"),
    @($X + ". liaudies", $caron_z_lo + ". liaudies"),
    @("m. " + $X + ". Jag", "m. " + $caron_z_lo + ". Jag"),
    @($X + "unparkis", $caron_z_hi + "unparkis"),
    @("Karpavi" + $X + "ius", "Karpavi" + [char]0x010D + "ius"),
    @($X + "io leidinio", $caron_s_hi + "io leidinio"),
    @("n" + $X + "ra galimyb", "n" + $e_dot + "ra galimyb"),
    @("galimyb" + $X + "s parsisi", "galimyb" + $e_dot + "s parsisi"),
    @("ta" + $X + "iau galima", "ta" + [char]0x010D + "iau galima"),
    @("persira" + $X + "yti i" + $X + " ", "persira" + $caron_s_lo + "yti i" + $caron_s_lo + " "),
    @("i" + $X + " Tautvydo", "i" + $caron_s_lo + " Tautvydo"),
    @("i" + $X + " radiostoties", "i" + $caron_s_lo + " radiostoties"),
    @("Elektrob" + $X + "gninis", "Elektrob" + $u_macron + "gninis"),
    @("Dain" + $X + " s", "Dain" + $u_ogon + " s"),
    @("1-6 dain" + $X + " tonacija", "1-6 dain" + $u_ogon + " tonacija"),
    @("I" + $X + "leidinys", "I" + $caron_s_lo + "leidinys"),
    @("gerb" + $X + "jui", "gerb" + $e_dot + "jui"),
    @($X + "tuceriui", $caron_s_lo + "tuceriui"),
    @("Zdanevi" + $X + "iui", "Zdanevi" + [char]0x010D + "iui"),
    @("GALI" + $X, "GALI" + $a_ogon),
    @("Juknevi" + $X + "ius", "Juknevi" + [char]0x010D + "ius"),
    @("Gimtin" + $X + "s laukai", "Gimtin" + $e_dot + "s laukai"),
    @("mi" + $X + "ke", "mi" + $caron_s_lo + "ke"),
    @($X + ". Maironis", $caron_z_lo + ". Maironis"),
    @("Senas " + $X + "uva", "Senas " + $caron_s_lo + "uo"),
    @("m. ir " + $X + ". OPUS", "m. ir " + $caron_z_lo + ". OPUS"),
    @("mir" + $X, "mir" + $e_dot),
    @("suk" + $X + "iai", "suk" + [char]0x010D + "iai"),
    @("me" + $X + "k" + $X, "me" + $caron_s_lo + "k" + $a_ogon),
    @("Bordi" + $X + "ras", "Bord" + $caron_z_lo + "ira" + $caron_s_lo),
    @("L" + $X + "tas " + $X + "uo", "L" + $e_dot + "tas " + $caron_s_lo + "uo"),
    @("Storas " + $X + "iuvas", "Storas " + $caron_s_lo + "iuvas"),
    @("i" + $X + "skyrus", "i" + $caron_s_lo + "skyrus"),
    @("pri" + $X + "ym" + $X + "ta", "pa" + $caron_z_lo + "ym" + $e_dot + "ta"),
    @($X + "tampuoti", $caron_s_lo + "tampuoti"),
    @("pasid" + $X + "ti", "pasid" + $e_dot + "ti"),
    @($X + "ito kompakto", $caron_s_lo + "ito kompakto"),
    @("vie" + $X + "ai negalima", "vie" + $caron_s_lo + "ai negalima"),
    @("Ira" + $X + "yta", "I" + $i_ogon + "ra" + $caron_s_lo + "yta"),
    @("ira" + $X + "u studijoje", "i" + $i_ogon + "ra" + $caron_s_lo + $u_ogon + " studijoje"),
    @("pa" + $X + "iais metais", "pa" + [char]0x010D + "iais metais"),
    @("raid" + $X + "iu", "raid" + $caron_z_lo + $u_ogon),
    @("B" + $X + "tlegai", "B" + $u_macron + "tlegai"),
    @("u" + $X + "uot leidusi", "u" + $caron_z_lo + "uot leidusi"),
    @("visoki" + $X + " nerimt", "visoki" + $u_ogon + " nerimt"),
    @("nerimt" + $X + " ", "nerimt" + $u_ogon + " "),
    @("i" + $X + "leido vien", "i" + $caron_s_lo + "leido vien"),
    @("vien" + $X + " rimt" + $X + ",", "vien" + $a_ogon + " rimt" + $a_ogon + ","),
    @($X + "iame rinkinyje", $caron_s_hi + "iame rinkinyje"),
    @($X + "ra" + $X + "ai,", $i_ogon + "ra" + $caron_s_lo + $u_ogon + "ai,"),
    @($X + "ra" + $X + "yti dar", $i_ogon + "ra" + $caron_s_lo + "yti dar"),
    @("Rugs" + $X + "jo", "Rugs" + $e_dot + "jo"),
    @("repeticij" + $X + " sal", "repeticij" + $u_ogon + " sal"),
    @("sal" + $X + "je ant", "sal" + $e_dot + "je ant"),
    @("Gerkl" + $X, "Gerkl" + $e_dot),
    @("klavi" + $X + "iniai", "klavi" + $caron_s_lo + "iniai"),
    @("ritmin" + $X + " gitara", "ritmin" + $e_dot + " gitara"),
    @($X + "oka ", $caron_z_lo + "oka "),
    @("mu" + $X + "amieji", "mu" + $caron_s_lo + "amieji"),
    @($X + ".Jag", $caron_z_lo + ". Jag"),
    @($X + ". V.A", $caron_z_lo + ". V.A"),
    @($X + "ilvin", $caron_z_hi + "ilvin"),
    @("akustin" + $X + " gitara", "akustin" + $e_dot + " gitara"),
    @("Parsisi" + $X + "sti", $parsisiusti),
    @("gadinti " + $X + "ito", "gadinti šito"),
    @("I" + $X + "ra" + $X + "yta", "Įrašyta"),
    @("repeticiju ira" + $X + "u ", "repeticiju įrašų "),
    @("nerimtų " + $X + "ra" + $X + $X + " ", "nerimtų įrašų "),
    @($X + "iame rinkinyje", "Šiame rinkinyje"),
    @("įrašųai,", "įrašai,"),
    @("dainos " + $X + "ra" + $X + "ytos", "dainos " + $i_ogon + "ra" + $caron_s_lo + "ytos"),
    @($X + ". V. A", $caron_z_lo + ". V. A"),
    @($X + ".V.A", $caron_z_lo + ".V.A"),
    @("m. ir " + $X + ". Arklio", "m. ir " + $caron_z_lo + ". Arklio"),
    @("Jagėla, " + $X + ". V.", "Jagėla, " + $caron_z_lo + ". V."),
    @("Jagėla, " + $X + ".V.", "Jagėla, " + $caron_z_lo + ".V."),
    @("Jagėla, " + $X + " V.", "Jagėla, " + $caron_z_lo + " V."),
    @("Jagėla, " + $X + " V.A", "Jagėla, " + $caron_z_lo + " V.A"),
    @("Karpavičius, " + $X + ". ž.", "Karpavičius, ž. ž."),
    # Aškinis (V.Aškinis, Aškinis)
    @("V.A" + $X + "kinis", "V.A" + $caron_s_lo + "kinis"),
    @("A" + $X + "kinis", "A" + $caron_s_lo + "kinis"),
    @("V.A" + $X + "kinio", "V.A" + $caron_s_lo + "kinio"),
    # m. ir X. X. Jag / ?. X. Jag (lyricist credits)
    @("m. ir " + $X + ". " + $X + ". Jag", "m. ir " + $caron_z_lo + ". " + $caron_z_hi + ". Jag"),
    @("?. " + $X + ". Jag", $caron_z_lo + ". " + $caron_z_hi + ". Jag"),
    @($X + ". ?. Jag", $caron_z_lo + ". " + $caron_z_hi + ". Jag"),
    # z + X + kinis (z. V. Aškinis)
    @($caron_z_lo + $X + "kinis", $caron_z_lo + ". V. A" + $caron_s_lo + "kinis"),
    # I + X + ra + X + yta, i + X + ra + X + X (įrašyta, įrašų)
    @("I" + $X + "ra" + $X + "yta", [char]0x012F + "ra" + $caron_s_lo + "yta"),
    @("i" + $X + "ra" + $X + $X + " ", [char]0x012F + "ra" + $caron_s_lo + $u_ogon + " "),
    # raid + X + X (raidžių)
    @("raid" + $X + $X, "raid" + $caron_z_lo + $u_ogon)
)

# Fix literal ? placeholders (used when char couldn't be encoded)
$qReplacements = @(
    @("i?leistas", "i" + $caron_s_lo + "leistas"),
    @("atsine?tos", "atsine" + $caron_s_lo + "tos"),
    @("i? ankstesni", "i" + $caron_s_lo + " ankstesni"),
    @("u?sienieti?ka", "u" + $caron_z_lo + "sienieti" + $caron_s_lo + "ka"),
    @("i?versta", "i" + $caron_s_lo + "versta"),
    @("lietuvi?kai", "lietuvi" + $caron_s_lo + "kai"),
    @("?. T.Augustinas", $caron_z_lo + ". T.Augustinas"),
    @("?. V. A", $caron_z_lo + ". V. A"),
    @("?.V.A", $caron_z_lo + ".V.A"),
    @("?.V.A", $caron_z_lo + ".V.A"),
    @("aran?uot", "aran" + $caron_z_lo + "uot"),
    @("V.A?kinio", "V.A" + $caron_s_lo + "kinio"),
    @("i?skyr", "i" + $caron_s_lo + "skyr"),
    @("nepa?intas", "nepa" + $caron_z_lo + "intas"),
    @("visi?kai", "visi" + $caron_s_lo + "kai"),
    @("neprana?auja", "neprana" + $caron_s_lo + "auja"),
    @("U?sived", "U" + $caron_z_lo + "sived"),
    @("?vaig?d?i", $caron_z_lo + "vaig" + $caron_z_lo + "d" + $caron_z_lo + "i"),
    @("A? neg", "A" + $caron_s_lo + " neg"),
    @("?em" + $e_dot + "s", $caron_z_hi + "em" + $e_dot + "s"),
    @("u?temimas", "u" + $caron_z_lo + "temimas"),
    @("?od?iai", $caron_z_lo + "od" + $caron_z_lo + "iai"),
    @("vir?elio", "vir" + $caron_s_lo + "elio"),
    @("Vir?elio", "Vir" + $caron_s_lo + "elio"),
    @("i? knygos", "i" + $caron_s_lo + " knygos"),
    @("vie?ai", "vie" + $caron_s_lo + "ai"),
    @("A? TAVE", "A" + $caron_s_lo + " TAVE"),
    @("A? Tave", "A" + $caron_s_lo + " Tave"),
    @("D?" + $e_dot + "s" + $e_dot, "D" + $caron_z_lo + $e_dot + "s" + $e_dot),
    @("?. Jolantos", $caron_z_lo + ". Jolantos"),
    @("A?kinyt", "A" + $caron_s_lo + "kinyt"),
    @("Mir" + $e_dot + " ?uo", "Mir" + $e_dot + " " + $caron_s_lo + "uo"),
    @("L" + $e_dot + "tas ?uo", "L" + $e_dot + "tas " + $caron_s_lo + "uo"),
    @("Tr" + $a_ogon + "?os", "Tr" + $a_ogon + $caron_s_lo + "os"),
    @("?. ?ar" + $u_ogon + "nas", $caron_z_lo + ". " + $caron_s_hi + "ar" + $u_ogon + "nas")
)

foreach ($r in $replacements) {
    $content = $content.Replace($r[0], $r[1])
}
foreach ($r in $qReplacements) {
    $content = $content.Replace($r[0], $r[1])
}

# Update charset to utf-8
$content = $content.Replace("charset=windows-1257", "charset=utf-8")
$content = $content.Replace("charset=iso-8859-1", "charset=utf-8")

# Regex fallback for any remaining U+FFFD patterns (match replacement char)
$R = "[\uFFFD]"
$content = $content -replace "($R)ar($R)no ve($R)im($R)lis", "Saruno vezimelis"
$content = $content -replace "($R)ar($R)no v($R)($R)im($R)lis", "Saruno vezimelis"
$content = $content -replace "($R)($R)aklinos kloaka", "Zaklinos kloaka"
$content = $content -replace "($R)aklinos kloaka", "Zaklinos kloaka"
$content = $content -replace "M($R)nulio Ind($R)nai", "Menulio Indenai"
$content = $content -replace "Baltsaundo ($R)vaig($R)d($R)i($R) karas", "Baltsaundo zvaigzdiu karas"
$content = $content -replace "A($R) Neg($R)riau", "As Negerau"
$content = $content -replace "($R)em($R)s U($R)temimas", "Zemes Uztemimas"
$content = $content -replace "($R)aldytuve", "Saldytuve"
$content = $content -replace "I($R)varymo daina", "Isvarymo daina"
$content = $content -replace "kal($R)dinis", ("kal" + [char]0x0117 + "dinis")
$content = $content -replace "met($R)(?=\s|\.|,|\)|$)", ("met" + [char]0x0173)
$content = $content -replace "Gruod($R)io", ("Gruod" + [char]0x017E + "io")
$content = $content -replace "m($R)n\.", ("m" + [char]0x0117 + "n.")
$content = $content -replace "dien($R)(?=\s|\.|,|\)|$)", ("dien" + [char]0x0105)
$content = $content -replace "Valiukevi($R)ius", ("Valiukevi" + [char]0x0161 + "ius")
$content = $content -replace "($R)\. ($R)\. Jag(?:$R|" + [char]0x0117 + ")la", ([char]0x017E + ". " + [char]0x017D + ". Jag" + [char]0x0117 + "la")
# More 2006-specific patterns
$content = $content -replace "Beveik kal($R) koncertas", ("Beveik kal" + [char]0x0117 + "dinis koncertas")
$content = $content -replace "Beveik kal($R)dinis koncertas", ("Beveik kal" + [char]0x0117 + "dinis koncertas")
$content = $content -replace "Valiukevi - bosin", ("Valiukevi" + [char]0x0161 + "ius - bosin")
$content = $content -replace "($R)\. liaudies", ([char]0x017E + ". liaudies")
$content = $content -replace "m\. ($R)\. Jag", ("m. " + [char]0x017E + ". Jag")
$content = $content -replace "($R)unparkis", ([char]0x017D + "unparkis")
$content = $content -replace "m\. ir ($R)\. I\.V\.", ("m. ir " + [char]0x017E + ". I.V.")
$content = $content -replace "Karpavi($R)ius", ("Karpavi" + [char]0x010D + "ius")
$content = $content -replace "($R)io leidinio", ([char]0x0160 + "io leidinio")
$content = $content -replace "n($R)ra galimyb", ("n" + [char]0x0117 + "ra galimyb")
$content = $content -replace "galimyb($R)s parsisi", ("galimyb" + [char]0x0117 + "s parsisi")
$content = $content -replace "ta($R)iau galima", ("ta" + [char]0x010D + "iau galima")
$content = $content -replace "persira($R)yti i", ("persira" + [char]0x0161 + "yti i")
$content = $content -replace "persira($R)yti i($R) ", ("persira" + [char]0x0161 + "yti i" + [char]0x0161 + " ")
$content = $content -replace " galima gal persira($R)yti i($R) Tautvydo", (" galima gal persira" + [char]0x0161 + "yti i" + [char]0x0161 + " Tautvydo")
$content = $content -replace "i($R) Tautvydo", ("i" + [char]0x0161 + " Tautvydo")
$content = $content -replace "i($R) radiostoties", ("i" + [char]0x0161 + " radiostoties")
$content = $content -replace "tiesiogiai i($R) ", ("tiesiogiai i" + [char]0x0161 + " ")
$content = $content -replace "Elektrob($R)gninis", ("Elektrob" + [char]0x016B + "gninis")
$content = $content -replace "($R)ra($R)as tiesiai", ([char]0x012F + "ra" + [char]0x0161 + "as tiesiai")
$content = $content -replace "Dain($R) s", ("Dain" + [char]0x0173 + " s")
$content = $content -replace "s($R)ra($R)o autorius", ("s" + [char]0x0105 + "ra" + [char]0x0161 + "o autorius")
$content = $content -replace "1-6 dain($R) tonacija", ("1-6 dain" + [char]0x0173 + " tonacija")
$content = $content -replace "I($R)leidinys", ("I" + [char]0x0161 + "leidinys")
$content = $content -replace "gerb($R)jui", ("gerb" + [char]0x0117 + "jui")
$content = $content -replace "($R)tuceriui", ([char]0x0161 + "tuceriui")
$content = $content -replace "Zdanevi($R)iui", ("Zdanevi" + [char]0x010D + "iui")
$content = $content -replace "v($R)($R)im($R)lis", ("ve" + [char]0x017E + "im" + [char]0x0117 + "lis")
$content = $content -replace "GALI($R)", ("GALI" + [char]0x0105)
$content = $content -replace "l($R)p($R) armonik", ("l" + [char]0x016B + "pin" + [char]0x0117 + " armonik")
$content = $content -replace "armonik($R)l($R),", ("armonik" + [char]0x0117 + "l" + [char]0x0117 + ",")
$content = $content -replace "armonik($R)l($R) ", ("armonik" + [char]0x0117 + "l" + [char]0x0117 + " ")
$content = $content -replace "Juknevi($R)ius", ("Juknevi" + [char]0x010D + "ius")
$content = $content -replace "Gimtin($R)s laukai", ("Gimtin" + [char]0x0117 + "s laukai")
$content = $content -replace "mi($R)ke", ("mi" + [char]0x0161 + "ke")
$content = $content -replace "($R)\. Maironis", ([char]0x017E + ". Maironis")
$content = $content -replace "Senas ($R)uva", ("Senas " + [char]0x0161 + "uo")
$content = $content -replace "m\. ir ($R)\. OPUS", ("m. ir " + [char]0x017E + ". OPUS")
$content = $content -replace "mir($R)\b", ("mir" + [char]0x0117)
$content = $content -replace "suk($R)iai", ("suk" + [char]0x010D + "iai")
$content = $content -replace "me($R)k($R)", ("me" + [char]0x0161 + "k" + [char]0x0105)
$content = $content -replace "Bordi($R)ras", ("Bord" + [char]0x017E + "ira" + [char]0x0161)
$content = $content -replace "L($R)tas ($R)uo", ("L" + [char]0x0117 + "tas " + [char]0x0161 + "uo")
$content = $content -replace "Storas ($R)iuvas", ("Storas " + [char]0x0161 + "iuvas")
$content = $content -replace "i($R)skyrus", ("i" + [char]0x0161 + "skyrus")
$content = $content -replace "pri($R)ym($R)ta", ("pa" + [char]0x017E + "ym" + [char]0x0117 + "ta")
$content = $content -replace "($R)tampuoti", ([char]0x0161 + "tampuoti")
$content = $content -replace "pasid($R)ti", ("pasid" + [char]0x0117 + "ti")
$content = $content -replace "($R)ito kompakto", ([char]0x0161 + "ito kompakto")
$content = $content -replace "vie($R)ai negalima", ("vie" + [char]0x0161 + "ai negalima")
$content = $content -replace "Ira($R)yta", ("I" + [char]0x012F + "ra" + [char]0x0161 + "yta")
$content = $content -replace "ira($R)u studijoje", ("i" + [char]0x012F + "ra" + [char]0x0161 + [char]0x0173 + " studijoje")
$content = $content -replace "ira($R)ai", ("I" + [char]0x012F + "ra" + [char]0x0161 + "ai")
$content = $content -replace "pa($R)iais metais", ("pa" + [char]0x010D + "iais metais")
$content = $content -replace "raid($R)iu", ("raid" + [char]0x017E + [char]0x0173)
$content = $content -replace "B($R)tlegai", ("B" + [char]0x016B + "tlegai")
$content = $content -replace "u($R)uot leidusi", ("u" + [char]0x017E + "uot leidusi")
$content = $content -replace "visoki($R) nerimt", ("visoki" + [char]0x0173 + " nerimt")
$content = $content -replace "nerimt($R) ", ("nerimt" + [char]0x0173 + " ")
$content = $content -replace "i($R)leido vien", ("i" + [char]0x0161 + "leido vien")
$content = $content -replace "vien($R) rimt($R),", ("vien" + [char]0x0105 + " rimt" + [char]0x0105 + ",")
$content = $content -replace "($R)iame rinkinyje", ([char]0x0160 + "iame rinkinyje")
$content = $content -replace "($R)ra($R)ai,", ([char]0x012F + "ra" + [char]0x0161 + [char]0x0173 + "ai,")
$content = $content -replace "($R)ra($R)yti dar", ([char]0x012F + "ra" + [char]0x0161 + "yti dar")
$content = $content -replace "Rugs($R)jo", ("Rugs" + [char]0x0117 + "jo")
$content = $content -replace "repeticij($R) sal", ("repeticij" + [char]0x0173 + " sal")
$content = $content -replace "sal($R)je ant", ("sal" + [char]0x0117 + "je ant")
$content = $content -replace "Gerkl($R)", ("Gerkl" + [char]0x0117)
$content = $content -replace "klavi($R)iniai", ("klavi" + [char]0x0161 + "iniai")
$content = $content -replace "ritmin($R) gitara", ("ritmin" + [char]0x0117 + " gitara")
$content = $content -replace "($R)oka ", ([char]0x017E + "oka ")
$content = $content -replace "mu($R)amieji", ("mu" + [char]0x0161 + "amieji")
$content = $content -replace "($R)\.Jag", ([char]0x017E + ". Jag")
$content = $content -replace "($R)\. V\.A", ([char]0x017E + ". V.A")
$content = $content -replace "($R)ilvin", ([char]0x017D + "ilvin")
$content = $content -replace "akustin($R) gitara", ("akustin" + [char]0x0117 + " gitara")
$content = $content -replace "Parsisi($R)sti", ("Parsisi" + [char]0x0173 + "sti")
$content = $content -replace "Jag" + [char]0x0117 + "la, ($R) V\.", ("Jag" + [char]0x0117 + "la, " + [char]0x017E + ". V.")
$content = $content -replace "V\.A($R)kinis", ("V.A" + [char]0x0161 + "kinis")
$content = $content -replace "A($R)kinis", ("A" + [char]0x0161 + "kinis")
$content = $content -replace "V\.A($R)kinio", ("V.A" + [char]0x0161 + "kinio")
$content = $content -replace ([char]0x017E + "($R)kinis"), ([char]0x017E + ". V. A" + [char]0x0161 + "kinis")
$content = $content -replace "I($R)ra($R)yta", ([char]0x012F + "ra" + [char]0x0161 + "yta")
$content = $content -replace "i($R)ra($R)($R) ", ([char]0x012F + "ra" + [char]0x0161 + [char]0x0173 + " ")
$content = $content -replace "raid($R)($R)(?=\s|\.|,|<|$)", ("raid" + [char]0x017E + "i" + [char]0x0173)
# albums.html: ir X. X. Jag, ir X. ?. Jag, X. Jagėla, X. T.Augustinas, X. Arklio, pas Xilvin
$content = $content -replace "m\. ir ($R)\. ($R)\. Jag", ("m. ir " + [char]0x017E + ". " + [char]0x017D + ". Jag")
$content = $content -replace "m\. ir ($R)\. \?\. Jag", ("m. ir " + [char]0x017E + ". " + [char]0x017D + ". Jag")
$content = $content -replace "ir ($R)\. ($R)\. Jag", ("ir " + [char]0x017E + ". " + [char]0x017D + ". Jag")
$content = $content -replace "ir ($R)\. \?\. Jag", ("ir " + [char]0x017E + ". " + [char]0x017D + ". Jag")
$content = $content -replace "\(m\. ($R)\. Jag", ("(m. " + [char]0x017E + ". Jag")
$content = $content -replace "ir ($R)\. T\.Augustinas", ("ir " + [char]0x017D + ". T.Augustinas")
$content = $content -replace "ir ($R)\. Arklio", ("ir " + [char]0x017D + ". Arklio")
$content = $content -replace "($R)\. Jag" + [char]0x0117 + "la", ([char]0x017D + ". Jag" + [char]0x0117 + "la")
$content = $content -replace "($R)\. Jag" + [char]0x0117 + "los", ([char]0x017D + ". Jag" + [char]0x0117 + "los")
$content = $content -replace "pas ($R)ilvin($R) ", ("pas " + [char]0x017D + "ilvin" + [char]0x0105 + " ")
$content = $content -replace "pas ($R)ilvin", ("pas " + [char]0x017D + "ilvin")
$content = $content -replace "Milda i($R) Radvili", ("Milda i" + [char]0x0161 + " Radvili")
$content = $content -replace "Radvili($R)kio", ("Radvili" + [char]0x0161 + "kio")

# Fix the ASCII placeholders to proper Lithuanian
$content = $content.Replace("Saruno vezimelis", $Saruno_vezimelis)
$content = $content.Replace("Zaklinos kloaka", $Zaklinos)
$content = $content.Replace("Menulio Indenai", $Menulio_Indenai)
$content = $content.Replace("Baltsaundo zvaigzdiu karas", "Baltsaundo " + $zvaigzdziu)
$content = $content.Replace("As Negerau", $As_Negerau)
$content = $content.Replace("Zemes Uztemimas", $Zemes_Uztemimas)
$content = $content.Replace("Saldytuve", $Saldytuve)
$content = $content.Replace("Isvarymo daina", $Isvarymo)

$content = $content.Replace("įrašųai,", "įrašai,")

# Fix wrong uppercase in middle of sentence (e.g. iS instead of is, RadviliSkio instead of Radviliškio)
$content = $content.Replace("Milda i" + $caron_s_hi + " Radvili" + $caron_s_hi + "kio", $Milda_is)

$enc = [System.Text.Encoding]::UTF8
[System.IO.File]::WriteAllText($path, $content, $enc)
Write-Host "Done. Fixed Lithuanian encoding in mp3.htm"

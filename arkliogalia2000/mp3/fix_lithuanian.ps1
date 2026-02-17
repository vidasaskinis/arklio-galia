# Fix corrupted Lithuanian chars (U+FFFD) in mp3.htm - ONLY link/body text, NOT href or src
# All strings built with [char] to avoid script encoding issues

$path = Join-Path $PSScriptRoot "mp3.htm"
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
    @("ie$X`kokit", $ieskokit)
)

foreach ($r in $replacements) {
    $content = $content.Replace($r[0], $r[1])
}

# Update charset to utf-8
$content = $content.Replace("charset=windows-1257", "charset=utf-8")

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

# Fix the ASCII placeholders to proper Lithuanian
$content = $content.Replace("Saruno vezimelis", $Saruno_vezimelis)
$content = $content.Replace("Zaklinos kloaka", $Zaklinos)
$content = $content.Replace("Menulio Indenai", $Menulio_Indenai)
$content = $content.Replace("Baltsaundo zvaigzdiu karas", "Baltsaundo " + $zvaigzdziu)
$content = $content.Replace("As Negerau", $As_Negerau)
$content = $content.Replace("Zemes Uztemimas", $Zemes_Uztemimas)
$content = $content.Replace("Saldytuve", $Saldytuve)
$content = $content.Replace("Isvarymo daina", $Isvarymo)

# Fix wrong uppercase in middle of sentence (e.g. iS instead of is, RadviliSkio instead of Radviliškio)
$content = $content.Replace("Milda i" + $caron_s_hi + " Radvili" + $caron_s_hi + "kio", $Milda_is)

[System.IO.File]::WriteAllText($path, $content, $enc)
Write-Host "Done. Fixed Lithuanian encoding in mp3.htm"

<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  <xsl:variable name="characters" select="'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  <xsl:variable name="accents" select="'áéíóúÁÉÍÓÚâêôÂÊÎÔÛûãõÃÕàèìòùÀÈÌÒÙç'"/>
  <xsl:variable name="accentsEnglish" select="'aeiouAEIOUaeoAEIOUuaoAOaeiouAEIOUc'"/>

  <xsl:template name="ColourLookup">
    <xsl:param name="colour"/>
    <xsl:param name="language"/>
    <xsl:if test="$language = 'nat'">
      <xsl:choose>
        <xsl:when test="$colour = 1">
          <xsl:text>B</xsl:text>
        </xsl:when>
        <xsl:when test="$colour = 3">
          <xsl:text>E</xsl:text>
        </xsl:when>
        <xsl:when test="$colour = 4">
          <xsl:text>V</xsl:text>
        </xsl:when>
        <xsl:when test="$colour = 5">
          <xsl:text>Az</xsl:text>
        </xsl:when>
        <xsl:when test="$colour = 6">
          <xsl:text>A</xsl:text>
        </xsl:when>
        <xsl:when test="$colour = 9">
          <xsl:text>Âmb</xsl:text>
        </xsl:when>
        <xsl:when test="$colour = 10">
          <xsl:text>Viol</xsl:text>
        </xsl:when>
        <xsl:when test="$colour = 11">
          <xsl:text>Alr</xsl:text>
        </xsl:when>
      </xsl:choose>
    </xsl:if>

    <xsl:if test="$language = 'eng'">
       <xsl:choose>
        <xsl:when test="$colour = 1">
          <xsl:text>W</xsl:text>
        </xsl:when>
        <xsl:when test="$colour = 3">
          <xsl:text>R</xsl:text>
        </xsl:when>
        <xsl:when test="$colour = 4">
          <xsl:text>G</xsl:text>
        </xsl:when>
        <xsl:when test="$colour = 5">
          <xsl:text>Bu</xsl:text>
        </xsl:when>
        <xsl:when test="$colour = 6">
          <xsl:text>Y</xsl:text>
        </xsl:when>
        <xsl:when test="$colour = 9">
          <xsl:text>Y | Am</xsl:text>
        </xsl:when>
        <xsl:when test="$colour = 10">
          <xsl:text>Vi</xsl:text>
        </xsl:when>
        <xsl:when test="$colour = 11">
          <xsl:text>Y | Or</xsl:text>
        </xsl:when>
      </xsl:choose>
      </xsl:if>
  
  </xsl:template>

  <xsl:template name="ColourNameToAbbrev">
    <xsl:param name="colour"/>
    <xsl:param name="language"/>

    <xsl:choose>
      <xsl:when test="$language = 'eng' ">
        <xsl:value-of select="translate(normalize-space($colour), $uppercase, $smallcase)"/>
      </xsl:when>

      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="translate(normalize-space($colour), $uppercase, $smallcase) = 'branca' ">
            <xsl:text>B</xsl:text>
          </xsl:when>
          <xsl:when test="translate(normalize-space($colour), $uppercase, $smallcase) = 'preto' ">
            <xsl:text>Preto - UNDEFINED</xsl:text>
          </xsl:when>
          <xsl:when
            test="translate(normalize-space($colour), $uppercase, $smallcase) = 'encarnada' ">
            <xsl:text>E</xsl:text>
          </xsl:when>
          <xsl:when test="translate(normalize-space($colour), $uppercase, $smallcase) = 'verde' ">
            <xsl:text>V</xsl:text>
          </xsl:when>
          <xsl:when test="translate(normalize-space($colour), $uppercase, $smallcase) = 'azul' ">
            <xsl:text>Az</xsl:text>
          </xsl:when>
          <xsl:when test="translate(normalize-space($colour), $uppercase, $smallcase) = 'amarela' ">
            <xsl:text>A</xsl:text>
          </xsl:when>
          <xsl:when test="translate(normalize-space($colour), $uppercase, $smallcase) = 'cinza' ">
            <xsl:text>Cinza - UNDEFINED</xsl:text>
          </xsl:when>
          <xsl:when test="translate(normalize-space($colour), $uppercase, $smallcase) = 'castanho' ">
            <xsl:text>Castanho - UNDEFINED</xsl:text>
          </xsl:when>
          <xsl:when test="translate(normalize-space($colour), $uppercase, $smallcase) = 'âmbar' ">
            <xsl:text>Âmb</xsl:text>
          </xsl:when>
          <xsl:when test="translate(normalize-space($colour), $uppercase, $smallcase) = 'violeta' ">
            <xsl:text>Viol</xsl:text>
          </xsl:when>
          <xsl:when
            test="translate(normalize-space($colour), $uppercase, $smallcase) = 'alaranjada' ">
            <xsl:text>Alr</xsl:text>
          </xsl:when>
          <xsl:when test="translate(normalize-space($colour), $uppercase, $smallcase) = 'magenta' ">
            <xsl:text>Magenta - UNDEFINED</xsl:text>
          </xsl:when>
          <xsl:when
            test="translate(normalize-space($colour), $uppercase, $smallcase) = 'cor-de-rosa' ">
            <xsl:text>Cor-de-rosa - UNDEFINED</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise> UNDEFINED </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="LitchrLookup">
    <xsl:param name="litchr"/>
    <xsl:param name="language"/>
    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$litchr = 1">
            <xsl:text>F</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 2">
            <xsl:text>Lp</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 3">
            <xsl:text>LpL</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 4">
            <xsl:text>R</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 5">
            <xsl:text>MR</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 6">
            <xsl:text>UR</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 7">
            <xsl:text>Iso </xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 8">
            <xsl:text>Oc</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 9">
            <xsl:text>Rin</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 10">
            <xsl:text>MRin</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 11">
            <xsl:text>URIn</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 12">
            <xsl:text>Mo</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 13">
            <xsl:text>FLp</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 14">
            <xsl:text>Lp.LpL</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 15">
            <xsl:text>Oc.Lp</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 16">
            <xsl:text>F.Lpl</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 17">
            <xsl:text>Oc.Alt</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 18">
            <xsl:text>LpL.Alt</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 19">
            <xsl:text>Lp.Alt</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 20">
            <xsl:text>Alt.</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 25">
            <xsl:text>R.LpL</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 26">
            <xsl:text>MR.LpL</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 27">
            <xsl:text>UR.LpL</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 28">
            <xsl:text>Alt</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 29">
            <xsl:text>F.Alt.Lp</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$litchr = 1">
            <xsl:text>F</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 2">
            <xsl:text>Fl</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 3">
            <xsl:text>LFl</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 4">
            <xsl:text>Q</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 5">
            <xsl:text>VQ</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 6">
            <xsl:text>UQ</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 7">
            <xsl:text>Iso </xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 8">
            <xsl:text>Oc</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 9">
            <xsl:text>IQ</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 10">
            <xsl:text>IVQ</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 11">
            <xsl:text>IUQ</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 12">
            <xsl:text>Mo</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 13">
            <xsl:text>FFl</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 14">
            <xsl:text>Fl LFl</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 15">
            <xsl:text>Oc Fl</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 16">
            <xsl:text>F LFl</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 17">
            <xsl:text>Oc Al</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 18">
            <xsl:text>LFl Al</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 19">
            <xsl:text>Fl Al</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 20">
            <xsl:text>Al</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 25">
            <xsl:text>Q LF1</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 26">
            <xsl:text>VQ LF1</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 27">
            <xsl:text>UQ LFl</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 28">
            <xsl:text>Al</xsl:text>
          </xsl:when>
          <xsl:when test="$litchr = 29">
            <xsl:text>F Al LFl</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="ColourDescLookup">
    <xsl:param name="language"/>
    <xsl:param name="colourValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$colourValue = 1 ">
            <xsl:text>Branca</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 2">
            <xsl:text>Preto</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 3">
            <xsl:text>Encarnada</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 4">
            <xsl:text>Verde</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 5">
            <xsl:text>Azul</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 6">
            <xsl:text>Amarela</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 7">
            <xsl:text>Cinza</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 8">
            <xsl:text>Castanho</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 9">
            <xsl:text>Âmbar</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 10">
            <xsl:text>Violeta</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 11">
            <xsl:text>Alaranjada</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 12">
            <xsl:text>Magenta</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 13">
            <xsl:text>Cor-de-rosa</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>

      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$colourValue = 1 ">
            <xsl:text>White</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 2">
            <xsl:text>Black</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 3">
            <xsl:text>Red</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 4">
            <xsl:text>Green</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 5">
            <xsl:text>Blue</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 6">
            <xsl:text>Yellow</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 7">
            <xsl:text>Grey</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 8">
            <xsl:text>Brown</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 9">
            <xsl:text>Amber</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 10">
            <xsl:text>Violet</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 11">
            <xsl:text>Orange</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 12">
            <xsl:text>Magenta</xsl:text>
          </xsl:when>
          <xsl:when test="$colourValue = 13">
            <xsl:text>Pink</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatlitLokoup">
    <xsl:param name="language"/>
    <xsl:param name="catlitValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$catlitValue = 1">
            <xsl:text>Luz direcional</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 4">
            <xsl:text>Luz Alinhamento</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 5">
            <xsl:text>Aerofarol</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 6">
            <xsl:text>Luz de obstrução aérea</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 7">
            <xsl:text>Luz detectora de nevoeiro</xsl:text>
          </xsl:when>

          <xsl:when test="$catlitValue = 8">
            <xsl:text>Holofote</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 9">
            <xsl:text>Luz em forma de faixa</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 10">
            <xsl:text>Luz secundária</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 11">
            <xsl:text>Holofote</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 12">
            <xsl:text>Anterior</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 13">
            <xsl:text>Posterior</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 14">
            <xsl:text>Inferior</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 15">
            <xsl:text>Superior</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 16">
            <xsl:text>Efeito de Moiré</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 17">
            <xsl:text>Emergência</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 18">
            <xsl:text>Luz de Marcação</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 19">
            <xsl:text>disposição horizontal</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 20">
            <xsl:text>disposição vertical</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$catlitValue = 1">
            <!--<xsl:text>Directional function</xsl:text>-->
            <xsl:text>Dir</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 4">
            <xsl:text>Leading light</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 5">
            <xsl:text>Aero</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 6">
            <xsl:text>Air obstruction light</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 7">
            <xsl:text>Fog detector light</xsl:text>
          </xsl:when>

          <xsl:when test="$catlitValue = 8">
            <xsl:text>Flood light</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 9">
            <xsl:text>Strip light</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 10">
            <xsl:text>Subsidiary light</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 11">
            <xsl:text>Spotlight</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 12">
            <xsl:text>Front</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 13">
            <xsl:text>Rear</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 14">
            <xsl:text>Lower</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 15">
            <xsl:text>Upper</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 16">
            <xsl:text>moiré effect</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 17">
            <xsl:text>Reserve light</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 18">
            <xsl:text>Bearing light</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 19">
            <xsl:text>Horizontally disposed</xsl:text>
          </xsl:when>
          <xsl:when test="$catlitValue = 20">
            <xsl:text>Vertically disposed</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="BcnshpLookup">
    <xsl:param name="language"/>
    <xsl:param name="bcnshpValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$bcnshpValue = 1">
            <xsl:text>Estaca, poste, suporte</xsl:text>
          </xsl:when>
          <xsl:when test="$bcnshpValue = 2">
            <xsl:text>Vara fina</xsl:text>
          </xsl:when>
          <xsl:when test="$bcnshpValue = 3">
            <xsl:text>Torres-baliza</xsl:text>
          </xsl:when>
          <xsl:when test="$bcnshpValue = 4">
            <xsl:text>Baliza em trelica</xsl:text>
          </xsl:when>
          <xsl:when test="$bcnshpValue = 5">
            <xsl:text>Baliza Pilar</xsl:text>
          </xsl:when>
          <xsl:when test="$bcnshpValue = 6">
            <xsl:text>Monte artificial de pedras</xsl:text>
          </xsl:when>
          <xsl:when test="$bcnshpValue = 7">
            <xsl:text>Baliza Flutuante </xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$bcnshpValue = 1">
            <xsl:text>Pole</xsl:text>
          </xsl:when>
          <xsl:when test="$bcnshpValue = 2">
            <xsl:text>Withy</xsl:text>
          </xsl:when>
          <xsl:when test="$bcnshpValue = 3">
            <xsl:text>Framework tower</xsl:text>
          </xsl:when>
          <xsl:when test="$bcnshpValue = 4">
            <xsl:text>Lattice beacon</xsl:text>
          </xsl:when>
          <xsl:when test="$bcnshpValue = 5">
            <xsl:text>Pile beacon</xsl:text>
          </xsl:when>
          <xsl:when test="$bcnshpValue = 6">
            <xsl:text>Cairn</xsl:text>
          </xsl:when>
          <xsl:when test="$bcnshpValue = 7">
            <xsl:text>Buoyant beacon </xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatofpLookup">
    <xsl:param name="language"/>
    <xsl:param name="catofpValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$catofpValue = 1">
            <xsl:text>Torre de perfuração</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 2">
            <xsl:text>Plataforma de produção  de petróleo</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 3">
            <xsl:text>Plataforma  de pesquisa / observação</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 4">
            <xsl:text>Plataforma de amarração</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 5">
            <xsl:text>Bóia de amarração</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 6">
            <xsl:text>Amarração torre</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 7">
            <xsl:text>Ilha artificial</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 8">
            <xsl:text>FPSO</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 9">
            <xsl:text>plataforma de alojamento</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 10">
            <xsl:text>NCCB</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$catofpValue = 1">
            <xsl:text>Oil derrick / rig</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 2">
            <xsl:text>Production platform</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 3">
            <xsl:text>Observation / research platform</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 4">
            <xsl:text>Articulated loading platform (AFL)</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 5">
            <xsl:text>Single anchor leg mooring (SALM)</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 6">
            <xsl:text>Mooring tower</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 7">
            <xsl:text>Artificial island</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 8">
            <xsl:text>FPSO</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 9">
            <xsl:text>Accommodation platform</xsl:text>
          </xsl:when>
          <xsl:when test="$catofpValue = 10">
            <xsl:text>NCCB</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatpleLookup">
    <xsl:param name="language"/>
    <xsl:param name="catpleValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$catpleValue = 1">
            <xsl:text>Estaca</xsl:text>
          </xsl:when>
          <xsl:when test="$catpleValue = 3">
            <xsl:text>Poste</xsl:text>
          </xsl:when>
          <xsl:when test="$catpleValue = 4">
            <xsl:text>Tripodal</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$catpleValue = 1">
            <xsl:text>Stake</xsl:text>
          </xsl:when>
          <xsl:when test="$catpleValue = 3">
            <xsl:text>Post</xsl:text>
          </xsl:when>
          <xsl:when test="$catpleValue = 4">
            <xsl:text>Tripodal</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatsilLookup">
    <xsl:param name="language"/>
    <xsl:param name="catsilValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$catsilValue = 1">
            <xsl:text>Silo em geral</xsl:text>
          </xsl:when>
          <xsl:when test="$catsilValue = 2">
            <xsl:text>Tanque em geral</xsl:text>
          </xsl:when>
          <xsl:when test="$catsilValue = 3">
            <xsl:text>Elevador de grãos</xsl:text>
          </xsl:when>
          <xsl:when test="$catsilValue = 4">
            <xsl:text>Caixa-d´água</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$catsilValue = 1">
            <xsl:text>Silo in general</xsl:text>
          </xsl:when>
          <xsl:when test="$catsilValue = 2">
            <xsl:text>Tank in general</xsl:text>
          </xsl:when>
          <xsl:when test="$catsilValue = 3">
            <xsl:text>Grain elevator</xsl:text>
          </xsl:when>
          <xsl:when test="$catsilValue = 4">
            <xsl:text>Water tower</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="BuishpLookup">
    <xsl:param name="language"/>
    <xsl:param name="buishpValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$buishpValue = 5">
            <xsl:text>Edificio alto</xsl:text>
          </xsl:when>
          <xsl:when test="$buishpValue = 6">
            <xsl:text>Pirâmide</xsl:text>
          </xsl:when>
          <xsl:when test="$buishpValue = 7">
            <xsl:text>Cilíndrica</xsl:text>
          </xsl:when>
          <xsl:when test="$buishpValue = 8">
            <xsl:text>Esférica</xsl:text>
          </xsl:when>
          <xsl:when test="$buishpValue = 9">
            <xsl:text>Cúbico</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$buishpValue = 5">
            <xsl:text>High-rise building</xsl:text>
          </xsl:when>
          <xsl:when test="$buishpValue = 6">
            <xsl:text>Pyramid</xsl:text>
          </xsl:when>
          <xsl:when test="$buishpValue = 7">
            <xsl:text>Cylindrical</xsl:text>
          </xsl:when>
          <xsl:when test="$buishpValue = 8">
            <xsl:text>Spherical</xsl:text>
          </xsl:when>
          <xsl:when test="$buishpValue = 9">
            <xsl:text>cubic</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="ColpatLookup">
    <xsl:param name="language"/>
    <xsl:param name="colpatValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$colpatValue = 1">
            <xsl:text>Listras horizontais</xsl:text>
          </xsl:when>
          <xsl:when test="$colpatValue = 2">
            <xsl:text>Listras verticais</xsl:text>
          </xsl:when>
          <xsl:when test="$colpatValue = 3">
            <xsl:text>Listras diagonais</xsl:text>
          </xsl:when>
          <xsl:when test="$colpatValue = 4">
            <xsl:text>Quadrado</xsl:text>
          </xsl:when>
          <xsl:when test="$colpatValue = 5">
            <xsl:text>Listras (direção desconhecida)</xsl:text>
          </xsl:when>
          <xsl:when test="$colpatValue = 6">
            <xsl:text>Margem listrada</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$colpatValue = 1">
            <xsl:text>Horizontal stripes</xsl:text>
          </xsl:when>
          <xsl:when test="$colpatValue = 2">
            <xsl:text>Vertical stripes</xsl:text>
          </xsl:when>
          <xsl:when test="$colpatValue = 3">
            <xsl:text>Diagonal stripes</xsl:text>
          </xsl:when>
          <xsl:when test="$colpatValue = 4">
            <xsl:text>Squared</xsl:text>
          </xsl:when>
          <xsl:when test="$colpatValue = 5">
            <xsl:text>Stripes (direction unknown)</xsl:text>
          </xsl:when>
          <xsl:when test="$colpatValue = 6">
            <xsl:text>Border stripe</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="NatconLookup">
    <xsl:param name="language"/>
    <xsl:param name="natconValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$natconValue = 1">
            <xsl:text>Alvenaria</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 2">
            <xsl:text>Concreto</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 3">
            <xsl:text>Matacão Solto</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 4">
            <xsl:text>Superfície dura</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 5">
            <xsl:text>Sem superfície</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 6">
            <xsl:text>De madeira</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 7">
            <xsl:text>Metal</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 8">
            <xsl:text>Vidro plástico reforçado</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 9">
            <xsl:text>Pintado</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$natconValue = 1">
            <xsl:text>Masonry</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 2">
            <xsl:text>Concrete</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 3">
            <xsl:text>Loose boulders</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 4">
            <xsl:text>Hard surfaced</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 5">
            <xsl:text>Unsurfaced</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 6">
            <xsl:text>Wooden</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 7">
            <xsl:text>Metal</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 8">
            <xsl:text>fibreglass</xsl:text>
          </xsl:when>
          <xsl:when test="$natconValue = 9">
            <xsl:text>Painted</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatlmkLookup">
    <xsl:param name="language"/>
    <xsl:param name="catlmkValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$catlmkValue = 1">
            <xsl:text>Monte artificial de pedras</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 2">
            <xsl:text>Cemitéiro</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 3">
            <xsl:text>Chaminé</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 4">
            <xsl:text>Dish aéreo</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 5">
            <xsl:text>Matro da bandeira</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 6">
            <xsl:text>Queimador</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 7">
            <xsl:text>mastro</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 8">
            <xsl:text>Biruta</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 9">
            <xsl:text>Monumento</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 10">
            <xsl:text>Coluna (pilar)</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 11">
            <xsl:text>Placa comemorativa</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 12">
            <xsl:text>Obelisco</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 13">
            <xsl:text>Estátua</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 14">
            <xsl:text>Cruzeiro</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 15">
            <xsl:text>Domo</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 16">
            <xsl:text>Radar de varredura</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 17">
            <xsl:text>Torre</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 18">
            <xsl:text>Moinho de vento</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 19">
            <xsl:text>Motor a vento</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 20">
            <xsl:text>Vértice (de igreja)</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 21">
            <xsl:text>Rocha grande ou Rocha no chão</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 22">
            <xsl:text>Rocha pináculo</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$catlmkValue = 1">
            <xsl:text>Cairn</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 2">
            <xsl:text>Cemetery</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 3">
            <xsl:text>Chimney</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 4">
            <xsl:text>Dish aerial</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 5">
            <xsl:text>Flagstaff</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 6">
            <xsl:text>Flare stack</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 7">
            <xsl:text>Mast</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 8">
            <xsl:text>Windsock</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 9">
            <xsl:text>Monument</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 10">
            <xsl:text>Column</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 11">
            <xsl:text>Memorial plaque</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 12">
            <xsl:text>Obelisk</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 13">
            <xsl:text>Statue</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 14">
            <xsl:text>Cross</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 15">
            <xsl:text>Dome</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 16">
            <xsl:text>Radar scanner</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 17">
            <xsl:text>Tower</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 18">
            <xsl:text>Windmill</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 19">
            <xsl:text>Windmotor</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 20">
            <xsl:text>Spire / minaret</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 21">
            <xsl:text>Large rock or boulder on land</xsl:text>
          </xsl:when>
          <xsl:when test="$catlmkValue = 22">
            <xsl:text>Rock pinnacle</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="LitvisLookup">
    <xsl:param name="language"/>
    <xsl:param name="litvisValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$litvisValue = 1">
            <xsl:text>Alta intensidade</xsl:text>
          </xsl:when>
          <xsl:when test="$litvisValue = 2">
            <xsl:text>Baixa intensidade</xsl:text>
          </xsl:when>
          <xsl:when test="$litvisValue = 3">
            <xsl:text>Fraco</xsl:text>
          </xsl:when>
          <xsl:when test="$litvisValue = 4">
            <xsl:text>Alta luminosidade</xsl:text>
          </xsl:when>
          <xsl:when test="$litvisValue = 5">
            <xsl:text>Baixa luminosidade</xsl:text>
          </xsl:when>
          <xsl:when test="$litvisValue = 6">
            <xsl:text>Visibilidade deliberadamente restrita</xsl:text>
          </xsl:when>
          <xsl:when test="$litvisValue = 7">
            <xsl:text>Obscurecido</xsl:text>
          </xsl:when>
          <xsl:when test="$litvisValue = 8">
            <xsl:text>Parcialmente obscurecido</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$litvisValue = 1">
            <xsl:text>High intensity</xsl:text>
          </xsl:when>
          <xsl:when test="$litvisValue = 2">
            <xsl:text>Low intensity</xsl:text>
          </xsl:when>
          <xsl:when test="$litvisValue = 3">
            <xsl:text>Faint</xsl:text>
          </xsl:when>
          <xsl:when test="$litvisValue = 4">
            <xsl:text>Intensified</xsl:text>
          </xsl:when>
          <xsl:when test="$litvisValue = 5">
            <xsl:text>Unintensified</xsl:text>
          </xsl:when>
          <xsl:when test="$litvisValue = 6">
            <xsl:text>Visibility deliberately restricted</xsl:text>
          </xsl:when>
          <xsl:when test="$litvisValue = 7">
            <xsl:text>Obscured</xsl:text>
          </xsl:when>
          <xsl:when test="$litvisValue = 8">
            <xsl:text>Partially obscured</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatcamLookup">
    <xsl:param name="language"/>
    <xsl:param name="catcamValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$catcamValue = 1">
            <xsl:text>Sinal cardinal norte</xsl:text>
          </xsl:when>
          <xsl:when test="$catcamValue = 2">
            <xsl:text>Sinal cardinal leste</xsl:text>
          </xsl:when>
          <xsl:when test="$catcamValue = 3">
            <xsl:text>Sinal cardinal sul</xsl:text>
          </xsl:when>
          <xsl:when test="$catcamValue = 4">
            <xsl:text>Sinal cardinal leste</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$catcamValue = 1">
            <xsl:text>North cardinal mark</xsl:text>
          </xsl:when>
          <xsl:when test="$catcamValue = 2">
            <xsl:text>East cardinal mark</xsl:text>
          </xsl:when>
          <xsl:when test="$catcamValue = 3">
            <xsl:text>South cardinal mark</xsl:text>
          </xsl:when>
          <xsl:when test="$catcamValue = 4">
            <xsl:text>West cardinal mark</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="TopshpLookup">
    <xsl:param name="language"/>
    <xsl:param name="topshpValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$topshpValue = 1">
            <xsl:text>cone </xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 2">
            <xsl:text>cone, apontando abaixo</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 3">
            <xsl:text>esfera</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 4">
            <xsl:text>2 esferas</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 5">
            <xsl:text>cilindro</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 6">
            <xsl:text>placa</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 7">
            <xsl:text>x-forma (A cruz de Santo André)</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 8">
            <xsl:text>cruz Vertical (Cruz de São Jorge)</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 9">
            <xsl:text>cubo, apontando para cima</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 10">
            <xsl:text>2 cones, ponto a ponto</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 11">
            <xsl:text>2 cones,  uma base para outra</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 12">
            <xsl:text>rombo (diamante)</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 13">
            <xsl:text>2 cones, (pontos para cima)</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 14">
            <xsl:text>2 cones, (pontos para baixo)</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 15">
            <xsl:text>estaca bombordo</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 16">
            <xsl:text>estaca boreste</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 17">
            <xsl:text>bandeira</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 18">
            <xsl:text>esfera sobre rombo</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 19">
            <xsl:text>quadrado</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 20">
            <xsl:text>retângulo, horizontal</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 21">
            <xsl:text>retângulo, vertical</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 22">
            <xsl:text>trapézio, para cima</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 23">
            <xsl:text>trapézio, para baixo</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 24">
            <xsl:text>triângulo, apontando para cima</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 25">
            <xsl:text>triângulo, apontando abaixo</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 26">
            <xsl:text>círculo</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 27">
            <xsl:text>duas cruzes verticais (uma sobre a outra)</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 28">
            <xsl:text>t-forma</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 29">
            <xsl:text>triângulo apontando para cima sobre um círculo</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 30">
            <xsl:text>vertical atravessando um circulo</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 31">
            <xsl:text>rhombus sobre um círculo</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 32">
            <xsl:text>círculo sobre um triângulo apontando para cima</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 33">
            <xsl:text>outra forma (ver INFROM)</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$topshpValue = 1">
            <xsl:text>Topmark, cone, point up</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 2">
            <xsl:text>Topmark, cone, point down</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 3">
            <xsl:text>Topmark, sphere</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 4">
            <xsl:text>Topmark, 2 spheres</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 5">
            <xsl:text>Cylindrical Topmark</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 6">
            <xsl:text>Topmark, board</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 7">
            <xsl:text>x-shape (St. Andrew's cross)</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 8">
            <xsl:text>Topmark, upright cross (St George's cross)</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 9">
            <xsl:text>Topmark, cube, point up</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 10">
            <xsl:text>Topmark,  2 cones, point to point</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 11">
            <xsl:text>Topmark, 2 cones,  base to base</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 12">
            <xsl:text>Topmark, rhombus</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 13">
            <xsl:text>Topmark, 2 cones, (points upward)</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 14">
            <xsl:text>Topmark, 2 cones, (points downward)</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 15">
            <xsl:text>Topmark, besom, point up</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 16">
            <xsl:text>>Topmark, besom, point down</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 17">
            <xsl:text>>Topmark, flag</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 18">
            <xsl:text>Topmark, sphere over rhombus</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 19">
            <xsl:text>Topmark, square</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 20">
            <xsl:text>Topmark, rectangle, horizontal</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 21">
            <xsl:text>Topmark, rectangle, vertical</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 22">
            <xsl:text>Topmark, trapezium, up</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 23">
            <xsl:text>Topmark, trapezium, down</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 24">
            <xsl:text>Topmark, triangle, point up</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 25">
            <xsl:text>Topmark, triangle, point down</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 26">
            <xsl:text>Topmark, circle</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 27">
            <xsl:text>Topmark, two upright crosses (one over the other)</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 28">
            <xsl:text>Topmark, t-shape</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 29">
            <xsl:text>Topmark, triangle pointing up over a circle</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 30">
            <xsl:text>Topmark, upright cross over a circle</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 31">
            <xsl:text>Topmark, rhombus over a circle</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 32">
            <xsl:text>Topmark, circle over a triangle pointing up</xsl:text>
          </xsl:when>
          <xsl:when test="$topshpValue = 33">
            <xsl:text>Topmark, other shape (see INFROM)</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="StatusLookup">
    <xsl:param name="language"/>
    <xsl:param name="statusValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$statusValue = 1">
            <xsl:text>Permanente</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 2">
            <xsl:text>Occas</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 3">
            <xsl:text>Recomendado</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 4">
            <xsl:text>Fora de uso</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 5">
            <xsl:text>Periódico / intermitente</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 6">
            <xsl:text>Reservado</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 7">
            <xsl:text>Temporário</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 8">
            <xsl:text>Particular</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 9">
            <xsl:text>Obrigatório</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 11">
            <xsl:text>extinta</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 12">
            <xsl:text>Iluminado</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 13">
            <xsl:text>Histórico</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 14">
            <xsl:text>Público</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 15">
            <xsl:text>Sincronizado</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 16">
            <xsl:text>guarnição</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 17">
            <xsl:text>Sem guarnição</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 18">
            <xsl:text>Existência duvidosa</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$statusValue = 1">
            <xsl:text>Permanent</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 2">
            <xsl:text>Occas</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 3">
            <xsl:text>Recommended</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 4">
            <xsl:text>Not in use</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 5">
            <xsl:text>Periodic / intermittent</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 6">
            <xsl:text>Reserved</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 7">
            <xsl:text>Temporary</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 8">
            <xsl:text>Private</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 9">
            <xsl:text>Mandatory</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 11">
            <xsl:text>Extinguished</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 12">
            <xsl:text>Floodlit</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 13">
            <xsl:text>Historic</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 14">
            <xsl:text>Public</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 15">
            <xsl:text>Synchronized</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 16">
            <xsl:text>Watched</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 17">
            <xsl:text>Un-watched</xsl:text>
          </xsl:when>
          <xsl:when test="$statusValue = 18">
            <xsl:text>Existence doubtful</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatrosLookup">
    <xsl:param name="language"/>
    <xsl:param name="catrosValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$catrosValue = 1">
            <xsl:text>Radiofarol circular</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 2">
            <xsl:text>Radiofarol direcional</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 3">
            <xsl:text>Radiofarol rotativo</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 4">
            <xsl:text>Baliza consol</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 5">
            <xsl:text>Estação radiogoniométrica</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 6">
            <xsl:text>Estação rádio costeira com serviço QTG</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 7">
            <xsl:text>Radiofarol aeronáutico</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 8">
            <xsl:text>Decca</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 9">
            <xsl:text>Loran C</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 10">
            <xsl:text>Sistema de posicionamento global diferencial</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 11">
            <xsl:text>Toran</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 12">
            <xsl:text>Omega</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 13">
            <xsl:text>Syledis</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 14">
            <xsl:text>Chaika</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$catrosValue = 1">
            <xsl:text>Circular(non directional) marine or aero-marine radiobeacon</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 2">
            <xsl:text>Directional radiobeacon</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 3">
            <xsl:text>Rotating-pattern radiobeacon</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 4">
            <xsl:text>Consol beacon</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 5">
            <xsl:text>Radio direction-finding station</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 6">
            <xsl:text>Coast radio station providing QTG service</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 7">
            <xsl:text>Aeronautical radiobeacon</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 8">
            <xsl:text>Decca</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 9">
            <xsl:text>Loran C</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 10">
            <xsl:text>Differential GPS</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 11">
            <xsl:text>Toran</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 12">
            <xsl:text>Omega</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 13">
            <xsl:text>Syledis</xsl:text>
          </xsl:when>
          <xsl:when test="$catrosValue = 14">
            <xsl:text>Chaika</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="FunctnLookup">
    <xsl:param name="language"/>
    <xsl:param name="functnValue"/>

    <xsl:choose>
      <xsl:when test="$language = 'nat'">
        <xsl:choose>
          <xsl:when test="$functnValue = 1">
            <xsl:text>Capitania dos portos</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 2">
            <xsl:text>Alfândega, Aduana</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 3">
            <xsl:text>Posto de saúde</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 4">
            <xsl:text>Posto de saúde</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 5">
            <xsl:text>Hospital</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 6">
            <xsl:text>Agência de correios</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 7">
            <xsl:text>Hotel</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 8">
            <xsl:text>Estação de trem</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 9">
            <xsl:text>Delegacia de polícia</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 10">
            <xsl:text>Estação de água da polícia</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 11">
            <xsl:text>Posto de observação</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 13">
            <xsl:text>agência bancária</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 14">
            <xsl:text>Sede para o controle de distrito</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 15">
            <xsl:text>Armazém, Galpão</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 16">
            <xsl:text>Fábrica</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 17">
            <xsl:text>Estação de energia</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 18">
            <xsl:text>Administrativo</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 19">
            <xsl:text>instituição de ensino</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 20">
            <xsl:text>Igreja</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 21">
            <xsl:text>Capela</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 22">
            <xsl:text>Templo</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 23">
            <xsl:text>pagode</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 24">
            <xsl:text>Santuário xintosía</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 25">
            <xsl:text>Templo budista</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 26">
            <xsl:text>Mesquita</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 27">
            <xsl:text>Marabuto</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 28">
            <xsl:text>Observação</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 29">
            <xsl:text>comunicação</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 30">
            <xsl:text>televisão</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 31">
            <xsl:text>Rádio</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 32">
            <xsl:text>Radar</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 33">
            <xsl:text>Suporte de luz</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 34">
            <xsl:text>Microonda</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 35">
            <xsl:text>Arrefecimento</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 36">
            <xsl:text>Observação</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 37">
            <xsl:text>quadra</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 38">
            <xsl:text>Relógio</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 39">
            <xsl:text>Controle</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 40">
            <xsl:text>Ancorar hidroavião</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 41">
            <xsl:text>Estádio</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 42">
            <xsl:text>rodoviária</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$language = 'eng'">
        <xsl:choose>
          <xsl:when test="$functnValue = 1">
            <xsl:text>no function/service of major interest</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 2">
            <xsl:text>Harbour-master's office</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 3">
            <xsl:text>Custom office</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 4">
            <xsl:text>Health office</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 5">
            <xsl:text>Hospital</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 6">
            <xsl:text>Post office</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 7">
            <xsl:text>Hotel</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 8">
            <xsl:text>Railway station</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 9">
            <xsl:text>Police station</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 10">
            <xsl:text>Water-police station</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 11">
            <xsl:text>Pilot office</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 13">
            <xsl:text>Bank office</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 14">
            <xsl:text>Headquarters for district control</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 15">
            <xsl:text>Transit shed/warehouse</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 16">
            <xsl:text>Factory</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 17">
            <xsl:text>Power Station</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 18">
            <xsl:text>Administrative</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 19">
            <xsl:text>Educational facility</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 20">
            <xsl:text>Church</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 21">
            <xsl:text>Chapel</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 22">
            <xsl:text>Temple</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 23">
            <xsl:text>Pagoda</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 24">
            <xsl:text>Shinto Shrine</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 25">
            <xsl:text>Buddhist Temple</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 26">
            <xsl:text>Mosque</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 27">
            <xsl:text>Marabout</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 28">
            <xsl:text>Lookout</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 29">
            <xsl:text>Communication</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 30">
            <xsl:text>Television</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 31">
            <xsl:text>Radio</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 32">
            <xsl:text>Radar</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 33">
            <xsl:text>Light support</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 34">
            <xsl:text>Microwave</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 35">
            <xsl:text>Cooling</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 36">
            <xsl:text>Observation</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 37">
            <xsl:text>Timeball</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 38">
            <xsl:text>Clock</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 39">
            <xsl:text>Control</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 40">
            <xsl:text>Airship mooring</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 41">
            <xsl:text>Stadium</xsl:text>
          </xsl:when>
          <xsl:when test="$functnValue = 42">
            <xsl:text>Bus station</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="morseCodeLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 'A' ">
        <xsl:text>. -</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'B' ">
        <xsl:text>- . . .</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'C' ">
        <xsl:text>- . - .</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'D' ">
        <xsl:text>- . .</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'E' ">
        <xsl:text>.</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'F' ">
        <xsl:text>. . - .</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'G' ">
        <xsl:text>- - .</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'H' ">
        <xsl:text>. . . .</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'I' ">
        <xsl:text>. . </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'J' ">
        <xsl:text>. - - - </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'K' ">
        <xsl:text>- . -</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'L' ">
        <xsl:text>. - . .</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'M' ">
        <xsl:text>- - </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'N' ">
        <xsl:text>- .</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'O' ">
        <xsl:text>- - -</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'P' ">
        <xsl:text>. - - .</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'Q' ">
        <xsl:text>- - . -</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'R' ">
        <xsl:text>. - .</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'S' ">
        <xsl:text>. . .</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'T' ">
        <xsl:text>-</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'U' ">
        <xsl:text>. . -</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'V' ">
        <xsl:text>. . . -</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'W' ">
        <xsl:text>. - -</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'X' ">
        <xsl:text>- . . -</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'Y' ">
        <xsl:text>- . - -</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 'Z' ">
        <xsl:text>- - . .</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="OrientLookup">
    <xsl:param name="value"/>

    <xsl:choose>
      <xsl:when test="$value = 0">
        <xsl:text>N</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 22.5">
        <xsl:text>NE</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 45">
        <xsl:text>ENE</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 67.5">
        <xsl:text>E</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 90">
        <xsl:text>ESE</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 112.5">
        <xsl:text>SE</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 135">
        <xsl:text>SSE</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 180">
        <xsl:text>S</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 202.5">
        <xsl:text>SSW</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 225">
        <xsl:text>SW</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 247.5">
        <xsl:text>WSW</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 270">
        <xsl:text>W</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 292.5">
        <xsl:text>WNW</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 315">
        <xsl:text>NW</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 337.5">
        <xsl:text>NNW</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatachLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>unrestricted anchorage</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>deep water anchorage</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>tanker anchorage</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>explosives anchorage</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>quarantine anchorage</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>sea-plane anchorage</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>small craft anchorage</xsl:text>
      </xsl:when>
      <xsl:when test="$value =8">
        <xsl:text>small craft mooring area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>anchorage for periods up to 24 hours</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>anchorage for a limited period of time</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatairLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>military airplane airport</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>civil airplane airport</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>military heliport</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>civil heliport</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>glider airfield</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>small planes airfield</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>helicopter platform</xsl:text>
      </xsl:when>
      <xsl:when test="$value =8">
        <xsl:text>emergency airfield</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>Search and Rescue</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatbrgLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>fixed bridge</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>opening bridge</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>swing bridge</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>lifting bridge</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>bascule bridge</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>pontoon bridge</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>draw bridge</xsl:text>
      </xsl:when>
      <xsl:when test="$value =8">
        <xsl:text>transporter bridge</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>footbridge</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>viaduct</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>aqueduct</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>suspension bridge</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatdpgLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>general dumping ground</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>chemical wastes dumping ground</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>nuclear wastes dumping ground</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>explosives dumping ground</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>spoil ground</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>vessel dumping ground</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catcblLookup">
    <xsl:param name="value"/>
    <!--  <xsl:param name="type" /> -->
    <xsl:choose>
      <xsl:when test="$value = 1">
        <!-- 	<xsl:if test="$type='full'"> -->
        <xsl:text>power line</xsl:text>
        <!-- </xsl:if> -->
        <!-- <xsl:if test="$type='abbr'">
		  <xsl:text>PL</xsl:text>
		</xsl:if> -->
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>telephone/telegraph</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>transmission line</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>telephone</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>telegraph</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>mooring cable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>data transmission</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 502">
        <xsl:text>fibre optic</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CathafLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>RoRo-terminal</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>timber yard</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>ferry terminal</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>fishing harbour</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>yacht harbour/marina</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>naval base</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>tanker terminal</xsl:text>
      </xsl:when>
      <xsl:when test="$value =8">
        <xsl:text>passenger terminal</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>shipyard</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>container terminal</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>bulk terminal</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>syncrolift</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>straddle carrier</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CaticeLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>fast ice</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>sea ice</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>growler area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>pancake ice</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>glacier</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>ice peak</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>pack ice</xsl:text>
      </xsl:when>
      <xsl:when test="$value =8">
        <xsl:text>polar ice</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CathlkLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>floating restaurant</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>historic ship</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>museum</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>accommodation</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>floating breakwater</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="cattssLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>IMO - adopted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>not IMO - adopted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="colourLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>W</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>B</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>R</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>G</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>Bu</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>Y</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>Y | Am</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>Vi</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>Y | Or</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catlLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>Cairn</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>Cemetery</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>Chimney</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>Dish aerial</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>Flagstaff</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>Flare stack</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 7">
        <xsl:text>Mast</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>Windsock</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>Monument</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>Column</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>Memorial plaque</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>Obelisk</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>Statue</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>Cross</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>Dome</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>Radar scanner</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>Tower</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>Windmill</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 19">
        <xsl:text>Windmotor</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 20">
        <xsl:text>Spire / minaret</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 21">
        <xsl:text>Large rock or boulder on land</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 22">
        <xsl:text>Rock pinnacle</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="bcnshpLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>Pole</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>Withy</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>Framework tower</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>Lattice beacon</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>Pile beacon</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>Cairn</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>Buoyant beacon </xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catsloLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>cutting</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>embankment</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>dune</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>hill</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>pingo</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>cliff</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>scree </xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catsilLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>Silo in general</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>Tank in general</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>Grain elevator</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>Water tower</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catcamLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>North cardinal mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>East cardinal mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>South cardinal mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>West cardinal mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatinbLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>catenary anchor leg mooring (CALM)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>single buoy mooring (SBM or SPM)</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="topshpbLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>cone, point up</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>cone, point down</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>sphere</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>2 spheres</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>cylinder</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>board</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>x-shape (St. Andrew's cross)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>upright cross (St George's cross)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>cube, point up</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>2 cones, point to point</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>2 cones,  base to base</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>rhombus</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>2 cones, (points upward)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>2 cones, (points downward)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>besom, point up</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>besom, point down</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>flag</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>sphere over rhombus</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 19">
        <xsl:text>square</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 20">
        <xsl:text>rectangle, horizontal</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 21">
        <xsl:text>rectangle, vertical</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 22">
        <xsl:text>trapezium, up</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 23">
        <xsl:text>trapezium, down</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 24">
        <xsl:text>triangle, point up</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 25">
        <xsl:text>triangle, point down</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 26">
        <xsl:text>circle</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 27">
        <xsl:text>two upright crosses (one over the other)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 28">
        <xsl:text>t-shape</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 29">
        <xsl:text>triangle pointing up over a circle</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 30">
        <xsl:text>upright cross over a circle</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 31">
        <xsl:text>rhombus over a circle</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 32">
        <xsl:text>circle over a triangle pointing up</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 33">
        <xsl:text>other shape (see INFROM)</xsl:text>

      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="convisLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>visually conspicuous</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>not visually conspicuous</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CattrkLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>based on a system of fixed marks</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>not based on a system of fixed marks</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="watlevLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>partly submerged at high water</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>always dry</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>always under water/submerged</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>covers and uncovers</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>awash</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>subject to inundation or flooding</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>floating</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catslcLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>breakwater</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>groyne</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>mole</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>pier (jetty)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>promenade pier</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>wharf (quay)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>training wall</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>rip rap</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>revetment</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>sea wall</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>landing stairs</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>ramp</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>slipway</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>fender</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>solid face wharf</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>open face wharf</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>log ramp</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>wharf (quay)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 502">
        <xsl:text>natural obstruction</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catbuaLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>urban area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>settlement</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>village</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>town</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>city</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>holiday village</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>native settlement</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatlitLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 'UNDEFINED'"/>
      <xsl:when test="$value = 1">
        <xsl:text>directional function</xsl:text>

      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>rear/upper light</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>front/lower light</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>leading light</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>aero light</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>air obstruction light</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>fog detector light</xsl:text>
      </xsl:when>
      <xsl:when test="$value =8">
        <xsl:text>flood light</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>strip light</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>subsidiary light</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>spotlight</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>front</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>rear</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>lower</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>upper</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>moire effect</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>Reserve</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>bearing light</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 19">
        <xsl:text>horizontally disposed</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 20">
        <xsl:text>vertically disposed</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>Marine Light</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatlLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>cairn</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>cemetery</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>chimney</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>dish aerial</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>flagstaff</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>flare stack</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>mast</xsl:text>
      </xsl:when>
      <xsl:when test="$value =8">
        <xsl:text>wind sock</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>monument</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>column</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>memorial plaque</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>obelisk</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>statue</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>cross</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>dome</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>radar scanner</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>tower</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>windmill</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 19">
        <xsl:text>windmotor</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 20">
        <xsl:text>spire/minaret</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 21">
        <xsl:text>large rock or boulder on land</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 22">
        <xsl:text>rock pinnacle</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatlndLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>fen</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>marsh</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>moor/bog</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>heathland</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>mountain range</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>lowlands</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>canyon lands</xsl:text>
      </xsl:when>
      <xsl:when test="$value =8">
        <xsl:text>paddy field</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>agricultural land</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>savanna/grassland</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>parkland</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>swamp</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>landslide</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>lava flow</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>salt pan</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>moraine</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>crater</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>cave</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 19">
        <xsl:text>rock column or pinnacle</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 20">
        <xsl:text>cay</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 501">
        <xsl:text>beach</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 502">
        <xsl:text>backshore</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 503">
        <xsl:text>foreshore</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 504">
        <xsl:text>ice cliff</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 505">
        <xsl:text>snowfield / icefield</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 506">
        <xsl:text>tundra</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 507">
        <xsl:text>esker</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 508">
        <xsl:text>fault</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 509">
        <xsl:text>geothermal feature</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 510">
        <xsl:text>mountain pass</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 511">
        <xsl:text>rock strata / rock formation</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 512">
        <xsl:text>volcano</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 513">
        <xsl:text>cleared way / firebreak</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 514">
        <xsl:text>land sub</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatmpaLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>practice area in general</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>torpedo exercise area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>submarine exercise area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>firing danger area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>mine-laying practice area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>small arms firing range</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>ACLANT) grid</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 502">
        <xsl:text>Surface Danger Area</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 503">
        <xsl:text>JMC Areas - JENOA grid</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 504">
        <xsl:text>practice and exercise area (surface fleet)</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 505">
        <xsl:text>stovepipe</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 506">
        <xsl:text>safe bottoming area</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 507">
        <xsl:text>submarine danger area</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 508">
        <xsl:text>testing and evaluation range</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 509">
        <xsl:text>range</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 510">
        <xsl:text>impact area</xsl:text>
      </xsl:when>


      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="CatoLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>oil derrick/rig</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>production platform</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>observation/research platform</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>articulated loading platform (ALP)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>single anchor leg mooring (SALM)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>mooring tower</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>artificial island</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 8">
        <xsl:text>floating production, storage and off-loading vessel (FPSO)</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 9">
        <xsl:text>accommodation platform</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 10">
        <xsl:text>navigation, communication and control buoy (NCCB)</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="CatmorLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>dolphin</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>deviation dolphin</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>bollard</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>tie-up wall</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>post or pile</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>chain/wire/cable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>mooring buoy</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>fast patrol boat waiting position</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatpipLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>pipeline in general</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>outfall pipe</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>intake pipe</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>sewer</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>bubbler system</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>supply pipe</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="CatreaLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>offshore safety zone</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>anchoring prohibition area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>fishing prohibition area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>nature reserve</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>bird sanctuary</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>game preserve</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>seal sanctuary</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>degaussing range</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>military area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>historic wreck restricted area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>inshore traffic zone</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>navigational aid safety zone</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>danger of stranding area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>minefield</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>diving prohibition area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>area to be avoided</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>prohibited area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>swimming area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 19">
        <xsl:text>waiting area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 20">
        <xsl:text>research area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 21">
        <xsl:text>dredging area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 22">
        <xsl:text>fish sanctuary</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 23">
        <xsl:text>ecological reserve</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 24">
        <xsl:text>no wake area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 25">
        <xsl:text>swinging area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 26">
        <xsl:text>water skiing area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 27">
        <xsl:text>Environmentally Sensitive Sea Area (ESSA)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 28">
        <xsl:text>Particularly Sensitive Sea Area (PSSA)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>Maritime notification area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 502">
        <xsl:text>Mine danger area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatrLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>circular (non-directional) marine or aero-marine radiobeacon</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>directional radiobeacon</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>rotating-pattern radiobeacon</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>consol beacon</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>radio direction-finding station</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>coast radio station providing QTG service</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>aeronautical radiobeacon</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>Decca</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>Loran C</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>Differential GPS</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>Toran</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>Omega</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>Syledis</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>Chaika</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>GSM</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 502">
        <xsl:text>MSI broadcast station</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 503">
        <xsl:text>Locator (LO)</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 504">
        <xsl:text>Distance Measuring Equipment (DME)</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 505">
        <xsl:text>Non-Directional Radio Beacon (NDB)</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 506">
        <xsl:text>Radar Responder Beacon (RACON)</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 507">
        <xsl:text>Radar Responder Beacon (RAMARK)</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 508">
        <xsl:text>VHF Omni Directional Radio Range (VOR)</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 509">
        <xsl:text>VHF Omni Directional (VORTAC)</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 510">
        <xsl:text>Tactical Air Navigational Equipment (TACAN)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 511">
        <xsl:text>Localiser/Distance Measuring Equipment (LOC/DME)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatpraLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>quarry</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>mine</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>stockpile</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>power station area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>refinery area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>timber yard</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>factory area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>tank farm</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>wind farm</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>slag heap/spoil heap</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 501">
        <xsl:text>production area in general</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 502">
        <xsl:text>substation/transformer yard</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 504">
        <xsl:text>oil/gas facilities</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 505">
        <xsl:text>thermal power station</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 506">
        <xsl:text>salt evaporator</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 507">
        <xsl:text>pumping station</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 508">
        <xsl:text>oil/gas field</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatrscLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>rescue station with lifeboat</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>rescue station with rocket</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>rescue station with lifeboat and rocket</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>refuge for shipwrecked mariners</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>refuge for intertidal area walkers</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>lifeboat lying at a mooring</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>aid radio station</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>first aid equipment</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatrodLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>motorway</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>major road</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>minor road</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>track/path</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>major street</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>minor street</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>crossing</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>interchange</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 502">
        <xsl:text>trail</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 503">
        <xsl:text>primary route</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 504">
        <xsl:text>secondary route</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatsrfLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>visitor's berth</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>nautical club</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>boat hoist</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>sailmaker</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>boatyard</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>public inn</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>restaurant</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>chandler</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>provisions</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>doctor</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>pharmacy</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>water tap</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>fuel station</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>electricity</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>bottled gas</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>showers</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>laundrette</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>public toilets</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 19">
        <xsl:text>post box</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 20">
        <xsl:text>public telephone</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 21">
        <xsl:text>refuse bin</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 22">
        <xsl:text>car park</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 23">
        <xsl:text>parking for boats and trailers</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 24">
        <xsl:text>caravan site</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 25">
        <xsl:text>camping site</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 26">
        <xsl:text>sewage pump-out station</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 27">
        <xsl:text>emergency telephone</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 28">
        <xsl:text>landing/launching place for boats</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 29">
        <xsl:text>visitors mooring</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 30">
        <xsl:text>scrubbing berth</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 31">
        <xsl:text>picnic area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 32">
        <xsl:text>mechanics workshop</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 33">
        <xsl:text>guard and/or security service</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatsitLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>port control</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>port entry and departure</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>International Port Traffic</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>berthing</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>dock</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>lock</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>flood barrage</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>bridge passage</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>dredging </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>traffic control light</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catcanLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>transportation</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>drainage</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>irrigation</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="cat_tsLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>flood stream</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>ebb stream</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>other tidal flow</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Undetermined or Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value =703">
        <xsl:text>Not Applicable </xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catrunLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>aeroplane runway</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>helicopter landing pad</xsl:text>
      </xsl:when>


    </xsl:choose>
  </xsl:template>

  <xsl:template name="catchpLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>custom</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>RV Location</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Undetermined or Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value =703">
        <xsl:text>Not Applicable </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="catnavLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>clearing line</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>transit line</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>leading line bearing a recommended track</xsl:text>
      </xsl:when>


    </xsl:choose>
  </xsl:template>

  <xsl:template name="litchLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>F</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>Fl</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>LFl</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>Q</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>VQ</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>UQ</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>Iso </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>Oc</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>IQ</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>IVQ</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>IUQ</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>Mo</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>FFl</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>Fl LFl</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>Oc Fl</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>F LFl</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>Oc Al</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>LFl Al</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 19">
        <xsl:text>Fl Al</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 20">
        <xsl:text>Al</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 25">
        <xsl:text>Q LF1</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 26">
        <xsl:text>VQ LF1</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 27">
        <xsl:text>UQ LFl</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 28">
        <xsl:text>Al</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 29">
        <xsl:text>F Al LFl</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Undetermined or Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value =703">
        <xsl:text>Not Applicable </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="jrsdtnLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>international</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>national</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>national sub-division</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>provincial</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>municipal</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>federal</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>NATO</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Undetermined or Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value =703">
        <xsl:text>Not Applicable </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="boyshpLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>conical</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>can</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>spherical</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>pillar</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>spar</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>barrel</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>super-buoy</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>ice buoy</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="catcrnLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>crane without specific construction</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>container crane/gantry</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>sheerleg</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>travelling crane</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>A-frame</xsl:text>
      </xsl:when>


    </xsl:choose>
  </xsl:template>

  <xsl:template name="catdamLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>weir</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>dam</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>flood barrage</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="condtnLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>under construction</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>ruined</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>under reclamation</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>wingless</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>planned construction</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>operational</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatsiwLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>danger</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>maritime obstruction</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>cable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>military practice</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>distress</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>weather</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>storm</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>ice</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>time </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>tide</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>tidal stream</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>tide gauge</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>tide scale</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>diving</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>water level gauge</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatcoaLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>steep coast</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>flat coast</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>sandy shore</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>stony shore</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>shingly shore</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>glacier (seaward end)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>mangrove</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>marshy shore</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>coral reef </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>ice coast</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>shelly shore</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatctrLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>triangulation point</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>spot</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>fixed point</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>benchmark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>boundary mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>horizontal control, main station</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>horizontal control, secondary station</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatconLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>aerial cable way (telepheric)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>belt conveyor</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatdisLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>distance mark not physically installed</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>visible mark: pole</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 3">
        <xsl:text>visible mark: board</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 4">
        <xsl:text>visible mark: undefined shape</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="traficLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>inbound</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>outbound</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>one-way</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>two-way</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatspmLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>firing danger area mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>target mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>marker ship mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>degaussing range mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>barge mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>cable mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>spoil ground mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>outfall mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>ODAS</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>recording mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>seaplane anchorage mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>recreation zone mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>private mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>mooring mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>LANBY</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>leading mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>measured distance mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>notice mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 19">
        <xsl:text>TSS mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 20">
        <xsl:text>anchoring prohibited mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 21">
        <xsl:text>berthing prohibited mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 22">
        <xsl:text>overtaking prohibited mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 23">
        <xsl:text>two-way traffic prohibited mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 24">
        <xsl:text>vessels must not generate waves mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 25">
        <xsl:text>speed limit mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 26">
        <xsl:text>leading mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 27">
        <xsl:text>general warning mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 28">
        <xsl:text>sound ship's siren` mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 29">
        <xsl:text>restricted vertical clearance mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 30">
        <xsl:text>maximum vessel's draught mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 31">
        <xsl:text>restricted horizontal clearance mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 32">
        <xsl:text>strong current warning mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 33">
        <xsl:text>berthing permitted mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 34">
        <xsl:text>overhead power cable mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 35">
        <xsl:text>channel edge gradient mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 36">
        <xsl:text>telephone mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 37">
        <xsl:text>ferry crossing mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 38">
        <xsl:text>marine traffic lights</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 39">
        <xsl:text>pipeline mark (sign)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 40">
        <xsl:text>anchorage mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 41">
        <xsl:text>clearing mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 42">
        <xsl:text>control mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 43">
        <xsl:text>diving mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 44">
        <xsl:text>refuge beacon</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 45">
        <xsl:text>foul ground mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 46">
        <xsl:text>yachting mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 47">
        <xsl:text>heliport mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 48">
        <xsl:text>GPS mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 49">
        <xsl:text>seaplane landing mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 50">
        <xsl:text>entry prohibited mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 51">
        <xsl:text>work in progress mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 52">
        <xsl:text>mark with unknown purpose</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 53">
        <xsl:text>wellhead mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 54">
        <xsl:text>channel separation mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 55">
        <xsl:text>marine farm mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 56">
        <xsl:text>artificial reef mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatvegLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>grass</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>paddy field</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>bush</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>deciduous wood</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>coniferous wood</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>wood in general</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>mangroves</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>park</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>parkland </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>mixed crops</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>reed</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>moss</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>tree in general</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>evergreen tree</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>coniferous tree</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>palm tree</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>nipa palm tree</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>casurina tree</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 19">
        <xsl:text>eucalypt tree</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 20">
        <xsl:text>deciduous tree</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 21">
        <xsl:text>mangrove tree</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 22">
        <xsl:text>filao tree</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>nursery</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 502">
        <xsl:text>orchard / plantation</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 503">
        <xsl:text>vineyards</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 504">
        <xsl:text>oasis</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 505">
        <xsl:text>bamboo/cane</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 506">
        <xsl:text>fallow land</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="ColoLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>white </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>black</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">

        <xsl:text>red</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>green</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>blue</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>yellow</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>grey</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>brown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>amber </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>violet</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>orange</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>magenta</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>pink</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatfogLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>Explosive </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>Diaphone</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">

        <xsl:text>Siren</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>Nautophone</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>Reed</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>Tyfon</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>Bell</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>Whistle</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>Gong </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>Horn</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="sigfrqLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>automatically </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>by wave action</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>by hand</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>by wind</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="ColpLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>horizontal bands from top to bottom</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>vertical stripes</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>diagonal stripes</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>squared</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>stripes (direction unknown)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>border stripe</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatforLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>castle</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>fort</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>battery</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>blockhouse</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>Martello tower</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>redoubt</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatgatLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>gate in general</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>flood barrage gate</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>caisson</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>lock gate</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>dyke gate</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>sluice</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatfifLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>fishing stake</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>fish trap</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>fish weir</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>tunny net</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatfryLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>free-moving ferry</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>cable ferry</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>ice ferry</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="BoyshpLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>conical</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>can</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>spherical</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>pillar</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>spar</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>barrel</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>super-buoy</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>ice buoy</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatlamLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>port-hand lateral mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>starboard-hand lateral mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>preferred channel to starboard lateral mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>preferred channel to port lateral mark</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown </xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="FuncLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>no function/service of major interest</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>harbour-master office</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>custom office</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>health office</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>hospital</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>post office</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>hotel</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>railway station</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>police station</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>water-police station</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>pilot office</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>pilot look-out</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>bank office</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>headquarters for district control</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>transit shed/warehouse</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>factory</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>power station</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>administrative</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 19">
        <xsl:text>educational facility</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 20">
        <xsl:text>church</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 21">
        <xsl:text>chapel</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 22">
        <xsl:text>temple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 23">
        <xsl:text>pagoda</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 24">
        <xsl:text>shinto-shrine</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 25">
        <xsl:text>buddhist temple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 26">
        <xsl:text>mosque</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 27">
        <xsl:text>marabout</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 28">
        <xsl:text>lookout</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 29">
        <xsl:text>communication</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 30">
        <xsl:text>television</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 31">
        <xsl:text>radio</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 32">
        <xsl:text>radar</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 33">
        <xsl:text>light support</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 34">
        <xsl:text>microwave</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 35">
        <xsl:text>cooling</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 36">
        <xsl:text>observation</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 37">
        <xsl:text>timeball</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 38">
        <xsl:text>clock</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 39">
        <xsl:text>control</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 40">
        <xsl:text>airship mooring</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 41">
        <xsl:text>stadium</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 42">
        <xsl:text>bus station</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>water treatment plant</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 502">
        <xsl:text>station (miscellaneous)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple </xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="LitvLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>high intensity</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>low intensity</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>faint</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>intensified</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>unintensified</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>visibility deliberately restricted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>obscured</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>partially obscured</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="NatcLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>masonry</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>concrete</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>loose boulders</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>hard surfaced</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>unsurfaced</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>wooden</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>metal</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>fibreglass</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>painted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>loose / unpaved</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 502">
        <xsl:text>loose / light</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 503">
        <xsl:text>hard / paved</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catobsLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>snag/stump</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>wellhead</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>diffuser</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>crib</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>fish haven</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>foul area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>foul ground</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>ice boom</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>ground tackle</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>boom</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>well protection structure</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 502">
        <xsl:text>subsea installation</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 503">
        <xsl:text>pipeline obstruction</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 504">
        <xsl:text>free standing conductor pipe</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 505">
        <xsl:text>manifold</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 506">
        <xsl:text>storage tank</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 507">
        <xsl:text>template</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 508">
        <xsl:text>pontoon</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 509">
        <xsl:text>sundry objects</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="NatquaLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>fine</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>medium</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>coarse</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>broken</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>sticky</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>soft</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>stiff</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>volcanic</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>calcareous</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>hard</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="NatsurLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>mud</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>clay</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>silt/ooze</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>sand</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>stone</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>gravel</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>pebbles</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>cobbles</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>rock</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>marsh</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>lava</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>snow</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>ice</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>coral</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>swamp</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>bog/moor</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>shells</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>boulder</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="ProdctLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>oil</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>gas</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>water</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>stone</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>coal</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>ore</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>chemicals</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>drinking water</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>milk</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>bauxite</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>coke</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>iron ingots</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>salt</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>sand</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>timber</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>sawdust/wood chips</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>scrap metal</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>liquified natural gas</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 19">
        <xsl:text>liquified petroleum gas</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 20">
        <xsl:text>wine</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 21">
        <xsl:text>cement</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 22">
        <xsl:text>grain</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>oil: crude and refined</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 502">
        <xsl:text>solid fuel</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 503">
        <xsl:text>flammable liquids and gases</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 504">
        <xsl:text>chemicals</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 505">
        <xsl:text>ferrous elements and ores: unrefined and refined</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 506">
        <xsl:text>non-ferrous elements and ores: unrefined and refined</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 507">
        <xsl:text>metal: concentrate and products</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 508">
        <xsl:text>minerals</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 509">
        <xsl:text>fertiliser: natural and products</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 510">
        <xsl:text>wood: unprocessed and products</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 511">
        <xsl:text>rubber</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 512">
        <xsl:text>clay products</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 513">
        <xsl:text>natural fibres and materials in general: unprocessed and products</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 514">
        <xsl:text>foodstuffs: solid</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 515">
        <xsl:text>foodstuffs: liquid</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 516">
        <xsl:text>foodstuffs: preserved</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 517">
        <xsl:text>general and mixed goods</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 518">
        <xsl:text>stone</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 519">
        <xsl:text>granular or powdery material</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 520">
        <xsl:text>machinery and mechanical parts</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 521">
        <xsl:text>construction materials</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 522">
        <xsl:text>vehicles</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 523">
        <xsl:text>aircraft</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 524">
        <xsl:text>railway: stock and construction materials</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 525">
        <xsl:text>portable buildings</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 526">
        <xsl:text>containers</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 527">
        <xsl:text>electronics</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 528">
        <xsl:text>plastic</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 529">
        <xsl:text>paint</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 530">
        <xsl:text>refuse and waste</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 531">
        <xsl:text>radioactive material</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 532">
        <xsl:text>armament</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 533">
        <xsl:text>personnel</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 534">
        <xsl:text>animals (land &amp; sea) and birds</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 535">
        <xsl:text>fish</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 536">
        <xsl:text>shellfish and crustaceans</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 537">
        <xsl:text>ballast</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 540">
        <xsl:text>diesel oil</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 541">
        <xsl:text>petrol/gasoline</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 542">
        <xsl:text>passengers</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="QuasouLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>depth known</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>depth unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>doubtful sounding</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>unreliable sounding</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>no bottom found at value shown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>least depth known</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>least depth unknown, safe clearance at value shown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>value reported (not surveyed)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>value reported (not confirmed)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>maintained depth</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>not regularly maintained</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="QuaposLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>surveyed</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>unsurveyed</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>inadequately surveyed</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>approximate</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>doubtful</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>unreliable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>reported (not surveyed)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>reported (not confirmed)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>estimated</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>precisely known</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>calculated</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="MarsysLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>IALA A</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>IALA B</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>modified U.S.</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>old U.S.</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>U.S. intracoastal waterway</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>U.S. uniform state</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>U.S. western rivers</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>SIGNI</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>no system</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="RestrnLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>anchoring prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>anchoring restricted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>fishing prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>fishing restricted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>trawling prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>trawling restricted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>entry prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>entry restricted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>dredging prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>dredging restricted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>diving prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>diving restricted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>no wake</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>area to be avoided</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>construction prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>discharging prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>discharging restricted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>industrial or mineral exploration/development prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 19">
        <xsl:text>industrial or mineral exploration/development restricted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 20">
        <xsl:text>drilling prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 21">
        <xsl:text>drilling restricted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 22">
        <xsl:text>removal of historical artifacts prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 23">
        <xsl:text>cargo transhipment (lightering) prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 24">
        <xsl:text>dragging prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 25">
        <xsl:text>stopping prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 26">
        <xsl:text>landing prohibited</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 27">
        <xsl:text>speed restricted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="StatLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>permanent</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>occasional</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>recommended</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>disused</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>periodic/intermittent</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>reserved</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 7">
        <xsl:text>temporary</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 8">
        <xsl:text>private</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 9">
        <xsl:text>mandatory</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 10">
        <xsl:text>destroyed/ruined</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 11">
        <xsl:text>extinguished</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>Floodlit</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>historic</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>public</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 15">
        <xsl:text>synchronized</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 16">
        <xsl:text>watched</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 17">
        <xsl:text>un-watched</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 18">
        <xsl:text>existence doubtful</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>active/in use</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 502">
        <xsl:text>claimed</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 503">
        <xsl:text>practice and/or exercise purposes</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 504">
        <xsl:text>recognised</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 505">
        <xsl:text>dead</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 506">
        <xsl:text>lifted</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 507">
        <xsl:text>mass grave</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 508">
        <xsl:text>exploration</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 509">
        <xsl:text>production</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 510">
        <xsl:text>suspended</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 511">
        <xsl:text>injection</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 512">
        <xsl:text>unspecified</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 513">
        <xsl:text>disputed</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 514">
        <xsl:text>designated</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 515">
        <xsl:text>on request</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 516">
        <xsl:text>dormant</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 517">
        <xsl:text>proposed</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 518">
        <xsl:text>abandoned</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 519">
        <xsl:text>grey zone</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 520">
        <xsl:text>indeterminate</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 521">
        <xsl:text>multilateral</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 522">
        <xsl:text>rules for transit passage apply</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 523">
        <xsl:text>voluntary</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 702">
        <xsl:text>Multiple</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="SurtypLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>reconnaissance/sketch survey</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>controlled survey</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>unsurveyed</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>examination survey</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>passage survey</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>remotely sensed</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catmfaLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>crustaceans</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>oyster/mussels</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>fish</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>seaweed</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>pearl culture farm</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catwedLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>kelp</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>sea weed</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>sea grass</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>sargasso</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 501">
        <xsl:text>Posidonia</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catwatLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>breakers</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>eddies</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>overfalls</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>tide rips</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>bombora</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catwrkLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>non-dangerous wreck</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>dangerous wreck</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>distributed remains of wreck</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>wreck showing mast/masts</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>wreck showing any portion of hull or superstructure</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="expsouLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>within the range of depth of surrounding depth area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>shoaler than range of depth of surrounding depth area</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>deeper than range of depth of surrounding depth area</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="catolbLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>oil retention (high pressure pipe)</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>floating oil barrier</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="catpleLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>stake</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>snag</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>post</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>tripodal</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="catpilLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>boarding by pilot-cruising vessel</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>boarding by helicopter</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>pilot comes out from shore</xsl:text>
      </xsl:when>


    </xsl:choose>
  </xsl:template>

  <xsl:template name="catpylLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>power transmission</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>telephone/telegraphic</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>arial cableway/sky</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>bridge</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>bridge pier</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatrasLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>radar surveillance station</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>coast radar station</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CatrtbLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>ramark, radar beacon transmitting continuously</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>racon, radar transponder beacon with morse identification</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>leading racon/radar transponder beacon</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>
  
      <xsl:template name="ConradLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>radar conspicuous</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>not radar conspicuous</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>Ra refl</xsl:text>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="TecsouLookup">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 1">
        <xsl:text>found by echo-sounder</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 2">
        <xsl:text>found by side scan sonar</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 3">
        <xsl:text>found by multi-beam</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 4">
        <xsl:text>found by diver</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 5">
        <xsl:text>found by lead-line</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 6">
        <xsl:text>swept by wire-drag</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 7">
        <xsl:text>found by laser</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 8">
        <xsl:text>swept by vertical acoustic system</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 9">
        <xsl:text>found by electromagnetic sensor</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 10">
        <xsl:text>photogrammetry</xsl:text>
      </xsl:when>

      <xsl:when test="$value = 11">
        <xsl:text>satellite imagery</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 12">
        <xsl:text>found by levelling</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 13">
        <xsl:text>swept by side-scan-sonar</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 14">
        <xsl:text>computer generated</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 701">
        <xsl:text>Unknown</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 703">
        <xsl:text>Not Applicable</xsl:text>
      </xsl:when>
      <xsl:when test="$value = 704">
        <xsl:text>Other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="ExclitLokoup">
    <xsl:param name="language"/>
    <xsl:param name="exclitValue"/>
    <xsl:choose>
      <xsl:when test="$exclitValue = 1">
        <xsl:text>Light shown without change of character</xsl:text>
      </xsl:when>
      <xsl:when test="$exclitValue = 2">
        <xsl:text>By day</xsl:text> 
      </xsl:when>
      <xsl:when test="$exclitValue = 3">
        <xsl:text>Fog light</xsl:text>
      </xsl:when>
      <xsl:when test="$exclitValue = 4">
        <xsl:text>By night</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:transform>

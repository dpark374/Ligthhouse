<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--	<xsl:output method="html" encoding="UTF-8" indent="yes" omit-xml-declaration="no" />-->
	<xsl:include href="lookups.xsl"/>
	
	<!-- Aliases to be converted to local language, master template uses the alias when generating strings -->
	<xsl:variable name="alias_From" select="'from'"/>
	<xsl:variable name="alias_To" select="'to'"/>
	<xsl:variable name="alias_and" select="'and'"/>
	<xsl:variable name="alias_with" select="'with'"/>

	<!-- Template to generate the description for a rock -->
	<xsl:template match="Feature[@acronym = 'UWTROC' ]">
		<xsl:variable name="final">
			<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
				<xsl:text>"</xsl:text>
				<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
				<xsl:text>" </xsl:text>
			</xsl:if>
			
			<!--<xsl:text>Underwater/awash rock </xsl:text>-->
			<xsl:text>Rock</xsl:text>
			
			<!--<xsl:variable name="natsval">
			<xsl:call-template name="NatsurLookup">
				<xsl:with-param name="value" select="Attributes/Attribute[@acronym='NATSUR' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>-->
			
			<!--<xsl:variable name="expsval">
			<xsl:call-template name="expsouLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='EXPSOU' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>-->
			
			<xsl:variable name="valsouval">
				<xsl:if test="./Attributes/Attribute[@acronym='VALSOU']/@value != '' ">
					<xsl:value-of select="./Attributes/Attribute[@acronym='VALSOU']/@value"/>
				</xsl:if>
			</xsl:variable>
			
			<xsl:if test="($valsouval!='') and ($valsouval!='UNKNOWN')">
				<xsl:text> </xsl:text>
				<xsl:value-of select="$valsouval"/>			
				<xsl:text>m </xsl:text>
			</xsl:if>
			<xsl:variable name="wl" select="Attributes/Attribute[@acronym='WATLEV' ]/@value"/>
			<xsl:variable name="watlval">
				<xsl:if test="$wl = 5 or $wl = 4">
					<xsl:call-template name="watlevLookup">
						<xsl:with-param name="value" select="$wl"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:variable>
			
			<xsl:if test="$watlval !=''">
				<xsl:text> (</xsl:text>
				<xsl:value-of select="$watlval"/>			
				<xsl:text>)</xsl:text>
			</xsl:if>
			
			<!--<xsl:variable name="quasval">
			<xsl:call-template name="QuasouLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='QUASOU' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>-->
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'ACHARE']">
		<xsl:variable name="final">
		<!-- If it has a acronym, include it in the description -->
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:variable name="catval">
			<xsl:call-template name="CatachLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATACH']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="resval">
			<xsl:call-template name="RestrnLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='RESTRN']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="staval">
			<xsl:call-template name="StatLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='STATUS']/@value"/>
			</xsl:call-template>
		</xsl:variable>
			<xsl:choose>
				<xsl:when test="normalize-space($catval)">
					<xsl:value-of select="$catval"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Anchorage area</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		<xsl:value-of select="concat(' (',$resval,',',$staval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'ACHBRT']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Anchor berth</xsl:text>
		<xsl:variable name="catval">
			<xsl:call-template name="CatachLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATACH']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($catval)">
			<xsl:value-of select="concat(' (',$catval,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'AIRARE']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Airport</xsl:text>
		<xsl:variable name="cataval">
			<xsl:call-template name="CatairLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATAIR']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($cataval)">
			<xsl:value-of select="concat(' (',$cataval,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BCNCAR']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Beacon </xsl:text>
		<xsl:variable name="catcamval">
			<xsl:call-template name="catcamLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATCAM']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="bcnshpval">
			<xsl:call-template name="bcnshpLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='BCNSHP']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($catcamval)">
			<xsl:value-of select="concat($catcamval,' ')"/>
		</xsl:if>
		<xsl:if test="normalize-space($bcnshpval)">
			<xsl:value-of select="concat('(',$bcnshpval,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BCNISD']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Beacon isolated danger </xsl:text>
		<xsl:variable name="shpval">
			<xsl:call-template name="bcnshpLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='BCNSHP']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($shpval)">
			<xsl:value-of select="concat(' (',$shpval, ')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BCNLAT']">
		<xsl:variable name="final">
			<xsl:if test="normalize-space(./Attributes/Attribute[@acronym='OBJNAM']/@value) != '' ">
				<xsl:text>"</xsl:text>
				<xsl:value-of select="normalize-space(./Attributes/Attribute[@acronym='OBJNAM']/@value)"/>
				<xsl:text>" </xsl:text>
			</xsl:if>
			<xsl:text>Beacon </xsl:text>
			<xsl:variable name="catlamval">
				<xsl:call-template name="CatlamLookup">
					<xsl:with-param name="value"
						select="Attributes/Attribute[@acronym='CATLAM']/@value"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="shpval">
				<xsl:call-template name="bcnshpLookup">
					<xsl:with-param name="value"
						select="Attributes/Attribute[@acronym='BCNSHP']/@value"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:if test="normalize-space($catlamval)">
				<xsl:value-of select="concat($catlamval,' ')"/>
			</xsl:if>
			<xsl:if test="normalize-space($shpval)">
				<xsl:value-of select="concat('(',$shpval,')')"/>
			</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BCNSAW']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Beacon safe water</xsl:text>
		<xsl:variable name="shpval">
			<xsl:call-template name="bcnshpLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='BCNSHP']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($shpval)">
			<xsl:value-of select="concat(' (',$shpval, ')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BCNSPP']">
		<xsl:variable name="final">
		<!-- Updated for two color codes -->
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Beacon special purpose,</xsl:text>
		<!-- Picked up the value from input into the variable -->
		<xsl:variable name="clrvalue" select="./Attributes/Attribute[@acronym='COLOUR']/@value"/>
		<xsl:choose>
			<xsl:when test="contains($clrvalue,',')">
				<xsl:call-template name="colourLookup">
					<xsl:with-param name="value" select="substring-before($clrvalue,',')"/>
				</xsl:call-template>
				<xsl:text>,</xsl:text>
				<xsl:call-template name="colourLookup">
					<xsl:with-param name="value" select="substring-after($clrvalue,',')"/>
				</xsl:call-template>
				<xsl:text>,</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="colourLookup">
					<xsl:with-param name="value" select="$clrvalue"/>
				</xsl:call-template>
				<xsl:text>,</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:variable name="catval">
			<xsl:call-template name="CatspmLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATSPM']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="shpval">
			<xsl:call-template name="bcnshpLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='BCNSHP' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($catval)">
			<xsl:value-of select="concat($catval,' ')"/>
		</xsl:if>
		<xsl:if test="normalize-space($shpval)">
			<xsl:value-of select="concat('(',$shpval,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BERTHS']">
		<xsl:if test="normalize-space(./Attributes/Attribute[@acronym='OBJNAM']/@value) != '' ">
			<xsl:text>Berth (</xsl:text>
			<xsl:value-of select="normalize-space(./Attributes/Attribute[@acronym='OBJNAM']/@value)"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BOYCAR']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Buoy </xsl:text>
		<xsl:variable name="catcamval">
			<xsl:call-template name="catcamLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATCAM']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="boyval">
			<xsl:call-template name="boyshpLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='BOYSHP']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($catcamval)">
			<xsl:value-of select="concat($catcamval,' ')"/>
		</xsl:if>
		<xsl:if test="normalize-space($boyval)">
			<xsl:value-of select="concat('(',$boyval, ')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BOYINB']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Buoy </xsl:text>
		<xsl:variable name="catinbval">
			<xsl:call-template name="CatinbLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATINB']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="boyval">
			<xsl:call-template name="boyshpLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='BOYSHP' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($catinbval)">
			<xsl:value-of select="concat($catinbval,' ')"/>
		</xsl:if>
		<xsl:if test="normalize-space($boyval)">
			<xsl:value-of select="concat('(',$boyval, ')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BOYISD']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Buoy isolated danger </xsl:text>

		<xsl:variable name="boyval">
			<xsl:call-template name="boyshpLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='BOYSHP' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($boyval)">
			<xsl:value-of select="concat('(',$boyval,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BOYLAT']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Buoy </xsl:text>
		<xsl:variable name="catlamval">
			<xsl:call-template name="CatlamLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATLAM']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="boyval">
			<xsl:call-template name="boyshpLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='BOYSHP']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($catlamval)">
			<xsl:value-of select="concat($catlamval,' ')"/>
		</xsl:if>
		<xsl:if test="normalize-space($boyval)">
			<xsl:value-of select="concat('(',$boyval, ')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BOYSAW']">
		<xsl:variable name="final">
			<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
				<xsl:text>"</xsl:text>
				<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
				<xsl:text>" </xsl:text>
			</xsl:if>
			<xsl:text>Buoy safe water </xsl:text>
			
			<xsl:variable name="boyval">
				<xsl:call-template name="boyshpLookup">
					<xsl:with-param name="value"
						select="./Attributes/Attribute[@acronym='BOYSHP']/@value"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:if test="normalize-space($boyval)">
				<xsl:value-of select="concat('(',$boyval,')')"/>
			</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BOYSPP']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Buoy special purpose,</xsl:text>
		<xsl:variable name="clrvalue" select="Attributes/Attribute[@acronym='COLOUR']/@value"/>
		<xsl:choose>
			<xsl:when test="contains($clrvalue,',')">
				<xsl:if test="not(substring-before($clrvalue,',')=1)">
					<xsl:call-template name="ColoLookup">
						<xsl:with-param name="value" select="substring-before($clrvalue,',')"/>
					</xsl:call-template>
					<xsl:text>,</xsl:text>
				</xsl:if>
				<xsl:if test="not(substring-after($clrvalue,',')=1)">
					<xsl:call-template name="ColoLookup">
						<xsl:with-param name="value" select="substring-after($clrvalue,',')"/>
					</xsl:call-template>
					<xsl:text>,</xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ColoLookup">
					<xsl:with-param name="value" select="$clrvalue"/>
				</xsl:call-template>
				<xsl:text>,</xsl:text>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:variable name="catval">
			<xsl:call-template name="CatspmLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATSPM' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="boyval">
			<xsl:call-template name="boyshpLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='BOYSHP' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($catval)">
			<xsl:value-of select="concat($catval,' ')"/>
		</xsl:if>
		<xsl:if test="normalize-space($boyval)">
			<xsl:value-of select="concat('(',$boyval,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BRIDGE']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:variable name="catval">
			<xsl:call-template name="CatbrgLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATBRG']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="vervalue">
			<xsl:if test="normalize-space(Attributes/Attribute[@acronym='VERCLR']/@value)">
				<xsl:value-of select="concat('with ', Attributes/Attribute[@acronym='VERCLR']/@value, 'm vertical/horizontal clearance')"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="horval">
			<xsl:if test="./Attributes/Attribute[@acronym='HORCLR']/@value != '' ">
				<xsl:if test="./Attributes/Attribute[@acronym='HORCLR']/@value != 'UNKNOWN'">
					<xsl:value-of select="./Attributes/Attribute[@acronym='HORCLR']/@value"/>
					<xsl:text>m </xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:variable>
		<xsl:if test="normalize-space($catval)">
			<xsl:value-of select="concat($catval,' ')"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="normalize-space($vervalue) and normalize-space($horval)">
				<xsl:value-of select="concat('(',$vervalue,',',$horval,')')"/>
			</xsl:when>
			<xsl:when test="normalize-space($vervalue) and not(normalize-space($horval))">
				<xsl:value-of select="concat('(',$vervalue,')')"/>
			</xsl:when>
			<xsl:when test="not(normalize-space($vervalue)) and normalize-space($horval)">
				<xsl:value-of select="concat('(',$horval,')')"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BUAARE']">
		<xsl:variable name="final">
		<xsl:choose>
			<xsl:when test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
				<xsl:text>"</xsl:text>
				<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
				<xsl:text>" </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Built-up area</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:variable name="catbatuaval">
			<xsl:call-template name="catbuaLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATBUA' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' ',$catbatuaval)"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'BUISGL']">
		<xsl:variable name="final">
		<xsl:choose>
			<xsl:when test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
				<xsl:text>"</xsl:text>
				<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
				<xsl:text>" </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Building </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:variable name="funLcval">
			<xsl:call-template name="FuncLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='FUNCTN']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($funLcval)">
			<xsl:value-of select="concat('(',$funLcval,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CANALS']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Canal</xsl:text>
		<xsl:variable name="catcaval">
			<xsl:call-template name="catcanLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATCAN' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($catcaval)">
			<xsl:value-of select="concat(' (',$catcaval,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CANBNK']">
		<xsl:text>Canal bank </xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CAUSWY']">
		<xsl:variable name="final">
		<xsl:text>Causeway</xsl:text>
		<xsl:variable name="watlval">
			<xsl:call-template name="watlevLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='WATLEV' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($watlval)">
		<xsl:value-of select="concat(' ','(',$watlval,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CBLARE']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:variable name="catcval">
			<xsl:call-template name="catcblLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATCBL' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="resval">
			<xsl:call-template name="RestrnLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='RESTRN' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="normalize-space($catcval) and normalize-space($resval)">
				<xsl:value-of select="concat('Cable area (',$catcval,',',$resval,')')"/>
			</xsl:when>
			<xsl:when test="normalize-space($catcval) and not(normalize-space($resval))">
				<xsl:value-of select="concat('Cable area (',$catcval,')')"/>
			</xsl:when>
			<xsl:when test="not(normalize-space($catcval)) and normalize-space($resval)">
				<xsl:value-of select="concat('Cable area (',$resval,')')"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CBLOHD']">
		<xsl:variable name="final">
		<xsl:variable name="catcval">
			<xsl:call-template name="catcblLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATCBL' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="vervalue">
			<xsl:choose>
				<xsl:when test="normalize-space(Attributes/Attribute[@acronym='VERCLR']/@value)">
					<xsl:value-of
						select="concat(' with ', Attributes/Attribute[@acronym='VERCLR']/@value, 'm vertical clearance')"/>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="concat('Cable, overhead ',$catcval,',',$vervalue)"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CBLSUB']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:variable name="catcval">
			<xsl:call-template name="catcblLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATCBL' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="vervalue">
			<xsl:choose>
				<xsl:when test="normalize-space(Attributes/Attribute[@acronym='VERCLR']/@value)">
					<xsl:value-of
						select="concat(' with ', Attributes/Attribute[@acronym='VERCLR']/@value, 'm vertical clearance')"/>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="concat('Cable, submarine ',$catcval,',',$vervalue)"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CGUSTA']">
		<xsl:variable name="final">
		<xsl:text>Coastguard station </xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
				<!--<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:if test="normalize-space($inforvalue)">
			<xsl:value-of select="concat('(',$inforvalue,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CHKPNT']">
		<xsl:variable name="final">
		<xsl:text>Checkpoint</xsl:text>
		<xsl:variable name="catchval">
			<xsl:call-template name="catchpLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATCHP' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="normalize-space($catchval) and normalize-space($inforvalue)">
				<xsl:value-of select="concat(' (',$catchval,',',$inforvalue,')')"/>
			</xsl:when>
			<xsl:when test="not(normalize-space($catchval)) and normalize-space($inforvalue)">
				<xsl:value-of select="concat(' (',$inforvalue,')')"/>
			</xsl:when>
			<xsl:when test="normalize-space($catchval) and not(normalize-space($inforvalue))">
				<xsl:value-of select="concat(' (',$catchval,')')"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'COALNE']">
		<xsl:variable name="final">
		<xsl:text>Coastline</xsl:text>
		<xsl:variable name="catcohval">
			<xsl:call-template name="CatcoaLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATCOA' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="(normalize-space($catcohval)) and (normalize-space($inforvalue))">
				<xsl:value-of select="concat(' (',$catcohval,',',$inforvalue,')')"/>
			</xsl:when>
			<xsl:when test="not(normalize-space($catcohval)) and (normalize-space($inforvalue))">
				<xsl:value-of select="concat(' (',$inforvalue,')')"/>
			</xsl:when>
			<xsl:when test="(normalize-space($catcohval)) and not(normalize-space($inforvalue))">
				<xsl:value-of select="concat(' (',$catcohval,')')"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CONVYR']">
		<xsl:variable name="final">
		<xsl:text>Conveyor</xsl:text>
		<xsl:variable name="catconhval">
			<xsl:call-template name="CatconLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATCON' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="vervalue">
			<xsl:if test="normalize-space(Attributes/Attribute[@acronym='VERCLR']/@value)">
				 <xsl:value-of select="concat(Attributes/Attribute[@acronym='VERCLR']/@value, 'm ')"/> 
			</xsl:if>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="normalize-space($catconhval) and normalize-space($vervalue)">
				<xsl:value-of select="concat(' ','(',$catconhval,',',$vervalue,')')"/>
			</xsl:when>
			<xsl:when test="not(normalize-space($catconhval)) and normalize-space($vervalue)">
				<xsl:value-of select="concat(' ','(',$vervalue,')')"/>
			</xsl:when>
			<xsl:when test="normalize-space($catconhval) and not(normalize-space($vervalue))">
				<xsl:value-of select="concat(' ','(',$catconhval,')')"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CONZNE']">
		<xsl:variable name="final">
		<xsl:text>Contiguous zone</xsl:text>
		<xsl:variable name="nativalue">
			<xsl:if test="Attributes/Attribute[@acronym='NATION']/@value != ''">
				<!--<xsl:value-of select=" Attributes/Attribute[@acronym='NATION']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'see Note'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$nativalue,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'COSARE']">
		<xsl:variable name="final">
		<xsl:text>Continental shelf area</xsl:text>
		<xsl:variable name="nativalue">
			<xsl:if test="Attributes/Attribute[@acronym='NATION']/@value != ''">
				<!--<xsl:value-of select=" Attributes/Attribute[@acronym='NATION']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'see Note'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$nativalue,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CRANES']">
		<xsl:variable name="final">
		<xsl:text>Crane</xsl:text>
		<xsl:variable name="catcrval">
			<xsl:call-template name="catcrnLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATCRN' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="lifvalue">
			<xsl:if test="Attributes/Attribute[@acronym='LIFCAP']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='LIFCAP']/@value"/>
				<xsl:value-of select="'t'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="normalize-space($catcrval) and normalize-space($lifvalue)">
				<xsl:value-of select="concat(' (',$catcrval,',',$lifvalue,')')"/>
			</xsl:when>
			<xsl:when test="$catcrval != ''">
				<xsl:value-of select="concat(' (',$catcrval,')')"/>
			</xsl:when>
			<xsl:when test="$lifvalue != ''">
				<xsl:value-of select="concat(' (',$lifvalue,')')"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CTNARE']">
		<xsl:variable name="final">
		<xsl:text>Caution area</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'see Note'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$inforvalue !='' and $txtvalue !=''">
				<xsl:value-of select="concat(' (',$inforvalue,',',$txtvalue,')')"/>
			</xsl:when>
			<xsl:when test="$inforvalue !=''">
				<xsl:value-of select="concat(' (',$inforvalue,')')"/>
			</xsl:when>
			<xsl:when test="$txtvalue !=''">
				<xsl:value-of select="concat(' (',$txtvalue,')')"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CTRPNT']">
		<xsl:variable name="final">
		<xsl:text>Control point</xsl:text>
		<xsl:variable name="catctval">
			<xsl:call-template name="CatctrLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATCTR' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($catctval)">
			<xsl:value-of select="concat(' (',$catctval,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CTSARE']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> Cargo transhipment area</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="normalize-space($inforvalue) and normalize-space($txtvalue)">
				<xsl:value-of select="concat(' (',$inforvalue,',',$txtvalue,')')"/>
			</xsl:when>
			<xsl:when test="not(normalize-space($inforvalue)) and normalize-space($txtvalue)">
				<xsl:value-of select="concat(' (',$txtvalue,')')"/>
			</xsl:when>
			<xsl:when test="normalize-space($inforvalue) and not(normalize-space($txtvalue))">
				<xsl:value-of select="concat(' (',$inforvalue,')')"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CURENT']">
		<xsl:variable name="final">
		<xsl:text>Current - non-gravitational</xsl:text>
		<xsl:variable name="curvvalue">
			<xsl:if test="Attributes/Attribute[@acronym='CURVEL']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='CURVEL']/@value"/>
				<xsl:value-of select="'Kn'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="orievalue">
			<xsl:if test="Attributes/Attribute[@acronym='ORIENT']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='ORIENT']/@value"/>
				<xsl:text>°</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$curvvalue,',',$orievalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'CUSZNE']">
		<xsl:variable name="final">
		<xsl:text>Custom zone</xsl:text>
		<xsl:variable name="nativalue">
			<xsl:if test="Attributes/Attribute[@acronym='NATION']/@value != ''">
				<!--<xsl:value-of select=" Attributes/Attribute[@acronym='NATION']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'see Note'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$nativalue,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'DAMCON']">
		<xsl:variable name="final">
		<xsl:text>Dam</xsl:text>
		<xsl:variable name="catdatval">
			<xsl:call-template name="catdamLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATDAM' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($catdatval)">
			<xsl:value-of select="concat(' (',$catdatval,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'DAYMAR']">
		<xsl:variable name="final">
		<xsl:value-of select="'Daymark '"/>
		<xsl:variable name="colouval">
			<xsl:call-template name="ColoLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='COLOUR' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="topsval">
			<xsl:call-template name="topshpbLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='TOPSHP' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="natcval">
			<xsl:call-template name="NatcLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='NATCON' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="catval">
			<xsl:call-template name="CatspmLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATSPM' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat($colouval ,'(',$topsval,',',$natcval,',',$catval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'DEPARE']">
		<xsl:text>Depth area</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'DEPCNT']">
		<xsl:text>Depth contour</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'DISMAR']">
		<xsl:variable name="final">
		<!-- <xsl:text>Distance mark</xsl:text> -->
		<xsl:variable name="catdival">
			<xsl:call-template name="CatdisLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATDIS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:if test="normalize-space($inforvalue)">
			<xsl:value-of select="concat(' (',$inforvalue,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'DMPGRD']">
<xsl:variable name="final">
		<xsl:variable name="catval">
			<xsl:call-template name="CatdpgLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATDPG' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="staval">
			<xsl:call-template name="StatLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='STATUS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat($catval,'(',$staval,',',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'DOCARE']">
		<xsl:variable name="final">
		<xsl:text>Dock area</xsl:text>
		<xsl:variable name="condval">
			<xsl:call-template name="condtnLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CONDTN' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="normalize-space($condval) and normalize-space($inforvalue)">
				<xsl:value-of select="concat(' (',$condval,',',$inforvalue,')')"/>
			</xsl:when>
			<xsl:when test="not(normalize-space($condval)) and normalize-space($inforvalue)">
				<xsl:value-of select="concat(' (',$inforvalue,')')"/>
			</xsl:when>
			<xsl:when test="normalize-space($condval) and not(normalize-space($inforvalue))">
				<xsl:value-of select="concat(' (',$condval,')')"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'DRGARE']">
		<xsl:variable name="final">
		<xsl:text>Dredged area</xsl:text>
		<xsl:variable name="quasval">
			<xsl:call-template name="QuasouLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='QUASOU' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="drvavalue">
			<xsl:if test="Attributes/Attribute[@acronym='DRVAL1']/@value != ''">
				<xsl:if test="Attributes/Attribute[@acronym='DRVAL1']/@value != 'UNKNOWN'">
					<xsl:value-of select=" Attributes/Attribute[@acronym='DRVAL1']/@value"/>
					<xsl:text>m </xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$drvavalue,',',$inforvalue,',',$quasval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'DRYDOC']">
		<xsl:variable name="final">
		<xsl:text>Dry dock</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:if test="normalize-space($inforvalue)">
			<xsl:value-of select="concat(' (',$inforvalue,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'DWRTCL']">
		<xsl:variable name="final">
		<xsl:text>Deep water route centerline</xsl:text>
		<xsl:variable name="trafval">
			<xsl:call-template name="traficLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='TRAFIC' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="orievalue">
			<xsl:if test="Attributes/Attribute[@acronym='ORIENT']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='ORIENT']/@value"/>
				<xsl:text>°</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="cattrval">
			<xsl:call-template name="CattrkLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATTRK' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$trafval,',',$orievalue,',',$cattrval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'DWRTPT']">
		<xsl:variable name="final">
		<xsl:text>Deep water route part</xsl:text>
		<xsl:variable name="trafval">
			<xsl:call-template name="traficLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='TRAFIC' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="orievalue">
			<xsl:if test="Attributes/Attribute[@acronym='ORIENT']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='ORIENT']/@value"/>
				<xsl:text>°</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="cattrval">
			<xsl:call-template name="CattrkLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATTRK' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="drvavalue">
			<xsl:if test="Attributes/Attribute[@acronym='DRVAL1']/@value != ''">
				<xsl:if test="Attributes/Attribute[@acronym='DRVAL1']/@value != 'UNKNOWN'">
					<xsl:value-of select=" Attributes/Attribute[@acronym='DRVAL1']/@value"/>
					<xsl:text>m </xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of
			select="concat(' (',$trafval,',',$orievalue,',',$cattrval,',',$drvavalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'DYKCON']">
		<xsl:text>Dyke</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'EXEZNE']">
		<xsl:variable name="final">
		<xsl:text>Exclusive economic zone</xsl:text>
		<xsl:variable name="nativalue">
			<xsl:if test="Attributes/Attribute[@acronym='NATION']/@value != ''">
				<!--<xsl:value-of select=" Attributes/Attribute[@acronym='NATION']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'see Note'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$nativalue,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'FAIRWY']">
		<xsl:text>Fairway</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'FERYRT']">
		<xsl:variable name="final">
		<!-- <xsl:text>Ferry route</xsl:text> -->
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="catfrval">
			<xsl:call-template name="CatfryLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATFRY' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="normalize-space($catfrval) and normalize-space($inforvalue)">
				<xsl:value-of select="concat($catfrval ,'(',$inforvalue,')')"/>
			</xsl:when>
			<xsl:when test="(normalize-space($catfrval)) and not(normalize-space($inforvalue))">
				<xsl:value-of select="$catfrval"/>
			</xsl:when>
			<xsl:when test="not(normalize-space($catfrval)) and normalize-space($inforvalue)">
				<xsl:value-of select="concat('(',$inforvalue,')')"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'FLODOC']">
		<xsl:text>Floating dock</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'FNCLNE']">
		<xsl:text>Fence</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'FOGSIG']">
		<xsl:variable name="final">
		<xsl:element name="br"/>
		<xsl:call-template name="CatfogLookup">
			<xsl:with-param name="value"
				select="Attributes/Attribute[@acronym='CATFOG' ]/@value"/>
		</xsl:call-template>
		<xsl:variable name="sigpvalue">
			<xsl:if test="Attributes/Attribute[@acronym='SIGPER']/@value!= '' ">
				<xsl:value-of select="Attributes/Attribute[@acronym='SIGPER']/@value"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="sigvalue">
			<xsl:if test="Attributes/Attribute[@acronym='SIGGRP']/@value!= '' ">
				<xsl:value-of select="Attributes/Attribute[@acronym='SIGGRP']/@value"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="siggeval">
			<xsl:call-template name="sigfrqLookup">
				<xsl:with-param name="value" select="Attributes/Attribute[@acronym='SIGGEN']/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="normalize-space($sigpvalue) and normalize-space($sigvalue) and normalize-space($siggeval)">
				<xsl:value-of select="concat(' (',$sigpvalue,',',$sigvalue,',',$siggeval,')')"/>
			</xsl:when>
			<xsl:when test="not(normalize-space($sigpvalue)) and normalize-space($sigvalue) and normalize-space($siggeval)">
				<xsl:value-of select="concat(' (',$sigvalue,',',$siggeval,')')"/>
			</xsl:when>
			<xsl:when test="(normalize-space($sigpvalue)) and not(normalize-space($sigvalue)) and normalize-space($siggeval)">
				<xsl:value-of select="concat(' (',$sigpvalue,',',$siggeval,')')"/>
			</xsl:when>
			<xsl:when test="(normalize-space($sigpvalue)) and (normalize-space($sigvalue)) and not(normalize-space($siggeval))">
				<xsl:value-of select="concat(' (',$sigpvalue,',',$sigvalue,')')"/>
			</xsl:when>
			<xsl:when test="not(normalize-space($sigpvalue)) and not(normalize-space($sigvalue)) and normalize-space($siggeval)">
				<xsl:value-of select="concat(' (',$siggeval,')')"/>
			</xsl:when>
			<xsl:when test="not(normalize-space($sigpvalue)) and (normalize-space($sigvalue)) and not(normalize-space($siggeval))">
				<xsl:value-of select="concat(' (',$sigvalue,')')"/>
			</xsl:when>
			<xsl:when test="(normalize-space($sigpvalue)) and not(normalize-space($sigvalue)) and not(normalize-space($siggeval))">
				<xsl:value-of select="concat(' (',$sigpvalue,')')"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'FORSTC']">
		<xsl:variable name="final">
		<!-- <xsl:text>Fortified structure</xsl:text> -->
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:variable name="catforval">
			<xsl:call-template name="CatforLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATFOR' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' ',$catforval ,'(',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'FRPARE']">
		<xsl:text>Free port area</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'FSHFAC']">
		<!-- Finalized  as per spreadsheet -->
		<xsl:call-template name="CatfifLookup">
			<xsl:with-param name="value" select="Attributes/Attribute[@acronym='CATFIF']/@value"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'FSHGRD']">
		<xsl:text>Fishing ground</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'FSHZNE']">
		<xsl:variable name="final">
		<xsl:text>Fishery zone</xsl:text>
		<xsl:variable name="nativalue">
			<xsl:if test="Attributes/Attribute[@acronym='NATION']/@value != ''">
				<!--<xsl:value-of select=" Attributes/Attribute[@acronym='NATION']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'see Note'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$nativalue,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'GATCON']">
		<xsl:variable name="final">
		<xsl:text>Gate</xsl:text> 
		<xsl:variable name="catgaval">
			<xsl:call-template name="CatgatLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATGAT' ]/@value"/>
			</xsl:call-template>
			<xsl:text> </xsl:text>
		</xsl:variable>
		<xsl:variable name="horclvalue">
			<xsl:if test="Attributes/Attribute[@acronym='HORCLR']/@value != ''">
				<xsl:if test="Attributes/Attribute[@acronym='HORCLR']/@value != 'UNKNOWN'">
					<xsl:value-of select=" Attributes/Attribute[@acronym='HORCLR']/@value"/>
					<xsl:text>m </xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="(normalize-space($catgaval)) and (normalize-space($horclvalue))">
				<xsl:value-of select="concat($catgaval,'(',$horclvalue,')')"/>
			</xsl:when>
			<xsl:when test="not(normalize-space($catgaval)) and (normalize-space($horclvalue))">
				<xsl:value-of select="concat('(',$horclvalue,')')"/>
			</xsl:when>
			<xsl:when test="(normalize-space($catgaval)) and not(normalize-space($horclvalue))">
				<xsl:value-of select="$catgaval"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'GRIDRN']">
		<xsl:variable name="final">
		<xsl:text>Gridiron</xsl:text>
		<xsl:variable name="watlval">
			<xsl:call-template name="watlevLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='WATLEV' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="normalize-space($watlval) and normalize-space($inforvalue)">
				<xsl:value-of select="concat(' (',$watlval,',',$inforvalue,')')"/>
			</xsl:when>
			<xsl:when test="$inforvalue != ''">
				<xsl:value-of select="concat(' (',$inforvalue,')')"/>
			</xsl:when>
			<xsl:when test="$watlval != ''">
				<xsl:value-of select="concat(' (',$watlval,')')"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'HRBARE']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> Harbour area</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'see Note'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="normalize-space($inforvalue) and normalize-space($txtvalue)">
				<xsl:value-of select="concat(' (',$inforvalue,',',$txtvalue,')')"/>
			</xsl:when>
			<xsl:when test="not(normalize-space($inforvalue)) and normalize-space($txtvalue)">
				<xsl:value-of select="concat(' (',$txtvalue,')')"/>
			</xsl:when>
			<xsl:when test="normalize-space($inforvalue) and not(normalize-space($txtvalue))">
				<xsl:value-of select="concat(' (',$inforvalue,')')"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'HRBFAC']">
		<xsl:variable name="final">
		<!-- <xsl:text>Harbour facility</xsl:text> -->
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:variable name="cathaval">
			<xsl:call-template name="CathafLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATHAF' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' ', $cathaval,'(',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'HULKES']">
		<xsl:variable name="final">
		<xsl:text>Hulk</xsl:text>
		<xsl:variable name="cathlval">
			<xsl:call-template name="CathlkLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATHLK' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' ', '(',$cathlval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'ICEARE']">
		<xsl:variable name="final">
		<xsl:text>Ice area</xsl:text>
		<xsl:variable name="caticval">
			<xsl:call-template name="CaticeLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATICE' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' ', '(',$caticval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'ICNARE']">
		<xsl:variable name="final">
		<xsl:text>Incineration area</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' ', '(',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'ISTZNE']">
		<xsl:variable name="final">
		<xsl:text>Inshore traffic zone</xsl:text>
		<xsl:variable name="cattsval">
			<xsl:call-template name="cattssLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATTSS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$cattsval,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'LAKARE']">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<!-- <xsl:choose>
			<xsl:when test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
				<xsl:text>"</xsl:text>
				<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
				<xsl:text>"</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Lake</xsl:text>
			</xsl:otherwise>
		</xsl:choose> -->
		<xsl:text>Lake</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'LAKSHR']">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Lake shore</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'LIGHTS']">
		<xsl:variable name="final">
		<xsl:element name="br"></xsl:element>
		<xsl:variable name="catlival">
			<xsl:call-template name="CatlitLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATLIT' ]/@value"/>
			</xsl:call-template>
			<xsl:text> </xsl:text>
		</xsl:variable>
		<xsl:variable name="clrvalue" select="Attributes/Attribute[@acronym='COLOUR']/@value"/>
		<xsl:variable name="color">
				<xsl:choose>
					<xsl:when test="contains($clrvalue,',')">
						<xsl:call-template name="colourLookup">
							<xsl:with-param name="value" select="substring-before($clrvalue,',')"/>
						</xsl:call-template>
						<xsl:call-template name="colourLookup">
							<xsl:with-param name="value" select="substring-after($clrvalue,',')"/>
						</xsl:call-template>
						<xsl:text>.</xsl:text>
					</xsl:when>
					<xsl:when test="$clrvalue='1'"/>
					<xsl:otherwise>
						<xsl:call-template name="colourLookup">
							<xsl:with-param name="value" select="$clrvalue"/>
						</xsl:call-template>
						<xsl:text>.</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
		</xsl:variable>
		<xsl:variable name="heigvalue">
			<xsl:if test="Attributes/Attribute[@acronym='HEIGHT']/@value!= '' ">
				<xsl:value-of select="concat(Attributes/Attribute[@acronym='HEIGHT']/@value, 'm')"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="valnvalue">
			<xsl:if test="Attributes/Attribute[@acronym='VALNMR']/@value!= '' ">
				<xsl:value-of select="concat(Attributes/Attribute[@acronym='VALNMR']/@value, 'M')"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="litcval">
			<xsl:call-template name="litchLookup">
				<xsl:with-param name="value" select="Attributes/Attribute[@acronym='LITCHR' ]/@value"/>
			</xsl:call-template>
			<xsl:text>.</xsl:text>
		</xsl:variable>
		<xsl:variable name="sigvalue">
			<xsl:if test="Attributes/Attribute[@acronym='SIGGRP']/@value!= '' ">
				<xsl:variable name="siggrp" select="Attributes/Attribute[@acronym='SIGGRP']/@value"/>
				<!-- This is because replace function is not available in 1.0 version -->
				<xsl:choose>
					<xsl:when test="contains($siggrp,'(1)')">
						<xsl:variable name="bfr" select="substring-before($siggrp,'(1)')"/>
						<xsl:variable name="afr" select="substring-after($siggrp,'(1)')"/>
						<xsl:value-of select="concat($bfr,$afr)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="Attributes/Attribute[@acronym='SIGGRP']/@value"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="sigpvalue">
			<xsl:if test="Attributes/Attribute[@acronym='SIGPER']/@value!= '' ">
				<xsl:value-of select="concat(Attributes/Attribute[@acronym='SIGPER']/@value, 's')"/>
			</xsl:if>
		</xsl:variable>
			<xsl:variable name="lv">
				<xsl:call-template name="LitvisLookup">
					<xsl:with-param name="language" select="'eng'"/>
					<xsl:with-param name="litvisValue" select="Attributes/Attribute[@acronym='LITVIS']/@value"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="litvis">
				<xsl:if test="normalize-space($lv)">
					<xsl:value-of select="$lv"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="sector">
				<xsl:if test="normalize-space(Attributes/Attribute[@acronym='SECTR1']/@value) or normalize-space(Attributes/Attribute[@acronym='SECTR2']/@value)">
					<xsl:value-of select="concat(normalize-space(Attributes/Attribute[@acronym='SECTR1']/@value),'','°','-',normalize-space(Attributes/Attribute[@acronym='SECTR2']/@value))"/>
					<xsl:text>°</xsl:text>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="mltylt">
				<xsl:value-of select="Attributes/Attribute[@acronym='MLTYLT']/@value"/>
			</xsl:variable>
			<xsl:variable name="inforvalue">
				<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--					<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
				</xsl:if>
			</xsl:variable>
			<xsl:value-of select="concat($catlival,$mltylt,$litcval,$sigvalue,$color,$sigpvalue,$heigvalue,$valnvalue)"/>
			<xsl:choose>
				<xsl:when test="normalize-space($litvis) and normalize-space($sector)">
					<xsl:value-of select="concat(' (',$litvis,' ',$sector,')')"/>
				</xsl:when>
				<xsl:when test="not(normalize-space($litvis)) and normalize-space($sector)">
					<xsl:value-of select="concat(' (',$sector,')')"/>
				</xsl:when>
				<xsl:when test="normalize-space($litvis) and not(normalize-space($sector))">
					<xsl:value-of select="concat(' (',$litvis,')')"/>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="normalize-space($inforvalue)">
				<xsl:value-of select="concat(' (',$inforvalue,')')"/>
			</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'LITFLT']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Light float </xsl:text>
		<xsl:variable name="marsyval">
			<xsl:call-template name="MarsysLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='MARSYS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="colouval">
			<xsl:call-template name="ColoLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='COLOUR' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$marsyval,',',$colouval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'LITVES']">
		<xsl:text>Light vessel</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'LNDARE']">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Land area</xsl:text>
		<!-- <xsl:choose>
			<xsl:when test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
				<xsl:text>"</xsl:text>
				<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
				<xsl:text>"</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Land area</xsl:text>
			</xsl:otherwise>
		</xsl:choose> -->
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'LNDELV']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Land elevation</xsl:text>
		<!-- <xsl:choose>
			<xsl:when test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
				<xsl:text>"</xsl:text>
				<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
				<xsl:text>"</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Land elevation</xsl:text>
			</xsl:otherwise>
		</xsl:choose> -->

		<xsl:variable name="elevalue">

			<xsl:if test="Attributes/Attribute[@acronym='ELEVAT']/@value != '' ">
				<xsl:if test="Attributes/Attribute[@acronym='ELEVAT']/@value != 'UNKNOWN' ">
					<xsl:value-of select="Attributes/Attribute[@acronym='ELEVAT']/@value"/>
					<xsl:text>m </xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="quapoval">
			<xsl:call-template name="QuaposLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='QUAPOS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' ','(',$elevalue,',',$quapoval,',',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'LNDMRK']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:variable name="catLval">
			<xsl:call-template name="catlLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATLMK' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="funLcval">
			<xsl:call-template name="FuncLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='FUNCTN' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:text>, </xsl:text>-->
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="convidval">
			<xsl:if test="Attributes/Attribute[@acronym='CONVIS']/@value=1">
				<xsl:text>, </xsl:text>
				<xsl:call-template name="convisLookup">
					<xsl:with-param name="value"
						select="Attributes/Attribute[@acronym='CONVIS']/@value"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="heigvalue">
			<xsl:if test="Attributes/Attribute[@acronym='HEIGHT']/@value!= '' ">
				<xsl:if test="Attributes/Attribute[@acronym='HEIGHT']/@value != 'UNKNOWN' ">
					<xsl:text>, </xsl:text>
					<xsl:value-of select="Attributes/Attribute[@acronym='HEIGHT']/@value"/>
					<xsl:text>m </xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:variable>
			<xsl:variable name="elevatvalue">
				<xsl:if test="Attributes/Attribute[@acronym='ELEVAT']/@value!= '' ">
					<xsl:if test="Attributes/Attribute[@acronym='ELEVAT']/@value!= 'UNKNOWN' ">
						<xsl:text>, </xsl:text>
						<xsl:value-of select="Attributes/Attribute[@acronym='ELEVAT']/@value"/>
						<xsl:text>m </xsl:text>
					</xsl:if>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="verlevalue">
			<xsl:if test="Attributes/Attribute[@acronym='VERLEN']/@value!= '' ">
				<xsl:if test="Attributes/Attribute[@acronym='VERLEN']/@value!= 'UNKNOWN' ">
					<xsl:text>, </xsl:text>
					<xsl:value-of select="Attributes/Attribute[@acronym='VERLEN']/@value"/>
					<xsl:text>m </xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat($catLval,' (',$funLcval,$inforvalue,$convidval,$heigvalue,$elevatvalue,$verlevalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'LNDRGN']">
		<xsl:variable name="final">
		<!-- <xsl:choose>
			<xsl:when test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
				<xsl:text>"</xsl:text>
				<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
				<xsl:text>"</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Land region</xsl:text>
			</xsl:otherwise>
		</xsl:choose> -->
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:variable name="catlnval">
			<xsl:call-template name="CatlndLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATLND' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:value-of select="concat(' ' ,$catlnval)"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'LOCMAG']">
		<xsl:variable name="final">
		<xsl:text>Local magnetic anomaly</xsl:text>
		<xsl:variable name="vallmvalue">
			<xsl:if test="Attributes/Attribute[@acronym='VALLMA']/@value!= '' ">
				<xsl:value-of select="Attributes/Attribute[@acronym='VALLMA']/@value"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$vallmvalue,',', $txtvalue ,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'LOGPON']">
		<xsl:variable name="final">
		<xsl:text>Log pond</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'LOKBSN']">
		<xsl:variable name="final">
		<xsl:text>Lock basin</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'MAGVAR']">
		<xsl:variable name="final">
		<xsl:text>Magnetic variation</xsl:text>
		<xsl:variable name="ryrmgvalue">
			<xsl:if test="Attributes/Attribute[@acronym='RYRMGV']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='RYRMGV']/@value"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="valmavalue">
			<xsl:if test="Attributes/Attribute[@acronym='VALMAG']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='VALMAG']/@value"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="valacvalue">
			<xsl:if test="Attributes/Attribute[@acronym='VALACM']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='VALACM']/@value"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$ryrmgvalue,',',$valmavalue,',',$valacvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'MARCUL']">
		<xsl:variable name="final">
		<xsl:text>Marine farm</xsl:text>
		<xsl:variable name="catmfval">
			<xsl:call-template name="catmfaLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATMFA' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="watlval">
			<xsl:call-template name="watlevLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='WATLEV' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="valsvalue">
			<xsl:if test="(./Attributes/Attribute[@acronym='VALSOU']/@value != '') and (./Attributes/Attribute[@acronym='VALSOU']/@value != 'UNKNOWN') ">
				<xsl:value-of select="./Attributes/Attribute[@acronym='VALSOU']/@value"/>
				<xsl:text>m </xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of
			select="concat(' (',$catmfval,',',$watlval,',',$valsvalue,',',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'MIPARE']">
		<xsl:variable name="final">
		<xsl:text>Military practice area</xsl:text>
		<xsl:variable name="catmpval">
			<xsl:call-template name="CatmpaLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATMPA' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catmpval,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'MORFAC']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Mooring </xsl:text>
		<xsl:variable name="catmoval">
			<xsl:call-template name="CatmorLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATMOR' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="boyval">
			<xsl:call-template name="boyshpLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='BOYSHP' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="watlval">
			<xsl:call-template name="watlevLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='WATLEV' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat($catmoval,' (',$boyval,',',$watlval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'NAVLNE']">
		<xsl:variable name="final">
		<xsl:text>Navigation line</xsl:text>
		<xsl:variable name="catnval">
			<xsl:call-template name="catnavLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATNAV' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="orievalue">
			<xsl:if test="Attributes/Attribute[@acronym='ORIENT']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='ORIENT']/@value"/>
				<xsl:text>°</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catnval,',',$orievalue,',',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'OBSTRN']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Obstruction</xsl:text>
		<xsl:variable name="catoval">
			<xsl:call-template name="catobsLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATOBS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="watlval">
			<xsl:call-template name="watlevLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='WATLEV' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="valsvalue">
			<xsl:if test="./Attributes/Attribute[@acronym='VALSOU']/@value != '' ">
				<xsl:if test="./Attributes/Attribute[@acronym='VALSOU']/@value != 'UNKNOWN' ">
					<xsl:value-of select="./Attributes/Attribute[@acronym='VALSOU']/@value"/>
					<xsl:text>m </xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="quasval">
			<xsl:call-template name="QuasouLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='QUASOU' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of
			select="concat(' ',$valsvalue,' (',$catoval,',',$quasval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'OFSPLF']">
		<!-- Finalized  as per spreadsheet -->
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Offshore platform </xsl:text>

		<xsl:variable name="catofval">
			<xsl:call-template name="CatoLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATOFP' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="staval">
			<xsl:call-template name="StatLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='STATUS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catofval,',',$staval,',',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'OILBAR']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:variable name="catolval">
			<xsl:call-template name="catolbLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATOLB' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' ' ,$catolval,' ','(',$inforvalue,',', $txtvalue, ')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
		<!-- <xsl:text> Oil barrier</xsl:text> -->
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'OSPARE']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> Offshore production area</xsl:text>
		<xsl:variable name="catprval">
			<xsl:call-template name="CatpraLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATPRA' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="prodcval">
			<xsl:call-template name="ProdctLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='PRODCT' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="restrval">
			<xsl:call-template name="RestrnLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='RESTRN' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catprval,',',$prodcval,',',$restrval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'PILBOP']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> Pilot boarding place</xsl:text>
		<xsl:variable name="catpival">
			<xsl:call-template name="catpilLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATPIL' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="pildsvalue">
			<xsl:if test="Attributes/Attribute[@acronym='PILDST']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='PILDST']/@value"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catpival,',',$pildsvalue,',',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'PILPNT']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Pile </xsl:text>
		<xsl:variable name="catplval">
			<xsl:call-template name="catpleLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATPLE' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catplval,',',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'PIPARE']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> Pipeline area</xsl:text>
		<xsl:variable name="catpival">
			<xsl:call-template name="CatpipLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATPIP' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="prodcval">
			<xsl:call-template name="ProdctLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='PRODCT' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="resval">
			<xsl:call-template name="RestrnLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='RESTRN' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of
			select="concat(' (',$catpival,',',$prodcval,',',$resval,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'PIPOHD']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> Pipeline, overhead</xsl:text>
		<xsl:variable name="catpival">
			<xsl:call-template name="CatpipLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATPIP' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="vervalue">

			<xsl:if test="normalize-space(Attributes/Attribute[@acronym='VERCLR']/@value)">
				<!-- <xsl:value-of select="concat('with ', Attributes/Attribute[@acronym='VERCLR']/@value, 'm clearance')"/> -->
				<xsl:value-of select="Attributes/Attribute[@acronym='VERCLR']/@value"/>
				<xsl:text>m</xsl:text>
			</xsl:if>

		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catpival,',',$vervalue,',',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'PIPSOL']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> Pipeline, submarine/on land</xsl:text>
		<xsl:variable name="catpival">
			<xsl:call-template name="CatpipLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATPIP' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="burdevalue">
			<xsl:if test="Attributes/Attribute[@acronym='BURDEP']/@value != ''">
				<xsl:if test="Attributes/Attribute[@acronym='BURDEP']/@value != 'UNKNOWN'">
					<xsl:value-of select=" Attributes/Attribute[@acronym='BURDEP']/@value"/>
					<xsl:text>m </xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="prodcval">
			<xsl:call-template name="ProdctLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='PRODCT' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>

			</xsl:if>
		</xsl:variable>
		<xsl:value-of
			select="concat(' (',$catpival,',',$burdevalue,',',$prodcval,',',$inforvalue,',',$txtvalue, ')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'PONTON']">
		<xsl:variable name="final">
		<xsl:text>Pontoon</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'PRCARE']">
		<xsl:variable name="final">
		<xsl:text>Precautionary area</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'see Note'"/>

			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'PRDARE']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> Production area</xsl:text>
		<xsl:variable name="catprval">
			<xsl:call-template name="CatpraLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATPRA' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>

			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catprval,',',$inforvalue,',',$txtvalue, ')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'PYLONS']">
		<xsl:variable name="final">
		<xsl:text>Pylon/bridge support</xsl:text>
		<xsl:variable name="catpyval">
			<xsl:call-template name="catpylLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATPYL' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catpyval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RADLNE']">
		<xsl:variable name="final">
		<xsl:text>Radar line</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="orievalue">
			<xsl:if test="Attributes/Attribute[@acronym='ORIENT']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='ORIENT']/@value"/>
				<xsl:text>°</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$orievalue,',',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RADRFL']">
		<xsl:variable name="final">
		<xsl:text>Radar reflector</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RADRNG']">
		<xsl:variable name="final">
		<xsl:text>Radar range</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>

			</xsl:if>
		</xsl:variable>
			<xsl:value-of select="concat(' (',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RADSTA']">
		<xsl:variable name="final">
		<xsl:element name="br"/>
		<xsl:text>Radar station</xsl:text>

		<xsl:variable name="catraval">
			<xsl:call-template name="CatrasLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATRAS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' ' ,' ','(',$catraval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RAILWY']">
		<xsl:text>Railway</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RAPIDS']">
		<xsl:text>Rapids</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RCRTCL']">
		<xsl:variable name="final">
		<xsl:text>Recommended route centerline</xsl:text>
		<xsl:variable name="cattrval">
			<xsl:call-template name="CattrkLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATTRK' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>

			</xsl:if>
		</xsl:variable>
			<xsl:value-of select="concat(' (',$cattrval,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RCTLPT']">
		<xsl:variable name="final">
		<xsl:text>Recommended traffic lane part</xsl:text>
		<xsl:variable name="orievalue">
			<xsl:if test="Attributes/Attribute[@acronym='ORIENT']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='ORIENT']/@value"/>
				<xsl:text>°</xsl:text>
			</xsl:if>
		</xsl:variable>

		<xsl:variable name="inforval">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$orievalue,',',$inforval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RDOCAL']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> Radio calling-in point</xsl:text>
		<xsl:variable name="orievalue">
			<xsl:if test="Attributes/Attribute[@acronym='ORIENT']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='ORIENT']/@value"/>
				<xsl:text>°</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="trafval">
			<xsl:call-template name="traficLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='TRAFIC' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforval">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' ' ,' ','(',$orievalue,',',$trafval,',',$inforval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RDOSTA']">
		<xsl:variable name="final">
		<xsl:element name="br"/>
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> Radio station</xsl:text>
		<xsl:variable name="catroval">
			<xsl:call-template name="CatrLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATROS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="staval">
			<xsl:call-template name="StatLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='STATUS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' ' ,' ','(',$catroval,',',$staval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RECTRC']">
		<xsl:variable name="final">
		<xsl:text>Recommended track</xsl:text>
		<xsl:variable name="cattrval">
			<xsl:call-template name="CattrkLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATTRK' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="orievalue">
			<xsl:if test="Attributes/Attribute[@acronym='ORIENT']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='ORIENT']/@value"/>
				<xsl:text>°</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="trafval">
			<xsl:call-template name="traficLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='TRAFIC' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforval">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>

			</xsl:if>
		</xsl:variable>
		<xsl:value-of
			select="concat(' (',$cattrval,',',$orievalue,',',$trafval,',',$inforval,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RESARE']">
		<xsl:variable name="final">
		<xsl:text>Restricted area</xsl:text>
		<xsl:variable name="catreval">
			<xsl:call-template name="CatreaLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATREA' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="resval">
			<xsl:call-template name="RestrnLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='RESTRN' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforval">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catreval,',',$resval,',',$inforval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RETRFL']">
		<xsl:element name="br"/>
		<xsl:text>Retro-reflector</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RIVBNK']">
		<xsl:text>River bank</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RIVERS']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> River</xsl:text>
		<xsl:variable name="staval">
			<xsl:call-template name="StatLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='STATUS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$staval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'ROADWY']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> Road</xsl:text>
		<xsl:variable name="catroval">
			<xsl:call-template name="CatrodLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATROD' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catroval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RSCSTA']">
		<xsl:variable name="final">
		<xsl:text>Rescue station</xsl:text>
		<xsl:variable name="catrsval">
			<xsl:call-template name="CatrscLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATRSC' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catrsval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RTPBCN']">
		<xsl:variable name="final">
		<xsl:element name="br"/>
		<xsl:text>Radar transponder beacon</xsl:text>
		<xsl:variable name="catrtval">
			<xsl:call-template name="CatrtbLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATRTB' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="radwavalue">
			<xsl:if test="Attributes/Attribute[@acronym='RADWAL']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='RADWAL']/@value"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="sigvalue">
			<xsl:if test="Attributes/Attribute[@acronym='SIGGRP']/@value!= '' ">
				<xsl:value-of select="Attributes/Attribute[@acronym='SIGGRP']/@value"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catrtval,',',$radwavalue,',',$sigvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'RUNWAY']">
		<xsl:variable name="final">
		<xsl:text>Runway</xsl:text>
		<xsl:variable name="catruval">
			<xsl:call-template name="catrunLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATRUN' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catruval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SBDARE']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> Seabed area</xsl:text>
		<xsl:variable name="natquval">
			<xsl:call-template name="NatquaLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='NATQUA' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="natsval">
			<xsl:call-template name="NatsurLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='NATSUR' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="watlval">
			<xsl:call-template name="watlevLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='WATLEV' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$natquval,',',$natsval,',',$watlval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SEAARE']">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Sea area</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SILTNK']">
		<xsl:variable name="final">
		<xsl:text>Silo/tank</xsl:text>
		<xsl:variable name="catsilval">
			<xsl:call-template name="catsilLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATSIL' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
			<xsl:variable name="prodcval">
				<xsl:variable name="cat" select="Attributes/Attribute[@acronym='CATSIL' ]/@value"/>
				<xsl:if test="not($cat = 4)">
			<xsl:call-template name="ProdctLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='PRODCT' ]/@value"/>
			</xsl:call-template>
			</xsl:if>
			</xsl:variable>
		
			
		<xsl:variable name="heigvalue">
			<xsl:if test="Attributes/Attribute[@acronym='HEIGHT']/@value!= '' ">
				<xsl:if test="Attributes/Attribute[@acronym='HEIGHT']/@value!= 'UNKNOWN' ">
					<xsl:value-of select="Attributes/Attribute[@acronym='HEIGHT']/@value"/>
					<xsl:text>m </xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catsilval,',',$prodcval,',',$heigvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SISTAT']">
		<xsl:variable name="final">
		<xsl:element name="br"></xsl:element>
		<xsl:text>Signal station, traffic </xsl:text>
		<xsl:variable name="catsival">
			<xsl:call-template name="CatsitLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATSIT' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforval">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catsival,',',$inforval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SISTAW']">
		<xsl:variable name="final">
		<xsl:element name="br"/>
		<xsl:text>Signal station, warning</xsl:text>
		<xsl:variable name="catsiwval">
			<xsl:call-template name="CatsiwLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATSIW' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catsiwval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SLCONS']">
		<xsl:variable name="final">
		<xsl:text>Shoreline Construction</xsl:text>
		<xsl:variable name="catslval">
			<xsl:call-template name="catslcLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATSLC' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="watlval">
			<xsl:call-template name="watlevLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='WATLEV' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="natcval">
			<xsl:call-template name="NatcLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='NATCON' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforval">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of
			select="concat(' (',$catslval,',',$watlval,',',$natcval,',',$inforval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SLOGRD']">
		<xsl:variable name="final">
		<xsl:text>Sloping ground</xsl:text>
		<xsl:variable name="catsloval">
			<xsl:call-template name="catsloLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATSLO' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="natsval">
			<xsl:call-template name="NatsurLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='NATSUR' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catsloval,',',$natsval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SLOTOP']">
		<xsl:variable name="final">
		<xsl:text>Slope topline</xsl:text>
		<xsl:variable name="catsloval">
			<xsl:call-template name="catsloLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATSLO' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catsloval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SMCFAC']">
		<xsl:variable name="final">
		<xsl:text>Small craft facility</xsl:text>
		<xsl:variable name="catscval">
			<xsl:call-template name="CatsrfLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATSCF' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catscval,',',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SNDWAV']">
		<xsl:variable name="final">
		<xsl:text>Sand waves</xsl:text>
		<xsl:variable name="verlevalue">
			<xsl:if test="Attributes/Attribute[@acronym='VERLEN']/@value!= '' ">
				<xsl:if test="Attributes/Attribute[@acronym='VERLEN']/@value!= 'UNKNOWN' ">
					<xsl:value-of select="Attributes/Attribute[@acronym='VERLEN']/@value"/>
					<xsl:text>m </xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$verlevalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SOUNDG']">
		<xsl:variable name="dptval" select="normalize-space(Geometry/Point/@z)"/>
		<xsl:if test="$dptval">
			<xsl:text>depth</xsl:text>
			<xsl:text> </xsl:text>
			<xsl:value-of select="$dptval * 1"/>
			<xsl:text>m</xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SPLARE']">
		<xsl:text>Sea-plane landing area</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SPRING']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Spring</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SQUARE']">
		<xsl:text>Square</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'STSLNE']">
		<xsl:variable name="final">
		<xsl:text>Straight territorial sea baseline</xsl:text>
		<xsl:variable name="nativalue">
			<xsl:if test="Attributes/Attribute[@acronym='NATION']/@value != ''">
				<!--<xsl:value-of select=" Attributes/Attribute[@acronym='NATION']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'see Note'"/>

			</xsl:if>
		</xsl:variable>
			<xsl:value-of select="concat(' (',$nativalue,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SUBTLN']">
		<xsl:variable name="final">
		<xsl:text>Submarine transit lane</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>

			</xsl:if>
		</xsl:variable>
			<xsl:value-of select="concat(' (',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'SWPARE']">
		<xsl:variable name="final">
		<xsl:text>Swept area</xsl:text>
		<xsl:variable name="drvavalue">
			<xsl:if test="Attributes/Attribute[@acronym='DRVAL1']/@value != ''">
				<xsl:if test="Attributes/Attribute[@acronym='DRVAL1']/@value != 'UNKNOWN'">
					<xsl:value-of select=" Attributes/Attribute[@acronym='DRVAL1']/@value"/>
					<xsl:text>m </xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="quasval">
			<xsl:call-template name="QuasouLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='QUASOU' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="tecsoval">
			<xsl:call-template name="TecsouLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='TECSOU' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$drvavalue,',',$quasval,',',$tecsoval,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TESARE']">
		<xsl:variable name="final">
		<xsl:text>Territorial sea area</xsl:text>
		<xsl:variable name="nativalue">
			<xsl:if test="Attributes/Attribute[@acronym='NATION']/@value != ''">
				<!--<xsl:value-of select=" Attributes/Attribute[@acronym='NATION']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'see Note'"/>

			</xsl:if>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$nativalue !='' and $inforvalue !=''">
				<xsl:value-of select="concat(' (',$nativalue,',',$inforvalue,',',$txtvalue,')')"/>
			</xsl:when>
			<xsl:when test="$nativalue !='' and $inforvalue =''">
				<xsl:value-of select="concat(' (',$nativalue,',',$txtvalue,')')"/>
			</xsl:when>
		</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TIDEWY']">
		<xsl:text>Tideway</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TOPMAR']">
		<xsl:variable name="final">
		<xsl:element name="br"></xsl:element>
		<xsl:text>Topmark </xsl:text>
		<xsl:variable name="topsval">
			<xsl:call-template name="topshpbLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='TOPSHP' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="colouval">
<!--			<xsl:call-template name="ColoLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='COLOUR' ]/@value"/>
			</xsl:call-template>-->
		</xsl:variable>
			<xsl:choose>
       <!--no need to display color for TOPMAR -->
				<xsl:when test="normalize-space($topsval) and normalize-space($colouval)">
					<xsl:value-of select="concat(' (',$topsval,')')"/>
				</xsl:when>
				<xsl:when test="normalize-space($topsval) and not(normalize-space($colouval))">
					<xsl:value-of select="concat(' (',$topsval,')')"/>
				</xsl:when>
				<!--<xsl:when test="not(normalize-space($topsval)) and (normalize-space($colouval))">
					<xsl:value-of select="concat(' (',$colouval,')')"/>
				</xsl:when>-->
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TSELNE']">
		<xsl:variable name="final">
		<xsl:text>Traffic separation line</xsl:text>
		<xsl:variable name="cattsval">
			<xsl:call-template name="cattssLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATTSS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>

			</xsl:if>
		</xsl:variable>
			<xsl:value-of select="concat(' (',$cattsval,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TSEZNE']">
		<xsl:variable name="final">
		<xsl:text>Traffic separation zone</xsl:text>
		<xsl:variable name="cattsval">
			<xsl:call-template name="cattssLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATTSS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>

			</xsl:if>
		</xsl:variable>
			<xsl:value-of select="concat(' (',$cattsval,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TSSBND']">
		<xsl:variable name="final">
		<xsl:text>Traffic separation scheme boundary</xsl:text>
		<xsl:variable name="cattsval">
			<xsl:call-template name="cattssLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATTSS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>

			</xsl:if>
		</xsl:variable>
			<xsl:value-of select="concat(' (',$cattsval,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TSSCRS']">
		<xsl:variable name="final">
		<xsl:text>Traffic separation scheme crossing</xsl:text>
		<xsl:variable name="cattsval">
			<xsl:call-template name="cattssLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATTSS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>

			</xsl:if>
		</xsl:variable>
			<xsl:value-of select="concat(' (',$cattsval,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TSSLPT']">
		<xsl:variable name="final">
		<xsl:text>Traffic separation scheme lane part</xsl:text>

		<xsl:variable name="cattsval">
			<xsl:call-template name="cattssLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATTSS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="orievalue">
			<xsl:if test="Attributes/Attribute[@acronym='ORIENT']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='ORIENT']/@value"/>
				<xsl:text>°, </xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>

			</xsl:if>
		</xsl:variable>
			<xsl:value-of select="concat(' (',$cattsval,$orievalue,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TSSRON']">
		<xsl:text>Traffic separation scheme roundabout</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TS_FEB']">
		<xsl:variable name="final">
		<xsl:text>Tidal streams</xsl:text>
		<xsl:variable name="cattsval">
			<xsl:call-template name="cat_tsLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CAT_TS' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="curvvalue">
			<xsl:if test="Attributes/Attribute[@acronym='CURVEL']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='CURVEL']/@value"/>
				<xsl:value-of select="'Kn'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="orievalue">
			<xsl:if test="Attributes/Attribute[@acronym='ORIENT']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='ORIENT']/@value"/>
				<xsl:text>°</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$cattsval,',',$curvvalue,',',$orievalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TS_PAD']">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Tidal stream panel data </xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TS_PNH']">
		<xsl:text>Tidal stream - non harmonic prediction</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TS_PRH']">
		<xsl:text>Tidal stream - harmonic prediction</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TS_TIS']">
		<xsl:text>Tidal stream time series</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TUNNEL']">
		<xsl:text>Tunnel</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'TWRTPT']">
		<xsl:variable name="final">
		<xsl:text>Two-way route part</xsl:text>
		<xsl:variable name="trafval">
			<xsl:call-template name="traficLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='TRAFIC' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="orievalue">
			<xsl:if test="Attributes/Attribute[@acronym='ORIENT']/@value != ''">
				<xsl:value-of select=" Attributes/Attribute[@acronym='ORIENT']/@value"/>
				<xsl:text>°</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="txtvalue">
			<xsl:if test="Attributes/Attribute[@acronym='TXTDSC']/@value != ''">
				<xsl:value-of select="'(see Note)'"/>

			</xsl:if>
		</xsl:variable>
			<xsl:value-of select="concat(' (',$trafval,',',$orievalue,',',$inforvalue,',',$txtvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'T_HMON']">
		<xsl:text>Tide - harmonic prediction</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'T_NHMN']">
		<xsl:text>Tide - non-harmonic prediction</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'T_TIMS']">
		<xsl:text>Tide - time series</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'UNSARE']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> Unsurveyed area</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'VEGATN']">
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text> Vegetation</xsl:text>
		<xsl:variable name="catvvalue">
			<xsl:call-template name="CatvegLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATVEG' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catvvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'WATFAL']">
		<xsl:variable name="final">
		<xsl:text>Waterfall</xsl:text>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'WATTUR']">
		<xsl:variable name="final">
		<xsl:text>Water turbulence</xsl:text>
		<xsl:variable name="catwaval">
			<xsl:call-template name="catwatLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATWAT' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catwaval,',',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'WEDKLP']">
		<xsl:variable name="final">
		<xsl:text>Weed/Kelp</xsl:text>
		<xsl:variable name="catweval">
			<xsl:call-template name="catwedLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='CATWED' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="inforvalue">
			<xsl:if test="Attributes/Attribute[@acronym='INFORM']/@value != ''">
<!--				<xsl:value-of select=" Attributes/Attribute[@acronym='INFORM']/@value"/>-->
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat(' (',$catweval,',',$inforvalue,')')"/>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'WRECKS']">
		<xsl:variable name="final">
			<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
				<xsl:text>"</xsl:text>
				<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
				<xsl:text>" </xsl:text>
			</xsl:if>
			<xsl:variable name="catwrval">
				<xsl:call-template name="catwrkLookup">
					<xsl:with-param name="value" select="Attributes/Attribute[@acronym='CATWRK']/@value"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:if test="$catwrval != ''">
				<xsl:value-of select="$catwrval"/>
			</xsl:if>
			<xsl:if test="./Attributes/Attribute[@acronym='VALSOU']/@value != '' ">
				<!--  Add the sounding value to the desciption, bold with decimal in subscript -->
				<xsl:variable name="valsovalue">
					<xsl:value-of select="./Attributes/Attribute[@acronym='VALSOU']/@value"/>
				</xsl:variable> 
				<xsl:if test="$valsovalue !='' and $valsovalue!='UNKNOWN'">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$valsovalue"/>
					<xsl:text>m </xsl:text>
				</xsl:if>
			</xsl:if>
			<xsl:variable name="quapoval">
				<xsl:call-template name="QuaposLookup">
					<xsl:with-param name="value"
						select="Attributes/Attribute[@acronym='QUAPOS' ]/@value"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:if test="$quapoval != ''">
				<xsl:text>, </xsl:text>
				<xsl:value-of select="$quapoval"/>
			</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="Feature[@acronym = '$AREAS']">
		<xsl:text>Cartographic area</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = '$COMPS']">
		<xsl:text>Compass</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = '$CSYMB']">
		<xsl:text>Cartographic symbol</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = '$LINES']">
		<xsl:text>Cartographic line</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = '$TEXTS']">
		<xsl:text>Text</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'C_AGGR']">
		<xsl:text>Aggregation</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'C_ASSO']">
		<xsl:text>Association</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'C_STAC']">
		<xsl:text>Stacked on/stacked under</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'M_ACCY']">
		<xsl:text>Accuracy of data</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'M_COVR']">
		<xsl:text>Coverage</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'M_CSCL']">
		<xsl:text>Compilation scale of data</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'M_HDAT']">
		<xsl:text>Horizontal datum of data</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'M_HOPA']">
		<xsl:text>Horizontal datum shift parameters</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'M_NPUB']">
		<xsl:text>Nautical publication information</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'M_NSYS']">
		<xsl:text>Navigational system of marks</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'M_PROD']">
		<xsl:text>Production information</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'M_QUAL']">
		<xsl:text>Quality of data</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'M_SDAT']">
		<xsl:text>Sounding datum</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'M_SREL']">
		<xsl:text>Survey reliability</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'M_UNIT']">
		<xsl:text>Units of measurement of data</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'M_VDAT']">
		<xsl:text>Vertical datum of data</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'ARCSLN']">
		<xsl:text>Archipelagic Sea Lane</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'ASLXIS']">
		<xsl:text>Archipelagic Sea Lane Axis</xsl:text>
	</xsl:template>
	<xsl:template match="Feature[@acronym = 'NEWOBJ']">
		<xsl:text>New Object</xsl:text>
	</xsl:template>
	<!-- Template to process a landmark structure -->
	<!--  <xsl:template match="Feature[@acronym='LNDMRK']">
	 <xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' " >
		   <xsl:text>"</xsl:text>
            <xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
             <xsl:text>"</xsl:text>
        </xsl:if>	
        <xsl:variable name="catLcval">
			<xsl:call-template name="catlmkLookup">			
				<xsl:with-param name="value" select="Attributes/Attribute[@acronym='CATLMK' ]/@value"/>	
			</xsl:call-template>
		</xsl:variable>
		
         <xsl:variable name="funLcval">
			<xsl:call-template name="FuncLookup">			
				<xsl:with-param name="value" select="Attributes/Attribute[@acronym='FUNCTN' ]/@value"/>	
			</xsl:call-template>
		</xsl:variable>
		
    <xsl:value-of select="concat(' ' ,$catLcval,' ',$funLcval )" /> 
        
    </xsl:template>
 -->
	<!-- Template to process an admin area -->
	<xsl:template match="Feature[@acronym='ADMARE']">
		<!-- If it has a name include it -->
		<xsl:variable name="final">
		<xsl:if test="./Attributes/Attribute[@acronym='OBJNAM']/@value != '' ">
			<xsl:text>"</xsl:text>
			<xsl:value-of select="./Attributes/Attribute[@acronym='OBJNAM']/@value"/>
			<xsl:text>" </xsl:text>
		</xsl:if>
		<xsl:text>Administrative Area</xsl:text>
		<xsl:variable name="jsrdval">
			<xsl:call-template name="jrsdtnLookup">
				<xsl:with-param name="value"
					select="Attributes/Attribute[@acronym='JRSDTN' ]/@value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="normalize-space($jsrdval)">
			<xsl:value-of select="concat(' (',$jsrdval,')')"/>
		</xsl:if>
		</xsl:variable>
		<xsl:call-template name="multiple-incorrect-values-replacement">
			<xsl:with-param name="input" select="$final"/>
		</xsl:call-template>
	</xsl:template>
	<!-- Template to lookup a Feature Acronym  -->
	<xsl:template name="lookupFeature">
		<xsl:param name="featureClass"/>
		<xsl:choose>
		    <xsl:when test="$featureClass = 'ACHARE'">
		        <xsl:text>Anchorage area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'ACHBRT'">
		        <xsl:text>Anchor berth</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'ADMARE'">
		        <xsl:text>Administration Area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'AIRARE'">
		        <xsl:text>Airport</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BCNCAR'">
		        <xsl:text>Beacon</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BCNISD'">
		        <xsl:text>Beacon isolated danger</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BCNLAT'">
		        <xsl:text>Beacon</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BCNSAW'">
		        <xsl:text>Beacon safe water</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BCNSPP'">
		        <xsl:text>Beacon</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BERTHS'">
		        <xsl:text>Berth</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BOYCAR'">
		        <xsl:text>Buoy</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BOYINB'">
		        <xsl:text>Buoy installation</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BOYISD'">
		        <xsl:text>Buoy isolated danger</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BOYLAT'">
		        <xsl:text>Buoy</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BOYSAW'">
		        <xsl:text>Buoy safe water</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BOYSPP'">
		        <xsl:text>Buoy</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BRIDGE'">
		        <xsl:text>Bridge</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BUAARE'">
		        <xsl:text>Built up area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'BUISGL'">
		        <xsl:text>Building</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CANALS'">
		        <xsl:text>Canal</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CANBNK'">
		        <xsl:text>Canal bank</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CAUSWY'">
		        <xsl:text>Causeway</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CBLARE'">
		        <xsl:text>Cable area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CBLOHD'">
		        <xsl:text>Cable overhead</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CBLSUB'">
		        <xsl:text>Cable submarine</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CGUSTA'">
		        <xsl:text>Coastguard station</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CHKPNT'">
		        <xsl:text>Checkpoint</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'COALNE'">
		        <xsl:text>Coastline</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CONVYR'">
		        <xsl:text>Conveyor</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CONZNE'">
		        <xsl:text>Contiguous zone</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'COSARE'">
		        <xsl:text>Continental shelf area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CRANES'">
		        <xsl:text>Crane</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CTNARE'">
		        <xsl:text>Caution area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CTRPNT'">
		        <xsl:text>Control point</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CTSARE'">
		        <xsl:text>Cargo transhipment area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CURENT'">
		        <xsl:text>Current non-gravitational</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'CUSZNE'">
		        <xsl:text>Custom zone</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'DAMCON'">
		        <xsl:text>Dam</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'DAYMAR'">
		        <xsl:text>Daymark</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'DEPARE'">
		        <xsl:text>Depth area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'DEPCNT'">
		        <xsl:text>Depth contour</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'DISMAR'">
		        <xsl:text>Distance mark</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'DMPGRD'">
		        <xsl:text>Dumping ground</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'DOCARE'">
		        <xsl:text>Dock area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'DRGARE'">
		        <xsl:text>Dredged area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'DRYDOC'">
		        <xsl:text>Dry dock</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'DWRTCL'">
		        <xsl:text>Deep water route centerline</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'DWRTPT'">
		        <xsl:text>Deep water route part</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'DYKCON'">
		        <xsl:text>Dyke</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'EXEZNE'">
		        <xsl:text>Exclusive economic zone</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'FAIRWY'">
		        <xsl:text>Fairway</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'FERYRT'">
		        <xsl:text>Ferry route</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'FLODOC'">
		        <xsl:text>Floating dock</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'FNCLNE'">
		        <xsl:text>Fence</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'FOGSIG'">
		        <xsl:text>Fog signal</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'FORSTC'">
		        <xsl:text>Fortified structure</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'FRPARE'">
		        <xsl:text>Free port area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'FSHFAC'">
		        <xsl:text>Fishing facility</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'FSHGRD'">
		        <xsl:text>Fishing ground</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'FSHZNE'">
		        <xsl:text>Fishery zone</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'GATCON'">
		        <xsl:text>Gate</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'GRIDRN'">
		        <xsl:text>Gridiron</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'HRBARE'">
		        <xsl:text>Harbour area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'HRBFAC'">
		        <xsl:text>Harbour facility</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'HULKES'">
		        <xsl:text>Hulk</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'ICEARE'">
		        <xsl:text>Ice area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'ICNARE'">
		        <xsl:text>Incineration area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'ISTZNE'">
		        <xsl:text>Inshore traffic zone</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'LAKARE'">
		        <xsl:text>Lake</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'LAKSHR'">
		        <xsl:text>Lake shore</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'LIGHTS'">
		        <xsl:text>Light</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'LITFLT'">
		        <xsl:text>Light float</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'LITVES'">
		        <xsl:text>Light vessel</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'LNDARE'">
		        <xsl:text>Land area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'LNDELV'">
		        <xsl:text>Land elevation</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'LNDMRK'">
		        <xsl:text>Landmark</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'LNDRGN'">
		        <xsl:text>Land region</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'LOCMAG'">
		        <xsl:text>Local magnetic anomaly</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'LOGPON'">
		        <xsl:text>Log pond</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'LOKBSN'">
		        <xsl:text>Lock basin</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'MAGVAR'">
		        <xsl:text>Magnetic variation</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'MARCUL'">
		        <xsl:text>Marine farm</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'MIPARE'">
		        <xsl:text>Military practice area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'MORFAC'">
		        <xsl:text>Mooring facility</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'NAVLNE'">
		        <xsl:text>Navigation line</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'OBSTRN'">
		        <xsl:text>Obstruction</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'OFSPLF'">
		        <xsl:text>Offshore platform</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'OILBAR'">
		        <xsl:text>Oil barrier</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'OSPARE'">
		        <xsl:text>Offshore production area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'PILBOP'">
		        <xsl:text>Pilot boarding place</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'PILPNT'">
		        <xsl:text>Pile</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'PIPARE'">
		        <xsl:text>Pipeline area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'PIPOHD'">
		        <xsl:text>Overhead Pipeline</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'PIPSOL'">
		        <xsl:text>Pipeline submarine/on land</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'PONTON'">
		        <xsl:text>Pontoon</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'PRCARE'">
		        <xsl:text>Precautionary area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'PRDARE'">
		        <xsl:text>Production area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'PYLONS'">
		        <xsl:text>Pylons</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RADLNE'">
		        <xsl:text>Radar line</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RADRFL'">
		        <xsl:text>Radar reflector</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RADRNG'">
		        <xsl:text>Radar range</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RADSTA'">
		        <xsl:text>Radar station</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RAILWY'">
		        <xsl:text>Railway</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RAPIDS'">
		        <xsl:text>Rapids</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RCRTCL'">
		        <xsl:text>Recommended route centerline</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RCTLPT'">
		        <xsl:text>Recommended traffic lane part</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RDOCAL'">
		        <xsl:text>Radio calling in point</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RDOSTA'">
		        <xsl:text>Radio station</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RECTRC'">
		        <xsl:text>Recommended track</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RESARE'">
		        <xsl:text>Restricted area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RETRFL'">
		        <xsl:text>Retro reflector</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RIVBNK'">
		        <xsl:text>River bank</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RIVERS'">
		        <xsl:text>River</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'ROADWY'">
		        <xsl:text>Road</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RSCSTA'">
		        <xsl:text>Rescue station</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RTPBCN'">
		        <xsl:text>Radar transponder beacon</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'RUNWAY'">
		        <xsl:text>Runway</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SBDARE'">
		        <xsl:text>Seabed area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SEAARE'">
		        <xsl:text>Sea area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SILTNK'">
		        <xsl:text>Silo/tank</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SISTAT'">
		        <xsl:text>Signal station, traffic</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SISTAW'">
		        <xsl:text>Signal station</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SLCONS'">
		        <xsl:text>Shoreline Construction</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SLOGRD'">
		        <xsl:text>Sloping ground</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SLOTOP'">
		        <xsl:text>Slope topline</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SMCFAC'">
		        <xsl:text>Small craft facility</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SNDWAV'">
		        <xsl:text>Sand waves</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SOUNDG'">
		        <xsl:text>Sounding</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SPLARE'">
		        <xsl:text>Sea-plane landing area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SPRING'">
		        <xsl:text>Spring</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SQUARE'">
		        <xsl:text>Square</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'STSLNE'">
		        <xsl:text>Straight territorial sea baseline</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SUBTLN'">
		        <xsl:text>Submarine transit lane</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'SWPARE'">
		        <xsl:text>Swept area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TESARE'">
		        <xsl:text>Territorial sea area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TIDEWY'">
		        <xsl:text>Tideway</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TOPMAR'">
		        <xsl:text>Topmark</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TSELNE'">
		        <xsl:text>Traffic separation line</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TSEZNE'">
		        <xsl:text>Traffic separation zone</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TSSBND'">
		        <xsl:text>Traffic separation scheme boundary</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TSSCRS'">
		        <xsl:text>Traffic separation scheme crossing</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TSSLPT'">
		        <xsl:text>Traffic separation scheme lane part</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TSSRON'">
		        <xsl:text>Traffic separation scheme roundabout</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TS_FEB'">
		        <xsl:text>Tidal streams</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TS_PAD'">
		        <xsl:text>Tidal stream panel data</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TS_PNH'">
		        <xsl:text>Tidal stream-non harmonic prediction</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TS_PRH'">
		        <xsl:text>Tidal stream-harmonic prediction</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TS_TIS'">
		        <xsl:text>Tidal stream time series</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TUNNEL'">
		        <xsl:text>Tunnel</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'TWRTPT'">
		        <xsl:text>Two-way route part</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'T_HMON'">
		        <xsl:text>Tide - harmonic prediction</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'T_NHMN'">
		        <xsl:text>Tide - non-harmonic prediction</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'T_TIMS'">
		        <xsl:text>Tide - time series</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'UNSARE'">
		        <xsl:text>Unsurveyed area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'UWTROC'">
		        <xsl:text>Rock</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'VEGATN'">
		        <xsl:text>Vegetation</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'WATFAL'">
		        <xsl:text>Waterfall</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'WATTUR'">
		        <xsl:text>Water turbulence</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'WEDKLP'">
		        <xsl:text>Weed/Kelp</xsl:text>
		    </xsl:when>
		    <xsl:when test="$featureClass = 'WRECKS'">
		        <xsl:text>Wreck</xsl:text>
		    </xsl:when>
			<xsl:otherwise>
				<!-- Default to spit out Feature Acronym if no when clause is found  -->
				<xsl:value-of select="$featureClass"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Template to lookup an Attribute Acronym  -->
	<xsl:template name="lookupAttribute">
		<xsl:param name="attributeClass"/>
		<xsl:choose>
		    <xsl:when test="$attributeClass = '$NTXST'">
		        <xsl:text>Text string in national language</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'AGENCY'">
		        <xsl:text>Agency responsible for production</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'BCNSHP'">
		        <xsl:text>Beacon shape</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'BOYSHP'">
		        <xsl:text>Buoy shape</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'BUISHP'">
		        <xsl:text>Building shape</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'BURDEP'">
		        <xsl:text>Buried depth</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CALSGN'">
		        <xsl:text>Call sign</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATACH'">
		        <xsl:text>Category of anchorage</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATAIR'">
		        <xsl:text>Category of airport/airfield</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATBRG'">
		        <xsl:text>Category of bridge</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATBUA'">
		        <xsl:text>Category of built-up area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATCAM'">
		        <xsl:text>Category of cardinal mark</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATCAN'">
		        <xsl:text>Category of canal</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATCBL'">
		        <xsl:text>Category of cable</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATCHP'">
		        <xsl:text>Category of checkpoint</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATCOA'">
		        <xsl:text>Category of coastline</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATCON'">
		        <xsl:text>Category of conveyor</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATCOV'">
		        <xsl:text>Category of coverage</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATCRN'">
		        <xsl:text>Category of crane</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATCTR'">
		        <xsl:text>Category of control point</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATDAM'">
		        <xsl:text>Category of dam</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATDIS'">
		        <xsl:text>Category of distance mark</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATDOC'">
		        <xsl:text>Category of dock</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATDPG'">
		        <xsl:text>Category of dumping ground</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATFIF'">
		        <xsl:text>Category of fishing facility</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATFNC'">
		        <xsl:text>Category of fence</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATFOG'">
		        <xsl:text>Category of fog signal</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATFOR'">
		        <xsl:text>Category of fortified structure</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATFRY'">
		        <xsl:text>Category of ferry</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATGAT'">
		        <xsl:text>Category of gate</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATHAF'">
		        <xsl:text>Category of harbour facility</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATHLK'">
		        <xsl:text>Category of hulk</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATICE'">
		        <xsl:text>Category of ice</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATINB'">
		        <xsl:text>Category of installation buoy</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATLAM'">
		        <xsl:text>Category of lateral mark</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATLIT'">
		        <xsl:text>Category of light</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATLMK'">
		        <xsl:text>Category of landmark</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATLND'">
		        <xsl:text>Category of land region</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATMFA'">
		        <xsl:text>Category of marine farm/culture</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATMOR'">
		        <xsl:text>Category of mooring/warping facility</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATMPA'">
		        <xsl:text>Category of military practice area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATNAV'">
		        <xsl:text>Category of navigation line</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATOBS'">
		        <xsl:text>Category of obstruction</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATOFP'">
		        <xsl:text>Category of offshore platform</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATOLB'">
		        <xsl:text>Category of oil barrier</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATPIL'">
		        <xsl:text>Category of pilot boarding place</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATPIP'">
		        <xsl:text>Category of pipeline/pipe</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATPLE'">
		        <xsl:text>Category of pile</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATPRA'">
		        <xsl:text>Category of production area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATPYL'">
		        <xsl:text>Category of pylon</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATQUA'">
		        <xsl:text>Category of quality of data</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATRAS'">
		        <xsl:text>Category of radar station</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATREA'">
		        <xsl:text>Category of restricted area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATROD'">
		        <xsl:text>Category of road</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATROS'">
		        <xsl:text>Category of radio station</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATRSC'">
		        <xsl:text>Category of rescue station</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATRTB'">
		        <xsl:text>Category of radar transponder beacon</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATRUN'">
		        <xsl:text>Category of runway</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATSCF'">
		        <xsl:text>Category of small craft facility</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATSEA'">
		        <xsl:text>Category of sea area</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATSIL'">
		        <xsl:text>Category of silo/tank</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATSIT'">
		        <xsl:text>Category of signal station, traffic</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATSIW'">
		        <xsl:text>Category of signal station, warning</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATSLC'">
		        <xsl:text>Category of shoreline construction</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATSLO'">
		        <xsl:text>Category of slope</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATSPM'">
		        <xsl:text>Category of special purpose mark</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATTRK'">
		        <xsl:text>Category of recommended track</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATTSS'">
		        <xsl:text>Category of Traffic Separation Scheme</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATVEG'">
		        <xsl:text>Category of vegetation</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATWAT'">
		        <xsl:text>Category of water turbulence</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATWED'">
		        <xsl:text>Category of weed/kelp</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATWRK'">
		        <xsl:text>Category of wreck</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CATZOC'">
		        <xsl:text>Category of zone of confidence in data</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CAT_TS'">
		        <xsl:text>Category of Tidal stream</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'COLOUR'">
		        <xsl:text>Colour</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'COLPAT'">
		        <xsl:text>Colour pattern</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'COMCHA'">
		        <xsl:text>Communication channel</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CONDTN'">
		        <xsl:text>Condition</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CONRAD'">
		        <xsl:text>Conspicuous, radar</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CONVIS'">
		        <xsl:text>Conspicuous, visually</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CPDATE'">
		        <xsl:text>Compilation date</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CSCALE'">
		        <xsl:text>Compilation scale</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CURVEL'">
		        <xsl:text>Current velocity</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'DATEND'">
		        <xsl:text>Date end</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'DATSTA'">
		        <xsl:text>Date start</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'DRVAL1'">
		        <xsl:text>Depth range value 1</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'DRVAL2'">
		        <xsl:text>Depth range value 2</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'DUNITS'">
		        <xsl:text>Depth units</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'ELEVAT'">
		        <xsl:text>Elevation</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'ESTRNG'">
		        <xsl:text>Estimated range of transmission</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'EXCLIT'">
		        <xsl:text>Exhibition condition of light</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'EXPSOU'">
		        <xsl:text>Exposition of sounding</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'FUNCTN'">
		        <xsl:text>Function</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'HEIGHT'">
		        <xsl:text>Height</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'HORACC'">
		        <xsl:text>Horizontal accuracy</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'HORCLR'">
		        <xsl:text>Horizontal clearance</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'HORDAT'">
		        <xsl:text>Horizontal datum</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'HORLEN'">
		        <xsl:text>Horizontal length</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'HORWID'">
		        <xsl:text>Horizontal width</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'HUNITS'">
		        <xsl:text>Height/length units</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'ICEFAC'">
		        <xsl:text>Ice factor</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'INFORM'">
		        <xsl:text>Information</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'JRSDTN'">
		        <xsl:text>Jurisdiction</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'LIFCAP'">
		        <xsl:text>Lifting capacity</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'LITCHR'">
		        <xsl:text>Light characteristic</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'LITVIS'">
		        <xsl:text>Light visibility</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'MARSYS'">
		        <xsl:text>Marks navigational - system of</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'MLTYLT'">
		        <xsl:text>Multiplicity of lights</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'NATCON'">
		        <xsl:text>Nature of construction</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'NATION'">
		        <xsl:text>Nationality</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'NATQUA'">
		        <xsl:text>Nature of surface - qualifying terms</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'NATSUR'">
		        <xsl:text>Nature of surface</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'NINFOM'">
		        <xsl:text>Information in national language</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'NMDATE'">
		        <xsl:text>Notice to Mariners date</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'NOBJNM'">
		        <xsl:text>Object name in national language</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'NPLDST'">
		        <xsl:text>Pilot district in national character set</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'NTXTDS'">
		        <xsl:text>Textual description in national language</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'OBJNAM'">
		        <xsl:text>Object name</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'ORIENT'">
		        <xsl:text>Orientation</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'PEREND'">
		        <xsl:text>Periodic date end</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'PERSTA'">
		        <xsl:text>Periodic date start</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'PICREP'">
		        <xsl:text>Pictorial representation</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'PILDST'">
		        <xsl:text>Pilot district</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'POSACC'">
		        <xsl:text>Positional accuracy</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'PRCTRY'">
		        <xsl:text>Producing country</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'PRODCT'">
		        <xsl:text>Product</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'PUBREF'">
		        <xsl:text>Publication reference</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'PUNITS'">
		        <xsl:text>Positional accuracy units</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'QUAPOS'">
		        <xsl:text>Quality of position</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'QUASOU'">
		        <xsl:text>Quality of sounding measurement</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'RADIUS'">
		        <xsl:text>Radius</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'RADWAL'">
		        <xsl:text>Radar wave length</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'RECDAT'">
		        <xsl:text>Recording date</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'RECIND'">
		        <xsl:text>Recording indication</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'RESTRN'">
		        <xsl:text>Restriction</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'RYRMGV'">
		        <xsl:text>Reference year for magnetic variation</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SCAMAX'">
		        <xsl:text>Scale maximum</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SCAMIN'">
		        <xsl:text>Scale minimum</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SCVAL1'">
		        <xsl:text>Scale value one</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SCVAL2'">
		        <xsl:text>Scale value two</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SDISMN'">
		        <xsl:text>Sounding distance - minimum</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SDISMX'">
		        <xsl:text>Sounding distance - maximum</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SECTR1'">
		        <xsl:text>Sector limit one</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SECTR2'">
		        <xsl:text>Sector limit two</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SHIPAM'">
		        <xsl:text>Shift parameters</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SIGFRQ'">
		        <xsl:text>Signal frequency</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SIGGEN'">
		        <xsl:text>Signal generation</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SIGGRP'">
		        <xsl:text>Signal group</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SIGPER'">
		        <xsl:text>Signal period</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SIGSEQ'">
		        <xsl:text>Signal sequence</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SORDAT'">
		        <xsl:text>Source date</xsl:text>
		    </xsl:when>
		   <!-- <xsl:when test="$attributeClass = 'SORIND'">
		        <xsl:text>Source indication</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SOUACC'">
		        <xsl:text>Sounding accuracy</xsl:text>
		    </xsl:when>-->
		    <xsl:when test="$attributeClass = 'STATUS'">
		        <xsl:text>Status</xsl:text>
		    </xsl:when>
		    <!--<xsl:when test="$attributeClass = 'SURATH'">
		        <xsl:text>Survey authority</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SUREND'">
		        <xsl:text>Survey date - end</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SURSTA'">
		        <xsl:text>Survey date - start</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SURTYP'">
		        <xsl:text>Survey type</xsl:text>
		    </xsl:when>-->
		    <xsl:when test="$attributeClass = 'TECSOU'">
		        <xsl:text>Technique of sounding measurement</xsl:text>
		    </xsl:when>
		    <!--<xsl:when test="$attributeClass = 'TIMEND'">
		        <xsl:text>Time end</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'TIMSTA'">
		        <xsl:text>Time start</xsl:text>
		    </xsl:when>-->
		    <xsl:when test="$attributeClass = 'TOPSHP'">
		        <xsl:text>Topmark/daymark shape</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'TRAFIC'">
		        <xsl:text>Traffic flow</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'TS_TSP'">
		        <xsl:text>Tidal stream - panel values</xsl:text>
		    </xsl:when>
		    <!--<xsl:when test="$attributeClass = 'TS_TSV'">
		        <xsl:text>Tide stream - time series values</xsl:text>
		    </xsl:when>-->
		    <xsl:when test="$attributeClass = 'TXTDSC'">
		        <xsl:text>Textual description</xsl:text>
		    </xsl:when>
		    <!--<xsl:when test="$attributeClass = 'T_ACWL'">
		        <xsl:text>Tidal - accuracy of water level</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'T_HWLW'">
		        <xsl:text>Tidal - high and low water values</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'T_MTOD'">
		        <xsl:text>Tide - method of Tidal prediction</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'T_THDF'">
		        <xsl:text>Tide - time and height differences</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'T_TINT'">
		        <xsl:text>Tidal - time interval of values</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'T_TSVL'">
		        <xsl:text>Tide - time series values</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'T_VAHC'">
		        <xsl:text>Value of harmonic constituents</xsl:text>
		    </xsl:when>-->
		    <xsl:when test="$attributeClass = 'VALACM'">
		        <xsl:text>Value of annual change in magnetic variation</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'VALDCO'">
		        <xsl:text>Value of depth contour</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'VALLMA'">
		        <xsl:text>Value of local magnetic anomaly</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'VALMAG'">
		        <xsl:text>Value of magnetic variation</xsl:text>
		    </xsl:when>
		    <!--<xsl:when test="$attributeClass = 'VALMXR'">
		        <xsl:text>Value of maximum range</xsl:text>
		    </xsl:when>-->
		    <xsl:when test="$attributeClass = 'VALNMR'">
		        <xsl:text>Value of nominal range</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'VALSOU'">
		        <xsl:text>Value of sounding</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'VERACC'">
		        <xsl:text>Vertical accuracy</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'VERCCL'">
		        <xsl:text>Vertical clearance, closed</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'VERCLR'">
		        <xsl:text>Vertical clearance</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'VERCOP'">
		        <xsl:text>Vertical clearance, open</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'VERCSA'">
		        <xsl:text>Vertical clearance, safe</xsl:text>
		    </xsl:when>
		    <!--<xsl:when test="$attributeClass = 'VERDAT'">
		        <xsl:text>Vertical datum</xsl:text>
		    </xsl:when>-->
		    <xsl:when test="$attributeClass = 'VERLEN'">
		        <xsl:text>Vertical length</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'WATLEV'">
		        <xsl:text>Water level effect</xsl:text>
		    </xsl:when>
		   <!-- <xsl:when test="$attributeClass = 'CLSDEF'">
		        <xsl:text>Object Class Definition</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'CLSNAM'">
		        <xsl:text>Object Class Name</xsl:text>
		    </xsl:when>
		    <xsl:when test="$attributeClass = 'SYMINS'">
		        <xsl:text>Symbol Instruction</xsl:text>
		    </xsl:when>-->

			<xsl:otherwise>
				<!-- Default to spit out Attribute Acronym if no when clause is found  -->
				<xsl:value-of select="$attributeClass"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Template to match a COLOUR Attribute  -->
	<xsl:template name="lookupColour">
		<xsl:param name="clrnum"/>
		<xsl:choose>
			<xsl:when test="$clrnum = '1'">
				<xsl:text>white</xsl:text>
			</xsl:when>
			<xsl:when test="$clrnum = '2'">
				<xsl:text>black</xsl:text>
			</xsl:when>
			<xsl:when test="$clrnum = '3'">
				<xsl:text>red</xsl:text>
			</xsl:when>
			<xsl:when test="$clrnum = '4'">
				<xsl:text>green</xsl:text>
			</xsl:when>
			<xsl:when test="$clrnum = '5'">
				<xsl:text>blue</xsl:text>
			</xsl:when>
			<xsl:when test="$clrnum = '6'">
				<xsl:text>yellow</xsl:text>
			</xsl:when>
			<xsl:when test="$clrnum = '7'">
				<xsl:text>grey</xsl:text>
			</xsl:when>
			<xsl:when test="$clrnum = '8'">
				<xsl:text>brown</xsl:text>
			</xsl:when>
			<xsl:when test="$clrnum = '9'">
				<xsl:text>amber</xsl:text>
			</xsl:when>
			<xsl:when test="$clrnum = '10'">
				<xsl:text>violet</xsl:text>
			</xsl:when>
			<xsl:when test="$clrnum = '11'">
				<xsl:text>orange</xsl:text>
			</xsl:when>
			<xsl:when test="$clrnum = '12'">
				<xsl:text>magenta</xsl:text>
			</xsl:when>
			<xsl:when test="$clrnum = '13'">
				<xsl:text>pink</xsl:text>
			</xsl:when>
			<xsl:when test="$clrnum = 'UNKNOWN'"> </xsl:when>
			<xsl:when test="$clrnum = ''"> </xsl:when>
			<xsl:otherwise>
				<xsl:text> Unknown Colour </xsl:text>
				<xsl:value-of select="$clrnum"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Template to match a BOYSHP Attribute  -->
	<xsl:template match="Attribute[@acronym='BOYSHP']">
		<xsl:choose>
			<xsl:when test="@value = '1'">
				<xsl:text>nun</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '2'">
				<xsl:text>can</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '3'">
				<xsl:text>sperical</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '4'">
				<xsl:text>pillar</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '5'">
				<xsl:text>spar</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '6'">
				<xsl:text>barrel</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '7'">
				<xsl:text>super</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '8'">
				<xsl:text>ice</xsl:text>
			</xsl:when>
			<xsl:when test="@value = ''"> </xsl:when>
			<xsl:otherwise> </xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Template to match a CATLMK Attribute  -->
	<xsl:template name="catlmkLookup">
		<xsl:param name="value"/>

		<xsl:choose>
			<xsl:when test="@value = '1'">
				<xsl:text>cairn</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '2'">
				<xsl:text>cemetery</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '3'">
				<xsl:text>chimney</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '4'">
				<xsl:text>dish aerial</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '5'">
				<xsl:text>flagstaff</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '6'">
				<xsl:text>flare stack</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '7'">
				<xsl:text>mast</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '8'">
				<xsl:text>windsock</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '9'">
				<xsl:text>monument</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '10'">
				<xsl:text>column</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '11'">
				<xsl:text>memorial</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '12'">
				<xsl:text>obelisk</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '13'">
				<xsl:text>statue</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '14'">
				<xsl:text>cross</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '15'">
				<xsl:text>dome</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '16'">
				<xsl:text>radar</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '17'">
				<xsl:text>tower</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '18'">
				<xsl:text>windmill</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '19'">
				<xsl:text>windmotor</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '20'">
				<xsl:text>spire</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '21'">
				<xsl:text>boulder</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '22'">
				<xsl:text>rock pinnacle</xsl:text>
			</xsl:when>
			<xsl:when test="@value = ''"> </xsl:when>
			<xsl:otherwise>
				<xsl:text> Unknown construction </xsl:text>
				<xsl:value-of select="@value"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Template to match a NATCON Attribute  -->
	<xsl:template match="Attribute[@acronym='NATCON']">
		<xsl:choose>
			<xsl:when test="@value = '1'">
				<xsl:text>masonry</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '2'">
				<xsl:text>concrete</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '3'">
				<xsl:text>boulders</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '4'">
				<xsl:text>hard surfaced</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '5'">
				<xsl:text>unsurfaced</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '6'">
				<xsl:text>wooden</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '7'">
				<xsl:text>metal</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '8'">
				<xsl:text>GRP</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '9'">
				<xsl:text>painted</xsl:text>
			</xsl:when>
			<xsl:when test="@value = ''"> </xsl:when>
			<xsl:otherwise>
				<xsl:text> Unknown construction </xsl:text>
				<xsl:value-of select="@value"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Template to match a WATLEV Attribute  -->
	<xsl:template match="watlevLookup">
		<xsl:param name="value"/>
		<xsl:choose>
			<xsl:when test="@value = '1'">
				<xsl:text>partly submerged at high water</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '2'">
				<xsl:text>always dry</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '3'">
				<xsl:text>always under water/submerged</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '4'">
				<xsl:text>covers and uncovers</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '5'">
				<xsl:text>awash</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '6'">
				<xsl:text>subject to inundation or flooding</xsl:text>
			</xsl:when>
			<xsl:when test="@value = '7'">
				<xsl:text>floating</xsl:text>
			</xsl:when>
			<xsl:when test="@value = ''"> </xsl:when>
			<xsl:otherwise> </xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="multiple-incorrect-values-replacement">
		<xsl:param name="input"/>
		<xsl:variable name="r1">
			<xsl:call-template name="replace-srtring">
				<xsl:with-param name="text" select="$input"/>
				<xsl:with-param name="replace" select="',,'"/>
				<xsl:with-param name="with" select="','"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="r2">
			<xsl:call-template name="replace-srtring">
				<xsl:with-param name="text" select="$r1"/>
				<xsl:with-param name="replace" select="'()'"/>
				<xsl:with-param name="with" select="''"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="r3">
			<xsl:call-template name="replace-srtring">
				<xsl:with-param name="text" select="$r2"/>
				<xsl:with-param name="replace" select="'(,)'"/>
				<xsl:with-param name="with" select="''"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="r4">
			<xsl:call-template name="replace-srtring">
				<xsl:with-param name="text" select="$r3"/>
				<xsl:with-param name="replace" select="',,'"/>
				<xsl:with-param name="with" select="','"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="r5">
			<xsl:call-template name="replace-srtring">
				<xsl:with-param name="text" select="$r4"/>
				<xsl:with-param name="replace" select="'(,'"/>
				<xsl:with-param name="with" select="'('"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="r6">
			<xsl:call-template name="replace-srtring">
				<xsl:with-param name="text" select="$r5"/>
				<xsl:with-param name="replace" select="',)'"/>
				<xsl:with-param name="with" select="')'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="r07">
			<xsl:call-template name="replace-srtring">
				<xsl:with-param name="text" select="$r6"/>
				<xsl:with-param name="replace" select="' )'"/>
				<xsl:with-param name="with" select="')'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="r7">
			<xsl:call-template name="replace-srtring">
				<xsl:with-param name="text" select="$r07"/>
				<xsl:with-param name="replace" select="' ,'"/>
				<xsl:with-param name="with" select="','"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="r8">
			<xsl:variable name="last-char">
			<xsl:value-of select="substring($r7,string-length($r7),1)"/>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="$last-char=','">
					<xsl:value-of select="substring($r7,1,string-length($r7)-1)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$r7"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:copy-of select="$r8"/>
	</xsl:template>

	<xsl:template name="replace-srtring">
		<xsl:param name="text"/>
		<xsl:param name="replace"/>
		<xsl:param name="with"/>
		<xsl:choose>
			<xsl:when test="contains($text,$replace)">
				<xsl:value-of select="substring-before($text,$replace)"/>
				<xsl:value-of select="$with"/>
				<xsl:call-template name="replace-srtring">
					<xsl:with-param name="text" select="substring-after($text,$replace)"/>
					<xsl:with-param name="replace" select="$replace"/>
					<xsl:with-param name="with" select="$with"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:transform>

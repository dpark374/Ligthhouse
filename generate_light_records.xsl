<?xml version="1.0" encoding="utf-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <!-- changes made on 31st-Mar-2020 IIC -->
  <!-- NTM-291,NTM272,NTM-288 updated by 23-Feb-2021, IIC -->
  <xsl:import href="lookups.xsl"/>
  <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  <xsl:variable name="characters" select="'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

  <xsl:key name="featureids" match="/Report/Features/Feature" use="@fid"/>

  <!-- Root template -->
  <xsl:template match="/">
    <xsl:apply-templates select="Report/Locations"/>
  </xsl:template>
  <!-- <xsl:func name="functx:substring-before-if-contains" as="xs:string?"
    xmlns:functx="http://www.functx.com">
    <xsl:param name="arg" as="xs:string?"/>
    <xsl:param name="delim" as="xs:string"/>
    
    <xsl:sequence select="
      if (contains($arg,$delim))
      then substring-before($arg,$delim)
      else $arg
      "/>
    
  </xsl:func>-->

  <!-- Locations template -->
  <xsl:template match="Locations">
    <xsl:element name="Objects">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <!-- Point Location template,  for each position in the input document (Generic product) -->
  <xsl:template match="Location[Geometry/Point]">

    <xsl:variable name="x" select="Geometry/Point/@x"/>
    <xsl:variable name="y" select="Geometry/Point/@y"/>


    <xsl:variable name="currentFeatures">
      <xsl:variable name="foid">
        <xsl:value-of select="@fid"/>
      </xsl:variable>
      <xsl:for-each select="./CollocatedFeature">
<!--        <xsl:sort select="//Features/Feature[@fid = $foid]/Attributes[Attribute[@acronym='llknum' and @value]]" order="ascending" />-->
        <xsl:value-of select="//Features/Feature[@fid = $foid]/Attributes[Attribute[@acronym='llknum' and @value]]"/>
        
        <xsl:value-of select="@fid"/>
        <xsl:text>,</xsl:text>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="lightFeatures">
      <xsl:variable name="foid">
        <xsl:value-of select="@fid"/>
      </xsl:variable>
      <xsl:if test="./CollocatedFeature/@acronym ='LIGHTS'">
        <xsl:for-each select="./CollocatedFeature">
          <xsl:sort select="//Features/Feature[@fid = $foid]/Attributes[Attribute[@acronym='llknum' and @value]]" order="ascending" />
          <!--<xsl:sort select="@fid"/>-->
          <xsl:value-of select="@fid"/>
          <xsl:text>,</xsl:text>
        </xsl:for-each>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="mooring">
      <xsl:if test="./CollocatedFeature/@acronym ='MORFAC'">
        <xsl:variable name="foid">
          <xsl:value-of select="@fid"/>
        </xsl:variable>
        <xsl:for-each select="./CollocatedFeature">
          <xsl:sort select="//Features/Feature[@fid = $foid]/Attributes[Attribute[@acronym='llknum' and @value]]" order="ascending" />
          <!--<xsl:sort select="@fid"/>-->
          <xsl:value-of select="@fid"/>
          <xsl:text>,</xsl:text>
        </xsl:for-each>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="lightAcronym" select="'LIGHTS'"/>
    <xsl:variable name="mooringAcronym" select="'MORFAC'"/>
    <xsl:variable name="mainFeatures" select="'LIGHTS,FOGSIG'"/>
    <xsl:variable name="masterFeatures"
      select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP,BOYCAR,BOYINB,BOYISD,BOYLAT,BOYSAW,BOYSPP,BUISGL,LNDMRK,LITFLT,LITVES,DAYMRK,MORFAC,OFSPLF,PILPNT'"/>
    <xsl:variable name="slaveFeatures"
      select="'RETRFL,FOGSIG,RTPBCN,SISTAW,TOPMAR,DAYMAR,SISTAT,LIGHTS'"/>
    <xsl:variable name="allFeatures"
      select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP,BOYCAR,BOYINB,BOYISD,BOYLAT,BOYSAW,BOYSPP,BUISGL,LNDMRK,LITFLT,LITVES,DAYMRK,MORFAC,OFSPLF,PILPNT,RETRFL,FOGSIG,RTPBCN,SISTAW,TOPMAR,DAYMAR,SISTAT,LIGHTS'"/>
    <!-- <xsl:text> currentFeatures :: </xsl:text>
      <xsl:value-of select="$currentFeatures"/>
      <xsl:text>  </xsl:text>-->
    <xsl:variable name="llk_number">

      <xsl:call-template name="get_attribute_from_feature_list_llknum">
        <xsl:with-param name="featureIds" select="$currentFeatures"/>
        <xsl:with-param name="featureAcronyms" select="$allFeatures"/>
        <xsl:with-param name="attribute" select="'llknum'"/>
      </xsl:call-template>

    </xsl:variable>
    <!--<xsl:text> llk_number :: </xsl:text>
      <xsl:value-of select="$llk_number"/>
      <xsl:text>  </xsl:text>-->
    <xsl:variable name="llk_with_fid">
      <xsl:call-template name="current_fid_llk">
        <xsl:with-param name="llk_num" select="$llk_number"/>
      </xsl:call-template>
    </xsl:variable>
  
    <!--<xsl:text> llk_with_fid :: </xsl:text>
      <xsl:value-of select="$llk_with_fid"/>
      <xsl:text>  </xsl:text>-->
    <xsl:variable name="original_llk">
      <xsl:choose>
        <xsl:when test="contains($llk_with_fid,'#')">
          <!--<xsl:value-of select="substring-before($llk_with_fid,'#')"/>-->
          <xsl:call-template name="original_llk_template">
            <xsl:with-param name="llk_num" select="$llk_with_fid"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$llk_with_fid"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!--<xsl:text> original_llk :: </xsl:text>
      <xsl:value-of select="$original_llk"/>
      <xsl:text>  </xsl:text>-->
    <xsl:variable name="other_llk">
      <xsl:choose>
        <xsl:when test="contains($llk_with_fid,'#')">
       <!--   <xsl:when test="substring-after($llk_with_fid,'#')!=''">-->
          <xsl:call-template name="other_llk_template">
            <xsl:with-param name="llk_num" select="$llk_with_fid"/>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <!-- <xsl:text> other_llk :: </xsl:text>
      <xsl:value-of select="$other_llk"/>
      <xsl:text>  </xsl:text>-->

    <xsl:variable name="other_llk_add">
      <xsl:if test="contains($llk_with_fid,'@')">
        <xsl:call-template name="other_llk_add_template">
          <xsl:with-param name="llk_num" select="$llk_with_fid"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:variable>

    <!--<xsl:text> other_llk_add :: </xsl:text>
      <xsl:value-of select="$other_llk_add"/>
      <xsl:text>  </xsl:text>-->

    <xsl:variable name="other_llk_last">
      <xsl:if test="contains($llk_with_fid,'$')">
        <xsl:call-template name="other_llk_last_template">
          <xsl:with-param name="llk_num" select="$llk_with_fid"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:variable>
    <!--<xsl:text> other_llk_last :: </xsl:text>
      <xsl:value-of select="$other_llk_last"/>
      <xsl:text>  </xsl:text>-->

    <xsl:variable name="add_llk_one" select="translate($other_llk,'#','')"/>
    <xsl:variable name="add_llk_two" select="translate($other_llk_add,'@','')"/>
    <xsl:variable name="add_llk_three" select="translate($other_llk_last,'$','')"/>
     <!--<xsl:text> original_llk :: </xsl:text>
      <xsl:value-of select="$original_llk"/>
      <xsl:text>  </xsl:text>
      <xsl:text> other_llk :: </xsl:text>
      <xsl:value-of select="$other_llk"/>
      <xsl:text>  </xsl:text>
      <xsl:text> add_llk :: </xsl:text>
      <xsl:value-of select="$add_llk_one"/>
      <xsl:text>  </xsl:text>
      <xsl:text> add_llk_two :: </xsl:text>
      <xsl:value-of select="$add_llk_two"/>
      <xsl:text>  </xsl:text>
      <xsl:text> add_llk_three :: </xsl:text>
      <xsl:value-of select="$add_llk_three"/>
      <xsl:text>  </xsl:text>-->
    <xsl:variable name="orginal_fids">
      <xsl:call-template name="list_of_fid">
        <xsl:with-param name="llk_num" select="$original_llk"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="additional_fids_one">
      <xsl:call-template name="list_of_fid">
        <xsl:with-param name="llk_num" select="$add_llk_one"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="additional_fids_two">
      <xsl:call-template name="list_of_fid">
        <xsl:with-param name="llk_num" select="$add_llk_two"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="additional_fids_three">
      <xsl:call-template name="list_of_fid">
        <xsl:with-param name="llk_num" select="$add_llk_three"/>
      </xsl:call-template>
    </xsl:variable>
    <!--<xsl:text> orginal_fids :: </xsl:text>
      <xsl:value-of select="$orginal_fids"/>
      <xsl:text> ***  </xsl:text>
      <xsl:text> additional_fids_one :: </xsl:text>
      <xsl:value-of select="$additional_fids_one"/>
    <xsl:text> ***  </xsl:text>
      <xsl:text> additional_fids_two :: </xsl:text>
      <xsl:value-of select="$additional_fids_two"/>
    <xsl:text> ***  </xsl:text>
      <xsl:text> additional_fids_three :: </xsl:text>
      <xsl:value-of select="$additional_fids_three "/>
    <xsl:text> ***  </xsl:text>-->
    <xsl:variable name="features">
      <xsl:choose>
        <xsl:when test="normalize-space($additional_fids_three) != ''">
          <xsl:value-of
            select="concat($orginal_fids,'#',$additional_fids_one,'@',$additional_fids_two,'$',$additional_fids_three)"
          />
        </xsl:when>
        <xsl:when test="normalize-space($additional_fids_two) != ''">
          <xsl:value-of
            select="concat($orginal_fids,'#',$additional_fids_one,'@',$additional_fids_two)"/>
        </xsl:when>
        <xsl:when test="normalize-space($additional_fids_one) != ''">
          <xsl:value-of select="concat($orginal_fids,'#',$additional_fids_one)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$orginal_fids"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!--<xsl:text> features :: </xsl:text>
      <xsl:value-of select="$features"/>
      <xsl:text>  </xsl:text>-->
    
    <xsl:call-template name="to_main_light_records">
      <xsl:with-param name="featureIds" select="$features"/>
      <xsl:with-param name="lightFeatures" select="$lightFeatures"/>
      <xsl:with-param name="mooring" select="$mooring"/>
      <xsl:with-param name="x" select="$x"/>
      <xsl:with-param name="y" select="$y"/>
    </xsl:call-template>


  </xsl:template>
  <xsl:template name="to_main_light_records">
    <xsl:param name="featureIds"/>
    <xsl:param name="lightFeatures"/>
    <xsl:param name="mooring"/>
    <xsl:param name="x"/>
    <xsl:param name="y"/>

    <xsl:if test="$featureIds != ''">
    <!--<xsl:text> $featureIds </xsl:text>
      <xsl:value-of select="$featureIds"/>
      <xsl:text> *** </xsl:text>-->
      <xsl:choose>
        <xsl:when test="contains($featureIds,'$')">
          <xsl:variable name="original_fid" select="substring-before($featureIds,'#')"/>
          <xsl:variable name="other_fids_one"
            select="substring-before(substring-after($featureIds,'#'),'@')"/>
          <xsl:variable name="other_fids_two"
            select="substring-before(substring-after($featureIds,'@'),'$')"/>
          <xsl:variable name="other_fids_three" select="substring-after($featureIds,'$')"/>
         
          <xsl:call-template name="main_temp">
            <xsl:with-param name="currentFeatures" select="$original_fid"/>
            <xsl:with-param name="lightFeatures" select="$lightFeatures"/>
            <xsl:with-param name="mooring" select="$mooring"/>
            <xsl:with-param name="x" select="$x"/>
            <xsl:with-param name="y" select="$y"/>
          </xsl:call-template>
          <xsl:call-template name="main_temp">
            <xsl:with-param name="currentFeatures" select="$other_fids_one"/>
            <xsl:with-param name="lightFeatures" select="$lightFeatures"/>
            <xsl:with-param name="mooring" select="$mooring"/>
            <xsl:with-param name="x" select="$x"/>
            <xsl:with-param name="y" select="$y"/>
          </xsl:call-template>
          <xsl:call-template name="main_temp">
            <xsl:with-param name="currentFeatures" select="$other_fids_two"/>
            <xsl:with-param name="lightFeatures" select="$lightFeatures"/>
            <xsl:with-param name="mooring" select="$mooring"/>
            <xsl:with-param name="x" select="$x"/>
            <xsl:with-param name="y" select="$y"/>
          </xsl:call-template>
          <xsl:call-template name="main_temp">
            <xsl:with-param name="currentFeatures" select="$other_fids_three"/>
            <xsl:with-param name="lightFeatures" select="$lightFeatures"/>
            <xsl:with-param name="mooring" select="$mooring"/>
            <xsl:with-param name="x" select="$x"/>
            <xsl:with-param name="y" select="$y"/>
          </xsl:call-template>

        </xsl:when>
        <xsl:when test="contains($featureIds,'@')">
          <xsl:variable name="original_fid" select="substring-before($featureIds,'#')"/>
          <xsl:variable name="other_fids_one"
            select="substring-before(substring-after($featureIds,'#'),'@')"/>
          <xsl:variable name="other_fids_two" select="substring-after($featureIds,'@')"/>
          <xsl:call-template name="main_temp">
            <xsl:with-param name="currentFeatures" select="$original_fid"/>
            <xsl:with-param name="lightFeatures" select="$lightFeatures"/>
            <xsl:with-param name="mooring" select="$mooring"/>
            <xsl:with-param name="x" select="$x"/>
            <xsl:with-param name="y" select="$y"/>
          </xsl:call-template>
          <xsl:call-template name="main_temp">
            <xsl:with-param name="currentFeatures" select="$other_fids_one"/>
            <xsl:with-param name="lightFeatures" select="$lightFeatures"/>
            <xsl:with-param name="mooring" select="$mooring"/>
            <xsl:with-param name="x" select="$x"/>
            <xsl:with-param name="y" select="$y"/>
          </xsl:call-template>
          <xsl:call-template name="main_temp">
            <xsl:with-param name="currentFeatures" select="$other_fids_two"/>
            <xsl:with-param name="lightFeatures" select="$lightFeatures"/>
            <xsl:with-param name="mooring" select="$mooring"/>
            <xsl:with-param name="x" select="$x"/>
            <xsl:with-param name="y" select="$y"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($featureIds,'#')">
          <xsl:variable name="original_fid" select="substring-before($featureIds,'#')"/>
          <xsl:variable name="other_fids_one" select="substring-after($featureIds,'#')"/>
          <xsl:call-template name="main_temp">
            <xsl:with-param name="currentFeatures" select="$original_fid"/>
            <xsl:with-param name="lightFeatures" select="$lightFeatures"/>
            <xsl:with-param name="mooring" select="$mooring"/>
            <xsl:with-param name="x" select="$x"/>
            <xsl:with-param name="y" select="$y"/>
          </xsl:call-template>
          <xsl:call-template name="main_temp">
            <xsl:with-param name="currentFeatures" select="$other_fids_one"/>
            <xsl:with-param name="lightFeatures" select="$lightFeatures"/>
            <xsl:with-param name="mooring" select="$mooring"/>
            <xsl:with-param name="x" select="$x"/>
            <xsl:with-param name="y" select="$y"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="main_temp">
            <xsl:with-param name="currentFeatures" select="$featureIds"/>
            <xsl:with-param name="lightFeatures" select="$lightFeatures"/>
            <xsl:with-param name="mooring" select="$mooring"/>
            <xsl:with-param name="x" select="$x"/>
            <xsl:with-param name="y" select="$y"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>


      <!--<xsl:choose>
       <xsl:when test="not(contains($featureIds,'#'))">
         <!-\-<xsl:text> featureIds :: </xsl:text>
         <xsl:value-of select="$featureIds"/>
         <xsl:text> *** </xsl:text>-\->
         <xsl:call-template name="main_temp">
           <xsl:with-param name="currentFeatures" select="$featureIds"/>
           <xsl:with-param name="lightFeatures" select="$lightFeatures"/>
           <xsl:with-param name="mooring" select="$mooring"/>
           <xsl:with-param name="x" select="$x"/>
           <xsl:with-param name="y" select="$y"/>
         </xsl:call-template>
       </xsl:when>
       <xsl:otherwise>
         <xsl:text> substring_before_featureIds :: </xsl:text>
         <xsl:value-of select="substring-before($featureIds,'#')"/>
         <xsl:text> *** </xsl:text>
         <xsl:call-template name="main_temp">
           <xsl:with-param name="currentFeatures" select="substring-before($featureIds,'#')"/>
           <xsl:with-param name="lightFeatures" select="$lightFeatures"/>
           <xsl:with-param name="mooring" select="$mooring"/>
           <xsl:with-param name="x" select="$x"/>
           <xsl:with-param name="y" select="$y"/>
         </xsl:call-template>
         <xsl:text> substring_after_featureIds :: </xsl:text>
         <xsl:value-of select="substring-after($featureIds,'#')"/>
         <xsl:text> *** </xsl:text>
         <xsl:call-template name="main_temp">
           <xsl:with-param name="currentFeatures" select="substring-after($featureIds,'#')"/>
           <xsl:with-param name="lightFeatures" select="$lightFeatures"/>
           <xsl:with-param name="mooring" select="$mooring"/>
           <xsl:with-param name="x" select="$x"/>
           <xsl:with-param name="y" select="$y"/>
         </xsl:call-template>
         
       </xsl:otherwise>
     </xsl:choose>-->

    </xsl:if>

  </xsl:template>

  <xsl:template name="main_temp">
    <xsl:param name="currentFeatures"/>
    <xsl:param name="x"/>
    <xsl:param name="y"/>
    <xsl:param name="mooring"/>
    <xsl:param name="lightFeatures"/>

    <xsl:variable name="lightAcronym" select="'LIGHTS'"/>
    <xsl:variable name="mooringAcronym" select="'MORFAC'"/>
    <xsl:variable name="mainFeatures" select="'LIGHTS,FOGSIG'"/>
    <xsl:variable name="masterFeatures"
      select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP,BOYCAR,BOYINB,BOYISD,BOYLAT,BOYSAW,BOYSPP,BUISGL,LNDMRK,LITFLT,LITVES,DAYMRK,MORFAC,OFSPLF,PILPNT'"/>
    <xsl:variable name="slaveFeatures"
      select="'RETRFL,FOGSIG,RTPBCN,SISTAW,TOPMAR,DAYMAR,SISTAT,LIGHTS'"/>
    <xsl:variable name="allFeatures"
      select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP,BOYCAR,BOYINB,BOYISD,BOYLAT,BOYSAW,BOYSPP,BUISGL,LNDMRK,LITFLT,LITVES,DAYMRK,MORFAC,OFSPLF,PILPNT,RETRFL,FOGSIG,RTPBCN,SISTAW,TOPMAR,DAYMAR,SISTAT,LIGHTS'"/>

    <xsl:element name="NM_LIGHT_LIST_RECORD">

      <xsl:variable name="tempMainFeature">
        <xsl:call-template name="get_first_feature_acronym">
          <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="mainfoid" select="substring-before($tempMainFeature, ',')"/>
      <xsl:variable name="mainacronym" select="substring-after($tempMainFeature, ',')"/>

      <xsl:variable name="masterFeature">
        <xsl:call-template name="get_first_feature_acronym">
          <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="masterFeatureID" select="substring-before($masterFeature, ',')"/>

      <xsl:variable name="slaveFeature">
        <xsl:call-template name="get_first_feature_acronym">
          <xsl:with-param name="featureAcronyms" select="$slaveFeatures"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="valnmr">
        <xsl:call-template name="get_attribute_from_feature_list">
          <xsl:with-param name="featureIds" select="$currentFeatures"/>
          <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
          <xsl:with-param name="attribute" select="'VALNMR'"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="catlmk">
        <xsl:call-template name="get_attribute_from_feature_list">
          <xsl:with-param name="featureIds" select="$currentFeatures"/>
          <xsl:with-param name="featureAcronyms" select="'LNDMRK'"/>
          <xsl:with-param name="attribute" select="'CATLMK'"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="functn">
        <xsl:call-template name="get_attribute_from_feature_list">
          <xsl:with-param name="featureIds" select="$currentFeatures"/>
          <xsl:with-param name="featureAcronyms" select="'LNDMRK'"/>
          <xsl:with-param name="attribute" select="'FUNCTN'"/>
        </xsl:call-template>
      </xsl:variable>

      <!-- DEBUG -->
      <xsl:element name="DEBUG">
        <xsl:attribute name="foid">
          <xsl:value-of select="$mainfoid"/>
        </xsl:attribute>
        <xsl:attribute name="acronym">
          <xsl:value-of select="$mainacronym"/>
        </xsl:attribute>
        <xsl:attribute name="collocated_foids">
          <xsl:value-of select="$currentFeatures"/>
        </xsl:attribute>
        <xsl:attribute name="master_feature">
          <xsl:value-of select="$masterFeature"/>
        </xsl:attribute>
        <xsl:attribute name="valnmr">
          <xsl:value-of select="$valnmr"/>
        </xsl:attribute>
        <xsl:attribute name="catlmk">
          <xsl:value-of select="$catlmk"/>
        </xsl:attribute>
        <xsl:attribute name="functn">
          <xsl:value-of select="$functn"/>
        </xsl:attribute>
      </xsl:element>

      <!-- POSITION -->
      <xsl:element name="POSITION">
        <xsl:variable name="llknum">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$allFeatures"/>
            <xsl:with-param name="attribute" select="'llknum'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:element name="LATITUDE">
          <!-- <xsl:value-of select="$y"/>  -->
          <xsl:if test="not(contains($llknum,'_'))">
            <xsl:call-template name="FormatLatLong">
              <xsl:with-param name="Coordinate" select="$y"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:element>
        <xsl:element name="LONGITUDE">
          <!-- <xsl:value-of select="$x"/> -->
          <xsl:if test="not(contains($llknum,'_'))">
            <xsl:call-template name="FormatLatLong">
              <xsl:with-param name="Coordinate" select="$x"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:element>
      </xsl:element>

      <!-- NATIONAL_NUMBER -->
      <!--  this will read the national light number from natnum attribute from the master object -->
      <xsl:variable name="natnum">
        <xsl:call-template name="get_attribute_from_feature_list">
          <xsl:with-param name="featureIds" select="$currentFeatures"/>
          <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
          <xsl:with-param name="attribute" select="'natnum'"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:element name="NATIONAL_NUMBER">
        <!-- If National Number is not empty, get the value -->
        <xsl:if test="normalize-space($natnum) != '' ">
          <xsl:value-of select="$natnum"/>
        </xsl:if>
      </xsl:element>

      <!-- INTERNATIONAL_NUMBER -->
      <!--  this will read the national light number from llknum attribute from the master object -->
      <xsl:variable name="llknum">
        <xsl:call-template name="get_attribute_from_feature_list">
          <xsl:with-param name="featureIds" select="$currentFeatures"/>
          <xsl:with-param name="featureAcronyms" select="$allFeatures"/>
          <xsl:with-param name="attribute" select="'llknum'"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:element name="INTERNATIONAL_NUMBER">
        <!-- If international Number is not empty, get the value -->
        <xsl:if test="normalize-space($llknum) != '' ">
          <xsl:value-of select="$llknum"/>
        </xsl:if>
      </xsl:element>

      <!-- LOC_NAME_CHART_NUM_ENG -->
      <xsl:element name="LOC_NAME_CHART_NUM_ENG">

        <xsl:variable name="litchrval">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
            <xsl:with-param name="attribute" select="'LITCHR'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="catlitval">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$allFeatures"/>
            <xsl:with-param name="attribute" select="'CATLIT'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="catlit_val">
          <xsl:call-template name="get_attribute_from_feature_list_for_lights_color">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
            <xsl:with-param name="attribute" select="'CATLIT'"/>
          </xsl:call-template>
        </xsl:variable>
       <!-- <xsl:text> $catlitval </xsl:text>
        <xsl:value-of select="$catlitval"/>
        <xsl:text> *** </xsl:text>
        <xsl:text> catlit_val </xsl:text>
        <xsl:value-of select="$catlit_val"/>
        <xsl:text> *** </xsl:text>-->
        <xsl:variable name="objnam_value">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'OBJNAM'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="llbear_value">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
            <xsl:with-param name="attribute" select="'llbear'"/>
          </xsl:call-template>
        </xsl:variable>
        <!--<xsl:text> llbear_value </xsl:text>
        <xsl:value-of select="$llbear_value"/>
        <xsl:text>  *** </xsl:text>
        <xsl:text> string length </xsl:text>
        <xsl:value-of select="string-length(substring-after($llbear_value,'.'))" />
        <xsl:text>  *** </xsl:text>-->
        <xsl:variable name="single_quote">
          <xsl:text>'</xsl:text>
        </xsl:variable>
        <xsl:variable name="minutes">
          <xsl:choose>
            <xsl:when test="string-length(substring-after($llbear_value,'.')) = '1'">
              <xsl:variable name="modified_llbear_value">
              <xsl:value-of select="concat($llbear_value,'0')"/>
              </xsl:variable>
              <xsl:value-of select="format-number((substring-after($modified_llbear_value,'.') * 60) div 100,'00')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number((substring-after($llbear_value,'.') * 60) div 100,'00')"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="llbear_string">
          <xsl:if test="$llbear_value != '' and contains($catlit_val,'4,') ">
          <xsl:choose>
            <xsl:when test="contains($llbear_value,'.')">
              <xsl:value-of select="concat(' ',substring-before($llbear_value,'.'),'° ',$minutes,$single_quote)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat(' ',$llbear_value,'°')"/>
            </xsl:otherwise>
          </xsl:choose>
          <!-- <xsl:value-of select="concat(' ',substring-before($llbear_value,'.'),'° ',substring-after($llbear_value,'.'),$single_quote)"/>-->
        </xsl:if>
        </xsl:variable>
        
        <xsl:variable name="objnam">
          <xsl:choose>
            <xsl:when test="$catlitval">
              <xsl:if
                test="substring-after(normalize-space($catlitval),',')='12' or substring-after(normalize-space($catlitval),',')='13'">
                <!-- NTM-291 i.e. Made the changes for the MACRONS, and contains Front -->
                <!--<xsl:variable name="objnam_val">
                  <xsl:call-template name="get_attribute_from_feature_list">
                    <xsl:with-param name="featureIds" select="$currentFeatures"/>
                    <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
                    <xsl:with-param name="attribute" select="'OBJNAM'"/>
                  </xsl:call-template>
                </xsl:variable>-->
                <xsl:variable name="objnam_val1">
                  <xsl:call-template name="get_attribute_from_feature_list">
                    <xsl:with-param name="featureIds" select="$currentFeatures"/>
                    <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
                    <xsl:with-param name="attribute" select="'OBJNAM'"/>
                  </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="nobjnm_val">
                  <xsl:call-template name="get_attribute_from_feature_list">
                    <xsl:with-param name="featureIds" select="$currentFeatures"/>
                    <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
                    <xsl:with-param name="attribute" select="'NOBJNM'"/>
                  </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="objnam_val">
                  <xsl:choose>
                    <xsl:when test="$nobjnm_val">
                      <xsl:value-of select="$nobjnm_val"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$objnam_val1"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:variable>
               <!-- <xsl:text> objnam_val </xsl:text>
                <xsl:value-of select="$objnam_val"/>
                <xsl:text> ### </xsl:text>-->

                <!-- Checking for Front lights -->
                <xsl:if test="substring-after(normalize-space($catlitval),',')='12'">
                  <!-- Testing***** -->
                  <xsl:if test="normalize-space($objnam_val) = '' and normalize-space($objnam_val1) != ''">
                    <xsl:value-of select="$objnam_val1"/>
                  </xsl:if>
                  
                  <!--<xsl:text> in 12th </xsl:text>
                  <xsl:text> $llknum </xsl:text>
                  <xsl:value-of select="$llknum"/>
                  <xsl:text> *** </xsl:text>
                  <xsl:text> objnam_val </xsl:text>
                  <xsl:value-of select="$objnam_val"/>
                  <xsl:text> *** </xsl:text>-->
                  
                  <xsl:choose>

                    <xsl:when
                      test="contains(normalize-space($objnam_val),'Front') or contains(normalize-space($objnam_val),'Leading')">
                      <xsl:variable name="frontVal">
                       <!-- <xsl:choose>
                          <xsl:when test="substring-before($objnam_val,'Front')">
                            <xsl:value-of select="substring-before($objnam_val,'Front')"/>
                          </xsl:when>
                          <xsl:when test="substring-after($objnam_val,'Front')">
                            <xsl:value-of select="substring-after($objnam_val,'Front')"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="$objnam_val"/>
                          </xsl:otherwise>
                        </xsl:choose>-->
                        <xsl:value-of select="$objnam_val"/>
                      </xsl:variable>
                     <!--  <xsl:text> frontVal@12 </xsl:text>
                    <xsl:value-of select="$frontVal"/>
                    <xsl:text> *** </xsl:text>-->


                      <xsl:variable name="leadVal">
                        <xsl:if test="contains(normalize-space($frontVal),'Leading')">
                          <xsl:choose>
                            <xsl:when test="substring-before($frontVal,'Leading')">
                              
                              <xsl:value-of select="concat(substring-before($frontVal,'Leading'),' Ldg Lts Front')"/>
                              
                            </xsl:when>
                            <xsl:when test="substring-after($frontVal,'Leading')">
                              
                              <xsl:value-of select="concat(substring-after($frontVal,'Leading'),' Ldg Lts Front')" />
                              
                            </xsl:when>

                          </xsl:choose>
                        </xsl:if>
                        <xsl:if test="not(contains(normalize-space($frontVal),'Leading')) ">
                          <xsl:choose>
                            <xsl:when test="contains(normalize-space($objnam_val),'Front') and substring-after($objnam_val,'Front') != '' ">
                              <xsl:value-of select="concat(substring-before($objnam_val,'Front'),' Ldg Lts Front. Front',substring-after($objnam_val,'Front'))"/>
                            </xsl:when>
                            <xsl:when test="contains(normalize-space($objnam_val),'Front') and substring-after($objnam_val,'Front') = '' ">
                              <xsl:value-of select="concat(substring-before($objnam_val,'Front'),' Ldg Lts Front.',substring-after($objnam_val,'Front'))"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="concat($frontVal,' Ldg Lts Front')"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        
                        </xsl:if>

                      </xsl:variable>
                      <!-- Printing values -->
                      <xsl:if test="$leadVal != ''">
                      <xsl:choose>
                        <xsl:when test="contains($leadVal,'Front') and normalize-space($llbear_string) != '' ">
                          <xsl:value-of select="concat(substring-before($leadVal,'Front'),$llbear_string,substring-after($leadVal,'Lts'))"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="$leadVal"/>
                        </xsl:otherwise>
                      </xsl:choose>
                      </xsl:if>
                      
                    </xsl:when>
                    <xsl:when test="normalize-space($objnam_val)= '' and not(contains($llknum,'_'))">
                      <xsl:choose>
                        <!-- Teating***** -->
                        <xsl:when test="normalize-space($llbear_string) != '' and normalize-space($catlitval) != ''"/>
                        <xsl:when test="normalize-space($llbear_string) = '' and  normalize-space($catlitval) != ''"/>
                        <xsl:when test="normalize-space($llbear_string) != '' ">
                          <xsl:value-of select="concat('Ldg Lts ',$llbear_string,' Front')"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="'Ldg Lts Front'"/>
                        </xsl:otherwise>
                      </xsl:choose>
                      
                    </xsl:when>

                    <xsl:otherwise>
                      <xsl:if test="$objnam_val != ''">
                        
                        <xsl:choose>
                          <xsl:when test="normalize-space($llbear_string) != '' ">
                            <xsl:value-of select="concat($objnam_val,' Ldg Lts ',$llbear_string,' Front')"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="concat($objnam_val,' Ldg Lts Front')"/>
                          </xsl:otherwise>
                        </xsl:choose>
                        
                      </xsl:if>
                    </xsl:otherwise>

                  </xsl:choose>
                </xsl:if>

                <!-- Checking for Rear lights -->
                <xsl:if test="substring-after(normalize-space($catlitval),',')='13'">

                  <xsl:choose>


                    <xsl:when
                      test="contains(normalize-space($objnam_val),'Rear') or contains(normalize-space($objnam_val),'Leading')">
                      <xsl:variable name="frontVal">
                        <xsl:choose>
                          <xsl:when test="substring-before($objnam_val,'Rear')">
                            <xsl:value-of select="substring-before($objnam_val,'Rear')"/>
                          </xsl:when>
                          <xsl:when test="substring-after($objnam_val,'Rear')">
                            <xsl:value-of select="substring-after($objnam_val,'Rear')"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="$objnam_val"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:variable>
                      <!--<xsl:text> frontVal@13 </xsl:text>
                    <xsl:value-of select="$frontVal"/>
                    <xsl:text> *** </xsl:text>-->
                      <xsl:variable name="leadVal">
                        <xsl:if test="contains(normalize-space($frontVal),'Leading')">
                          <xsl:choose>
                            <xsl:when test="substring-before($frontVal,'Leading')">
                              <xsl:value-of
                                select="concat(substring-before($frontVal,'Leading'),' Ldg Lts Rear')"
                              />
                            </xsl:when>
                            <xsl:when test="substring-after($frontVal,'Leading')">
                              <xsl:value-of
                                select="concat(substring-after($frontVal,'Leading'),' Ldg Lts Rear')"
                              />
                            </xsl:when>

                          </xsl:choose>
                        </xsl:if>
                        <xsl:if test="not(contains(normalize-space($frontVal),'Leading'))">
                          <xsl:value-of select="concat($frontVal,' Ldg Lts Rear')"/>
                        </xsl:if>
                      </xsl:variable>
                      <!-- Printing values -->
                      <xsl:if test="$leadVal != ''">
                        <xsl:choose>
                          <xsl:when test="contains($leadVal,'Rear') and normalize-space($llbear_string) != '' ">
                            <xsl:value-of select="concat(substring-before($leadVal,'Rear'),$llbear_string,substring-after($leadVal,'Lts'))"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="$leadVal"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:if>
                      
                    </xsl:when>
                    <xsl:when test="normalize-space($objnam_val)= '' and not(contains($llknum,'_'))">

                      <xsl:value-of select="'Ldg Lts Rear'"/>
                    </xsl:when>

                    <xsl:otherwise>
                      <xsl:if test="$objnam_val != ''">
                        <xsl:value-of select="concat($objnam_val,' Ldg Lts Rear')"/>
                      </xsl:if>
                    </xsl:otherwise>

                  </xsl:choose>
                </xsl:if>
              </xsl:if>
              <xsl:if
                test="not(substring-after(normalize-space($catlitval),',')='12' or substring-after(normalize-space($catlitval),',')='13')">
                <!-- NTM-291, Modify the code and made the changes for the Macrons -->
                <!--<xsl:call-template name="get_attribute_from_feature_list">
                  <xsl:with-param name="featureIds" select="$currentFeatures"/>
                  <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
                  <xsl:with-param name="attribute" select="'OBJNAM'"/>
                </xsl:call-template>-->
                <xsl:variable name="OBJNAM_VALUE">
                  <xsl:call-template name="get_attribute_from_feature_list">
                    <xsl:with-param name="featureIds" select="$currentFeatures"/>
                    <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
                    <xsl:with-param name="attribute" select="'OBJNAM'"/>
                  </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="NOBJNM_VALUE">
                  <xsl:call-template name="get_attribute_from_feature_list">
                    <xsl:with-param name="featureIds" select="$currentFeatures"/>
                    <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
                    <xsl:with-param name="attribute" select="'NOBJNM'"/>
                  </xsl:call-template>
                </xsl:variable>
                <xsl:choose>
                  <xsl:when test="normalize-space($NOBJNM_VALUE)">
                    <xsl:value-of select="$NOBJNM_VALUE"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$OBJNAM_VALUE"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:if>

            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="get_attribute_from_feature_list">
                <xsl:with-param name="featureIds" select="$currentFeatures"/>
                <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
                <xsl:with-param name="attribute" select="'OBJNAM'"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="feature_range_values">
          <xsl:for-each select="CollocatedFeature[contains($currentFeatures,@fid)]">
            <!--<xsl:sort
              select="key('featureids', @fid)[contains('LIGHTS', @acronym)]/Attributes/Attribute[@acronym='COLOUR']/@value"
              data-type="number" order="ascending"/>-->
            <!-- <xsl:sort select="key('featureids', @fid)[contains('LIGHTS', @acronym)]/Attributes/Attribute[@acronym='COLOUR']/@value"  data-type="number" order="ascending"/>-->
            <xsl:call-template name="get_attribute_from_feature_list_for_ranges">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
              <xsl:with-param name="attribute" select="'VALNMR'"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:variable>
       <!-- <xsl:text> master_range </xsl:text>
        <xsl:value-of select="$master_range"/>
        <xsl:text> *** </xsl:text>-->
        <!-- lowercase upright and bold -->
        <xsl:if
          test="(count(./CollocatedFeature[substring(@acronym, 1, 3)='BCN' or @acronym='BUISGL' or @acronym='LNDMRK' or @acronym='LITVES' or @acronym='SILTNK' or @acronym='PILPNT' or @acronym='OFSPLF']) > 0) and $valnmr >= 15">
          <!--<xsl:sort select="@fid"/>-->
          <xsl:variable name="tempAcronym">
            <xsl:call-template name="get_first_feature_acronym">
              <xsl:with-param name="featureAcronyms"
                select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP,BUISGL,LNDMRK,LITVES,SILTNK,PILPNT,OFSPLF'"
              />
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="foid" select="substring-before($tempAcronym, ',')"/>
          <xsl:variable name="acronym" select="substring-after($tempAcronym, ',')"/>
          <!--<xsl:if test="$acronym !=''">
            <strong>
              <xsl:value-of select="$objnam"/>
            </strong>
          </xsl:if>-->
          <xsl:if test="$acronym !=''">
            <xsl:choose>
              <xsl:when test="$feature_range_values !='' ">
                <xsl:choose>
                  <xsl:when test="contains($objnam,'Ldg')">
                    <strong><xsl:value-of select="substring-before($objnam,'Ldg')"/></strong>
                    <xsl:value-of select="concat('Ldg',substring-after($objnam,'Ldg'))"/>
                  </xsl:when>
                  <xsl:otherwise><strong><xsl:value-of select="$objnam"/></strong></xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <strong><xsl:value-of select="$objnam"/></strong>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
          
        </xsl:if>
        <!-- lowercase upright and light -->
        <xsl:if
          test="not($valnmr >= 15) and count(./CollocatedFeature[substring(@acronym, 1, 3)='BCN' or @acronym='BUISGL' or @acronym='LNDMRK' or @acronym='LITVES' or @acronym='SILTNK' or @acronym='PILPNT' or @acronym='OFSPLF']) > 0 ">
<!--          <xsl:sort select="@fid"/>-->
          <xsl:variable name="tempAcronym">
            <xsl:call-template name="get_first_feature_acronym">
              <xsl:with-param name="featureAcronyms"
                select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP,BUISGL,LNDMRK,LITVES,SILTNK,PILPNT,OFSPLF'"
              />
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="foid" select="substring-before($tempAcronym, ',')"/>
          <xsl:variable name="acronym" select="substring-after($tempAcronym, ',')"/>
          <xsl:if test="$acronym !=''">
            <xsl:choose>
              <xsl:when test="$feature_range_values !='' ">
                <xsl:choose>
                  <xsl:when test="contains($objnam,'Ldg')">
                    <strong><xsl:value-of select="substring-before($objnam,'Ldg')"/></strong>
                    <xsl:value-of select="concat('Ldg',substring-after($objnam,'Ldg'))"/>
                  </xsl:when>
                  <xsl:otherwise><strong><xsl:value-of select="$objnam"/></strong></xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <!--  Testing**** -->
                <!--<xsl:value-of select="$objnam"/>-->
                <xsl:variable name="obj-lenght" select="string-length(normalize-space($objnam))"/>
                <xsl:choose>
                  <!--<xsl:when test="contains($objnam,'Front')">
                    <xsl:value-of select="substring-before($objnam,'Front')"/>
                  </xsl:when>-->
                  <xsl:when test="number(string-length(normalize-space(substring($objnam,'Front')))) = 'NaN' or number(string-length(normalize-space(substring($objnam,'Front.')))) = 'NaN'">
                    <xsl:value-of select="substring-before($objnam,'Front')"/>
                  </xsl:when>
                  <!--<xsl:when test="substring($objnam, $obj-lenght - 5) = ' Front'">
                    <xsl:value-of select="substring($objnam, 1, $obj-lenght - 6)"/>
                  </xsl:when>
                  <xsl:when test="substring($objnam, $obj-lenght - 6) = ' Front.'">
                    <xsl:value-of select="substring($objnam, 1, $obj-lenght - 7)"/>
                  </xsl:when>
                  <xsl:when test="starts-with(normalize-space($objnam),'Front.')">
                    <xsl:value-of select="substring-after($objnam,'Front.')"/>
                  </xsl:when>
                  <xsl:when test="starts-with(normalize-space($objnam),'Front')">
                    <xsl:value-of select="substring-after($objnam,'Front')"/>
                  </xsl:when>
                  <xsl:when test="contains(normalize-space($objnam),'Front Leading Light')">
                    <xsl:value-of select="concat(substring-before($objnam,'Front Leading Light'),'Leading Light')"/>
                  </xsl:when>
                  <xsl:when test="contains(normalize-space($objnam),'Leading Front Light')">
                    <xsl:value-of select="concat(substring-before($objnam,'Front Light'),'Light')"/>
                  </xsl:when>-->
                  <!--<xsl:when test="$objnam = 'Front'">
                    <xsl:value-of select="$objnam"/>
                  </xsl:when>-->
                  <xsl:when test="contains($objnam,'Front.')">
                    <xsl:variable name="before" select="substring-before($objnam,'Front.')"/>
                    <xsl:variable name="after" select="substring-after($objnam,'Front.')"/>
                    <xsl:value-of select="concat($before,$after)"/>
                  </xsl:when>
                  <xsl:when test="contains($objnam,'Front')">
                    <xsl:variable name="before" select="substring-before($objnam,'Front')"/>
                    <xsl:variable name="after" select="substring-after($objnam,'Front')"/>
                    <xsl:value-of select="concat($before,$after)"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$objnam"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:if>

        <!-- lowercase italiced  -->
        <xsl:if
          test="count(./CollocatedFeature[substring(@acronym, 1, 3) = 'BOY' or @acronym='LITFLT']) > 0">
<!--          <xsl:sort select="@fid"/>-->
          <xsl:choose>
            <xsl:when test="$feature_range_values != ''">
              <xsl:choose>
                <xsl:when test="contains($objnam,'Ldg')">
                  <span style="font-style: italic;">
                  <strong><xsl:value-of select="substring-before($objnam,'Ldg')"/></strong>
                  <xsl:value-of select="concat('Ldg',substring-after($objnam,'Ldg'))"/>
                  </span>
                </xsl:when>
                <xsl:otherwise><span style="font-style: italic;"><strong><xsl:value-of select="$objnam"/></strong></span></xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <span style="font-style: italic;">
                <xsl:value-of select="$objnam"/>
              </span>
            </xsl:otherwise>
          </xsl:choose>
          
        </xsl:if>

        <!-- uppercase italic  -->
        <xsl:if test="count(./CollocatedFeature[@acronym='LITVES']) > 0">
<!--          <xsl:sort select="@fid"/>-->
          <xsl:choose>
            <xsl:when test="$feature_range_values != ''">
              <xsl:choose>
                <xsl:when test="contains($objnam,'Ldg')">
                  <span style="font-style: italic; text-transform: uppercase;">
                    <strong><xsl:value-of select="substring-before($objnam,'Ldg')"/></strong>
                    <xsl:value-of select="concat('Ldg',substring-after($objnam,'Ldg'))"/>
                  </span>
                </xsl:when>
                <xsl:otherwise><span style="font-style: italic; text-transform: uppercase;"><strong><xsl:value-of select="$objnam"/></strong></span></xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <span style="font-style: italic; text-transform: uppercase;">
                <xsl:value-of select="$objnam"/>
              </span>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <xsl:variable name="llk_value">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$allFeatures"/>
            <xsl:with-param name="attribute" select="'llknum'"/>
          </xsl:call-template>
        </xsl:variable>


        <!-- add the chartnumber - international chart number below -->
        <!-- this will be done manually by the user in publication module -->

        <!--- Add G to newline to the end if (LNDMRK with CATLMK = 17  and FUNCTN = 33), and the STATUS = 16 -->
        <xsl:variable name="status">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'STATUS'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:if test="$status = 16 and $catlmk = '17' and $functn = 33 ">
          <br/>
          <strong>G</strong>
        </xsl:if>
        <xsl:variable name="mooring_objnam">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$mooring"/>
            <xsl:with-param name="featureAcronyms" select="$mooringAcronym"/>
            <xsl:with-param name="attribute" select="'OBJNAM'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$mooring_objnam"/>
        <!--<xsl:text> $catlit_val </xsl:text>
        <xsl:value-of select="$catlit_val"/>
        <xsl:text> *** </xsl:text>-->
        <!-- PDMD6977 if  catlit=1 -->
        <xsl:variable name="catval">
        <xsl:choose>
          <xsl:when test="$catlit_val ='1' or contains($catlit_val,'1,')">
            <!-- <xsl:template name="CatlitLokoup"> -->
              <xsl:call-template name="CatlitLokoup">
                <xsl:with-param name="catlitValue" select="'1'"/>
                <xsl:with-param name="language" select="'eng'"/>
              </xsl:call-template>
          </xsl:when>
          <!--<xsl:when test="$catlit_val ='4' or contains($catlit_val,'4')">
            <!-\- <xsl:template name="CatlitLokoup"> -\->
            
            <xsl:call-template name="CatlitLokoup">
              <xsl:with-param name="catlitValue" select="'4'"/>
              <xsl:with-param name="language" select="'eng'"/>
            </xsl:call-template>
          </xsl:when>-->
        </xsl:choose>
        </xsl:variable>
        <!--<xsl:text> catval </xsl:text>
        <xsl:value-of select="$catval"/>
        <xsl:text> *** </xsl:text>-->
        <xsl:if test="$objnam_value != ''">
          <!-- Testing******* -->
          <!--<xsl:if test="$catlit_val ='1' or contains($catlit_val,'1,')">
            <xsl:value-of select="concat(' ',$catval,' Lt')"/>
          </xsl:if>-->

          <xsl:choose>
            <xsl:when test="$catlit_val ='1' or contains($catlit_val,'1,')">
              <xsl:value-of select="concat(' ',$catval,' Lt')"/>
            </xsl:when>
            <xsl:when test="$llbear_value != ''">
              <xsl:if test="not($catlit_val ='1' or contains($catlit_val,'1,') or contains($catlit_val,',12'))">
<!--              <xsl:value-of select="concat(' ', '***',' Dir Lt')"/>-->
                <xsl:value-of select="concat(' ',' Dir Lt')"/>
              </xsl:if>
              
              <xsl:if test="contains($catlit_val,',12')">
                <xsl:value-of select="concat(' ',' Ldg Lts')"/>
                <!--<xsl:choose>
                  <xsl:when test="$objnam='Front'">
                    <xsl:value-of select="concat('Front ',' Ldg Lts')"/>    
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="concat(' ',' Ldg Lts')"/>
                  </xsl:otherwise>
                </xsl:choose>-->
              </xsl:if>
              
            </xsl:when>
            
          </xsl:choose>
          
        </xsl:if>
        <!--<xsl:if test="$catlit_val ='1' or contains($catlit_val,'1')">
          <!-\- <xsl:template name="CatlitLokoup"> -\->
          <xsl:variable name="catval">
            <xsl:call-template name="CatlitLokoup">
              <xsl:with-param name="catlitValue" select="$catlitval"/>
              <xsl:with-param name="language" select="'eng'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:if test="$objnam_value != ''">
            <xsl:if test="$catval != ''">
              <xsl:value-of select="concat(' ',$catval,' Lt')"/>
            </xsl:if>
          </xsl:if>
        </xsl:if>-->
        <!--<xsl:text> $currentFeatures </xsl:text>
        <xsl:value-of select="$currentFeatures"/>
        <xsl:text> *** </xsl:text>
        <xsl:text> $masterFeatures </xsl:text>
        <xsl:value-of select="$masterFeatures"/>
        <xsl:text> *** </xsl:text>-->
        <!--<xsl:variable name="llbear_value">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
            <xsl:with-param name="attribute" select="'llbear'"/>
          </xsl:call-template>
        </xsl:variable>-->
        <!--<xsl:text> llbear_value </xsl:text>
        <xsl:value-of select="$llbear_value"/>
        <xsl:text> *** </xsl:text>-->
        <!--<xsl:variable name="single_quote">
          <xsl:text>'</xsl:text>
        </xsl:variable>-->
        <xsl:if test="($llbear_value != '' and contains($catlit_val,'1,')) or $llbear_value != ''">
          <xsl:choose>
            <xsl:when test="contains($llbear_value,'.')">
              <xsl:choose>
                <xsl:when test="contains($catlit_val,'4,')">
                  <xsl:choose>
                    <xsl:when test="$objnam = ''">
                      <xsl:value-of select="concat('Ldg Lts ',substring-before($llbear_value,'.'),'° ',$minutes,$single_quote, ' Front')"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="concat(' ',substring-before($llbear_value,'.'),'° ',$minutes,$single_quote, ' Front')"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="concat(' ',substring-before($llbear_value,'.'),'° ',$minutes,$single_quote)"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <!-- Testing******* -->
            
            <xsl:otherwise>
              <!-- Testing******* -->
              <!--<xsl:value-of select="concat(' ',$llbear_value,'°')"/>-->
              <xsl:variable name="llbear_value1">
              <xsl:choose>
                <xsl:when test="string-length($llbear_value)=1">
                  <xsl:value-of select="concat('00',$llbear_value)"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$llbear_value"/>
                </xsl:otherwise>
              </xsl:choose>
              </xsl:variable>
              <xsl:choose>
                <xsl:when test="contains($objnam,'Front')">
                  <xsl:value-of select="concat(' ',$llbear_value1,'°',' Front')"/>
                </xsl:when>

                <xsl:when test="normalize-space($objnam) = ''">
                  <xsl:value-of select="concat('Dir Lt ',$llbear_value1,'°')"/>
                </xsl:when>
                
                <xsl:otherwise>
                  <xsl:value-of select="concat(' ',$llbear_value1,'°')"/>    
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
         <!-- <xsl:value-of select="concat(' ',substring-before($llbear_value,'.'),'° ',substring-after($llbear_value,'.'),$single_quote)"/>-->
        </xsl:if>
        <!-- <xsl:value-of select="$objnam_value"/>-->
        <xsl:if test="$catlitval='17' and contains($llk_value,'_')">

          <xsl:call-template name="CatlitLokoup">
            <xsl:with-param name="catlitValue" select="$catlitval"/>
            <xsl:with-param name="language" select="'eng'"/>
          </xsl:call-template>

        </xsl:if>

        <!-- END -->
      </xsl:element>
      <!--  /LOC_NAME_CHART_NUM_ENG -->

      <!-- NM_LIGHTS_OBMNZ -->
      <xsl:variable name="inform">
        <xsl:call-template name="get_attribute_from_feature_list">
          <xsl:with-param name="featureIds" select="$currentFeatures"/>
          <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
          <xsl:with-param name="attribute" select="'INFORM'"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:element name="NM_LIGHTS_OBMNZ">
        <xsl:choose>
          <xsl:when test="contains($inform, 'Owned by Maritime New Zealand')">
            <xsl:text>Yes</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>No</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <!-- /NM_LIGHTS_OBMNZ -->

      <!-- LOC_NAME_CHART_NUM_ENG_SUM -->
      <xsl:element name="LOC_NAME_CHART_NUM_ENG_SUM">
        <xsl:variable name="objnam">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'OBJNAM'"/>
          </xsl:call-template>
        </xsl:variable>

        <!-- lowercase upright and bold -->
        <xsl:if
          test="(count(./CollocatedFeature[substring(@acronym, 1, 3)='BCN' or @acronym='BUISGL' or @acronym='LNDMRK' or @acronym='LITVES' or @acronym='SILTNK' or @acronym='PILPNT' or @acronym='OFSPLF']) > 0) and $valnmr >= 15">
<!--          <xsl:sort select="@fid"/>-->
          <xsl:variable name="tempAcronym">
            <xsl:call-template name="get_first_feature_acronym">
              <xsl:with-param name="featureAcronyms"
                select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP,BUISGL,LNDMRK,LITVES,SILTNK,PILPNT,OFSPLF'"
              />
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="foid" select="substring-before($tempAcronym, ',')"/>
          <xsl:variable name="acronym" select="substring-after($tempAcronym, ',')"/>

          <xsl:choose>
            <xsl:when test="$acronym='LNDMRK'">
              <xsl:if
                test="//Features/Feature[@fid = $foid]/Attributes[Attribute[@acronym='CATLMK' and @value='17'] and Attribute[@acronym='FUNCTN' and @value='33'] ]">
                <xsl:value-of select="translate($objnam, $accents, $accentsEnglish)"/>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <strong>
                <xsl:value-of select="translate($objnam, $accents, $accentsEnglish)"/>
              </strong>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <!-- lowercase upright and light -->
        <xsl:if
          test="not($valnmr >= 15) and count(./CollocatedFeature[substring(@acronym, 1, 3)='BCN' or @acronym='BUISGL' or @acronym='LNDMRK' or @acronym='LITVES' or @acronym='SILTNK' or @acronym='PILPNT' or @acronym='OFSPLF']) > 0 ">
<!--          <xsl:sort select="@fid"/>-->
          <xsl:variable name="tempAcronym">
            <xsl:call-template name="get_first_feature_acronym">
              <xsl:with-param name="featureAcronyms"
                select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP,BUISGL,LNDMRK,LITVES,SILTNK,PILPNT,OFSPLF'"
              />
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="foid" select="substring-before($tempAcronym, ',')"/>
          <xsl:variable name="acronym" select="substring-after($tempAcronym, ',')"/>

          <xsl:choose>
            <xsl:when test="$acronym='LNDMRK'">
              <xsl:if test="$catlmk = 17 or $catlmk = 7">
                <xsl:value-of select="translate($objnam, $accents, $accentsEnglish)"/>
              </xsl:if>
            </xsl:when>

            <xsl:otherwise>
              <xsl:value-of select="translate($objnam, $accents, $accentsEnglish)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <!-- lowercase italiced  -->
        <xsl:if
          test="count(./CollocatedFeature[substring(@acronym, 1, 3) = 'BOY' or @acronym='LITFLT']) > 0">
<!--          <xsl:sort select="@fid"/>-->
          <xsl:value-of select="translate($objnam, $accents, $accentsEnglish)"/>
        </xsl:if>

        <!-- uppercase italic  -->
        <xsl:if test="count(./CollocatedFeature[@acronym='LITVES']) > 0">
<!--          <xsl:sort select="@fid"/>-->
          <xsl:value-of select="translate($objnam, $accents, $accentsEnglish)"/>
        </xsl:if>

        <!-- add the chartnumber - international chart number below -->
        <!-- this will be done manually by the user in publication module -->

        <!--- Add G to newline to the end if (LNDMRK with CATLMK = 17  and FUNCTN = 33), and the STATUS = 16 -->
        <xsl:variable name="status">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'STATUS'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:if test="$status = 16 and $catlmk = '17' and $functn = 33 "> G </xsl:if>

      </xsl:element>
      <!--  /LOC_NAME_CHART_NUM_ENG_SUM -->


      <!-- LOC_NAME_CHART_NUM_NAT -->
      <xsl:element name="LOC_NAME_CHART_NUM_NAT">
        <xsl:variable name="nobjnm">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'NOBJNM'"/>
          </xsl:call-template>
        </xsl:variable>

        <!-- lowercase upright and bold -->
        <xsl:if
          test="(count(./CollocatedFeature[substring(@acronym, 1, 3)='BCN' or @acronym='BUISGL' or @acronym='LNDMRK' or @acronym='LITVES' or @acronym='SILTNK' or @acronym='PILPNT' or @acronym='OFSPLF']) > 0) and $valnmr >= 15">
<!--          <xsl:sort select="@fid"/>-->
          <xsl:variable name="tempAcronym">
            <xsl:call-template name="get_first_feature_acronym">
              <xsl:with-param name="featureAcronyms"
                select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP,BUISGL,LNDMRK,LITVES,SILTNK,PILPNT,OFSPLF'"
              />
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="foid" select="substring-before($tempAcronym, ',')"/>
          <xsl:variable name="acronym" select="substring-after($tempAcronym, ',')"/>

          <xsl:choose>
            <xsl:when test="$acronym='LNDMRK'">
              <xsl:if
                test="//Features/Feature[@fid = $foid]/Attributes[Attribute[@acronym='CATLMK' and @value='17'] and Attribute[@acronym='FUNCTN' and @value='33'] ]">
                <strong>
                  <xsl:value-of select="$nobjnm"/>
                </strong>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <strong>
                <xsl:value-of select="$nobjnm"/>
              </strong>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <!-- lowercase upright and light -->
        <xsl:if
          test="not($valnmr >= 15) and count(./CollocatedFeature[substring(@acronym, 1, 3)='BCN' or @acronym='BUISGL' or @acronym='LNDMRK' or @acronym='LITVES' or @acronym='SILTNK' or @acronym='PILPNT' or @acronym='OFSPLF']) > 0 ">
<!--          <xsl:sort select="@fid"/>-->
          <xsl:variable name="tempAcronym">
            <xsl:call-template name="get_first_feature_acronym">
              <xsl:with-param name="featureAcronyms"
                select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP,BUISGL,LNDMRK,LITVES,SILTNK,PILPNT,OFSPLF'"
              />
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="foid" select="substring-before($tempAcronym, ',')"/>
          <xsl:variable name="acronym" select="substring-after($tempAcronym, ',')"/>

          <xsl:choose>
            <xsl:when test="$acronym='LNDMRK'">
              <xsl:if test="$catlmk = 17 or $catlmk = 7">
                <xsl:value-of select="$nobjnm"/>
              </xsl:if>
            </xsl:when>

            <xsl:otherwise>
              <xsl:value-of select="$nobjnm"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <!-- lowercase italiced  -->
        <xsl:if
          test="count(./CollocatedFeature[substring(@acronym, 1, 3) = 'BOY' or @acronym='LITFLT']) > 0">
<!--          <xsl:sort select="@fid"/>-->
          <span style="font-style: italic;">
            <xsl:value-of select="$nobjnm"/>
          </span>
        </xsl:if>

        <!-- uppercase italic  -->
        <xsl:if test="count(./CollocatedFeature[@acronym='LITVES']) > 0">
<!--          <xsl:sort select="@fid"/>-->
          <span style="font-style: italic; text-transform: uppercase;">
            <xsl:value-of select="$nobjnm"/>
          </span>
        </xsl:if>

        <!-- add the chartnumber - international chart number below -->
        <!-- this will be done manually by the user in publication module -->

        <!--- Add G to newline to the end if (LNDMRK with CATLMK = 17  and FUNCTN = 33), and the STATUS = 16 -->
        <xsl:variable name="status">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'STATUS'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:if test="$status = 16 and $catlmk = '17' and $functn = 33 ">
          <br/>
          <strong>G</strong>
        </xsl:if>

      </xsl:element>
      <!--  /LOC_NAME_CHART_NUM_NAT -->


      <!-- LOC_NAME_CHART_NUM_NAT_SUM -->
      <xsl:element name="LOC_NAME_CHART_NUM_NAT_SUM">
        <xsl:variable name="nobjnm">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'NOBJNM'"/>
          </xsl:call-template>
        </xsl:variable>

        <!-- lowercase upright and bold -->
        <xsl:if
          test="(count(./CollocatedFeature[substring(@acronym, 1, 3)='BCN' or @acronym='BUISGL' or @acronym='LNDMRK' or @acronym='LITVES' or @acronym='SILTNK' or @acronym='PILPNT' or @acronym='OFSPLF']) > 0) and $valnmr >= 15">
<!--          <xsl:sort select="@fid"/>-->
          <xsl:variable name="tempAcronym">
            <xsl:call-template name="get_first_feature_acronym">
              <xsl:with-param name="featureAcronyms"
                select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP,BUISGL,LNDMRK,LITVES,SILTNK,PILPNT,OFSPLF'"
              />
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="foid" select="substring-before($tempAcronym, ',')"/>
          <xsl:variable name="acronym" select="substring-after($tempAcronym, ',')"/>

          <xsl:choose>
            <xsl:when test="$acronym='LNDMRK'">
              <xsl:if
                test="//Features/Feature[@fid = $foid]/Attributes[Attribute[@acronym='CATLMK' and @value='17'] and Attribute[@acronym='FUNCTN' and @value='33'] ]">
                <xsl:value-of select="translate($nobjnm, $accents, $accentsEnglish)"/>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <strong>
                <xsl:value-of select="translate($nobjnm, $accents, $accentsEnglish)"/>
              </strong>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <!-- lowercase upright and light -->
        <xsl:if
          test="not($valnmr >= 15) and count(./CollocatedFeature[substring(@acronym, 1, 3)='BCN' or @acronym='BUISGL' or @acronym='LNDMRK' or @acronym='LITVES' or @acronym='SILTNK' or @acronym='PILPNT' or @acronym='OFSPLF']) > 0 ">
<!--          <xsl:sort select="@fid"/>-->
          <xsl:variable name="tempAcronym">
            <xsl:call-template name="get_first_feature_acronym">
              <xsl:with-param name="featureAcronyms"
                select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP,BUISGL,LNDMRK,LITVES,SILTNK,PILPNT,OFSPLF'"
              />
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="foid" select="substring-before($tempAcronym, ',')"/>
          <xsl:variable name="acronym" select="substring-after($tempAcronym, ',')"/>

          <xsl:choose>
            <xsl:when test="$acronym='LNDMRK'">
              <xsl:if test="$catlmk = 17 or $catlmk = 7">
                <xsl:value-of select="translate($nobjnm, $accents, $accentsEnglish)"/>
              </xsl:if>
            </xsl:when>

            <xsl:otherwise>
              <xsl:value-of select="translate($nobjnm, $accents, $accentsEnglish)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <!-- lowercase italiced  -->
        <xsl:if
          test="count(./CollocatedFeature[substring(@acronym, 1, 3) = 'BOY' or @acronym='LITFLT']) > 0">
<!--          <xsl:sort select="@fid"/>-->
          <xsl:value-of select="translate($nobjnm, $accents, $accentsEnglish)"/>
        </xsl:if>

        <!-- uppercase italic  -->
        <xsl:if test="count(./CollocatedFeature[@acronym='LITVES']) > 0">
<!--          <xsl:sort select="@fid"/>-->
          <xsl:value-of select="translate($nobjnm, $accents, $accentsEnglish)"/>
        </xsl:if>

        <!-- add the chartnumber - international chart number below -->
        <!-- this will be done manually by the user in publication module -->

        <!--- Add G to newline to the end if (LNDMRK with CATLMK = 17  and FUNCTN = 33), and the STATUS = 16 -->
        <xsl:variable name="status">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'STATUS'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:if test="$status = 16 and $catlmk = '17' and $functn = 33 "> G </xsl:if>

      </xsl:element>
      <!--  /LOC_NAME_CHART_NUM_NAT_SUM -->



      <!-- LIGHT_CHARACTERISTICS_ENG -->
      <xsl:element name="LIGHT_CHARACTERISTICS_ENG">
        <xsl:variable name="exclitval">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$allFeatures"/>
            <xsl:with-param name="attribute" select="'EXCLIT'"/>
          </xsl:call-template>
        </xsl:variable>

        <!--<xsl:text> exclitval </xsl:text>
          <xsl:value-of select="$exclitval"/>
          <xsl:text> end </xsl:text>-->
        <xsl:variable name="exclit_value">
          <xsl:call-template name="ExclitLokoup">
            <xsl:with-param name="exclitValue" select="$exclitval"/>
            <xsl:with-param name="language" select="'eng'"/>
          </xsl:call-template>
        </xsl:variable>
        <!--<xsl:text> exclit_value </xsl:text>
          <xsl:value-of select="$exclit_value"/>
          <xsl:text> end </xsl:text>-->

        <xsl:variable name="litcharval">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$allFeatures"/>
            <xsl:with-param name="attribute" select="'LITCHR'"/>
          </xsl:call-template>
        </xsl:variable>
        <!--<xsl:variable name="litchar_value">
            <xsl:for-each select="CollocatedFeature[contains($currentFeatures,@fid)]">
            
              <xsl:call-template name="get_attribute_from_feature_list_catlit" >
              <xsl:with-param name="featureIds" select="concat(@fid,',')" />
              <xsl:with-param name="featureAcronyms" select="$allFeatures" />
              <xsl:with-param name="attribute" select="'LITCHR'" />
            </xsl:call-template>
            </xsl:for-each>
          </xsl:variable>-->
        <!--<xsl:text> litcharval </xsl:text>
          <xsl:value-of select="$litcharval"/>
          <xsl:text> END </xsl:text>
          <xsl:text> litchar_value </xsl:text>
          <xsl:value-of select="$litchar_value"/>
          <xsl:text> END </xsl:text>-->
        <!--<xsl:variable name="lit_char">
            <xsl:for-each select="substring-before($litchar_value,',')">
              
          <xsl:call-template name="comparing_litchar_values">
            <xsl:with-param name="litchar_values" select="$litchar_value"/>
          </xsl:call-template>
            </xsl:for-each>
          </xsl:variable>
          <xsl:text> lit_char </xsl:text>
          <xsl:value-of select="$lit_char"/>
          <xsl:text> END </xsl:text>-->
        <xsl:variable name="catlitval">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$allFeatures"/>
            <xsl:with-param name="attribute" select="'CATLIT'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="catlit_value">
          <xsl:for-each select="CollocatedFeature[contains($currentFeatures,@fid)]">
            <!--<xsl:sort select="@fid"/>-->

            <xsl:call-template name="get_attribute_from_feature_list_catlit">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="$allFeatures"/>
              <xsl:with-param name="attribute" select="'CATLIT'"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:variable>
        <!--<xsl:text> catlit_value </xsl:text>
          <xsl:value-of select="$catlit_value"/>
          <xsl:text> end </xsl:text>-->

        <xsl:variable name="catlit_dir">
          <xsl:choose>
            <xsl:when test="not(contains($catlit_value,','))">
              <xsl:value-of select="$catlit_value"/>
            </xsl:when>

            <xsl:otherwise>
              <xsl:call-template name="catlit_value_for_dir">
                <xsl:with-param name="list_of_catlit" select="$catlit_value"/>
              </xsl:call-template>
            </xsl:otherwise>

          </xsl:choose>
        </xsl:variable>

        <!--<xsl:text> catlit_dir </xsl:text>
          <xsl:value-of select="$catlit_dir"/>
          <xsl:text> end </xsl:text>-->



        <!-- <xsl:variable name="catlit_value">
            <xsl:call-template name="get_attribute_from_feature_list" >
              <xsl:with-param name="featureIds" select="$currentFeatures" />
              <xsl:with-param name="featureAcronyms" select="$allFeatures" />
              <xsl:with-param name="attribute" select="'CATLIT'" />
            </xsl:call-template>
          </xsl:variable>-->

        <xsl:variable name="objnam_val">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$allFeatures"/>
            <xsl:with-param name="attribute" select="'OBJNAM'"/>
          </xsl:call-template>
        </xsl:variable>
        <!-- <xsl:text> objnam_val </xsl:text>
          <xsl:value-of select="$objnam_val"/>
          <xsl:text> END </xsl:text>-->
        <xsl:variable name="llknum_val">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$allFeatures"/>
            <xsl:with-param name="attribute" select="'llknum'"/>
          </xsl:call-template>
        </xsl:variable>
        <!-- <xsl:text> llknum_val </xsl:text>
          <xsl:value-of select="$llknum_val"/>
          <xsl:text> END </xsl:text>-->
        <xsl:choose>
          <!--<xsl:for-each select="CollocatedFeature[contains($currentFeatures,@fid)]">-->
          <!-- <xsl:when test="CollocatedFeature[@acronym='FOGSIG']">-->
          <xsl:when test="CollocatedFeature[contains($currentFeatures,@fid) and @acronym='FOGSIG']">
<!--            <xsl:sort select="@fid"/>-->
<!--                       <xsl:text> FOGSIG </xsl:text>-->
            <xsl:variable name="fogsig_catfog">
              <xsl:call-template name="get_attribute_from_feature_list">
                <xsl:with-param name="featureIds" select="$currentFeatures"/>
                <xsl:with-param name="featureAcronyms" select="'FOGSIG'"/>
                <xsl:with-param name="attribute" select="'CATFOG'"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="fogsig_siggrp">
              <xsl:call-template name="get_attribute_from_feature_list">
                <xsl:with-param name="featureIds" select="$currentFeatures"/>
                <xsl:with-param name="featureAcronyms" select="'FOGSIG'"/>
                <xsl:with-param name="attribute" select="'SIGGRP'"/>
              </xsl:call-template>
            </xsl:variable>
            <!--<xsl:text> fogsig_catfog </xsl:text>
          <xsl:value-of select="$fogsig_catfog"/>
          <xsl:text> *** </xsl:text>-->
            <xsl:variable name="catfog_value">
              <xsl:call-template name="CatfogLookup">
                <xsl:with-param name="value" select="$fogsig_catfog"/>
              </xsl:call-template>
            </xsl:variable>
            <!--<xsl:text> catfog_value </xsl:text>
          <xsl:value-of select="$catfog_value"/>
          <xsl:text> *** </xsl:text>-->
            <xsl:variable name="fogsig_sigper">
              <xsl:call-template name="get_attribute_from_feature_list">
                <xsl:with-param name="featureIds" select="$currentFeatures"/>
                <xsl:with-param name="featureAcronyms" select="'FOGSIG'"/>
                <xsl:with-param name="attribute" select="'SIGPER'"/>
              </xsl:call-template>
            </xsl:variable>
            <!--<xsl:text> $fogsig_siggrp </xsl:text>
             <xsl:value-of select="$fogsig_siggrp"/>
             <xsl:text> *** </xsl:text>-->
            <xsl:if test="$catfog_value !=''">
              <xsl:choose>
                <xsl:when test="normalize-space($fogsig_siggrp) != '(1)'">
                  <xsl:value-of select="concat($catfog_value,' ',$fogsig_siggrp)"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$catfog_value"/>
                </xsl:otherwise>
              </xsl:choose>

            </xsl:if>

            <xsl:if test="normalize-space($fogsig_sigper)">
              <xsl:if test="normalize-space($fogsig_sigper) != 1">
                <xsl:value-of select="concat(' ',$fogsig_sigper, 's')"/>
              </xsl:if>
            </xsl:if>

          </xsl:when>

          <xsl:when test="not(contains($llknum_val,'_')) or $llknum_val = '3981_1'">
            <!--           <xsl:text> for llk not contains '_' </xsl:text>-->
            <!--<xsl:text> $catlit_dir </xsl:text>
           <xsl:value-of select="$catlit_dir"/>
           <xsl:text> *** </xsl:text>-->
            <!-- CATLIT="1" for (Dir) -->
            <xsl:if test="$catlit_dir='1'">
              <xsl:variable name="catval">
                <xsl:call-template name="CatlitLokoup">
                  <xsl:with-param name="catlitValue" select="$catlit_dir"/>
                  <xsl:with-param name="language" select="'eng'"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:value-of select="concat($catval,' ')"/>
            </xsl:if>
            <!-- CATLIT="5" or CATLIT="6" for 'Aero' -->
            <xsl:if test="$catlitval='5' or $catlitval='6'">
<!--              <xsl:if test="$catlitval='5'">-->
              <xsl:variable name="catval">
                <xsl:call-template name="CatlitLokoup">
                  <xsl:with-param name="catlitValue" select="5"/>
                  <xsl:with-param name="language" select="'eng'"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:value-of select="concat($catval,' ')"/>
            </xsl:if>

            <xsl:variable name="light_litchr">
              <xsl:call-template name="get_attribute_from_feature_list">
                <xsl:with-param name="featureIds" select="$currentFeatures"/>
                <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
                <xsl:with-param name="attribute" select="'LITCHR'"/>
              </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="fogsig_catfog">
              <xsl:call-template name="get_attribute_from_feature_list">
                <xsl:with-param name="featureIds" select="$currentFeatures"/>
                <xsl:with-param name="featureAcronyms" select="'FOGSIG'"/>
                <xsl:with-param name="attribute" select="'CATFOG'"/>
              </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="light_siggrp">
              <xsl:call-template name="get_attribute_from_feature_list">
                <xsl:with-param name="featureIds" select="$currentFeatures"/>
                <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
                <xsl:with-param name="attribute" select="'SIGGRP'"/>
              </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="mltylt">
              <xsl:call-template name="get_attribute_from_feature_list">
                <xsl:with-param name="featureIds" select="$currentFeatures"/>
                <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
                <xsl:with-param name="attribute" select="'MLTYLT'"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:if test="normalize-space($mainacronym) != ''  ">

              <xsl:if test="normalize-space($mltylt)">
                <xsl:value-of select="concat($mltylt,' ')"/>
              </xsl:if>
            </xsl:if>

            <xsl:variable name="catlit">
              <xsl:call-template name="get_attribute_from_feature_list">
                <xsl:with-param name="featureIds" select="$currentFeatures"/>
                <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
                <xsl:with-param name="attribute" select="'CATLIT'"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:call-template name="GetLitchr">
              <xsl:with-param name="litchr" select="$light_litchr"/>
              <xsl:with-param name="siggrp" select="$light_siggrp"/>
              <xsl:with-param name="lang" select="'eng'"/>
            </xsl:call-template>
            <!--<xsl:value-of separator="|" select="distinct-values(tokenize(.,'\|'))"/>-->
            <xsl:variable name="count_lights"
              select="count(CollocatedFeature[@acronym='LIGHTS']/@fid)"/>
<!--            <xsl:sort select="@fid"/>-->
            <xsl:variable name="light_col">
              <!--<xsl:for-each select="CollocatedFeature[@acronym='LIGHTS']">-->
              <!--<xsl:for-each select="CollocatedFeature[@acronym='LIGHTS']">-->
              <xsl:call-template name="get_attribute_from_feature_list_for_lights_color">
                <!--                <xsl:with-param name="featureIds" select="concat(@fid,',')" />-->
                <xsl:with-param name="featureIds" select="$currentFeatures"/>
                <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
                <xsl:with-param name="attribute" select="'COLOUR'"/>
              </xsl:call-template>
              <!--</xsl:for-each>-->
              <!--</xsl:for-each>-->
            </xsl:variable>

            <!-- <xsl:text>@@  </xsl:text>
            <xsl:value-of select="$light_col"/>
            <xsl:text>  @@</xsl:text>-->
            <xsl:variable name="light_colour">
              <xsl:call-template name="distinctvalues">
                <xsl:with-param name="values" select="$light_col"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="final_light">
              <xsl:call-template name="passing_single_color_for_light_eng">
                <xsl:with-param name="text" select="$light_colour"/>
              </xsl:call-template>
            </xsl:variable>
            <!-- Print the colour as is from the attribute COLOUR=*.* for MLTYLT -->

            <xsl:if test="$mltylt > 1">
              <xsl:variable name="MltColour">
                <xsl:call-template name="MultipleColourDescLookup">
                  <xsl:with-param name="colourValue"
                    select="normalize-space(substring($light_colour,1,string-length($light_colour)-1))"/>
                  <xsl:with-param name="language" select="'eng'"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:value-of select="$MltColour"/>
            </xsl:if>
            <xsl:if test="not($mltylt > 1)">
              <xsl:choose>
                <xsl:when test="contains($final_light,'RWG')">
                  <xsl:value-of select="normalize-space(translate($final_light,'RWG','WRG'))"/>
                </xsl:when>
                <xsl:when test="contains($final_light,'RGW')">
                  <xsl:value-of select="normalize-space(translate($final_light,'RGW','WRG'))"/>
                </xsl:when>
                <xsl:when test="contains($final_light,'GRW')">
                  <xsl:value-of select="normalize-space(translate($final_light,'GRW','WRG'))"/>
                </xsl:when>
                <xsl:when test="contains($final_light,'GWR')">
                  <xsl:value-of select="normalize-space(translate($final_light,'GWR','WRG'))"/>
                </xsl:when>
                <xsl:when test="contains($final_light,'WGR')">
                  <xsl:value-of select="normalize-space(translate($final_light,'WGR','WRG'))"/>
                </xsl:when>
                <xsl:when test="contains($final_light,'RW')">
                  <xsl:value-of select="normalize-space(translate($final_light,'RW','WR'))"/>
                </xsl:when>
                <xsl:when test="contains($final_light,'GW')">
                  <xsl:value-of select="normalize-space(translate($final_light,'RWG','WG'))"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$final_light"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>

            <xsl:if test="normalize-space($mainacronym) != ''  ">
              <xsl:variable name="light_sigper">
                <xsl:call-template name="get_attribute_from_feature_list">
                  <xsl:with-param name="featureIds" select="$currentFeatures"/>
                  <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
                  <xsl:with-param name="attribute" select="'SIGPER'"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:if test="normalize-space($light_sigper)">
                <xsl:if test="normalize-space($light_sigper) != 1">
                  <xsl:value-of select="concat(' ',$light_sigper, 's')"/>
                </xsl:if>
              </xsl:if>

              <xsl:choose>
                <xsl:when test="normalize-space($catlit)='19'">
                  <xsl:value-of select="'(hor)'"/>
                </xsl:when>
                <xsl:when test="normalize-space($catlit)='20'">
                  <xsl:value-of select="'(vert)'"/>
                </xsl:when>
              </xsl:choose>

            </xsl:if>
          </xsl:when>
          <xsl:when test="contains($llknum_val,'_')">
                     <!--<xsl:text> for llk contains '_' </xsl:text>-->
            <!--<xsl:text> $exclitval </xsl:text>
            <xsl:value-of select="$exclitval"/>
            <xsl:text> ### </xsl:text>-->

            <xsl:choose>

              <xsl:when test="normalize-space($exclitval) != '' and $litcharval = 1 or $litcharval = 'UNKNOWN' or $litcharval = '' ">
                <!--<xsl:text> $$$$$$$$ </xsl:text>-->
                <span style="font-style: italic;"><xsl:value-of select="$exclit_value"/></span>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="normalize-space($objnam_val) = ''">
                  <span style="font-style: italic;"><xsl:value-of select="concat($exclit_value,' ')"/></span>
                </xsl:if>

                <!-- CATLIT="1" for (Dir) -->
                <xsl:if test="$catlitval='1'">
                  <xsl:variable name="catval">
                    <xsl:call-template name="CatlitLokoup">
                      <xsl:with-param name="catlitValue" select="$catlitval"/>
                      <xsl:with-param name="language" select="'eng'"/>
                    </xsl:call-template>
                  </xsl:variable>
                  <xsl:value-of select="concat($catval,' ')"/>
                </xsl:if>
                <!-- CATLIT="5" or CATLIT="6" for 'Aero' -->
                <xsl:if test="$catlitval='5' or $catlitval='6'">
                  <!--<xsl:if test="$catlitval='5'">-->
                  <xsl:variable name="catval">
                    <xsl:call-template name="CatlitLokoup">
                      <xsl:with-param name="catlitValue" select="5"/>
                      <xsl:with-param name="language" select="'eng'"/>
                    </xsl:call-template>
                  </xsl:variable>
                  <xsl:value-of select="concat($catval,' ')"/>
                </xsl:if>

                <xsl:variable name="light_litchr">
                  <xsl:call-template name="get_attribute_from_feature_list">
                    <xsl:with-param name="featureIds" select="$currentFeatures"/>
                    <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
                    <xsl:with-param name="attribute" select="'LITCHR'"/>
                  </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="fogsig_catfog">
                  <xsl:call-template name="get_attribute_from_feature_list">
                    <xsl:with-param name="featureIds" select="$currentFeatures"/>
                    <xsl:with-param name="featureAcronyms" select="'FOGSIG'"/>
                    <xsl:with-param name="attribute" select="'CATFOG'"/>
                  </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="light_siggrp">
                  <xsl:call-template name="get_attribute_from_feature_list">
                    <xsl:with-param name="featureIds" select="$currentFeatures"/>
                    <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
                    <xsl:with-param name="attribute" select="'SIGGRP'"/>
                  </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="mltylt">
                  <xsl:call-template name="get_attribute_from_feature_list">
                    <xsl:with-param name="featureIds" select="$currentFeatures"/>
                    <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
                    <xsl:with-param name="attribute" select="'MLTYLT'"/>
                  </xsl:call-template>
                </xsl:variable>
                <xsl:if test="normalize-space($mainacronym) != ''  ">

                  <xsl:if test="normalize-space($mltylt)">
                    <xsl:value-of select="concat($mltylt,' ')"/>
                  </xsl:if>
                </xsl:if>

                <xsl:variable name="catlit">
                  <xsl:call-template name="get_attribute_from_feature_list">
                    <xsl:with-param name="featureIds" select="$currentFeatures"/>
                    <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
                    <xsl:with-param name="attribute" select="'CATLIT'"/>
                  </xsl:call-template>
                </xsl:variable>
                <xsl:call-template name="GetLitchr">
                  <xsl:with-param name="litchr" select="$light_litchr"/>
                  <xsl:with-param name="siggrp" select="$light_siggrp"/>
                  <xsl:with-param name="lang" select="'eng'"/>
                </xsl:call-template>
                <!--<xsl:value-of separator="|" select="distinct-values(tokenize(.,'\|'))"/>-->
                <xsl:variable name="count_lights"
                  select="count(CollocatedFeature[@acronym='LIGHTS']/@fid)"/>
<!--                <xsl:sort select="@fid"/>-->

                <xsl:variable name="light_col">
                  <!--<xsl:for-each select="CollocatedFeature[@acronym='LIGHTS']">-->
                  <!--<xsl:for-each select="CollocatedFeature[@acronym='LIGHTS']">-->
                  <xsl:call-template name="get_attribute_from_feature_list_for_lights_color">
                    <!--                <xsl:with-param name="featureIds" select="concat(@fid,',')" />-->
                    <xsl:with-param name="featureIds" select="$currentFeatures"/>
                    <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
                    <xsl:with-param name="attribute" select="'COLOUR'"/>
                  </xsl:call-template>
                  <!--</xsl:for-each>-->
                  <!--</xsl:for-each>-->
                </xsl:variable>

                 <!--<xsl:text>@@  </xsl:text>
            <xsl:value-of select="$light_col"/>
            <xsl:text>  @@</xsl:text>-->
                <xsl:variable name="light_colour">
                  <xsl:call-template name="distinctvalues">
                    <xsl:with-param name="values" select="$light_col"/>
                  </xsl:call-template>
                </xsl:variable>
                <!--<xsl:text>**  </xsl:text>
            <xsl:value-of select="$light_colour"/>
            <xsl:text>  **</xsl:text>-->
                <xsl:variable name="final_light">
                  <xsl:call-template name="passing_single_color_for_light_eng">
                    <xsl:with-param name="text" select="$light_colour"/>
                  </xsl:call-template>
                </xsl:variable>
                <!-- Print the colour as is from the attribute COLOUR=*.* for MLTYLT -->

                <xsl:if test="$mltylt > 1">
                  <xsl:variable name="MltColour">
                    <xsl:call-template name="MultipleColourDescLookup">
                      <xsl:with-param name="colourValue"
                        select="normalize-space(substring($light_colour,1,string-length($light_colour)-1))"/>
                      <xsl:with-param name="language" select="'eng'"/>
                    </xsl:call-template>
                  </xsl:variable>
                  <xsl:value-of select="$MltColour"/>
                </xsl:if>
                <xsl:if test="not($mltylt > 1)">
                  <xsl:choose>
                    <xsl:when test="contains($final_light,'RWG')">
                      <xsl:value-of select="normalize-space(translate($final_light,'RWG','WRG'))"/>
                    </xsl:when>
                    <xsl:when test="contains($final_light,'RGW')">
                      <xsl:value-of select="normalize-space(translate($final_light,'RGW','WRG'))"/>
                    </xsl:when>
                    <xsl:when test="contains($final_light,'GRW')">
                      <xsl:value-of select="normalize-space(translate($final_light,'GRW','WRG'))"/>
                    </xsl:when>
                    <xsl:when test="contains($final_light,'GWR')">
                      <xsl:value-of select="normalize-space(translate($final_light,'GWR','WRG'))"/>
                    </xsl:when>
                    <xsl:when test="contains($final_light,'WGR')">
                      <xsl:value-of select="normalize-space(translate($final_light,'WGR','WRG'))"/>
                    </xsl:when>
                    <xsl:when test="contains($final_light,'RW')">
                      <xsl:value-of select="normalize-space(translate($final_light,'RW','WR'))"/>
                    </xsl:when>
                    <xsl:when test="contains($final_light,'GW')">
                      <xsl:value-of select="normalize-space(translate($final_light,'RWG','WG'))"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$final_light"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:if>

                <xsl:if test="normalize-space($mainacronym) != ''  ">
                  <xsl:variable name="light_sigper">
                    <xsl:call-template name="get_attribute_from_feature_list">
                      <xsl:with-param name="featureIds" select="$currentFeatures"/>
                      <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
                      <xsl:with-param name="attribute" select="'SIGPER'"/>
                    </xsl:call-template>
                  </xsl:variable>
                  <xsl:if test="normalize-space($light_sigper)">
                    <xsl:if test="normalize-space($light_sigper) != 1">
                      <xsl:value-of select="concat(' ',$light_sigper, 's')"/>
                    </xsl:if>
                  </xsl:if>
                  <xsl:choose>
                    <xsl:when test="normalize-space($catlit)='19'">
                      <xsl:value-of select="'(hor)'"/>
                    </xsl:when>
                    <xsl:when test="normalize-space($catlit)='20'">
                      <xsl:value-of select="'(vert)'"/>
                    </xsl:when>
                  </xsl:choose>
                </xsl:if>
                <!-- fourth line - Intensity -->
                <!-- this will be added manually by the user -->
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
        </xsl:choose>
      </xsl:element>
      <!-- /LIGHT_CHARACTERISTICS_ENG -->

      <!-- NM_REMARKS -->
      <xsl:element name="NM_REMARKS">
        <xsl:if test="normalize-space($mainacronym) != ''  ">
          <!-- second line - Signal Period -->
          <xsl:variable name="light_colour">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="$currentFeatures"/>
              <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
              <xsl:with-param name="attribute" select="'COLOUR'"/>
            </xsl:call-template>
          </xsl:variable>

          <!-- third line - Signal Sequence -->
          <xsl:variable name="light_sigseq">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="$currentFeatures"/>
              <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
              <xsl:with-param name="attribute" select="'SIGSEQ'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="sigseq_feature">
            <xsl:call-template name="get_sigseq_from_feature_list">
              <xsl:with-param name="featureIds" select="$currentFeatures"/>
              <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
              <xsl:with-param name="attribute" select="'SIGSEQ'"/>
            </xsl:call-template>
          </xsl:variable>
         <!-- <xsl:text> light_sigseq </xsl:text>
          <xsl:value-of select="$light_sigseq"/>
          <xsl:text> **** </xsl:text>-->
          <!--<xsl:text> sigseq_feature </xsl:text>
          <xsl:value-of select="$sigseq_feature"/>
          <xsl:text> **** </xsl:text>-->
          <xsl:variable name="fogfig_sigseq">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="$currentFeatures"/>
              <xsl:with-param name="featureAcronyms" select="'FOGSIG'"/>
              <xsl:with-param name="attribute" select="'SIGSEQ'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="fogfig_sigseq_feature">
            <xsl:call-template name="get_sigseq_from_feature_list">
              <xsl:with-param name="featureIds" select="$currentFeatures"/>
              <xsl:with-param name="featureAcronyms" select="'FOGSIG'"/>
              <xsl:with-param name="attribute" select="'SIGSEQ'"/>
            </xsl:call-template>
          </xsl:variable>

          <!--<xsl:text> fogfig_sigseq </xsl:text>
            <xsl:value-of select="$fogfig_sigseq"/>
            <xsl:text> *** </xsl:text>
          <xsl:text> fogfig_sigseq_feature </xsl:text>
          <xsl:value-of select="$fogfig_sigseq_feature"/>
          <xsl:text> *** </xsl:text>-->
          
          <xsl:choose>
           <!-- <xsl:when test="$fogfig_sigseq != ''">
              <xsl:call-template name="FormatSigseq_for_fogsig">
                <xsl:with-param name="sigseq" select="$fogfig_sigseq"/>
                <xsl:with-param name="colour" select="$light_colour"/>
                <xsl:with-param name="lang" select="'eng'"/>
              </xsl:call-template>
            </xsl:when>-->
            <xsl:when test="$fogfig_sigseq_feature != ''">
              <xsl:call-template name="Summarise_formatSigseq_for_fogsig">
                <xsl:with-param name="sigseq" select="$fogfig_sigseq_feature"/>
                <xsl:with-param name="colour" select="$light_colour"/>
                <xsl:with-param name="lang" select="'eng'"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:when test="normalize-space($light_sigseq) != ''">

              <!--  <xsl:variable name="light_litchr" >
                <xsl:call-template name="get_attribute_from_feature_list" >
                  <xsl:with-param name="featureIds" select="$lightFeatures" />
                  <xsl:with-param name="featureAcronyms" select="'LIGHTS'" />
                  <xsl:with-param name="attribute" select="'LITCHR'" />
                </xsl:call-template>                
              </xsl:variable>-->
              <xsl:variable name="light_litchr">
                <xsl:call-template name="get_attribute_from_feature_list">
                  <xsl:with-param name="featureIds" select="$currentFeatures"/>
                  <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
                  <xsl:with-param name="attribute" select="'LITCHR'"/>
                </xsl:call-template>
              </xsl:variable>

              <!--LITCHR - <xsl:value-of select="$light_litchr"/>$$$-->
              <xsl:choose>
                <xsl:when test="$light_litchr = 8">
                  <xsl:call-template name="summarise_FormatLitSigseq">
                    <xsl:with-param name="sigseq" select="$sigseq_feature"/>
                    <xsl:with-param name="colour" select="$light_colour"/>
                    <xsl:with-param name="lang" select="'eng'"/>
                  </xsl:call-template>
                </xsl:when>
                
                <xsl:when test="$light_litchr != 8">
                  <xsl:call-template name="summarise_FormatSigseq">
                    <xsl:with-param name="sigseq" select="$sigseq_feature"/>
                    <xsl:with-param name="colour" select="$light_colour"/>
                    <xsl:with-param name="lang" select="'eng'"/>
                  </xsl:call-template>
                </xsl:when>
                
               <!-- <xsl:when test="$light_litchr = 8">
                  <xsl:call-template name="FormatLitSigseq">
                    <xsl:with-param name="sigseq" select="$light_sigseq"/>
                    <xsl:with-param name="colour" select="$light_colour"/>
                    <xsl:with-param name="lang" select="'eng'"/>
                  </xsl:call-template>
                </xsl:when>
                
                <xsl:when test="$light_litchr != 8">
                  <xsl:call-template name="FormatSigseq">
                    <xsl:with-param name="sigseq" select="$light_sigseq"/>
                    <xsl:with-param name="colour" select="$light_colour"/>
                    <xsl:with-param name="lang" select="'eng'"/>
                  </xsl:call-template>
                </xsl:when>-->

              </xsl:choose>


            </xsl:when>

          </xsl:choose>
        </xsl:if>
      </xsl:element>

      <!-- LIGHT_CHARACTERISTICS_NAT -->
      <xsl:element name="LIGHT_CHARACTERISTICS_NAT">
        <xsl:variable name="light_litchr">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
            <xsl:with-param name="attribute" select="'LITCHR'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="light_siggrp">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
            <xsl:with-param name="attribute" select="'SIGGRP'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="light_colour">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
            <xsl:with-param name="attribute" select="'COLOUR'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:if test="normalize-space($mainacronym) != ''  ">
          <!-- poplate the first line -->
          <xsl:call-template name="GetLitchr">
            <xsl:with-param name="litchr" select="$light_litchr"/>
            <xsl:with-param name="siggrp" select="$light_siggrp"/>
            <xsl:with-param name="colour" select="$light_colour"/>
            <xsl:with-param name="lang" select="'nat'"/>
          </xsl:call-template>

          <!-- second line - Signal Period -->
          <xsl:variable name="light_sigper">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="$currentFeatures"/>
              <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
              <xsl:with-param name="attribute" select="'SIGPER'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:value-of select="concat(' ',$light_sigper, 's')"/>

          <!-- third line - Signal Sequence -->
          <xsl:variable name="light_sigseq">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="$currentFeatures"/>
              <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
              <xsl:with-param name="attribute" select="'SIGSEQ'"/>
            </xsl:call-template>
          </xsl:variable>
          <br/>
          <xsl:if test="normalize-space($light_sigseq) != ''  ">
            <xsl:call-template name="FormatSigseq">
              <xsl:with-param name="sigseq" select="$light_sigseq"/>
              <xsl:with-param name="colour" select="$light_colour"/>
              <xsl:with-param name="lang" select="'nat'"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:if>
        <!-- fourth line - Intensity -->
        <!-- this will be added manually by the user -->

      </xsl:element>
      <!-- /LIGHT_CHARACTERISTICS_NAT -->

      <!-- HEIGHT -->
      <xsl:element name="LIGHT_HEIGHT">
        <xsl:variable name="height">
          <xsl:for-each select="CollocatedFeature[contains($currentFeatures,@fid)]">
            <!--<xsl:sort select="@fid"/>-->
            <xsl:call-template name="get_attribute_from_feature_list_exclit">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
              <xsl:with-param name="attribute" select="'HEIGHT'"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:variable>
        <!--<xsl:text> height </xsl:text>
        <xsl:value-of select="$height"/>
        <xsl:text> *** </xsl:text>-->
        <xsl:variable name="light_height">
          <xsl:call-template name="distinctvalues_exclit">
            <xsl:with-param name="values" select="$height"/>
          </xsl:call-template>
        </xsl:variable>
        <!--<xsl:text> light_height </xsl:text>
        <xsl:value-of select="$light_height"/>
        <xsl:text> *** </xsl:text>-->
        <xsl:variable name="catlit_val">
        <xsl:call-template name="get_attribute_from_feature_list">
          <xsl:with-param name="featureIds" select="$currentFeatures"/>
          <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
          <xsl:with-param name="attribute" select="'CATLIT'"/>
        </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="exclit_val">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
            <xsl:with-param name="attribute" select="'EXCLIT'"/>
          </xsl:call-template>
        </xsl:variable>
        <!--<xsl:text> catlit_val </xsl:text>
        <xsl:value-of select="$catlit_val"/>
        <xsl:text> *** </xsl:text>-->
        <xsl:variable name="llknum_val">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$mainFeatures"/>
            <xsl:with-param name="attribute" select="'llknum'"/>
          </xsl:call-template>
        </xsl:variable>
        <!--<xsl:text> $light_height </xsl:text>
        <xsl:value-of select="$light_height"/>
        <xsl:text> *** </xsl:text>-->
        <xsl:call-template name="redering_light_height">
          <xsl:with-param name="values" select="$light_height"/>
          <xsl:with-param name="llknum_val" select="$llknum_val"/>
          <xsl:with-param name="catlit_val" select="$catlit_val"/>
          <xsl:with-param name="exclit_val" select="$exclit_val"/>
        </xsl:call-template>
      </xsl:element>
      <!-- /HEIGHT -->

      <!-- LUM_GEO_RANGE -->
      <xsl:element name="LUM_GEO_RANGE">

        <xsl:variable name="lightValnmr">
          <xsl:for-each select="CollocatedFeature[contains($currentFeatures,@fid)]">
            <xsl:sort
              select="key('featureids', @fid)[contains('LIGHTS', @acronym)]/Attributes/Attribute[@acronym='COLOUR']/@value"
              data-type="number" order="ascending"/>
            <!-- <xsl:sort select="key('featureids', @fid)[contains('LIGHTS', @acronym)]/Attributes/Attribute[@acronym='COLOUR']/@value"  data-type="number" order="ascending"/>-->
            <xsl:call-template name="get_attribute_from_feature_list_geo_range_exclit">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
              <xsl:with-param name="attribute" select="'VALNMR,COLOUR'"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:variable>

        <!--<xsl:text> lightValnmr </xsl:text>
          <xsl:value-of select="$lightValnmr"/>
          <xsl:text> stop </xsl:text>-->
        <xsl:variable name="final_result">
          <xsl:if test="$lightValnmr !=''">
            <xsl:call-template name="distinctvalues_for_range">
              <xsl:with-param name="textIn"
                select="substring($lightValnmr,1,string-length($lightValnmr)-1)"/>
              <xsl:with-param name="wordsIn"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:variable>
        <!-- <xsl:text> final_result </xsl:text>
          <xsl:value-of select="$final_result"/>
          <xsl:text> stop </xsl:text>-->
        <xsl:variable name="valnmr_value">
          <xsl:choose>
            <xsl:when test="string-length($final_result) &gt;= 5">
              <xsl:variable name="valnmr_with_col" select="concat($final_result,',')"/>
              <xsl:variable name="first_val" select="substring-before($valnmr_with_col,',')"/>
              <xsl:variable name="first_valnmr" select="concat($first_val,',')"/>
              <xsl:variable name="valnmr_color"
                select="substring-after($valnmr_with_col,$first_valnmr)"/>
              <xsl:value-of select="concat($first_val,',',' ')"/>
              <xsl:call-template name="checking_for_same_valnmr_value">
                <xsl:with-param name="additional_colour" select="$valnmr_color"/>
                <xsl:with-param name="valnmr_with_colour" select="$valnmr_color"/>
                <xsl:with-param name="first_valnmr" select="$first_val"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>

              <xsl:value-of select="concat($final_result,',')"/>
            </xsl:otherwise>
          </xsl:choose>
          <!--<xsl:text> $$$$$$$$ </xsl:text>-->
        </xsl:variable>
        <!--<xsl:text> valnmr_value </xsl:text>
          <xsl:value-of select="$valnmr_value"/>
          <xsl:text> stop </xsl:text>-->
        <xsl:variable name="color_with_valnmr_final_result">
          <xsl:if test="$valnmr_value !=''">
            <xsl:call-template name="distinctvalues_for_range">
              <xsl:with-param name="textIn"
                select="substring(normalize-space($valnmr_value),1,string-length(normalize-space($valnmr_value))-1)"/>
              <xsl:with-param name="wordsIn"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:variable>
       <!-- <xsl:text> final_result_duplicate </xsl:text>
          <xsl:value-of select="normalize-space($color_with_valnmr_final_result)"/>
          <xsl:text> stop </xsl:text>-->
        <!-- If Single color and VALNMR >= 15 - bold the value and remove color prefix -->
        <xsl:choose>
          <xsl:when test="not(contains($color_with_valnmr_final_result,','))">
            <!--<xsl:if test="string-length($color_with_valnmr_final_result) = 1">
              <xsl:value-of select="$color_with_valnmr_final_result"/>
            </xsl:if>-->

            <xsl:if
              test="starts-with($color_with_valnmr_final_result,'Bu') or starts-with($color_with_valnmr_final_result,'Am') or starts-with($color_with_valnmr_final_result,'Vi') or starts-with($color_with_valnmr_final_result,'Or')">
              <xsl:if
                test="substring($color_with_valnmr_final_result,3,string-length($color_with_valnmr_final_result)) >= 15">
                <strong>
                  <xsl:value-of
                    select="substring($color_with_valnmr_final_result,3,string-length($color_with_valnmr_final_result))"
                  />
                </strong>
              </xsl:if>
              <xsl:if
                test="not(substring($color_with_valnmr_final_result,3,string-length($color_with_valnmr_final_result)) >= 15)">
                <xsl:value-of
                  select="substring($color_with_valnmr_final_result,3,string-length($color_with_valnmr_final_result))"
                />
              </xsl:if>
            </xsl:if>
            <xsl:if
              test="not(starts-with($color_with_valnmr_final_result,'Bu') or starts-with($color_with_valnmr_final_result,'Am') or starts-with($color_with_valnmr_final_result,'Vi') or starts-with($color_with_valnmr_final_result,'Or'))">
              <xsl:if
                test="substring($color_with_valnmr_final_result,2,string-length($color_with_valnmr_final_result)) >= 15">
                <strong>
                  <xsl:value-of
                    select="substring($color_with_valnmr_final_result,2,string-length($color_with_valnmr_final_result))"
                  />
                </strong>
              </xsl:if>

              <xsl:if
                test="not(substring($color_with_valnmr_final_result,2,string-length($color_with_valnmr_final_result)) >= 15)">
                <!--<xsl:text> $final_result </xsl:text>
                    <xsl:value-of select="$final_result"/>
                    <xsl:text> @@@ </xsl:text>-->
                <xsl:choose>
                  <xsl:when
                    test="contains($color_with_valnmr_final_result,'W') or contains($color_with_valnmr_final_result,'R') or contains($color_with_valnmr_final_result,'G') or contains($color_with_valnmr_final_result,'Bu')or contains($color_with_valnmr_final_result,'Y')or contains($color_with_valnmr_final_result,'Am')
                        or contains($color_with_valnmr_final_result,'Vi')or contains($color_with_valnmr_final_result,'Or') or contains($color_with_valnmr_final_result,'*')">

                    <xsl:value-of
                      select="substring($color_with_valnmr_final_result,2,string-length($color_with_valnmr_final_result))"/>

                  </xsl:when>
                  <xsl:otherwise>
                    <!--<xsl:text> final_result_duplicate </xsl:text>
                    <xsl:value-of select="normalize-space($color_with_valnmr_final_result)"/>
                    <xsl:text> stop </xsl:text>-->
                    <xsl:value-of select="$color_with_valnmr_final_result"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
            </xsl:if>

          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="split_exclit_and_other_values">
              <xsl:with-param name="geo_ranges" select="$color_with_valnmr_final_result"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>

      <!--  DESC_STRUCT_HEIGHT_ENG -->
      <xsl:element name="DESC_STRUCT_HEIGHT_ENG">
        <xsl:variable name="masterFeatureAcronym"
          select="normalize-space(substring-after($masterFeature, ','))"/>
        <xsl:variable name="slaveFeatureAcronym"
          select="normalize-space(substring-after($slaveFeature, ','))"/>
        <xsl:variable name="tmpNatcon">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'NATCON'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="natcon">
          <xsl:call-template name="RecursiveNatconLookup">
            <xsl:with-param name="language" select="'eng'"/>
            <xsl:with-param name="natconValue" select="normalize-space($tmpNatcon)"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="tmpColour">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'COLOUR'"/>
          </xsl:call-template>
        </xsl:variable>
        <!-- <xsl:text> tmpColour </xsl:text>
              <xsl:value-of select="$tmpColour"/>
              <xsl:text>***</xsl:text>-->
        <xsl:variable name="colour">
          <xsl:call-template name="RecursiveColourDescLookup">
            <xsl:with-param name="language" select="'eng'"/>
            <xsl:with-param name="colourValue" select="normalize-space($tmpColour)"/>
          </xsl:call-template>
        </xsl:variable>
        <!-- <xsl:text> colour </xsl:text>
          <xsl:value-of select="$colour"/>
          <xsl:text>***</xsl:text>-->


        <xsl:variable name="tmpColpat">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'COLPAT'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="colpat">
          <xsl:call-template name="ColpatLookup">
            <xsl:with-param name="language" select="'eng'"/>
            <xsl:with-param name="colpatValue" select="normalize-space($tmpColpat)"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="tmpCatofp">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'CATOFP'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="catofp">
          <xsl:call-template name="CatofpLookup">
            <xsl:with-param name="language" select="'eng'"/>
            <xsl:with-param name="catofpValue" select="normalize-space($tmpCatofp)"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="tmpCatple">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'CATPLE'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="catple">
          <xsl:call-template name="CatpleLookup">
            <xsl:with-param name="language" select="'eng'"/>
            <xsl:with-param name="catpleValue" select="normalize-space($tmpCatple)"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="verlen">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'VERLEN'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="tmpBuishp">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'BUISGL'"/>
            <xsl:with-param name="attribute" select="'BUISHP'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="buishp">
          <xsl:call-template name="BuishpLookup">
            <xsl:with-param name="language" select="'eng'"/>
            <xsl:with-param name="buishpValue" select="normalize-space($tmpBuishp)"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="tmpCatsil">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'BUISGL'"/>
            <xsl:with-param name="attribute" select="'CATSIL'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="catsil">
          <xsl:call-template name="CatsilLookup">
            <xsl:with-param name="language" select="'eng'"/>
            <xsl:with-param name="catsilValue" select="normalize-space($tmpCatsil)"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="topcolor">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'TOPMAR'"/>
            <xsl:with-param name="attribute" select="'COLOUR'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="topshp">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'TOPMAR'"/>
            <xsl:with-param name="attribute" select="'TOPSHP'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
          <xsl:when
            test="contains($masterFeatureAcronym, 'BCN') or $masterFeatureAcronym = 'LNDMRK' or $masterFeatureAcronym = 'BUISGL'">
            <xsl:variable name="firstAttribute">
              <xsl:choose>
                <xsl:when test="contains($masterFeatureAcronym, 'BCN')">

                  <xsl:variable name="tmpFirstAttribute">
                    <xsl:call-template name="get_attribute_from_feature_list">
                      <xsl:with-param name="featureIds" select="$currentFeatures"/>
                      <xsl:with-param name="featureAcronyms"
                        select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP'"/>
                      <xsl:with-param name="attribute" select="'BCNSHP'"/>
                    </xsl:call-template>
                  </xsl:variable>
                  
                  <xsl:variable name="colour_val">
                    <xsl:call-template name="get_attribute_from_feature_list">
                      <xsl:with-param name="featureIds" select="$currentFeatures"/>
                      <xsl:with-param name="featureAcronyms" select="'DAYMAR'"/>
                      <xsl:with-param name="attribute" select="'COLOUR'"/>
                    </xsl:call-template>
                  </xsl:variable>
                  <xsl:variable name="colpat_val">
                    <xsl:call-template name="get_attribute_from_feature_list">
                      <xsl:with-param name="featureIds" select="$currentFeatures"/>
                      <xsl:with-param name="featureAcronyms" select="'DAYMAR'"/>
                      <xsl:with-param name="attribute" select="'COLPAT'"/>
                    </xsl:call-template>
                  </xsl:variable>
                  <xsl:variable name="topshp_val">
                    <xsl:call-template name="get_attribute_from_feature_list">
                      <xsl:with-param name="featureIds" select="$currentFeatures"/>
                      <xsl:with-param name="featureAcronyms" select="'DAYMAR'"/>
                      <xsl:with-param name="attribute" select="'TOPSHP'"/>
                    </xsl:call-template>
                  </xsl:variable>
                  
                  
                    <xsl:variable name="topshp_value">
                      <xsl:if test="normalize-space($topshp_val) != ''">
                      <xsl:call-template name="TopshpLookup">
                        <xsl:with-param name="language" select="'eng'"/>
                        <xsl:with-param name="topshpValue" select="normalize-space($topshp_val)"/>
                      </xsl:call-template>
                      </xsl:if>
                    </xsl:variable>
                  <xsl:variable name="colpat_value">
                    <xsl:if test="normalize-space($colpat_val) != ''">
                    <xsl:call-template name="ColpatLookup">
                      <xsl:with-param name="language" select="'eng'"/>
                      <xsl:with-param name="colpatValue" select="normalize-space($colpat_val)"/>
                    </xsl:call-template>
                    </xsl:if>
                  </xsl:variable>
                  
                 <!-- <xsl:variable name="colour_value">
                    <xsl:call-template name="MultipleColourDescLookup">
                      <xsl:with-param name="colourValue" select="$colour_val"/>
                      <xsl:with-param name="language" select="'eng'"/>
                    </xsl:call-template>
                  </xsl:variable>-->
                  <!--<xsl:text> $colour_val </xsl:text>
                  <xsl:value-of select="concat($colour_val,',')"/>
                  <xsl:text> *** </xsl:text>-->
                  <xsl:variable name="colour_value">
                    <xsl:call-template name="passing_single_color_for_lum_geo_range">
                      <xsl:with-param name="text" select="concat($colour_val,',')"/>
                    </xsl:call-template>
                  </xsl:variable>
                  <!--<xsl:text> slaveFeatureAcronym </xsl:text>
                  <xsl:value-of select="$slaveFeatureAcronym"/>
                  <xsl:text> *** </xsl:text>-->
                  <!--<xsl:text> $topshp_value </xsl:text>
                  <xsl:value-of select="$topshp_value"/>
                  <xsl:text> $colpat_value </xsl:text>
                  <xsl:value-of select="$colpat_value"/>
                  <xsl:text> $colour_value </xsl:text>
                  <xsl:value-of select="$colour_value"/>
                  <xsl:text> *** </xsl:text>-->
                  
                  <!--  we should convert DAYMAR into daymark -->
                  <xsl:variable name="daymar_conversion">
                  <xsl:if test="$slaveFeatureAcronym = 'DAYMAR'">
                    <xsl:text>daymark</xsl:text>
                  </xsl:if> 
                  </xsl:variable>
                  <xsl:choose>
                    <xsl:when test="$colour_value != ''">
                      <xsl:variable name="daymar_height">
                        <xsl:value-of select="concat(substring-before($colour_value,','),' ',$daymar_conversion,' ',substring-after($colour_value,','),' ',$colpat_value)"/>
                      </xsl:variable>
                      <xsl:value-of select="concat(substring($daymar_height, 1, 1), translate(substring($daymar_height, 2), $uppercase, $smallcase))"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:if test="$tmpFirstAttribute = '' and not(contains($llknum,'_'))">
                        <!--<xsl:value-of select="'Beacon'"/>-->
                        <xsl:value-of select="'beacon'"/>
                      </xsl:if>
                    </xsl:otherwise>
                  </xsl:choose>
                  
                  <xsl:if test="$tmpFirstAttribute != ''">
                    <xsl:call-template name="BcnshpLookup">
                      <xsl:with-param name="language" select="'eng'"/>
                      <xsl:with-param name="bcnshpValue"
                        select="normalize-space($tmpFirstAttribute)"/>
                    </xsl:call-template>
                  </xsl:if>
                </xsl:when>
                <xsl:when test="$masterFeatureAcronym = 'LNDMRK'">
                  <xsl:variable name="tmpFirstAttribute">
                    <xsl:call-template name="get_attribute_from_feature_list">
                      <xsl:with-param name="featureIds" select="$currentFeatures"/>
                      <xsl:with-param name="featureAcronyms" select="'LNDMRK'"/>
                      <xsl:with-param name="attribute" select="'CATLMK'"/>
                    </xsl:call-template>
                  </xsl:variable>
                  <xsl:call-template name="CatlmkLookup">
                    <xsl:with-param name="language" select="'eng'"/>
                    <xsl:with-param name="catlmkValue" select="normalize-space($tmpFirstAttribute)"
                    />
                  </xsl:call-template>
                </xsl:when>
                <xsl:when test="$masterFeatureAcronym = 'BUISGL'">
                  <xsl:variable name="tmpFirstAttribute">
                    <xsl:call-template name="get_attribute_from_feature_list">
                      <xsl:with-param name="featureIds" select="$currentFeatures"/>
                      <xsl:with-param name="featureAcronyms" select="'BUISGL'"/>
                      <xsl:with-param name="attribute" select="'BUISHP'"/>
                    </xsl:call-template>
                  </xsl:variable>
                  <xsl:call-template name="BuishpLookup">
                    <xsl:with-param name="language" select="'eng'"/>
                    <xsl:with-param name="buishpValue" select="normalize-space($tmpFirstAttribute)"
                    />
                  </xsl:call-template>
                </xsl:when>
              </xsl:choose>
            </xsl:variable>

            <xsl:variable name="final">


              <!-- Checking for STATUS=12 then print it in Structure Height as "Floodlit" -->
              <xsl:variable name="statusVal">
                <xsl:call-template name="get_attribute_from_feature_list">
                  <xsl:with-param name="featureIds" select="$currentFeatures"/>
                  <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
                  <xsl:with-param name="attribute" select="'STATUS'"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:if test="normalize-space($colour) != '' ">
                <xsl:variable name="colorCamelCase">
                  <xsl:value-of
                    select="translate(substring(normalize-space($colour),1,1),$smallcase,$uppercase)"/>
                  <xsl:value-of
                    select="translate(substring(normalize-space($colour),2,string-length($colour)),$uppercase,$smallcase)"
                  />
                </xsl:variable>
                
                <!--<xsl:text> colorCamelCase </xsl:text>
                <xsl:value-of select="$colorCamelCase"/>
                <xsl:text> *** </xsl:text>-->
                <!-- Formatting the Colours Red, White, Green as Red, white and green. If two colours then Red and white (assuming only three colours) -->
                <xsl:if test="contains($colorCamelCase,', ')">
                  <xsl:variable name="first">
                    <xsl:value-of select="substring-before($colorCamelCase,', ')"/>
                  </xsl:variable>
                  <xsl:variable name="rest">
                    <xsl:value-of select="substring-after($colorCamelCase,', ')"/>
                  </xsl:variable>
                  <xsl:if test="contains($rest,', ')">
                    <xsl:value-of
                      select="concat(' ',$first,', ',substring-before($rest,', '), ' and ', substring-after($rest,', '))"
                    />
                  </xsl:if>
                  <xsl:if test="not(contains($rest,', '))">
                    <xsl:value-of select="concat(' ',$first,' and ', $rest)"/>
                  </xsl:if>
                </xsl:if>
              </xsl:if>

              <xsl:if test="normalize-space($colpat) != '' ">
                <xsl:value-of select="concat(' ' , $colpat,', ')"/>
              </xsl:if>
              <xsl:if test="normalize-space($natcon) != '' ">
                <!-- Testing***** NTM-288 -->
                <!--<xsl:value-of select="concat(' ' , $natcon,' ')"/>-->
                <xsl:choose>
                  <xsl:when test="normalize-space($colour) = '' and normalize-space($colpat) = '' and normalize-space($statusVal) = ''">
                    <xsl:value-of select="translate(substring(normalize-space($natcon),1,1),$smallcase,$uppercase)"/>
                    <xsl:value-of select="concat(translate(substring(normalize-space($natcon),2,string-length($natcon)),$uppercase,$smallcase),' ')"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="concat(' ' , $natcon,' ')"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
              <xsl:if test="normalize-space($firstAttribute) != ''">
                <!--<xsl:value-of select="$firstAttribute"/>-->
                <xsl:choose>
                  <xsl:when test="normalize-space($colour) = '' and normalize-space($colpat) = '' and normalize-space($statusVal) = '' and normalize-space($natcon)=''">
                    <xsl:value-of select="translate(substring(normalize-space($firstAttribute),1,1),$smallcase,$uppercase)"/>
                    <xsl:value-of select="concat(translate(substring(normalize-space($firstAttribute),2,string-length($firstAttribute)),$uppercase,$smallcase),' ')"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$firstAttribute"/>
                  </xsl:otherwise>
                </xsl:choose>
                
              </xsl:if>
              <!--<xsl:text> *** </xsl:text>
              <xsl:value-of select="$firstAttribute"/>
              <xsl:text> *** </xsl:text>-->
              <xsl:if test="(normalize-space($statusVal) != '') and ($statusVal = 12)">
                <xsl:variable name="stat">
                  <xsl:call-template name="StatusLookup">
                    <xsl:with-param name="language" select="'eng'"/>
                    <xsl:with-param name="statusValue" select="$statusVal"/>
                  </xsl:call-template>
                </xsl:variable>
                <!--
                <xsl:text> *** </xsl:text>
                <xsl:value-of select="$stat"/>
                <xsl:text> *** </xsl:text>-->
                
                <xsl:value-of select="concat(', ',$stat)"/>
              </xsl:if>
            </xsl:variable>
            <xsl:variable name="colorCamelCase">
              <xsl:value-of
                select="translate(substring(normalize-space($colour),1,1),$smallcase,$uppercase)"/>
              <xsl:value-of
                select="translate(substring(normalize-space($colour),2,string-length($colour)),$uppercase,$smallcase)"
              />
            </xsl:variable>

            <xsl:if test="not(contains($colorCamelCase,','))">
              <xsl:if test="$colour != ''">
                <xsl:value-of select="concat($colour,' ')"/>
              </xsl:if>
            </xsl:if>

            <xsl:value-of select="$final"/>
            <!-- Testing***** -->
            <!--<xsl:choose>
              <xsl:when test="$colour != ''">
                <xsl:value-of select="translate($final,$uppercase,$smallcase)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$final"/>
              </xsl:otherwise>
            </xsl:choose>-->

            <xsl:if test="normalize-space($topcolor) != ''">
              <xsl:variable name="topcolorLookup">
                <xsl:call-template name="ColourDescLookup">
                  <xsl:with-param name="colourValue" select="normalize-space($topcolor)"/>
                  <xsl:with-param name="language" select="'eng'"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:if test="normalize-space($topcolorLookup) != '' ">
                <br/>
                <xsl:value-of select="$topcolorLookup"/>
              </xsl:if>
            </xsl:if>

            <xsl:if test="normalize-space($topshp) != ''">
              <xsl:variable name="topshpLookup">
                <xsl:call-template name="TopshpLookup">
                  <xsl:with-param name="language" select="'eng'"/>
                  <xsl:with-param name="topshpValue" select="normalize-space($topshp)"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:if test="normalize-space($topshpLookup) != '' ">
                <xsl:value-of select="concat(' ','')"/>
                <!--<xsl:value-of select="$topshpLookup"/>-->
                <xsl:value-of select="translate($topshpLookup,$uppercase,$smallcase)"/>
              </xsl:if>
            </xsl:if>
            <xsl:if test="normalize-space($verlen) != ''">
              
              <p style="text-align:center;margin-top: 0px;margin-bottom: 2px;">
                <xsl:value-of select="normalize-space($verlen)"/>
              </p>
            </xsl:if>

          </xsl:when>

          <xsl:when test="$masterFeatureAcronym = 'OFSPLF' ">
            <xsl:choose>
              <xsl:when test="normalize-space($natcon) and normalize-space($catofp)">
                <xsl:value-of select="concat($natcon, ', ', $catofp)"/>
              </xsl:when>
              <xsl:when test="not(normalize-space($natcon)) and normalize-space($catofp)">
                <xsl:value-of select="$catofp"/>
              </xsl:when>
            </xsl:choose>
            <xsl:if test="normalize-space($verlen) != ''">
              <br/>
              <p style="text-align: center; margin:0px; padding: 0px;">
                <xsl:value-of select="$verlen"/>
              </p>
            </xsl:if>
          </xsl:when>

          <xsl:when test="$masterFeatureAcronym = 'LITVES' or $masterFeatureAcronym = 'LITFLT'">
            <xsl:value-of select="$natcon"/>
            <xsl:if test="normalize-space($colour) != '' ">
              <xsl:value-of select="concat(', ', $colour)"/>
            </xsl:if>
            <xsl:if test="normalize-space($colpat) != '' ">
              <xsl:value-of select="concat(', ', $colpat)"/>
            </xsl:if>
            <xsl:if test="normalize-space($verlen) != ''">
              <br/>
              <p style="text-align: center; margin:0px; padding: 0px;">
                <xsl:value-of select="$verlen"/>
              </p>
            </xsl:if>
          </xsl:when>

          <xsl:when test="$masterFeatureAcronym = 'PILPNT'">
            <xsl:value-of select="$catple"/>
            <xsl:if test="normalize-space($colour) != '' ">
              <xsl:value-of select="concat(', ', $colour)"/>
            </xsl:if>
            <xsl:if test="normalize-space($colpat) != '' ">
              <xsl:value-of select="concat(', ', $colpat)"/>
            </xsl:if>
            <xsl:if test="normalize-space($verlen) != ''">
              <br/>
              <p style="text-align: center; margin:0px; padding: 0px;">
                <xsl:value-of select="$verlen"/>
              </p>
            </xsl:if>
          </xsl:when>

          <xsl:when test="contains($masterFeatureAcronym, 'BOY')">
            <xsl:value-of select="$colour"/>
            <xsl:if test="$colpat != ''">
              <xsl:value-of select="concat(', ', $colpat)"/>
            </xsl:if>
          </xsl:when>

          <xsl:when test="$masterFeatureAcronym = 'SILTNK'">
            <xsl:value-of
              select="concat($buishp, ', ', $catsil, ', ', $natcon, ', ', $colour, ', ', $colpat)"/>
            <xsl:if test="normalize-space($verlen) != ''">
              <br/>
              <p style="text-align: center; margin:0px; padding: 0px;">
                <xsl:value-of select="$verlen"/>
              </p>
            </xsl:if>
          </xsl:when>
        </xsl:choose>


      </xsl:element>
      <!-- /DESC_STRUCT_HEIGHT_ENG -->


      <!--  DESC_STRUCT_HEIGHT_NAT -->
      <xsl:element name="DESC_STRUCT_HEIGHT_NAT">
        <xsl:variable name="masterFeatureAcronym"
          select="normalize-space(substring-after($masterFeature, ','))"/>

        <xsl:variable name="tmpNatcon">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'NATCON'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="natcon">
          <xsl:call-template name="RecursiveNatconLookup">
            <xsl:with-param name="language" select="'nat'"/>
            <xsl:with-param name="natconValue" select="normalize-space($tmpNatcon)"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="tmpColour">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'COLOUR'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="colour">
          <xsl:call-template name="RecursiveColourDescLookup">
            <xsl:with-param name="language" select="'nat'"/>
            <xsl:with-param name="colourValue" select="normalize-space($tmpColour)"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="tmpColpat">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'COLPAT'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="colpat">
          <xsl:call-template name="ColpatLookup">
            <xsl:with-param name="language" select="'nat'"/>
            <xsl:with-param name="colpatValue" select="normalize-space($tmpColpat)"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="tmpCatofp">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'CATOFP'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="catofp">
          <xsl:call-template name="CatofpLookup">
            <xsl:with-param name="language" select="'nat'"/>
            <xsl:with-param name="catofpValue" select="normalize-space($tmpCatofp)"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="tmpCatple">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'CATPLE'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="catple">
          <xsl:call-template name="CatpleLookup">
            <xsl:with-param name="language" select="'nat'"/>
            <xsl:with-param name="catpleValue" select="normalize-space($tmpCatple)"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="verlen">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'VERLEN'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="tmpBuishp">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'BUISGL'"/>
            <xsl:with-param name="attribute" select="'BUISHP'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="buishp">
          <xsl:call-template name="BuishpLookup">
            <xsl:with-param name="language" select="'nat'"/>
            <xsl:with-param name="buishpValue" select="normalize-space($tmpBuishp)"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="tmpCatsil">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'BUISGL'"/>
            <xsl:with-param name="attribute" select="'CATSIL'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="catsil">
          <xsl:call-template name="CatsilLookup">
            <xsl:with-param name="language" select="'nat'"/>
            <xsl:with-param name="catsilValue" select="normalize-space($tmpCatsil)"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="topshp">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'TOPMAR'"/>
            <xsl:with-param name="attribute" select="'TOPSHP'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="normalize-space($topshp) != ''">
          <xsl:variable name="topshpLookup">
            <xsl:call-template name="TopshpLookup">
              <xsl:with-param name="language" select="'nat'"/>
              <xsl:with-param name="topshpValue" select="normalize-space($topshp)"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:if test="normalize-space($topshpLookup) != '' ">
            <br/>
            <xsl:value-of select="$topshpLookup"/>
          </xsl:if>
        </xsl:if>

        <xsl:choose>
          <xsl:when
            test="contains($masterFeatureAcronym, 'BCN') or $masterFeatureAcronym = 'LNDMRK' or $masterFeatureAcronym = 'BUISGL'">
            <xsl:variable name="firstAttribute">
              <xsl:choose>
                <xsl:when test="contains($masterFeatureAcronym, 'BCN')">
                  <xsl:variable name="tmpFirstAttribute">
                    <xsl:call-template name="get_attribute_from_feature_list">
                      <xsl:with-param name="featureIds" select="$currentFeatures"/>
                      <xsl:with-param name="featureAcronyms"
                        select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP'"/>
                      <xsl:with-param name="attribute" select="'BCNSHP'"/>
                    </xsl:call-template>
                  </xsl:variable>
                  <xsl:call-template name="BcnshpLookup">
                    <xsl:with-param name="language" select="'nat'"/>
                    <xsl:with-param name="bcnshpValue" select="normalize-space($tmpFirstAttribute)"
                    />
                  </xsl:call-template>
                </xsl:when>
                <xsl:when test="$masterFeatureAcronym = 'LNDMRK'">
                  <xsl:variable name="tmpFirstAttribute">
                    <xsl:call-template name="get_attribute_from_feature_list">
                      <xsl:with-param name="featureIds" select="$currentFeatures"/>
                      <xsl:with-param name="featureAcronyms" select="'LNDMRK'"/>
                      <xsl:with-param name="attribute" select="'CATLMK'"/>
                    </xsl:call-template>
                  </xsl:variable>
                  <xsl:call-template name="CatlmkLookup">
                    <xsl:with-param name="language" select="'nat'"/>
                    <xsl:with-param name="catlmkValue" select="normalize-space($tmpFirstAttribute)"
                    />
                  </xsl:call-template>
                </xsl:when>
                <xsl:when test="$masterFeatureAcronym = 'BUISGL'">
                  <xsl:variable name="tmpFirstAttribute">
                    <xsl:call-template name="get_attribute_from_feature_list">
                      <xsl:with-param name="featureIds" select="$currentFeatures"/>
                      <xsl:with-param name="featureAcronyms" select="'BUISGL'"/>
                      <xsl:with-param name="attribute" select="'BUISHP'"/>
                    </xsl:call-template>
                  </xsl:variable>
                  <xsl:call-template name="BuishpLookup">
                    <xsl:with-param name="language" select="'nat'"/>
                    <xsl:with-param name="buishpValue" select="normalize-space($tmpFirstAttribute)"
                    />
                  </xsl:call-template>
                </xsl:when>
              </xsl:choose>
            </xsl:variable>
            <xsl:if test="normalize-space($firstAttribute) != ''">
              <xsl:value-of select="$firstAttribute"/>
            </xsl:if>
            <xsl:if test="normalize-space($natcon) != '' ">
              <xsl:value-of select="concat(', ' , $natcon)"/>
            </xsl:if>
            <xsl:if test="normalize-space($colour) != '' ">
              <xsl:value-of select="concat(', ' , $colour)"/>
            </xsl:if>
            <xsl:if test="normalize-space($colpat) != '' ">
              <xsl:value-of select="concat(', ' , $colpat)"/>
            </xsl:if>
            <xsl:if test="normalize-space($verlen) != ''">
              <br/>
              <span style="text-align: center">
                <xsl:value-of select="$verlen"/>
              </span>
            </xsl:if>
          </xsl:when>

          <xsl:when test="$masterFeatureAcronym = 'OFSPLF' ">
            <xsl:value-of select="concat($natcon, ', ', $colour, ', ', $colpat, ', ', $catofp)"/>
            <xsl:if test="normalize-space($verlen) != ''">
              <br/>
              <span style="text-align: center">
                <xsl:value-of select="$verlen"/>
              </span>
            </xsl:if>
          </xsl:when>

          <xsl:when test="$masterFeatureAcronym = 'LITVES' or $masterFeatureAcronym = 'LIFLT'">
            <xsl:value-of select="$natcon"/>
            <xsl:if test="normalize-space($colour) != '' ">
              <xsl:value-of select="concat(', ', $colour)"/>
            </xsl:if>
            <xsl:if test="normalize-space($colpat) != '' ">
              <xsl:value-of select="concat(', ', $colpat)"/>
            </xsl:if>
            <xsl:if test="normalize-space($verlen) != ''">
              <br/>
              <span style="text-align: center">
                <xsl:value-of select="$verlen"/>
              </span>
            </xsl:if>
          </xsl:when>

          <xsl:when test="$masterFeatureAcronym = 'PILPNT'">
            <xsl:value-of select="$catple"/>
            <xsl:if test="normalize-space($colour) != '' ">
              <xsl:value-of select="concat(', ', $colour)"/>
            </xsl:if>
            <xsl:if test="normalize-space($colpat) != '' ">
              <xsl:value-of select="concat(', ', $colpat)"/>
            </xsl:if>
            <xsl:if test="normalize-space($verlen) != ''">
              <br/>
              <span style="text-align: center">
                <xsl:value-of select="$verlen"/>
              </span>
            </xsl:if>
          </xsl:when>

          <xsl:when test="contains($masterFeatureAcronym, 'BOY')">
            <xsl:value-of select="$colour"/>
            <xsl:if test="$colpat != ''">
              <xsl:value-of select="concat(', ', $colpat)"/>
            </xsl:if>
          </xsl:when>

          <xsl:when test="$masterFeatureAcronym = SILTNK">
            <xsl:value-of
              select="concat($buishp, ', ', $catsil, ', ', $natcon, ', ', $colour, ', ', $colpat)"/>
            <xsl:if test="normalize-space($verlen) != ''">
              <br/>
              <span style="text-align: center">
                <xsl:value-of select="$verlen"/>
              </span>
            </xsl:if>
          </xsl:when>
        </xsl:choose>


      </xsl:element>
      <!-- /DESC_STRUCT_HEIGHT_NAT -->

      <!-- OBSERVATION_ENG -->
      <xsl:element name="OBSERVATION_ENG">
        <!--<xsl:variable name="light_catlit">
          <xsl:call-template name="get_attribute_from_feature_list_for_catlit">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
            <xsl:with-param name="attribute" select="'CATLIT'"/>
          </xsl:call-template>
        </xsl:variable>-->
        <xsl:variable name="catlit_value">
          <xsl:for-each select="CollocatedFeature[contains($currentFeatures,@fid)]">
            <!--<xsl:sort select="@fid"/>-->
            <xsl:call-template name="get_attribute_from_feature_list_catlit">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="$allFeatures"/>
              <xsl:with-param name="attribute" select="'CATLIT'"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="catlit_dir">
          <xsl:choose>
            <xsl:when test="not(contains($catlit_value,','))">
              <xsl:value-of select="$catlit_value"/>
            </xsl:when>
            
            <xsl:otherwise>
              <xsl:call-template name="catlit_value_for_dir">
                <xsl:with-param name="list_of_catlit" select="$catlit_value"/>
              </xsl:call-template>
            </xsl:otherwise>
            
          </xsl:choose>
        </xsl:variable>
        <xsl:for-each select="CollocatedFeature[contains($currentFeatures,@fid)]">
          <xsl:sort
            select="key('featureids', @fid)[contains('LIGHTS', @acronym)]/Attributes/Attribute[@acronym='SECTR1']/@value"
            data-type="number" order="ascending"/>
          <xsl:variable name="masterFunctn">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
              <xsl:with-param name="attribute" select="'FUNCTN'"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="rtpbcn_catrtb">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'RTPBCN'"/>
              <xsl:with-param name="attribute" select="'CATRTB'"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="rtpbcn_siggrp">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'RTPBCN'"/>
              <xsl:with-param name="attribute" select="'SIGGRP'"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="rtpbcn_radwal">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'RTPBCN'"/>
              <xsl:with-param name="attribute" select="'RADWAL'"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="rtpbcn_inform">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'RTPBCN'"/>
              <xsl:with-param name="attribute" select="'INFORM'"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="lights_catlit">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
              <xsl:with-param name="attribute" select="'CATLIT'"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="lc">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
              <xsl:with-param name="attribute" select="'COLOUR'"/>
            </xsl:call-template>
          </xsl:variable>
          <!-- <xsl:text> lc </xsl:text>
            <xsl:value-of select="$lc"/>
            <xsl:text> *** </xsl:text>-->

          <xsl:variable name="lights_colour">
            <xsl:choose>
              <xsl:when test="contains($lc,',')">
                <xsl:call-template name="passing_single_color_for_sector_lights">
                  <xsl:with-param name="colour" select="concat($lc,',')"/>
                </xsl:call-template>

              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="ColourLookup">
                  <xsl:with-param name="colour" select="$lc"/>
                  <xsl:with-param name="language" select="'eng'"/>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <!-- <xsl:text> lights_col </xsl:text>
            <xsl:value-of select="$lights_col"/>
            <xsl:text> *** </xsl:text>-->
          <xsl:variable name="lights_inform">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
              <xsl:with-param name="attribute" select="'INFORM'"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="lights_sectr1">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
              <xsl:with-param name="attribute" select="'SECTR1'"/>
            </xsl:call-template>
          </xsl:variable>
          <!--<xsl:text> lights_sectr1 </xsl:text>
          <xsl:value-of select="$lights_sectr1"/>
          <xsl:text> **** </xsl:text>-->
          <!--<xsl:variable name="lights_modified_sectr1">
            <xsl:if test="$lights_sectr1 != ''">
            <xsl:choose>
              <xsl:when test="contains($lights_sectr1,'.')">
                <xsl:choose>
                  <xsl:when test="string-length(substring-before($lights_sectr1,'.') ) = 2">
                    <xsl:value-of select="concat(0,$lights_sectr1)"/>
                  </xsl:when>
                  <xsl:when test="string-length(substring-before($lights_sectr1,'.') ) = 1 ">
                    <xsl:value-of select="concat(00,$lights_sectr1)"/>
                  </xsl:when>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                  <xsl:when test="string-length($lights_sectr1 ) = 2 ">
                    <xsl:value-of select="concat(0,$lights_sectr1)"/>
                  </xsl:when>
                  <xsl:when test="string-length($lights_sectr1 ) = 1">
                    <xsl:value-of select="concat(00,$lights_sectr1)"/>
                  </xsl:when>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
            </xsl:if>
          </xsl:variable>-->
          <xsl:variable name="lights_modified_sectr1" select="format-number($lights_sectr1,'000.######')"/>
          <!--<xsl:text> lights_modified_sectr1 </xsl:text>
          <xsl:value-of select="$lights_modified_sectr1"/>
          <xsl:text>***</xsl:text>-->
          <xsl:variable name="lights_sectr2">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
              <xsl:with-param name="attribute" select="'SECTR2'"/>
            </xsl:call-template>
          </xsl:variable>
          <!--<xsl:text> lights_sectr2 </xsl:text>
          <xsl:value-of select="$lights_sectr2"/>
          <xsl:text>***</xsl:text>-->
          <!--<xsl:variable name="lights_modified_sectr2">
            <xsl:if test="$lights_sectr2 != ''">
              <xsl:choose>
                <xsl:when test="contains($lights_sectr2,'.')">
                  <xsl:choose>
                    <xsl:when test="string-length(substring-before($lights_sectr2,'.') ) = 2">
                      <xsl:value-of select="concat(0,$lights_sectr2)"/>
                    </xsl:when>
                    <xsl:when test="string-length(substring-before($lights_sectr2,'.') ) = 1 ">
                      <xsl:value-of select="concat(00,$lights_sectr2)"/>
                    </xsl:when>
                  </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="string-length($lights_sectr2 ) = 2 ">
                      <xsl:value-of select="concat(0,$lights_sectr2)"/>
                    </xsl:when>
                    <xsl:when test="string-length($lights_sectr2 ) = 1">
                      <xsl:value-of select="concat(00,$lights_sectr2)"/>
                    </xsl:when>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </xsl:variable>-->
          <!--<xsl:variable name="lights_modified_sectr2" select="format-number($lights_sectr2,'000')"/>  -->
          <xsl:variable name="lights_modified_sectr2" select="format-number($lights_sectr2,'000.######')"/>  
         <!-- <xsl:text> lights_modified_sectr2 </xsl:text>
          <xsl:value-of select="$lights_modified_sectr2"/>
          <xsl:text>***</xsl:text>-->
          <xsl:variable name="lights_litvis">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
              <xsl:with-param name="attribute" select="'LITVIS'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="lights_litvisTranslated">
            <xsl:call-template name="LitvisLookup">
              <xsl:with-param name="language" select="'eng'"/>
              <xsl:with-param name="litvisValue" select="normalize-space($lights_litvis)"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="light_litchr">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="$allFeatures"/>
              <xsl:with-param name="attribute" select="'LITCHR'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="catlit_val">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="$currentFeatures"/>
              <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
              <xsl:with-param name="attribute" select="'CATLIT'"/>
            </xsl:call-template>
          </xsl:variable>

          <!--<xsl:text> catlit_val </xsl:text>
            <xsl:value-of select="$catlit_val"/>
            <xsl:text>  **</xsl:text>-->
          <!--<xsl:text> catlit_val </xsl:text>
            <xsl:value-of select="$catlit_val"/>
            <xsl:text>  **</xsl:text>-->

          <xsl:variable name="translatedLitchr">
            <xsl:call-template name="LitchrLookup">
              <xsl:with-param name="litchr" select="$light_litchr"/>
              <xsl:with-param name="language" select="'eng'"/>
            </xsl:call-template>
          </xsl:variable>
            <!--<xsl:text> light_litchr </xsl:text>
            <xsl:value-of select="$light_litchr"/>
            <xsl:text>  **</xsl:text>-->



          <!--xsl:element name="debug" >
            <xsl:element name="functn" >
              <xsl:value-of select="$masterFunctn" />
            </xsl:element>
            <xsl:element name="catrtb" >
              <xsl:value-of select="$rtpbcn_catrtb" />
            </xsl:element>
            <xsl:element name="siggrp">
              <xsl:value-of select="$rtpbcn_siggrp" />
            </xsl:element>
            <xsl:element name="radwal" >
              <xsl:value-of select="$rtpbcn_radwal" />
            </xsl:element>
            <xsl:element name="lights_status" >
              <xsl:value-of select="$lights_status" />
            </xsl:element>
          </xsl:element-->

          <!-- morse code -->
          <xsl:if test="$rtpbcn_catrtb = 2">
            <xsl:variable name="morsecode">
              <xsl:call-template name="GetMorseCode">
                <xsl:with-param name="value"
                  select="substring-before(substring-after($rtpbcn_siggrp, '('), ')')"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:if test="$rtpbcn_siggrp !=''">
            <xsl:value-of select="concat('Racon ', $rtpbcn_siggrp)"/>
            <br/>
            </xsl:if>
            <xsl:if test="$morsecode !=''">
            <xsl:value-of select="concat('(', $morsecode, ')')"/>
            <br/>
            </xsl:if>
          </xsl:if>

          <!-- radar bands -->
          <xsl:if test="normalize-space($rtpbcn_radwal) != '' ">
            <xsl:call-template name="RecurseRadarBands">
              <xsl:with-param name="language" select="'eng'"/>
              <xsl:with-param name="bands" select="$rtpbcn_radwal"/>
              <xsl:with-param name="firstCall" select="'true'"/>
            </xsl:call-template>
            <br/>
          </xsl:if>
          <xsl:if test="$masterFunctn = 31 or $masterFunctn = 29">
            <xsl:text>radio comunication station</xsl:text>
            <br/>
          </xsl:if>
          <xsl:if test="normalize-space($rtpbcn_inform) != '' ">
            <xsl:value-of select="$rtpbcn_inform"/>
            <br/>

            <xsl:if
              test="normalize-space($lights_inform) != '' and not(contains($lights_inform, 'geographical range'))  and not(contains($lights_inform, 'luminous range'))">
              <xsl:value-of select="$lights_inform"/>
              <br/>
            </xsl:if>

          </xsl:if>
         <!--<xsl:text> $light_catlit </xsl:text>
          <xsl:value-of select="$light_catlit"/>
          <xsl:text> *** </xsl:text>
          <xsl:text> $light_litchr </xsl:text>
          <xsl:value-of select="$light_litchr"/>
          <xsl:text> *** </xsl:text>-->
          
          <!--<xsl:if test="$catlit_dir='1'">
            <xsl:variable name="catval">
              <xsl:call-template name="CatlitLokoup">
                <xsl:with-param name="catlitValue" select="$catlit_dir"/>
                <xsl:with-param name="language" select="'eng'"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="concat($catval,' ')"/>
          </xsl:if>-->

          <xsl:if test="$catlit_dir = 1">
            <xsl:if test="$light_litchr != 2 and $lights_sectr1 != '' ">
            <xsl:value-of select="concat($translatedLitchr,' ')"/>
          </xsl:if>
          </xsl:if>
          <xsl:variable name="navlne_orient">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'NAVLNE'"/>
              <xsl:with-param name="attribute" select="'ORIENT'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="masterFeatureAcronym"
            select="normalize-space(substring-after($masterFeature, ','))"/>
          <xsl:if
            test="normalize-space($masterFeatureAcronym) != '' and normalize-space($navlne_orient) != '' ">
            <!-- TODO test this, there is nothing in the sample data to test this -->
            <xsl:value-of select="concat('Alignment to ', $navlne_orient)"/>
            <br/>
          </xsl:if>


          <!-- RDOSTA object is encountered -->
          <xsl:variable name="rdosta_catros">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'RDOSTA'"/>
              <xsl:with-param name="attribute" select="'CATROS'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="rdosta_estring">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'RDOSTA'"/>
              <xsl:with-param name="attribute" select="'ESTRNG'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="rdosta_orient">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'RDOSTA'"/>
              <xsl:with-param name="attribute" select="'ORIENT'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="rdosta_ninfom">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'RDOSTA'"/>
              <xsl:with-param name="attribute" select="'INFORM'"/>
            </xsl:call-template>
          </xsl:variable>


          <!--<xsl:text> translatedLitchr </xsl:text>
            <xsl:value-of select="c"/>
            <xsl:text>  **  </xsl:text>-->

          <xsl:if test="normalize-space($rdosta_catros) != '' ">
            <xsl:variable name="translatedCatros">
              <xsl:call-template name="CatrosLookup">
                <xsl:with-param name="language" select="'eng'"/>
                <xsl:with-param name="catrosValue" select="$rdosta_catros"/>
              </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="translatedOrient">
              <xsl:call-template name="OrientLookup">
                <xsl:with-param name="value" select="$rdosta_orient"/>
              </xsl:call-template>
            </xsl:variable>

            <xsl:if test="normalize-space($translatedCatros) != '' ">
              <xsl:value-of select="$translatedCatros"/>
              <br/>
            </xsl:if>

            <xsl:if test="normalize-space($rdosta_estring) != '' ">
              <xsl:value-of
                select="concat($rdosta_estring, ' mile &quot;a&quot; ', $translatedOrient)"/>
              <br/>
              <xsl:if test="normalize-space($rdosta_ninfom) != '' ">
                <xsl:value-of select="normalize-space($rdosta_ninfom)"/>
                <br/>
              </xsl:if>
            </xsl:if>
          </xsl:if>

          <xsl:if
            test="normalize-space($lights_sectr1) != '' and normalize-space($lights_sectr2) = '' ">
            <xsl:if test="normalize-space($lights_litvisTranslated) = '' ">
              <xsl:value-of
                select="concat(translate(normalize-space($lights_modified_sectr1), '.', '.'), '°')"/>
            </xsl:if>
            <xsl:if
              test="normalize-space($lights_litvisTranslated) != ''  and normalize-space($lights_litvisTranslated) = 'Obscured'">
              <xsl:value-of select="concat(' ',$lights_litvisTranslated, ' ', c, '°')"/>
            </xsl:if>
          </xsl:if>

          <xsl:if
            test="normalize-space($lights_sectr1) != '' and normalize-space($lights_sectr2) != '' ">
            <!--<xsl:value-of select="concat($lights_colour,' ')"/>-->
            <xsl:value-of select="concat(' ',$lights_colour,' ')"/>
            <xsl:if test="normalize-space($lights_litvisTranslated) !=''">
            <xsl:value-of select="concat('(',$lights_litvisTranslated,') ')"/>
            </xsl:if>
            <xsl:if test="normalize-space($lights_litvisTranslated) != 'Obscured'">
              <xsl:value-of
                select="concat(translate(normalize-space($lights_modified_sectr1), '.', '.'), '°-', translate(normalize-space($lights_modified_sectr2), '.', '.'), '°' )"
              />
            </xsl:if>

            <xsl:if
              
              
              
              test="normalize-space($lights_litvisTranslated) != ''  and normalize-space($lights_litvisTranslated) = 'Obscured'">
              <!--<xsl:value-of
                select="concat($lights_litvisTranslated, ' ', translate(normalize-space($lights_modified_sectr1), '.', ','), '°- ', translate(normalize-space($lights_modified_sectr2), '.', '.'), '°')"
              />-->
              <xsl:value-of
                select="concat(translate(normalize-space($lights_modified_sectr1), '.', '.'), '°- ', translate(normalize-space($lights_modified_sectr2), '.', '.'), '°')"
              />
            </xsl:if>

            <xsl:if test="$lights_modified_sectr2 > $lights_modified_sectr1"> (<xsl:value-of
              select="format-number(($lights_modified_sectr2 - $lights_modified_sectr1),'#.#')"/>°) <br/>
            </xsl:if>
            <xsl:if test="$lights_sectr1 > $lights_sectr2">
              <!--  Wrong sector value , it should be - ((SECTR1-360)-SECTR2) = ((135-360)-80) = 305 -->
              <!--(<xsl:value-of select="$lights_sectr1 - $lights_sectr2" />°)-->
              <xsl:variable name="angleValue">
                <xsl:value-of select="360"/>
              </xsl:variable> (<xsl:value-of
                select="(($lights_modified_sectr1 - $angleValue) - $lights_modified_sectr2) * (-1)"/>°) <!--<br/>-->
            </xsl:if>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="$lights_inform != '' and $lights_sectr1 != ''">
              <xsl:value-of select="$lights_inform"/><br/>
            </xsl:when>
            <xsl:otherwise>
              
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="$lights_inform != '' and $lights_sectr1 != ''">
          
          </xsl:if>
          <xsl:variable name="topmar_catcam">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'TOPMAR'"/>
              <xsl:with-param name="attribute" select="'CATCAM'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="topmar_catcamTranslated">
            <xsl:call-template name="CatcamLookup">
              <xsl:with-param name="language" select="'eng'"/>
              <xsl:with-param name="catcamValue" select="normalize-space($topmar_catcam)"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="topmar_topshp">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'TOPMAR'"/>
              <xsl:with-param name="attribute" select="'TOPSHP'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="topmar_topshpTranslated">
            <xsl:call-template name="TopshpLookup">
              <xsl:with-param name="language" select="'eng'"/>
              <xsl:with-param name="topshpValue" select="normalize-space($topmar_topshp)"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="topmar_inform">
            <xsl:call-template name="get_attribute_from_feature_list">
              <xsl:with-param name="featureIds" select="concat(@fid,',')"/>
              <xsl:with-param name="featureAcronyms" select="'TOPMAR'"/>
              <xsl:with-param name="attribute" select="'INFORM'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:if test="normalize-space(substring-after($slaveFeature, ',')) = 'TOPMAR'">
            <xsl:if
              test="($masterFeatureAcronym = 'BCNCAR' or $masterFeatureAcronym = 'BOYCAR') and normalize-space($topmar_catcamTranslated) != ''  ">
              <xsl:value-of select="$topmar_catcamTranslated"/>
              <br/>
            </xsl:if>
            <!--this is becoming a duplicate in both remarks and description hence suppressed from remarks column-->
            <!--            <xsl:if test="normalize-space($topmar_topshpTranslated) != '' ">
              <xsl:value-of select="$topmar_topshpTranslated" />
              <br />
            </xsl:if>-->
            <xsl:if test="normalize-space($topmar_inform) != '' ">
              <xsl:value-of select="$topmar_inform"/>
              <br/>
            </xsl:if>
          </xsl:if>


        </xsl:for-each>

        <xsl:variable name="master_conrad">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'CONRAD'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:if test="normalize-space($master_conrad) = 3">
          
          <xsl:text>Ra refl</xsl:text>
          <br/>
        </xsl:if>

        
          <xsl:variable name="slave_inform">
              <xsl:call-template name="get_attribute_from_feature_list_for_slave_inform">
                <xsl:with-param name="featureIds" select="$currentFeatures"/>
                <xsl:with-param name="featureAcronyms" select="$slaveFeatures"/>
                <xsl:with-param name="attribute" select="'INFORM'"/>
              </xsl:call-template>
          </xsl:variable>
        <xsl:if test="$slave_inform !=''">
                <span>
                 <xsl:call-template name="tokenize_for_break">
                   <xsl:with-param name="delimiter"  select="'|'"/>
                  <xsl:with-param name="text" select="$slave_inform"/>
                 </xsl:call-template>
                </span>
        </xsl:if>
              
        <!-- Included INFORM for all master features -->
        <xsl:variable name="master_inform">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'INFORM'"/>
          </xsl:call-template>
        </xsl:variable>

        <!-- Check if data includes 'Owned by Maritime New Zealand', don't shown that text remarks Column, other details should be displayed in remarks column -->
        <xsl:choose>
          <xsl:when test="contains($master_inform, 'Owned by Maritime New Zealand')">
            <xsl:choose>
              <xsl:when test="substring-after($master_inform,'Owned by Maritime New Zealand.')">
                <br/>
                <xsl:value-of
                  select="substring-after($master_inform,'Owned by Maritime New Zealand.')"/>
              </xsl:when>
              <xsl:otherwise>
                
                <xsl:value-of
                  select="substring-before($master_inform,'Owned by Maritime New Zealand.')"/>
              </xsl:otherwise>
            </xsl:choose>
            <!--<xsl:value-of select="substring-after($master_inform,'Owned by Maritime New Zealand.')"/>-->
          </xsl:when>
          <!-- NTM-288, Added below condition -->
          <xsl:when test="$master_inform = 'on building'">
            <xsl:value-of select="'On building'"/>
          </xsl:when>
          <xsl:otherwise>

            
            <xsl:if test="$master_inform != ''">
            <xsl:value-of select="$master_inform"/>
            <!--<br/>-->
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:variable name="lights_status">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
            <xsl:with-param name="attribute" select="'STATUS'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:if test="$mainacronym = 'LIGHTS' ">
          <xsl:choose>
            <xsl:when test="normalize-space($lights_status) = 8">
              <br/>
              <xsl:text>Private Light</xsl:text>

            </xsl:when>
            <xsl:otherwise>
              <xsl:variable name="translatedStatus">
                <xsl:call-template name="StatusLookup">
                  <xsl:with-param name="language" select="'eng'"/>
                  <xsl:with-param name="statusValue" select="$lights_status"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:if test="normalize-space($translatedStatus) != '' ">
                <xsl:value-of select="$translatedStatus"/>

              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <!-- END -->

      </xsl:element>
      <!-- /OBSERVATION_ENG -->

      <!-- OBSERVATION_NAT -->
      <xsl:element name="OBSERVATION_NAT">
        <xsl:variable name="masterFunctn">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="$masterFeatures"/>
            <xsl:with-param name="attribute" select="'FUNCTN'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="rtpbcn_catrtb">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'RTPBCN'"/>
            <xsl:with-param name="attribute" select="'CATRTB'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="rtpbcn_siggrp">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'RTPBCN'"/>
            <xsl:with-param name="attribute" select="'SIGGRP'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="rtpbcn_radwal">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'RTPBCN'"/>
            <xsl:with-param name="attribute" select="'RADWAL'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="rtpbcn_ninfom">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'RTPBCN'"/>
            <xsl:with-param name="attribute" select="'NINFOM'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="lights_catlit">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
            <xsl:with-param name="attribute" select="'CATLIT'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="lights_ninfom">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
            <xsl:with-param name="attribute" select="'NINFOM'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="lights_status">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
            <xsl:with-param name="attribute" select="'STATUS'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="lights_sectr1">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
            <xsl:with-param name="attribute" select="'SECTR1'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="lights_sectr2">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
            <xsl:with-param name="attribute" select="'SECTR2'"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="lights_litvis">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'LIGHTS'"/>
            <xsl:with-param name="attribute" select="'LITVIS'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="lights_litvisTranslated">
          <xsl:call-template name="LitvisLookup">
            <xsl:with-param name="language" select="'eng'"/>
            <xsl:with-param name="litvisValue" select="normalize-space($lights_litvis)"/>
          </xsl:call-template>
        </xsl:variable>

        <!--xsl:element name="debug" >
            <xsl:element name="functn" >
              <xsl:value-of select="$masterFunctn" />
            </xsl:element>
            <xsl:element name="catrtb" >
              <xsl:value-of select="$rtpbcn_catrtb" />
            </xsl:element>
            <xsl:element name="siggrp">
              <xsl:value-of select="$rtpbcn_siggrp" />
            </xsl:element>
            <xsl:element name="radwal" >
              <xsl:value-of select="$rtpbcn_radwal" />
            </xsl:element>
            <xsl:element name="lights_status" >
              <xsl:value-of select="$lights_status" />
            </xsl:element>
          </xsl:element-->

        <!-- morse code -->
        <xsl:if test="$rtpbcn_catrtb = 2">
          <xsl:variable name="morsecode">
            <xsl:call-template name="GetMorseCode">
              <xsl:with-param name="value"
                select="substring-before(substring-after($rtpbcn_siggrp, '('), ')')"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:value-of select="concat('Racon ', $rtpbcn_siggrp)"/>
          <br/>
          <xsl:value-of select="concat('(', $morsecode, ')')"/>
          <br/>
        </xsl:if>

        <!-- radar bands -->
        <xsl:if test="normalize-space($rtpbcn_radwal) != '' ">
          <xsl:call-template name="RecurseRadarBands">
            <xsl:with-param name="language" select="'nat'"/>
            <xsl:with-param name="bands" select="$rtpbcn_radwal"/>
            <xsl:with-param name="firstCall" select="'true'"/>
          </xsl:call-template>
          <br/>
        </xsl:if>
        <xsl:if test="$masterFunctn = 31 or $masterFunctn = 29">
          <xsl:text>Estação de radiocomunicação</xsl:text>
          <br/>
        </xsl:if>
        <xsl:if test="normalize-space($rtpbcn_ninfom) != '' ">
          <xsl:value-of select="$rtpbcn_ninfom"/>
          <br/>

          <xsl:if
            test="normalize-space($lights_ninfom) != '' and not(contains($lights_ninfom, 'alcance geográfico')) and not(contains($lights_ninfom, 'alcance luminoso'))">
            <xsl:value-of select="$lights_ninfom"/>
            <br/>
          </xsl:if>

        </xsl:if>

        <xsl:if test="$mainacronym = 'LIGHTS' ">
          <xsl:choose>
            <xsl:when test="normalize-space($lights_status) = 8">
              <xsl:text>Luz Particular</xsl:text>
              <br/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:variable name="translatedStatus">
                <xsl:call-template name="StatusLookup">
                  <xsl:with-param name="language" select="'nat'"/>
                  <xsl:with-param name="statusValue" select="$lights_status"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:if test="normalize-space($translatedStatus) != '' ">
                <xsl:value-of select="concat('Function ', $translatedStatus)"/>
                <br/>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <xsl:variable name="navlne_orient">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'NAVLNE'"/>
            <xsl:with-param name="attribute" select="'ORIENT'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="masterFeatureAcronym"
          select="normalize-space(substring-after($masterFeature, ','))"/>
        <xsl:if
          test="normalize-space($masterFeatureAcronym) != '' and normalize-space($navlne_orient) != '' ">
          <!-- TODO test this, there is nothing in the sample data to test this -->
          <xsl:value-of select="concat('Alinhamento aos ', $navlne_orient)"/>
          <br/>
        </xsl:if>


        <!-- RDOSTA object is encountered -->
        <xsl:variable name="rdosta_catros">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'RDOSTA'"/>
            <xsl:with-param name="attribute" select="'CATROS'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="rdosta_estring">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'RDOSTA'"/>
            <xsl:with-param name="attribute" select="'ESTRNG'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="rdosta_orient">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'RDOSTA'"/>
            <xsl:with-param name="attribute" select="'ORIENT'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="rdosta_ninfom">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'RDOSTA'"/>
            <xsl:with-param name="attribute" select="'NINFOM'"/>
          </xsl:call-template>
        </xsl:variable>


        <xsl:if test="normalize-space($rdosta_catros) != '' ">
          <xsl:variable name="translatedCatros">
            <xsl:call-template name="CatrosLookup">
              <xsl:with-param name="language" select="'nat'"/>
              <xsl:with-param name="catrosValue" select="$rdosta_catros"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="translatedOrient">
            <xsl:call-template name="OrientLookup">
              <xsl:with-param name="value" select="$rdosta_orient"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:if test="normalize-space($translatedCatros) != '' ">
            <xsl:value-of select="$translatedCatros"/>
            <br/>
          </xsl:if>

          <xsl:if test="normalize-space($rdosta_estring) != '' ">
            <xsl:value-of
              select="concat($rdosta_estring, ' milha &quot;a&quot; ', $translatedOrient)"/>
            <br/>
            <xsl:if test="normalize-space($rdosta_ninfom) != '' ">
              <xsl:value-of select="normalize-space($rdosta_ninfom)"/>
              <br/>
            </xsl:if>
          </xsl:if>
        </xsl:if>

        <xsl:if
          test="normalize-space($lights_sectr1) != '' and normalize-space($lights_sectr2) = '' ">
          <xsl:if test="normalize-space($lights_litvisTranslated) = '' ">
            <xsl:text>Setor de visibilidade </xsl:text>
            <br/>
            <xsl:value-of select="concat(translate(normalize-space($lights_sectr1), '.', '.'), '°')"/>
            <br/>
          </xsl:if>
          <xsl:if test="normalize-space($lights_litvisTranslated) != '' ">
            <xsl:value-of
              select="concat('Visibilidade ', $lights_litvisTranslated, ' ', translate(normalize-space($lights_sectr1), '.', ','), '°')"/>
            <br/>
          </xsl:if>
        </xsl:if>

        <xsl:if
          test="normalize-space($lights_sectr1) != '' and normalize-space($lights_sectr2) != '' ">
          <xsl:text>Setor de visibilidade </xsl:text>
          <br/>
          <xsl:value-of
            select="concat(translate(normalize-space($lights_sectr1), '.', '.'), '°-', translate(normalize-space($lights_sectr2), '.', '.'), '°' )"/>
          <br/>
          <xsl:if test="normalize-space($lights_litvisTranslated) != ''">
            <xsl:value-of
              select="concat('Visibilidade ', substring($lights_litvisTranslated,1,6), ' ', translate(normalize-space($lights_sectr1), '.', ','), '°- ', translate(normalize-space($lights_sectr2), '.', '.'), '°')"/>
            <br/>
          </xsl:if>
          <xsl:if test="$lights_sectr2 > $lights_sectr1"> (<xsl:value-of
              select="$lights_sectr2 - $lights_sectr1"/>)° <br/>
          </xsl:if>
          <xsl:if test="$lights_sectr1 > $lights_sectr2"> (<xsl:value-of
              select="$lights_sectr1 - $lights_sectr2"/>)° <br/>
          </xsl:if>
        </xsl:if>

        <xsl:variable name="topmar_catcam">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'TOPMAR'"/>
            <xsl:with-param name="attribute" select="'CATCAM'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="topmar_catcamTranslated">
          <xsl:call-template name="CatcamLookup">
            <xsl:with-param name="language" select="'nat'"/>
            <xsl:with-param name="catcamValue" select="normalize-space($topmar_catcam)"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="topmar_topshp">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'TOPMAR'"/>
            <xsl:with-param name="attribute" select="'TOPSHP'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="topmar_topshpTranslated">
          <xsl:call-template name="TopshpLookup">
            <xsl:with-param name="language" select="'nat'"/>
            <xsl:with-param name="topshpValue" select="normalize-space($topmar_topshp)"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="topmar_ninfom">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$currentFeatures"/>
            <xsl:with-param name="featureAcronyms" select="'TOPMAR'"/>
            <xsl:with-param name="attribute" select="'NINFOM'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="normalize-space(substring-after($slaveFeature, ',')) = 'TOPMAR'">
          <xsl:if
            test="($masterFeatureAcronym = 'BCNCAR' or $masterFeatureAcronym = 'BOYCAR') and normalize-space($topmar_catcamTranslated) != ''  ">
            <xsl:value-of select="$topmar_catcamTranslated"/>
            <br/>
          </xsl:if>
          <xsl:if test="normalize-space($topmar_topshpTranslated) != '' ">
            <xsl:value-of select="$topmar_topshpTranslated"/>
            <br/>
          </xsl:if>
          <xsl:if test="normalize-space($topmar_ninfom) != '' ">
            <xsl:value-of select="$topmar_ninfom"/>
          </xsl:if>
        </xsl:if>

      </xsl:element>
      <!-- /OBSERVATION_NAT -->

      <xsl:element name="PRODUCT_REF">

        <xsl:element name="PRODUCTVER_ID">
          <xsl:value-of select="/Report/Product/@version_id"/>
        </xsl:element>
        <!-- 3.0+ update, change UPDATE_KEY to use national Number (natnum) or international light number ( llknum), or the FOID of the master feature
                    If the above items do not exist, then the position will be used as the update key
				    <xsl:element name="UPDATE_KEY"><xsl:value-of select="$y"/>,<xsl:value-of select="$x"/></xsl:element> -->

        <xsl:element name="UPDATE_KEY">
          <xsl:choose>
            <xsl:when test="$natnum != '' ">
              <xsl:value-of select="$natnum"/>
            </xsl:when>
            <xsl:when test="$llknum != '' ">
              <xsl:value-of select="$llknum"/>
            </xsl:when>
            <xsl:when test="$masterFeatureID !='' ">
              <xsl:value-of select="$masterFeatureID"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$y"/>,<xsl:value-of select="$x"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:element>

        <xsl:element name="CONTRIBUTING_FEATURE_LIST">
          <xsl:for-each select="./CollocatedFeature">
            <!--<xsl:sort select="@fid"/>-->
            <xsl:element name="CONTRIBUTING_FEATURE_VERSION_ID">
              <xsl:variable name="currentfid" select="@fid"/>
              <xsl:value-of select="/Report/Features/Feature[@fid=$currentfid]/@version_id"/>
            </xsl:element>
          </xsl:for-each>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template name="GetLitchr">
    <xsl:param name="litchr"/>
    <xsl:param name="siggrp"/>
    <xsl:param name="colour"/>
    <xsl:param name="lang"/>
    <!--<xsl:text>**  </xsl:text>
  <xsl:value-of select="$colour"/>
  <xsl:text>  **</xsl:text>-->
    <xsl:variable name="language" select="$lang"/>

    <xsl:variable name="translatedColour">

      <xsl:call-template name="ColourLookup">
        <xsl:with-param name="colour" select="$colour"/>
        <xsl:with-param name="language" select="$language"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="translatedLitchr">
      <xsl:call-template name="LitchrLookup">
        <xsl:with-param name="litchr" select="$litchr"/>
        <xsl:with-param name="language" select="$language"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="$litchr = '' and $siggrp = ''">
      <xsl:value-of select="$translatedColour"/>
    </xsl:if>
    <xsl:choose>

      <!-- if SIGGRP has no value, and LITCHR =
         {1,2,3,4,5,6,7,8,9,10,11,12,13 } -->
      <xsl:when
        test="($litchr = 1 or $litchr = 2 or $litchr = 3 or $litchr = 4 or $litchr = 5 or $litchr = 6 or $litchr = 7 or $litchr = 8 or $litchr = 9 or $litchr = 10 or $litchr = 11 or $litchr = 12 or $litchr = 13) and normalize-space($siggrp) = '' ">
        <xsl:value-of
          select="concat($translatedLitchr, ' ', translate($translatedColour,',',''), '')"/>
      </xsl:when>

      <!-- If SIGGRP has no value and LITCHR = {14,15,16,25,26,27} -->
      <xsl:when
        test="($litchr = 14 or $litchr = 15 or $litchr = 16 or $litchr = 25 or $litchr = 26 or $litchr = 27) and normalize-space($siggrp) = '' ">
        <xsl:if test="$language = 'eng' ">
          <xsl:value-of
            select="concat('Q ', translate($translatedColour,',',''), 'LFl ', translate($translatedColour,',',''), '')"
          />
        </xsl:if>
        <xsl:if test="$language = 'nat' ">
          <xsl:value-of
            select="concat('R ', translate($translatedColour,',',''), 'LpL ', translate($translatedColour,',',''), '')"
          />
        </xsl:if>
      </xsl:when>

      <!-- For non-grouped items and alternating items (Only Alternating items can have multiple colours)  -->
      <xsl:when
        test="($litchr = 17 or $litchr = 18 or $litchr = 19 or $litchr = 28) and normalize-space($siggrp) = '' ">
        <xsl:value-of
          select="concat($translatedLitchr, ' ', translate($translatedColour,',',''), '')"/>
      </xsl:when>

      <!--  For grouped items (SIGGRP has value) and LITCHR = {1,2,3,4,5,6,7,8,9,10,11,12,13 } -->
      <xsl:when
        test="($litchr = 1 or $litchr = 2 or $litchr = 3 or $litchr = 4 or $litchr = 5 or $litchr = 6 or $litchr = 7 or $litchr = 8 or $litchr = 9 or $litchr = 10 or $litchr = 11 or $litchr = 12 or $litchr = 13) and normalize-space($siggrp) != '' ">
        <xsl:if test="normalize-space($siggrp) != '(1)' ">
          <xsl:value-of
            select="concat($translatedLitchr, $siggrp, '', translate($translatedColour,',',''), '')"
          />
        </xsl:if>
        <xsl:if test="normalize-space($siggrp) = '(1)' ">
          <xsl:value-of
            select="concat($translatedLitchr, ' ', translate($translatedColour,',',''), '')"/>
        </xsl:if>
      </xsl:when>

      <!--  For Grouped items (SIGGRP has value) and LITHCR = {14,15,16,25,26,27} -->
      <xsl:when
        test="($litchr = 14 or $litchr = 15 or $litchr = 16 or $litchr = 25 or $litchr = 26 or $litchr = 27) and normalize-space($siggrp) != '' ">
        <!-- Implemented the logic to normalize SIGGRP (1) -->
        <xsl:variable name="group1">
          <xsl:choose>
            <xsl:when test="substring-before($siggrp, '+') != ''">
              <xsl:if test="substring-before($siggrp, '+') != '(1)'">
                <xsl:value-of select="substring-before($siggrp, '+')"/>
              </xsl:if>
              <xsl:if test="substring-before($siggrp, '+') = '(1)'">
                <xsl:value-of select="concat('',' ')"/>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="concat(substring-before($siggrp, ')'),')') != '(1)'">
                <xsl:value-of select="concat(substring-before($siggrp, ')'), ') + ')"/>
              </xsl:if>
              <xsl:if test="concat(substring-before($siggrp, ')'),')') = '(1)'">
                <xsl:value-of select="concat('',' ')"/>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:variable name="group2">
          <xsl:choose>
            <xsl:when test="substring-after($siggrp, '+') != ''">
              <xsl:if test="substring-after($siggrp, ')') != '(1)'">
                <xsl:value-of select="substring-after($siggrp, '+')"/>
              </xsl:if>
              <xsl:if test="substring-after($siggrp, ')') = '(1)'">
                <xsl:value-of select="concat('',' ')"/>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="substring-after($siggrp, ')') != '(1)'">
                <xsl:value-of select="substring-after($siggrp, ')')"/>
              </xsl:if>
              <xsl:if test="substring-after($siggrp, ')') = '(1)'">
                <xsl:value-of select="concat('',' ')"/>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:if test="$group2 != ''">
          <xsl:choose>
            <xsl:when test="$litchr = 25">
              <xsl:if test="$language = 'eng' ">
                <xsl:value-of
                  select="concat('Q', $group1, '', $translatedColour, 'LFl ', $group2, '', $translatedColour, '')"
                />
              </xsl:if>
              <xsl:if test="$language = 'nat' ">
                <xsl:value-of
                  select="concat('R', $group1, '', $translatedColour, 'LpL', $group2, '', $translatedColour, '')"
                />
              </xsl:if>
            </xsl:when>
            <xsl:when test="$litchr = 26">
              <xsl:if test="$language = 'eng' ">
                <xsl:value-of
                  select="concat('VQ', $group1, '', $translatedColour, 'LFl ', $group2, '', $translatedColour, '')"
                />
              </xsl:if>
              <xsl:if test="$language = 'nat' ">
                <xsl:value-of
                  select="concat('MR', $group1, '', $translatedColour, 'LpL', $group2, '', $translatedColour, '')"
                />
              </xsl:if>
            </xsl:when>
          </xsl:choose>
        </xsl:if>

        <xsl:if test="$group2 = ''">
          <xsl:choose>
            <xsl:when test="$litchr = 25">
              <xsl:if test="$language = 'eng' ">
                <xsl:value-of
                  select="concat('Q', $group1, '', $translatedColour, 'LpL ', $translatedColour, '')"
                />
              </xsl:if>
              <xsl:if test="$language = 'nat' ">
                <xsl:value-of
                  select="concat('R', $group1, '', $translatedColour, 'LpL ', $translatedColour, '')"
                />
              </xsl:if>
            </xsl:when>
            <xsl:when test="$litchr = 26">

              <xsl:if test="$language = 'eng' ">
                <xsl:value-of
                  select="concat('VQ', $group1, '', $translatedColour, 'LpL ', $translatedColour, '')"
                />
              </xsl:if>
              <xsl:if test="$language = 'nat' ">
                <xsl:value-of
                  select="concat('MR', $group1, '', $translatedColour, 'LpL ', $translatedColour, '')"
                />
              </xsl:if>
            </xsl:when>
          </xsl:choose>
        </xsl:if>
      </xsl:when>

      <xsl:when test="$litchr = 19 and $siggrp != ''">
        <xsl:if test="normalize-space($siggrp) != '(1)'">
          <xsl:if test="$language = 'eng' ">
            <xsl:value-of
              select="concat('Fl', $siggrp, 'Al', translate($translatedColour,',',''), '')"/>
          </xsl:if>
          <xsl:if test="$language = 'nat' ">
            <xsl:value-of
              select="concat('Lp', $siggrp, 'Alt', translate($translatedColour,',',''), '')"/>
          </xsl:if>


        </xsl:if>
        <xsl:if test="normalize-space($siggrp) = '(1)'">
          <xsl:if test="$language = 'eng' ">
            <xsl:value-of select="concat('Fl Al', translate($translatedColour,',',''), '')"/>
          </xsl:if>
          <xsl:if test="$language = 'nat' ">
            <xsl:value-of select="concat('Lp Alt', translate($translatedColour,',',''), '')"/>
          </xsl:if>

        </xsl:if>
      </xsl:when>

      <xsl:when test="($litchr = 29) and $siggrp != ''">
        <xsl:variable name="firstColour">
          <xsl:if test="substring-before($translatedColour, ',') != ''">
            <xsl:value-of select="substring-before($translatedColour, ',')"/>
          </xsl:if>
          <xsl:if test="substring-before($translatedColour, ',') = ''">
            <xsl:value-of select="$translatedColour"/>
          </xsl:if>
        </xsl:variable>
        <xsl:variable name="additionalColours" select="substring-after($translatedColour, ',')"/>
        <xsl:if test="$language = 'eng' ">
          <xsl:value-of select="concat('F', $firstColour, 'Al Fl', $additionalColours, '') "/>
        </xsl:if>
        <xsl:if test="$language = 'nat' ">
          <xsl:value-of select="concat('F', $firstColour, 'Alt Lp', $additionalColours, '') "/>
        </xsl:if>

      </xsl:when>

      <xsl:when test="$litchr = 29 and $siggrp = ''">
        <xsl:variable name="firstColour">
          <xsl:if test="substring-before($translatedColour, ',') != ''">
            <xsl:value-of select="substring-before($translatedColour, ',')"/>
          </xsl:if>
          <xsl:if test="substring-before($translatedColour, ',') = ''">
            <xsl:value-of select="$translatedColour"/>
          </xsl:if>
        </xsl:variable>
        <xsl:variable name="additionalColours" select="substring-after($translatedColour, ',')"/>
        <xsl:if test="normalize-space($siggrp) != '(1)'">
          <xsl:if test="$language = 'eng' ">
            <xsl:value-of
              select="concat('F', $firstColour, 'Al Fl', $siggrp, $additionalColours, '') "/>
          </xsl:if>
          <xsl:if test="$language = 'nat' ">
            <xsl:value-of
              select="concat('F', $firstColour, 'Alt Lp ', $siggrp, $additionalColours, '') "/>
          </xsl:if>

        </xsl:if>
        <xsl:if test="normalize-space($siggrp) = '(1)'">
          <xsl:if test="$language = 'eng' ">
            <xsl:value-of select="concat('F', $firstColour, 'Al Fl', $additionalColours, '') "/>
          </xsl:if>
          <xsl:if test="$language = 'nat' ">
            <xsl:value-of select="concat('F', $firstColour, 'Alt Lp ', $additionalColours, '') "/>
          </xsl:if>


        </xsl:if>
      </xsl:when>


    </xsl:choose>
  </xsl:template>


  <xsl:template name="FormatSigseq">
    <xsl:param name="sigseq"/>
    <xsl:param name="colour"/>
    <xsl:param name="lang"/>
    
   <!-- <xsl:text> FormatSigseq </xsl:text>
    <xsl:value-of select="$sigseq"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:variable name="firstLine" select="concat(substring-before($sigseq, ')'), ')' )"/>
    <xsl:variable name="additionalLines"
      select="substring-after(substring-after($sigseq, ')'), '+')"/>
   <!-- <xsl:text> firstLine </xsl:text>
    <xsl:value-of select="$firstLine"/>
    <xsl:text> *** </xsl:text>
    <xsl:text> additionalLines </xsl:text>
    <xsl:value-of select="$additionalLines"/>
    <xsl:text> *** </xsl:text>-->
    <!--First - <xsl:value-of select="$firstLine"/> $$$$
  Add -\-\- <xsl:value-of select="$additionalLines"/>-->
    <xsl:variable name="firstColour">
      <xsl:if test="substring-before($colour, ',') != '' ">
        <xsl:value-of select="substring-before($colour, ',')"/>
      </xsl:if>
      <xsl:if test="substring-before($colour, ',') = '' ">
        <xsl:value-of select="$colour"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="translatedColour">
      <xsl:call-template name="ColourLookup">
        <xsl:with-param name="colour" select="$firstColour"/>
        <xsl:with-param name="language" select="$lang"/>
      </xsl:call-template>
    </xsl:variable>
<!--<xsl:text> first line </xsl:text>
    <xsl:value-of select="$firstLine"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:if test="normalize-space($firstLine) != ''">

      <xsl:if test="$lang = 'eng' ">
        <i>
          <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
          <xsl:value-of
            select="concat('fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
          <xsl:if test="(normalize-space($additionalLines))">
            <xsl:text>, </xsl:text>
          </xsl:if>
        </i>
      </xsl:if>
      <xsl:if test="$lang = 'nat' ">
        <i>
          <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
          <xsl:value-of
            select="concat('fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
          <xsl:if test="(normalize-space($additionalLines))">
            <xsl:text>, </xsl:text>
          </xsl:if>
        </i>
      </xsl:if>
    </xsl:if>
    <xsl:if test="normalize-space($additionalLines) != '' ">
      <xsl:call-template name="FormatSigseq">
        <xsl:with-param name="sigseq" select="$additionalLines"/>
        <xsl:with-param name="colour" select="$firstColour"/>
        <xsl:with-param name="lang" select="$lang"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="normalize-space($additionalLines) = '' ">
        <br/>
    </xsl:if>
  </xsl:template>
  <xsl:template name="FormatSigseq_for_fogsig">
    <xsl:param name="sigseq"/>
    <xsl:param name="colour"/>
    <xsl:param name="lang"/>

    <xsl:variable name="firstLine" select="concat(substring-before($sigseq, ')'), ')' )"/>
    <xsl:variable name="additionalLines"
      select="substring-after(substring-after($sigseq, ')'), '+')"/>

    <!--First - <xsl:value-of select="$firstLine"/> $$$$
  Add -\-\- <xsl:value-of select="$additionalLines"/>-->
    <xsl:variable name="firstColour">
      <xsl:if test="substring-before($colour, ',') != '' ">
        <xsl:value-of select="substring-before($colour, ',')"/>
      </xsl:if>
      <xsl:if test="substring-before($colour, ',') = '' ">
        <xsl:value-of select="$colour"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="translatedColour">
      <xsl:call-template name="ColourLookup">
        <xsl:with-param name="colour" select="$firstColour"/>
        <xsl:with-param name="language" select="$lang"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="normalize-space($firstLine) != ''">

      <xsl:if test="$lang = 'eng' ">
        <i>
          <!--<xsl:value-of select="concat('bl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', si ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
          <xsl:value-of
            select="concat('bl ', format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', si ', format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
          <xsl:if test="(normalize-space($additionalLines))">
            <xsl:text>, </xsl:text>
          </xsl:if>
        </i>
      </xsl:if>
      <xsl:if test="$lang = 'nat' ">
        <i>
          <!--<xsl:value-of select="concat('bl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', si ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
          <xsl:value-of
            select="concat('bl ', format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', si ', format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
          <xsl:if test="(normalize-space($additionalLines))">
            <xsl:text>, </xsl:text>
          </xsl:if>
        </i>
      </xsl:if>
    </xsl:if>
    <xsl:if test="normalize-space($additionalLines) != '' ">
      <xsl:call-template name="FormatSigseq_for_fogsig">
        <xsl:with-param name="sigseq" select="$additionalLines"/>
        <xsl:with-param name="colour" select="$firstColour"/>
        <xsl:with-param name="lang" select="$lang"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="normalize-space($additionalLines) = '' ">
      <br/>
    </xsl:if>
  </xsl:template>
  <xsl:template name="Summarise_formatSigseq_for_fogsig">
    <xsl:param name="sigseq"/>
    <xsl:param name="colour"/>
    <xsl:param name="lang"/>
    <!--<xsl:text> FormatSigseq </xsl:text>
    <xsl:value-of select="$sigseq"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:variable name="firstLine">
      <xsl:choose>
        <xsl:when test="contains($sigseq,'*')">
          <xsl:value-of select="substring-before($sigseq,'$' )"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat(substring-before($sigseq, ')'), ')' )"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalLines"
      select="substring-after($sigseq, '$)')"/>
    <!--<xsl:text> firstLine </xsl:text>
    <xsl:value-of select="$firstLine"/>
    <xsl:text> *** </xsl:text>
    <xsl:text> additionalLines </xsl:text>
    <xsl:value-of select="$additionalLines"/>
    <xsl:text> *** </xsl:text>-->
    <!--First - <xsl:value-of select="$firstLine"/> $$$$
  Add -\-\- <xsl:value-of select="$additionalLines"/>-->
    <xsl:variable name="firstColour">
      <xsl:if test="substring-before($colour, ',') != '' ">
        <xsl:value-of select="substring-before($colour, ',')"/>
      </xsl:if>
      <xsl:if test="substring-before($colour, ',') = '' ">
        <xsl:value-of select="$colour"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="translatedColour">
      <xsl:call-template name="ColourLookup">
        <xsl:with-param name="colour" select="$firstColour"/>
        <xsl:with-param name="language" select="$lang"/>
      </xsl:call-template>
    </xsl:variable>
    <!--<xsl:text> first line </xsl:text>
    <xsl:value-of select="$firstLine"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:choose>
      <xsl:when test="contains($firstLine,'*')"> 
        <xsl:variable name="value" select="substring-after($firstLine,'*')"/>
        <xsl:variable name="val">
          <xsl:if test="$value >= 2">
            <xsl:value-of select="$value"/>
          </xsl:if>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$value >=2">
            <xsl:if test="normalize-space($firstLine) != ''">
              
              <xsl:if test="$lang = 'eng' ">
                <i>
                  <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', si ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                  <xsl:value-of
                    select="concat('(bl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', si ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'),') x ',$value)"/>
                  <xsl:if test="(normalize-space($additionalLines))">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </i>
              </xsl:if>
              <xsl:if test="$lang = 'nat' ">
                <i>
                  <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                  <xsl:value-of
                    select="concat('bl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', si ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
                  <xsl:if test="(normalize-space($additionalLines))">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </i>
              </xsl:if>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="normalize-space($firstLine) != ''">
              
              <xsl:if test="$lang = 'eng' ">
                <i>
                  <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                  <xsl:value-of
                    select="concat('bl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', si ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
                  <xsl:if test="(normalize-space($additionalLines))">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </i>
              </xsl:if>
              <xsl:if test="$lang = 'nat' ">
                <i>
                  <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                  <xsl:value-of
                    select="concat('bl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', si ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
                  <xsl:if test="(normalize-space($additionalLines))">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </i>
              </xsl:if>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="normalize-space($firstLine) != ''">
          
          <xsl:if test="$lang = 'eng' ">
            <i>
              <!--<xsl:value-of select="concat('bl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', si ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
              <xsl:value-of
                select="concat('bl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', si ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
              <xsl:if test="(normalize-space($additionalLines))">
                <xsl:text>, </xsl:text>
              </xsl:if>
            </i>
          </xsl:if>
          <xsl:if test="$lang = 'nat' ">
            <i>
              <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
              <xsl:value-of
                select="concat('bl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', si ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
              <xsl:if test="(normalize-space($additionalLines))">
                <xsl:text>, </xsl:text>
              </xsl:if>
            </i>
          </xsl:if>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
    
    <xsl:if test="normalize-space($additionalLines) != '' ">
      <xsl:call-template name="Summarise_formatSigseq_for_fogsig">
        <xsl:with-param name="sigseq" select="$additionalLines"/>
        <xsl:with-param name="colour" select="$firstColour"/>
        <xsl:with-param name="lang" select="$lang"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="normalize-space($additionalLines) = '' ">
      <br/>
    </xsl:if>
  </xsl:template>
  <xsl:template name="FormatLitSigseq">
    <xsl:param name="sigseq"/>
    <xsl:param name="colour"/>
    <xsl:param name="lang"/>
    <!--<xsl:text> sigseq </xsl:text>
    <xsl:value-of select="$sigseq"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:variable name="firstLine" select="substring-before($sigseq,'+')"/>
    <xsl:variable name="additionalLines" select="substring-after($sigseq, '+')"/>
   <!--<xsl:text> firstLine </xsl:text>
    <xsl:value-of select="$firstLine"/>
    <xsl:text> *** </xsl:text>
    <xsl:text> additionalLines </xsl:text>
    <xsl:value-of select="$additionalLines"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:variable name="firstColour">
      <xsl:if test="substring-before($colour, ',') != '' ">
        <xsl:value-of select="substring-before($colour, ',')"/>
      </xsl:if>
      <xsl:if test="substring-before($colour, ',') = '' ">
        <xsl:value-of select="$colour"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="translatedColour">
      <xsl:call-template name="ColourLookup">
        <xsl:with-param name="colour" select="$firstColour"/>
        <xsl:with-param name="language" select="$lang"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="normalize-space($firstLine) != ''">
      <xsl:if test="$lang = 'eng' ">
        <i>
          <!--<xsl:value-of select="concat('ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), ' , fl ', translate(number($additionalLines), '.', '.'))" />-->
          <!-- <xsl:value-of select="concat('ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), ' , fl ', translate(number($additionalLines), '.', '.'))" />-->
          <xsl:value-of
            select="concat('ec ', format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'), ' , fl ', format-number(translate(number($additionalLines), '.', '.'), '0.##'))"/>
          <xsl:if test="(normalize-space($additionalLines))">
            <xsl:text>, </xsl:text>
          </xsl:if>
        </i>
      </xsl:if>
      <xsl:if test="$lang = 'nat' ">
        <i>
          <xsl:value-of
            select="concat('ec ', format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'), ' , fl ', format-number(translate(number($additionalLines), '.', '.'), '0.##'))"/>
          <xsl:if test="(normalize-space($additionalLines))">
            <xsl:text>, </xsl:text>
          </xsl:if>
        </i>
      </xsl:if>
    </xsl:if>

    <xsl:if test="normalize-space($additionalLines) != '' ">
      <xsl:call-template name="FormatLitSigseq">
        <xsl:with-param name="sigseq" select="$additionalLines"/>
        <xsl:with-param name="colour" select="$firstColour"/>
        <xsl:with-param name="lang" select="$lang"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="normalize-space($additionalLines) = '' ">
      <br/>
    </xsl:if>
  </xsl:template>
  <xsl:template name="GetMorseCode">
    <xsl:param name="value"/>

    <xsl:variable name="firstChar" select="substring($value, 1, 1)"/>
    <xsl:variable name="additionalChars" select="substring($value, 2, string-length($value) - 1)"/>
    <xsl:variable name="morseCode">
      <xsl:call-template name="morseCodeLookup">
        <xsl:with-param name="value" select="$firstChar"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="$morseCode"/>
    <xsl:if test="normalize-space($additionalChars) != ''">
      <xsl:call-template name="GetMorseCode">
        <xsl:with-param name="value" select="$additionalChars"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="RecurseRadarBands">
    <xsl:param name="language"/>
    <xsl:param name="bands"/>
    <xsl:param name="firstCall"/>

    <xsl:variable name="firstBand">
      <xsl:if test="substring-before($bands, ',') != '' ">
        <xsl:value-of select="substring-after(substring-before($bands, ','), '-')"/>
      </xsl:if>
      <xsl:if test="substring-before($bands, ',') = '' ">
        <xsl:value-of select="translate(substring-after($bands, '-'), '()', '')"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="additionalBands" select="substring-after($bands, ',')"/>
    <xsl:if test="$firstCall = 'true' ">
      <xsl:if test="$language = 'eng' ">
        <xsl:text>Bands </xsl:text>
      </xsl:if>
      <xsl:if test="$language = 'nat' ">
        <xsl:text>Bandas </xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:if test="$firstCall != 'true'">
      <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:if test="normalize-space($additionalBands) = ''">
      <xsl:text>&#x26; </xsl:text>
    </xsl:if>
    <xsl:value-of select="$firstBand"/>
    <xsl:if test="normalize-space($additionalBands) != '' ">
      <xsl:call-template name="RecurseRadarBands">
        <xsl:with-param name="language" select="$language"/>
        <xsl:with-param name="bands" select="$additionalBands"/>
        <xsl:with-param name="firstCall" select="'false'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="RecursiveNatconLookup">
    <xsl:param name="language"/>
    <xsl:param name="natconValue"/>

    <xsl:variable name="firstNatconValue">
      <xsl:if test="normalize-space(substring-before($natconValue, ',')) != '' ">
        <xsl:value-of select="normalize-space(substring-before($natconValue, ','))"/>
      </xsl:if>
      <xsl:if test="normalize-space(substring-before($natconValue, ',')) = '' ">
        <xsl:value-of select="normalize-space($natconValue)"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="additionalNatconValues" select="substring-after($natconValue, ',')"/>
    <xsl:variable name="translatedNatconValue">
      <xsl:call-template name="NatconLookup">
        <xsl:with-param name="language" select="$language"/>
        <xsl:with-param name="natconValue" select="$firstNatconValue"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="$translatedNatconValue"/>
    <xsl:if test="normalize-space($additionalNatconValues) != '' ">
      <xsl:text>, </xsl:text>
      <xsl:call-template name="RecursiveNatconLookup">
        <xsl:with-param name="language" select="$language"/>
        <xsl:with-param name="natconValue" select="$additionalNatconValues"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="RecursiveColourDescLookup">
    <xsl:param name="language"/>
    <xsl:param name="colourValue"/>

    <xsl:variable name="firstValue">
      <xsl:if test="normalize-space(substring-before($colourValue, ',')) != '' ">
        <xsl:value-of select="normalize-space(substring-before($colourValue, ','))"/>
      </xsl:if>
      <xsl:if test="normalize-space(substring-before($colourValue, ',')) = '' ">
        <xsl:value-of select="normalize-space($colourValue)"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="additionalValues" select="substring-after($colourValue, ',')"/>
    <xsl:variable name="translatedValue">
      <xsl:call-template name="ColourDescLookup">
        <xsl:with-param name="language" select="$language"/>
        <xsl:with-param name="colourValue" select="$firstValue"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="$translatedValue"/>
    <xsl:if test="normalize-space($additionalValues) != '' ">
      <xsl:text>, </xsl:text>
      <xsl:call-template name="RecursiveColourDescLookup">
        <xsl:with-param name="language" select="$language"/>
        <xsl:with-param name="colourValue" select="$additionalValues"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>



  <xsl:template name="MultipleColourDescLookup">
    <xsl:param name="language"/>
    <xsl:param name="colourValue"/>

    <xsl:variable name="firstValue">
      <xsl:if test="normalize-space(substring-before($colourValue, ',')) != '' ">
        <xsl:value-of select="normalize-space(substring-before($colourValue, ','))"/>
      </xsl:if>
      <xsl:if test="normalize-space(substring-before($colourValue, ',')) = '' ">
        <xsl:value-of select="normalize-space($colourValue)"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="additionalValues" select="substring-after($colourValue, ',')"/>

    <xsl:variable name="translatedValue">
      <xsl:call-template name="ColourLookup">
        <xsl:with-param name="language" select="$language"/>
        <xsl:with-param name="colour" select="$firstValue"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="$translatedValue"/>

    <xsl:if test="normalize-space($additionalValues) != '' ">
      <!--<xsl:text>, </xsl:text>-->
      <xsl:if test="contains(normalize-space($additionalValues),',') ">
        <!--<xsl:variable name="nextValue">
          <xsl:value-of select="substring-before(normalize-space($additionalValues),',')"/>
        </xsl:variable>
        <xsl:variable name="restValue">
          <xsl:value-of select="substring-after(normalize-space($additionalValues),',')"/>
        </xsl:variable>-->
        <xsl:call-template name="MultipleColourDescLookup">
          <xsl:with-param name="language" select="$language"/>
          <xsl:with-param name="colourValue" select="$additionalValues"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="not(contains(normalize-space($additionalValues),',')) ">
        <xsl:call-template name="MultipleColourDescLookup">
          <xsl:with-param name="language" select="$language"/>
          <xsl:with-param name="colourValue" select="$additionalValues"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <!-- Template to return unique token values from a sorted delimited list -->
  <xsl:template name="Uniquetokens">
    <xsl:param name="list"/>
    <!-- A delimited list in a string that is already sorted-->
    <xsl:param name="delimiter"/>
    <!-- The delimiter eg ',' -->
    <xsl:param name="name"/>
    <!-- optional, element name to output unique values into -->
    <xsl:param name="terminator"/>
    <!-- what to put at end of list -->

    <xsl:if test="$list != '' ">

      <!-- Make sure the string is cleaned up.  Extra white space removed and at least a delimiter on the end -->
      <xsl:variable name="newlist">
        <xsl:choose>
          <xsl:when test="contains($list, $delimiter)">
            <xsl:value-of select="normalize-space($list)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat(normalize-space($list), $delimiter)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <!--Parse the first string up to the delimiter-->
      <xsl:variable name="first" select="substring-before($newlist, $delimiter)"/>
      <!--Parse the remainder after the delimiter-->
      <xsl:variable name="remaining" select="substring-after($newlist, $delimiter)"/>

      <xsl:choose>
        <!--if first is same as next, skip and recurse with the rest-->
        <xsl:when test="$remaining and(starts-with($remaining,$first))">
          <xsl:call-template name="Uniquetokens">
            <xsl:with-param name="list" select="$remaining"/>
            <xsl:with-param name="delimiter" select="$delimiter"/>
            <xsl:with-param name="name" select="$name"/>
            <xsl:with-param name="terminator" select="$terminator"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$remaining">

          <xsl:choose>
            <xsl:when test="$name">
              <xsl:element name="{$name}">
                <xsl:value-of select="$first"/>
              </xsl:element>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$first"/>
              <xsl:value-of select="$delimiter"/>
            </xsl:otherwise>
          </xsl:choose>

          <!-- then recursively call this template -->
          <xsl:call-template name="Uniquetokens">
            <xsl:with-param name="list" select="$remaining"/>
            <xsl:with-param name="delimiter" select="$delimiter"/>
            <xsl:with-param name="name" select="$name"/>
            <xsl:with-param name="terminator" select="$terminator"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <!--otherwise This is the last entry output with terminator -->
          <xsl:choose>
            <xsl:when test="$name">
              <xsl:element name="{$name}">
                <xsl:value-of select="$first"/>
              </xsl:element>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$first"/>
              <xsl:value-of select="$terminator"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>

    </xsl:if>
  </xsl:template>
  <!--  Get the attribute value  of the first matching attribute acronym  which comes from a featureid and feature acronym in the passed in lists -->
  <xsl:template name="get_attribute_from_feature_list_geo_range_exclit_color">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>

    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>


    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value"/>

    <xsl:choose>
      <xsl:when test="($value != '') and ($value != 'UNKNOWN') and ($value !='()') ">
        <xsl:choose>
          <xsl:when
            test="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym='EXCLIT']">
            <xsl:text>#</xsl:text>
            <xsl:value-of select="$value"/>
            <xsl:text>,</xsl:text>

          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$value"/>

          </xsl:otherwise>
        </xsl:choose>

      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_attribute_from_feature_list_geo_range_exclit_color">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--  Get the attribute value  of the first matching attribute acronym  which comes from a featureid and feature acronym in the passed in lists -->
  <xsl:template name="get_attribute_from_feature_list_geo_range_exclit">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>

    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>
    <xsl:variable name="valnmr" select="substring-before($attribute,',')"/>
    <xsl:variable name="colour" select="substring-after($attribute,',')"/>

    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="val_value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$valnmr]/@value"/>

    <xsl:variable name="col_value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$colour]/@value"/>
    <!--<xsl:text> col_value </xsl:text>
    <xsl:value-of select="$col_value"/>
    <xsl:text> end </xsl:text>-->
    <xsl:variable name="light_color">

      <xsl:choose>
        <!-- If color value is (1,3) - multiple values - still pending -->
        <xsl:when test="contains($col_value,',')">
          <xsl:call-template name="multiple_colour_lookup">
            <xsl:with-param name="colour" select="$col_value"/>
            <xsl:with-param name="language" select="'eng'"/>
          </xsl:call-template>
        </xsl:when>
        <!-- END -->
        <xsl:when test="not(contains($col_value,','))">
          <xsl:call-template name="ColourLookup">
            <xsl:with-param name="colour" select="$col_value"/>
            <xsl:with-param name="language" select="'eng'"/>
          </xsl:call-template>
        </xsl:when>

      </xsl:choose>
    </xsl:variable>
    <!--<xsl:text> light_color </xsl:text>
    <xsl:value-of select="$light_color"/>
    <xsl:text> end </xsl:text>-->
    <xsl:choose>
      <xsl:when test="($val_value != '') and ($val_value != 'UNKNOWN') and ($val_value !='()') ">
        <!-- <xsl:value-of select="$light_color" /><xsl:value-of select="$lightValnmr" /><xsl:text>,</xsl:text>-->
        <xsl:if test="normalize-space($light_color) = 'Bu'">

          <xsl:value-of select="concat($val_value,',')"/>
        </xsl:if>
        <xsl:if test="normalize-space($light_color) != 'Bu'">
          <!--<xsl:text> ###### </xsl:text>
        <xsl:value-of select="$light_color"/>
        <xsl:text> ### </xsl:text>-->


          <xsl:choose>
            <xsl:when test="$light_color !=''">
              <xsl:value-of select="concat(normalize-space($light_color),$val_value,',')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat('*',$val_value,',')"/>
            </xsl:otherwise>
          </xsl:choose>

        </xsl:if>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_attribute_from_feature_list_geo_range_exclit">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_attribute_from_feature_list_geo_range_exclit">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--  Get the attribute value  of the first matching attribute acronym  which comes from a featureid and feature acronym in the passed in lists -->
  <xsl:template name="get_attribute_from_feature_list">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>

    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>


    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value"/>

    <xsl:choose>
      <xsl:when test="($value != '') and ($value != 'UNKNOWN') and ($value !='()') ">
        <xsl:value-of select="$value"/>

      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--  Get the attribute value  of the first matching attribute acronym  which comes from a featureid and feature acronym in the passed in lists -->
  <xsl:template name="get_attribute_from_feature_list_exclit">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>

    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>


    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value"/>

    <xsl:choose>
      <xsl:when test="($value != '') and ($value != 'UNKNOWN') and ($value !='()') ">
        <!-- <xsl:variable name="final_value">-->
        <!--<xsl:text>Current Feature ID: </xsl:text> 
      <xsl:value-of select="$currentfeature" />-->
        <xsl:choose>
          <xsl:when
            test="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym='EXCLIT']/@value != ''">

            <xsl:text>#</xsl:text>
            <xsl:value-of select="$value"/>
            <xsl:text>,</xsl:text>

          </xsl:when>
          <xsl:otherwise>

            <xsl:value-of select="$value"/>
            <xsl:text>,</xsl:text>

          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_attribute_from_feature_list_exclit">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
        <!--<xsl:if test="$additionalFeatures = ''">
        <xsl:text> height value::  </xsl:text>
        <xsl:value-of select="$value" />
      </xsl:if>-->
      </xsl:when>

      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_attribute_from_feature_list_exclit">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>

    </xsl:choose>


  </xsl:template>
  <!--  Get the attribute value  of the first matching attribute acronym  which comes from a featureid and feature acronym in the passed in lists -->
  <xsl:template name="get_attribute_from_feature_list_for_ranges">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>

    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>


    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value"/>

    <xsl:choose>
      <xsl:when test="$value &gt;= 15">
        <xsl:value-of select="$value"/>
        <xsl:choose>
          <xsl:when test="position() = last()">
            <!-- WE SHOULDN'T GIVE COMMA -->
          </xsl:when>
          <xsl:otherwise><xsl:text>,</xsl:text></xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <!--<xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_attribute_from_feature_list_for_ranges">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>-->
    </xsl:choose>
  </xsl:template>
  <!--  Get the attribute value  of the first matching attribute acronym  which comes from a featureid and feature acronym in the passed in lists -->
  <xsl:template name="get_attribute_from_feature_list_for_lights_color">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>

    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>


    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value"/>

    <xsl:choose>
      <xsl:when test="($value != '') and ($value != 'UNKNOWN') and ($value !='()') ">
        <xsl:value-of select="$value"/>
        <xsl:text>,</xsl:text>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_attribute_from_feature_list_for_lights_color">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_attribute_from_feature_list_for_lights_color">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--
  <!-\-  Get the attribute value  of the first matching attribute acronym  which comes from a featureid and feature acronym in the passed in lists for light_colors only -\->
  <xsl:template name="get_attribute_from_feature_list_for_light_color" >
    <xsl:param name="featureIds" />
    <xsl:param name="featureAcronyms" />
    <xsl:param name="attribute" />
    
    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>
    
    
    <!-\-xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-\->
    <xsl:variable name="value" select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value" />
    
    <xsl:choose>
      <xsl:when test="($value != '') and ($value != 'UNKNOWN') and ($value !='()') ">
        <xsl:value-of select="$value" />
        
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' " >
          <xsl:call-template name="get_attribute_from_feature_list_for_light_color">
            <xsl:with-param name="featureIds" select="$additionalFeatures" />
            <xsl:with-param name="attribute" select="$attribute" />
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms" />
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>-->

  <!-- Returns the first acronym from the passed in list that is a collocated feature at the current context -->
  <!-- Context expected to be at Report/Locations/Location[Geometry/Point] -->
  <xsl:template name="get_first_feature_acronym">
    <xsl:param name="featureAcronyms"/>

    <xsl:variable name="currentAcronym">
      <xsl:choose>
        <xsl:when test="substring-before($featureAcronyms,',') != ''">
          <xsl:value-of select="substring-before($featureAcronyms,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureAcronyms"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="additionalAcronyms">
      <xsl:value-of select="substring-after($featureAcronyms,',')"/>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="count(./CollocatedFeature[@acronym = $currentAcronym])">
<!--        <xsl:sort select="@fid"/>-->
        <xsl:value-of select="./CollocatedFeature[@acronym = $currentAcronym]/@fid"/>,<xsl:value-of
          select="$currentAcronym"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- recurse on rest of acronyms if there are any left -->
        <xsl:if test="$additionalAcronyms != ''">
          <xsl:call-template name="get_first_feature_acronym">
            <xsl:with-param name="featureAcronyms" select="$additionalAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <!-- taken from  http://stackoverflow.com/questions/7520762/xslt-1-0-string-replace-function -->
  <xsl:template name="replace-string">
    <xsl:param name="text"/>
    <xsl:param name="replace"/>
    <xsl:param name="with"/>
    <xsl:choose>
      <xsl:when test="contains($text,$replace)">
        <xsl:value-of select="substring-before($text,$replace)"/>
        <xsl:value-of select="$with"/>
        <xsl:call-template name="replace-string">
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


  <xsl:template name="FormatLatLong">
    <xsl:param name="Coordinate"/>
    <!-- Coordinate string to format -->

    <xsl:choose>
      <!-- If the string is empty spit out "Error, Empty Coordinate" -->
      <xsl:when test="$Coordinate = '' ">
        <xsl:text>Error, Empty Coordinate</xsl:text>
      </xsl:when>
      <!-- If the string is already formatted (found degree symbol) just spit 
				it out -->
      <xsl:when test="contains($Coordinate, '°') ">
        <xsl:value-of select="$Coordinate"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- Identify the separator to use for parsing the string -->
        <xsl:variable name="Separator">
          <xsl:choose>
            <xsl:when test="contains($Coordinate, '-') ">
              <!-- Assumes no negative coords -->
              <xsl:text>-</xsl:text>
            </xsl:when>
            <xsl:when test="contains($Coordinate, ' ') ">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="contains($Coordinate, '.') ">
              <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:when test="contains($Coordinate, ',') ">
              <xsl:text>,</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>

        <!-- Identify the quadrant character, expected at the end of the string -->
        <xsl:variable name="Quadrant">
          <xsl:choose>
            <xsl:when test="contains($Coordinate, 'N') ">
              <xsl:text>N</xsl:text>
            </xsl:when>
            <xsl:when test="contains($Coordinate, 'S') ">
              <xsl:text>S</xsl:text>
            </xsl:when>
            <xsl:when test="contains($Coordinate, 'E') ">
              <xsl:text>E</xsl:text>
            </xsl:when>
            <xsl:when test="contains($Coordinate, 'W') ">
              <xsl:text>W</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>

        <!-- Get the original Coordinate without the Quadrant -->
        <xsl:variable name="BareCoord">
          <xsl:value-of select="substring-before($Coordinate, $Quadrant)"/>
        </xsl:variable>

        <!-- Get the Degrees -->
        <xsl:variable name="Degrees">
          <xsl:value-of select="substring-before($BareCoord, $Separator)"/>
        </xsl:variable>

        <xsl:variable name="decimalMinutes">
          <xsl:value-of select="($BareCoord - $Degrees)* 60"/>
        </xsl:variable>

        <!-- Get the MinSecs -->
        <xsl:variable name="MinSecs">
          <xsl:value-of select="$decimalMinutes"/>
        </xsl:variable>

        <!-- Get the Minutes -->
        <xsl:variable name="Minutes">
          <xsl:choose>
            <xsl:when test="contains($MinSecs,'.') ">
              <xsl:value-of select="substring-before($MinSecs, '.')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$MinSecs"/>
            </xsl:otherwise>
          </xsl:choose>

        </xsl:variable>

        <!--				<xsl:variable name="Seconds">
					<xsl:value-of select="format-number(number(($MinSecs - $Minutes)* 60.0),'0.00')" />
				</xsl:variable>
-->
        <!-- Get the original Coordinate without the Quadrant -->
        <!--<xsl:variable name="Seconds">
					<xsl:value-of select="substring-after($MinSecs, '.')" />
				</xsl:variable> -->

        <xsl:if test="$Degrees != '' ">
          <xsl:value-of select="$Degrees"/>
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:if test="$decimalMinutes != '' ">
          <xsl:value-of select="format-number($decimalMinutes,'00.00')"/>
          <!--<xsl:text>.</xsl:text>-->
        </xsl:if>

        <!--				<xsl:if test="$Seconds != '' ">
					<!-\- <xsl:text> </xsl:text> -\->
					<xsl:value-of select="$Seconds" />
				</xsl:if>
-->
        <!--				<xsl:text> </xsl:text>
				<xsl:value-of select="$Quadrant" />-->

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="distinctvalues">
    <xsl:param name="values"/>
    <xsl:variable name="firstvalue" select="substring-before($values, ',')"/>
    <xsl:variable name="restofvalue" select="substring-after($values, ',')"/>
    <xsl:if test="not(contains($values, ','))">
      <xsl:value-of select="$values"/>
    </xsl:if>
    <xsl:if test="contains($restofvalue, $firstvalue) = false">
      <xsl:value-of select="$firstvalue"/>
      <xsl:text>,</xsl:text>
    </xsl:if>
    <xsl:if test="$restofvalue != ''">
      <xsl:call-template name="distinctvalues">
        <xsl:with-param name="values" select="$restofvalue"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template name="distinctvalues_exclit">
    <xsl:param name="values"/>
    <xsl:variable name="firstvalue" select="substring-before($values, ',')"/>
    <xsl:variable name="restofvalue" select="substring-after($values, ',')"/>
    <xsl:variable name="nextvalue" select="substring-before($restofvalue,',')"/>
    <xsl:if test="not(contains($values, ','))">
      <xsl:value-of select="$values"/>
    </xsl:if>
    <!--<xsl:if test="contains($restofvalue, $firstvalue) = false">-->
    <xsl:if test="$firstvalue != $nextvalue">
      <xsl:value-of select="$firstvalue"/>
      <xsl:text>,</xsl:text>
    </xsl:if>
    <xsl:if test="$restofvalue != ''">
      <xsl:call-template name="distinctvalues_exclit">
        <xsl:with-param name="values" select="$restofvalue"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>


  <xsl:template name="passing_single_color_for_light_eng">
    <xsl:param name="text"/>
  <!--  <xsl:text> $text </xsl:text>
    <xsl:value-of select="$text"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:if test="$text != ''">
      <xsl:variable name="letter" select="substring($text, 1, 2)"/>
     <!-- <xsl:text> letter </xsl:text>
      <xsl:value-of select="$letter"/>
      <xsl:text> *** </xsl:text>
      <xsl:text> substring-before($letter,',') </xsl:text>
      <xsl:value-of select="substring-before($letter,',')"/>
      <xsl:text> *** </xsl:text>-->
      <xsl:variable name="color">
        <xsl:call-template name="GetLitchr">
          <xsl:with-param name="colour" select="substring-before($letter,',')"/>
          <xsl:with-param name="lang" select="'eng'"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="$color"/>
      <xsl:call-template name="passing_single_color_for_light_eng">
        <xsl:with-param name="text" select="substring-after($text, $letter)"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="passing_single_color_for_sector_lights">
    <xsl:param name="colour"/>
    <xsl:if test="$colour != ''">
      <xsl:variable name="letter" select="substring($colour, 1, 2)"/>
      <xsl:variable name="color">

        <xsl:call-template name="ColourLookup">
          <xsl:with-param name="colour" select="substring-before($letter,',')"/>
          <xsl:with-param name="language" select="'eng'"/>
        </xsl:call-template>

        <!--<xsl:call-template name="GetLitchr">
          <xsl:with-param name="colour" select="substring-before($letter,',')" />
          <xsl:with-param name="lang" select="'eng'" />
        </xsl:call-template>-->
      </xsl:variable>
      <xsl:value-of select="$color"/>
      <xsl:call-template name="passing_single_color_for_sector_lights">
        <xsl:with-param name="colour" select="substring-after($colour, $letter)"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="passing_single_color_for_lum_geo_range">
    <xsl:param name="text"/>
    <xsl:if test="$text != ''">
      <xsl:variable name="letter" select="substring($text, 1, 2)"/>
      <xsl:variable name="colour_val">
      <xsl:call-template name="ColourLookup">
        <xsl:with-param name="colour" select="substring-before($letter,',')"/>
        <xsl:with-param name="language" select="'eng'"/>
      </xsl:call-template>
      </xsl:variable>
      
      <xsl:choose>
        <xsl:when test="$colour_val = 'W' ">
          <xsl:text>White</xsl:text>
        </xsl:when>
        <xsl:when test="$colour_val = 'B' ">
          <xsl:text>Black</xsl:text>
        </xsl:when>
        <xsl:when test="$colour_val = 'R' ">
          <xsl:text>Red</xsl:text>
        </xsl:when>
        <xsl:when test="$colour_val = 'G' ">
          <xsl:text>Green</xsl:text>
        </xsl:when>
        <xsl:when test="$colour_val = 'Bu' ">
          <xsl:text>Blue</xsl:text>
        </xsl:when>
        <xsl:when test="$colour_val = 'Y' ">
          <xsl:text>Yellow</xsl:text>
        </xsl:when>
        <xsl:when test="$colour_val = 'Gr' ">
          <xsl:text>Grey</xsl:text>
        </xsl:when>
        <xsl:when test="$colour_val = 'Br' ">
          <xsl:text>Brown</xsl:text>
        </xsl:when>
        <xsl:when test="$colour_val = 'Y | Am' ">
          <xsl:text>Amber</xsl:text>
        </xsl:when>
        <xsl:when test="$colour_val = 'Vi' ">
          <xsl:text>Violet</xsl:text>
        </xsl:when>
        <xsl:when test="$colour_val = 'Y | Or' ">
          <xsl:text>Orange</xsl:text>
        </xsl:when>
        <xsl:when test="$colour_val = 'Mg' ">
          <xsl:text>Magenta</xsl:text>
        </xsl:when>
        <xsl:when test="$colour_val = 'P' ">
          <xsl:text>Pink</xsl:text>
        </xsl:when>
      </xsl:choose>
      <xsl:if test="substring-before(substring-after($text, $letter),',') != ''">
        <xsl:text>,</xsl:text>
      </xsl:if>
      <xsl:call-template name="passing_single_color_for_lum_geo_range">
        <xsl:with-param name="text" select="substring-after($text, $letter)"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="redering_light_height">
    <xsl:param name="values"/>
    <xsl:param name="llknum_val"/>
    <xsl:param name="catlit_val"/>
    <xsl:param name="exclit_val"/>
    <xsl:variable name="firstvalue" select="substring-before($values, ',')"/>
    <xsl:variable name="restofvalue" select="substring-after($values, ',')"/>
     <!--<xsl:text> catlit_val </xsl:text>
    <xsl:value-of select="$catlit_val"/>
    <xsl:text> *** </xsl:text>
    <xsl:text> exclit_val </xsl:text>
    <xsl:value-of select="$exclit_val"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:variable name="first_val" select="translate($firstvalue,'#','')"/>
    <xsl:if test="$first_val !=''">
      <xsl:choose>
        <xsl:when test="not(contains(normalize-space($first_val),'#'))">
          <xsl:choose>
            <xsl:when test="not(contains($llknum_val,'_'))">
          <xsl:value-of select="$first_val"/>
            </xsl:when>
            <xsl:otherwise>
              <!--<xsl:if test="$catlit_val != 17">
                <xsl:value-of select="$first_val"/>
              </xsl:if>-->
              <!--<xsl:if test="$exclit_val != 2">
                <xsl:value-of select="$first_val"/>
              </xsl:if>
              <xsl:if test="$exclit_val != 4">
                <xsl:value-of select="$first_val"/>
              </xsl:if>-->
              <xsl:choose>
                <xsl:when test="$exclit_val = 2 or $exclit_val = 4 or $catlit_val = 17">
                  <!-- we should not render height -->
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$first_val"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
          
        </xsl:when>

      </xsl:choose>
    </xsl:if>

    <xsl:if test="$restofvalue != ''">
      <br/>
      <xsl:call-template name="redering_light_height">
        <xsl:with-param name="values" select="$restofvalue"/>
        <xsl:with-param name="catlit_val" select="$catlit_val"/>
        <xsl:with-param name="llknum_val" select="$llknum_val"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="split_exclit_and_other_values">
    <xsl:param name="geo_ranges"/>

    <xsl:variable name="current_range">
      <xsl:choose>
        <xsl:when test="substring-before($geo_ranges,',') != ''">
          <strong>
            <xsl:value-of select="substring-before($geo_ranges,',')"/>
          </strong>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$geo_ranges"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($geo_ranges,',')"/>
    </xsl:variable>

    <xsl:if test="$current_range != '' and $current_range != ','">

      <xsl:if test="not(contains($current_range,'#'))">
        <xsl:variable name="range_val">
          <xsl:if test="normalize-space($current_range) != ''">
            <xsl:value-of select="translate($current_range,'*','')"/>
          </xsl:if>
        </xsl:variable>
        <xsl:choose>
          <xsl:when
            test="normalize-space(substring(normalize-space($range_val),2,string-length(normalize-space($range_val)))) &gt;= 15">

            <b>
              <xsl:value-of select="normalize-space($range_val)"/>
            </b>
            <br/>

          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="normalize-space($range_val) &gt;= 15">
                <b><xsl:value-of select="normalize-space($range_val)"/></b><br/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="normalize-space($range_val) != ''">
                  <xsl:value-of select="normalize-space($range_val)"/>
                  <br/>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <xsl:if test="contains($current_range,'#')">
        <br/>
        <br/>
        <xsl:value-of select="translate($current_range,'#','')"/>
        <br/>
      </xsl:if>
    </xsl:if>
    <xsl:if test="$additionalFeatures != '' ">
      <xsl:call-template name="split_exclit_and_other_values">
        <xsl:with-param name="geo_ranges" select="$additionalFeatures"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="multiple_colour_lookup">
    <xsl:param name="colour"/>
    <xsl:variable name="firstvalue" select="substring-before($colour, ',')"/>
    <xsl:variable name="restofvalue" select="substring-after($colour, ',')"/>

    <xsl:call-template name="ColourLookup">
      <xsl:with-param name="colour" select="$firstvalue"/>
      <xsl:with-param name="language" select="'eng'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="distinctvalues_for_range">
    <xsl:param name="textIn"/>
    <xsl:param name="wordsIn"/>
    <xsl:choose>
      <xsl:when test="contains($textIn, ',')">
        <xsl:variable name="firstWord" select="substring-before($textIn, ',')"/>
        <xsl:choose>
          <xsl:when test="not(contains($wordsIn, $firstWord))">
            <xsl:variable name="newString">
              <xsl:choose>
                <xsl:when test="string-length($wordsIn)=0">
                  <xsl:value-of select="$firstWord"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$wordsIn"/>
                  <xsl:text>,</xsl:text>
                  <xsl:value-of select="$firstWord"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:call-template name="distinctvalues_for_range">
              <xsl:with-param name="textIn" select="substring-after($textIn, ',')"/>
              <xsl:with-param name="wordsIn" select="$newString"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="distinctvalues_for_range">
              <xsl:with-param name="textIn" select="substring-after($textIn, ',')"/>
              <xsl:with-param name="wordsIn" select="$wordsIn"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="string-length($wordsIn)=0">
            <xsl:value-of select="$textIn"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="contains($wordsIn, $textIn)">
                <xsl:value-of select="$wordsIn"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$wordsIn"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="$textIn"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="exclit_distinctvalues_for_range">
    <xsl:param name="textIn"/>
    <xsl:param name="wordsIn"/>

    <xsl:choose>
      <xsl:when test="contains($textIn, ',')">
        <xsl:variable name="firstWord" select="substring-before($textIn, ',')"/>
        <xsl:choose>
          <xsl:when test="not(contains($wordsIn, $firstWord))">
            <xsl:variable name="newString">
              <xsl:choose>
                <xsl:when test="string-length($wordsIn)=0">
                  <xsl:value-of select="$firstWord"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$wordsIn"/>
                  <xsl:text>,</xsl:text>
                  <xsl:value-of select="$firstWord"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:call-template name="exclit_distinctvalues_for_range">
              <xsl:with-param name="textIn" select="substring-after($textIn, ',')"/>
              <xsl:with-param name="wordsIn" select="$newString"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="exclit_distinctvalues_for_range">
              <xsl:with-param name="textIn" select="substring-after($textIn, ',')"/>
              <xsl:with-param name="wordsIn" select="$wordsIn"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="string-length($wordsIn)=0">
            <xsl:value-of select="$textIn"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="contains($wordsIn, $textIn)">
                <xsl:value-of select="$wordsIn"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$wordsIn"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="$textIn"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--  Get the attribute value  of the first matching attribute acronym  which comes from a featureid and feature acronym in the passed in lists -->
  <xsl:template name="get_attribute_from_feature_list_llknum">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>

    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>
    <!-- <xsl:text> additionalFeatures :: </xsl:text>
    <xsl:value-of select="$additionalFeatures"/>-->


    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value"/>

    <xsl:choose>

      <xsl:when test="($value != '') and ($value != 'UNKNOWN') and ($value !='()') ">
        <!--<xsl:value-of select="$value" />-->
        <xsl:value-of select="concat($value,'|',$currentfeature,',')"/>

        <xsl:if test="$additionalFeatures != '' ">

          <xsl:call-template name="get_attribute_from_feature_list_llknum">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_attribute_from_feature_list_llknum">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
  <xsl:template name="current_fid">
    <xsl:param name="llk_num"/>

    <!--<xsl:text> llk_num :: </xsl:text>
    <xsl:value-of select="$llk_num"/>
    <xsl:text> %%% </xsl:text>-->
    <xsl:variable name="first_llk">
      <xsl:choose>
        <xsl:when test="substring-before($llk_num,',') != ''">
          <xsl:value-of select="substring-before($llk_num,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$llk_num"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <xsl:variable name="list_of_remain_llk">
      <xsl:if test="substring-after($llk_num,',') != ''">
        <xsl:value-of select="substring-after($llk_num,',')"/>
      </xsl:if>
    </xsl:variable>

    <xsl:variable name="second_llk">
      <xsl:if test="substring-before($list_of_remain_llk,',')!=''">
        <xsl:value-of select="substring-before($list_of_remain_llk,',')"/>
      </xsl:if>
    </xsl:variable>

    <xsl:variable name="modifying_second_llk">
      <xsl:if test="$second_llk !=''">
        <xsl:value-of select="concat($second_llk,',')"/>
      </xsl:if>
    </xsl:variable>
    <!--<xsl:text> modifying_second_llk :: </xsl:text>
    <xsl:value-of select="$modifying_second_llk"/>
    <xsl:text> **** </xsl:text>-->
    <xsl:variable name="remain_llk">
      <xsl:if test="substring-after($list_of_remain_llk,$modifying_second_llk) != ''">
        <xsl:value-of select="substring-after($list_of_remain_llk,$modifying_second_llk)"/>
      </xsl:if>
    </xsl:variable>

    <!--<xsl:text> remain_llk :: </xsl:text>
    <xsl:value-of select="$remain_llk"/>
    <xsl:text> **** </xsl:text>-->

    <xsl:choose>

      <xsl:when test="substring-before($first_llk,'|') = substring-before($second_llk,'|')">

        <xsl:variable name="orginal_llk">
          <xsl:value-of select="concat($first_llk,',',$second_llk)"/>

          <xsl:if test="$remain_llk != ''">
            <xsl:text>,</xsl:text>
            <xsl:call-template name="current_fid">
              <xsl:with-param name="llk_num" select="$remain_llk"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:variable>
        <!--<xsl:text> test1 :: </xsl:text>
        <xsl:value-of select="$test1"/>
        <xsl:text> **** </xsl:text>-->
        <xsl:value-of select="$orginal_llk"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:variable name="additinal_llk">
          <xsl:value-of select="concat($first_llk,',',$second_llk)"/>



          <xsl:if test="$remain_llk !=''">
            <xsl:text>,</xsl:text>
            <xsl:call-template name="current_fid">
              <xsl:with-param name="llk_num" select="$remain_llk"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:variable>
        <xsl:text>#</xsl:text>
        <xsl:value-of select="$additinal_llk"/>
      </xsl:otherwise>
    </xsl:choose>


  </xsl:template>

  <!--<xsl:template name="other_llk_template">
    <xsl:param name="llk_num"/>
    
    <xsl:variable name="current_llk">
      <xsl:choose>
        <xsl:when test="substring-before($llk_num,',') != ''">
          <xsl:value-of select="substring-before($llk_num,',')"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="additional_llk">
      <xsl:value-of select="substring-after($llk_num,',')"/>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="contains(substring-before($current_llk,'|'),'#')">
        <xsl:value-of select="concat($current_llk,',')"/>
        <xsl:if test="$additional_llk != '' ">
          <xsl:call-template name="other_llk_template">
            <xsl:with-param name="llk_num" select="$additional_llk"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additional_llk != '' ">
          <xsl:call-template name="other_llk_template">
            <xsl:with-param name="llk_num" select="$additional_llk"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>-->
  
  <!--<xsl:template name="other_llk_add_template">
    <xsl:param name="llk_num"/>
    
    <xsl:variable name="current_llk">
      <xsl:choose>
        <xsl:when test="substring-before($llk_num,',') != ''">
          <xsl:value-of select="substring-before($llk_num,',')"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="additional_llk">
      <xsl:value-of select="substring-after($llk_num,',')"/>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="contains(substring-before($current_llk,'|'),'@')">
        <xsl:value-of select="concat($current_llk,',')"/>
        <xsl:if test="$additional_llk != '' ">
          <xsl:call-template name="other_llk_add_template">
            <xsl:with-param name="llk_num" select="$additional_llk"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additional_llk != '' ">
          <xsl:call-template name="other_llk_add_template">
            <xsl:with-param name="llk_num" select="$additional_llk"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>-->
  
  <xsl:template name="other_llk_last_template">
    <xsl:param name="llk_num"/>
    
    <xsl:variable name="current_llk">
      <xsl:choose>
        <xsl:when test="substring-before($llk_num,',') != ''">
          <xsl:value-of select="substring-before($llk_num,',')"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="additional_llk">
      <xsl:value-of select="substring-after($llk_num,',')"/>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="contains(substring-before($current_llk,'|'),'$')">
        <xsl:value-of select="concat($current_llk,',')"/>
        <xsl:if test="$additional_llk != '' ">
          <xsl:call-template name="other_llk_last_template">
            <xsl:with-param name="llk_num" select="$additional_llk"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      
      <xsl:otherwise>
        <xsl:if test="$additional_llk != '' ">
          <xsl:call-template name="other_llk_last_template">
            <xsl:with-param name="llk_num" select="$additional_llk"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  
  <xsl:template name="other_llk_add_template">
    <xsl:param name="llk_num"/>
    
    <xsl:variable name="current_llk">
      <xsl:choose>
        <xsl:when test="substring-before($llk_num,',') != ''">
          <xsl:value-of select="substring-before($llk_num,',')"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="additional_llk">
      <xsl:value-of select="substring-after($llk_num,',')"/>
    </xsl:variable>
    
    <xsl:choose>
      
      
      <xsl:when test="contains(substring-before($current_llk,'|'),'@')">
        <xsl:value-of select="concat($current_llk,',')"/>
        <xsl:if test="$additional_llk != '' ">
          <xsl:call-template name="other_llk_add_template">
            <xsl:with-param name="llk_num" select="$additional_llk"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      
      <xsl:otherwise>
        <xsl:if test="$additional_llk != '' ">
          <xsl:call-template name="other_llk_add_template">
            <xsl:with-param name="llk_num" select="$additional_llk"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <xsl:template name="other_llk_template">
    <xsl:param name="llk_num"/>
    
    <xsl:variable name="current_llk">
      <xsl:choose>
        <xsl:when test="substring-before($llk_num,',') != ''">
          <xsl:value-of select="substring-before($llk_num,',')"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="additional_llk">
      <xsl:value-of select="substring-after($llk_num,',')"/>
    </xsl:variable>
    
    <xsl:choose>
       <xsl:when test="contains(substring-before($current_llk,'|'),'#')">
        <xsl:value-of select="concat($current_llk,',')"/>
        <xsl:if test="$additional_llk != '' ">
          <xsl:call-template name="other_llk_template">
            <xsl:with-param name="llk_num" select="$additional_llk"/>
          </xsl:call-template>
        </xsl:if>
       </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additional_llk != '' ">
          <xsl:call-template name="other_llk_template">
            <xsl:with-param name="llk_num" select="$additional_llk"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="original_llk_template">
    <xsl:param name="llk_num"/>
    
    <xsl:variable name="current_llk">
      <xsl:choose>
        <xsl:when test="substring-before($llk_num,',') != ''">
          <xsl:value-of select="substring-before($llk_num,',')"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="additional_llk">
      <xsl:value-of select="substring-after($llk_num,',')"/>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="not(contains(substring-before($current_llk,'|'),'#')) and not(contains(substring-before($current_llk,'|'),'@')) and not(contains(substring-before($current_llk,'|'),'$')) ">
        <xsl:value-of select="concat($current_llk,',')"/>
        <xsl:if test="$additional_llk != '' ">
          <xsl:call-template name="original_llk_template">
            <xsl:with-param name="llk_num" select="$additional_llk"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additional_llk != '' ">
          <xsl:call-template name="original_llk_template">
            <xsl:with-param name="llk_num" select="$additional_llk"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <xsl:template name="current_fid_llk">
    <xsl:param name="llk_num"/>

    <xsl:variable name="current_llk">
      <xsl:choose>
        <xsl:when test="substring-before($llk_num,',') != ''">
          <xsl:value-of select="substring-before($llk_num,',')"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additional_llk">
      <xsl:value-of select="substring-after($llk_num,',')"/>
    </xsl:variable>
    <!-- <xsl:text> additionalFeatures :: </xsl:text>
    <xsl:value-of select="$additionalFeatures"/>-->
    <xsl:choose>
      <xsl:when test="not(contains(substring-before($current_llk,'|'),'_'))">
        <xsl:variable name="test1">
        <xsl:value-of select="concat($current_llk,',')"/>

          <xsl:if test="$additional_llk != '' ">

            <xsl:call-template name="current_fid_llk">
              <xsl:with-param name="llk_num" select="$additional_llk"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$test1"/>
      </xsl:when>
      <xsl:when test="contains(substring-before($current_llk,'|'),'_1')">
        <xsl:variable name="test2">
          <xsl:value-of select="concat($current_llk,',')"/>
          <xsl:if test="$additional_llk != '' ">
            <xsl:call-template name="current_fid_llk">
              <xsl:with-param name="llk_num" select="$additional_llk"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:variable>
        <xsl:text>#</xsl:text>
        <xsl:value-of select="$test2"/>
      </xsl:when>
      <xsl:when test="contains(substring-before($current_llk,'|'),'_2')">
        <xsl:variable name="test3">
          <xsl:value-of select="concat($current_llk,',')"/>
          <xsl:if test="$additional_llk != '' ">
            <xsl:call-template name="current_fid_llk">
              <xsl:with-param name="llk_num" select="$additional_llk"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:variable>
        <xsl:text>@</xsl:text>
        <xsl:value-of select="$test3"/>
      </xsl:when>
      <xsl:when test="contains(substring-before($current_llk,'|'),'_3')">
        <xsl:variable name="test4">
          <xsl:value-of select="concat($current_llk,',')"/>
          <xsl:if test="$additional_llk != '' ">
            <xsl:call-template name="current_fid_llk">
              <xsl:with-param name="llk_num" select="$additional_llk"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:variable>
        <xsl:text>$</xsl:text>
        <xsl:value-of select="$test4"/>
      </xsl:when>
    </xsl:choose>

  </xsl:template>
  
<xsl:template name="sorting_llk">
  <xsl:param name="llk_with_fid"/>
  
  <xsl:for-each select=".">
    <xsl:sort select="substring-before(substring-before($llk_with_fid,','),'|')"/>
    <xsl:sort select="substring-before(substring-before($llk_with_fid,','),'|')" data-type="number" />
    <xsl:value-of select="number(substring-before(substring-before($llk_with_fid,','),'|'))" />
    <xsl:if test="position()!=last()"><xsl:text>,&#160;</xsl:text></xsl:if>
  </xsl:for-each>
  
  <!--<xsl:variable name="current_llk">
  <xsl:choose>
        <xsl:when test="substring-before($llk_with_fid,',') != ''">
          <xsl:value-of select="substring-before($llk_with_fid,',')"/>
        </xsl:when>
  </xsl:choose>
  </xsl:variable>
  
  <xsl:variable name="additional_llk">
    <xsl:value-of select="substring-after($llk_with_fid,',')"/>
  </xsl:variable>
  <xsl:variable name="slave_llk">
  <xsl:if test="contains(substring-before($current_llk,'|'),'_')">
    
      <xsl:value-of select="concat($current_llk,',')"/>
    
 </xsl:if>
  </xsl:variable>
  <xsl:variable name="master_llk">
  <xsl:if test="not(contains(substring-before($current_llk,'|'),'_'))">
    
      <xsl:value-of select="concat($current_llk,',')"/>
    
  </xsl:if>
  </xsl:variable>
  <xsl:choose>
    <xsl:when test="$additional_llk != ''">
      <xsl:call-template name="sorting_llk">
        <xsl:with-param name="llk_with_fid" select="$additional_llk"></xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="concat($master_llk,$slave_llk)"/>
    </xsl:otherwise>
  </xsl:choose>
  -->
  
</xsl:template>
  
  <xsl:template name="list_of_fid">
    <xsl:param name="llk_num"/>

    <xsl:variable name="current_llk">
      <xsl:choose>
        <xsl:when test="substring-before($llk_num,',') != ''">
          <xsl:value-of select="substring-before($llk_num,',')"/>
        </xsl:when>

      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="additional_llk">
      <xsl:value-of select="substring-after($llk_num,',')"/>
    </xsl:variable>
    <!-- <xsl:text> additionalFeatures :: </xsl:text>
    <xsl:value-of select="$additionalFeatures"/>-->



    <xsl:choose>

      <xsl:when test="substring-after($current_llk,'|') != ''">
        <xsl:variable name="test1">

          <xsl:value-of select="concat(substring-after($current_llk,'|'),',')"/>

          <xsl:if test="$additional_llk != '' ">

            <xsl:call-template name="list_of_fid">
              <xsl:with-param name="llk_num" select="$additional_llk"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$test1"/>
      </xsl:when>
      <xsl:otherwise>

        <xsl:if test="$additional_llk != '' ">
          <xsl:call-template name="list_of_fid">
            <xsl:with-param name="llk_num" select="$additional_llk"/>
          </xsl:call-template>
        </xsl:if>

      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
  <!--  Get the attribute value  of the first matching attribute acronym  which comes from a featureid and feature acronym in the passed in lists -->
  <xsl:template name="get_attribute_from_feature_list_catlit">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>

    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>


    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value"/>

    <xsl:choose>
      <!-- for only catlit value = 1 in current features -->
      <xsl:when test="($value != '') and ($value != 'UNKNOWN') and ($value !='()')  ">
        <xsl:value-of select="concat($value,',')"/>

      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_attribute_from_feature_list_catlit">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="catlit_value_for_dir">
    <xsl:param name="list_of_catlit"/>

    <xsl:variable name="current_catlit">
      <xsl:choose>
        <xsl:when test="substring-before($list_of_catlit,',') != ''">
          <xsl:value-of select="substring-before($list_of_catlit,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$list_of_catlit"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additional_catlit">
      <xsl:value-of select="substring-after($list_of_catlit,',')"/>
    </xsl:variable>
    <xsl:choose>
      <!-- for only catlit value = 1 in current features -->
      <xsl:when test="$current_catlit = 1">
        <xsl:value-of select="$current_catlit"/>

      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additional_catlit != '' ">
          <xsl:call-template name="catlit_value_for_dir">
            <xsl:with-param name="list_of_catlit" select="$additional_catlit"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="get_attribute_from_feature_for_litchar">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>

    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>


    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value"/>

    <xsl:choose>
      <!-- for only catlit value = 1 in current features -->
      <xsl:when test="($value != '')">
        <xsl:value-of select="concat($value,',')"/>

      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_attribute_from_feature_list_catlit">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="checking_for_same_valnmr_value">
    <xsl:param name="additional_colour"/>
    <xsl:param name="first_valnmr"/>
    <xsl:param name="valnmr_with_colour"/>
    <xsl:param name="copy_second_val"/>
    <xsl:param name="final_valnmr"/>
    <xsl:variable name="second_val" select="substring-before($valnmr_with_colour,',')"/>
    <xsl:variable name="add_val"
      select="substring-after($valnmr_with_colour,concat($second_val,','))"/>
    <!--<xsl:text> second_val </xsl:text>
    <xsl:value-of select="substring($second_val,2,string-length($second_val))"/>
    <xsl:text> **** </xsl:text>
    <xsl:text> first_valnmr </xsl:text>
    <xsl:value-of select="substring($first_valnmr,'2',string-length($first_valnmr))"/>
    <xsl:text> ***** </xsl:text>-->

    <xsl:choose>
      <xsl:when
        test="substring($second_val,2,string-length($second_val))  != substring($first_valnmr,'2',string-length($first_valnmr))">
        <xsl:variable name="final_val">

          <xsl:value-of select="$second_val"/>
        </xsl:variable>

        <xsl:if test="$add_val != ''">
          <xsl:text>,</xsl:text>
          <xsl:call-template name="checking_for_same_valnmr_value">
            <xsl:with-param name="additional_colour" select="$additional_colour"/>
            <xsl:with-param name="first_valnmr" select="$first_valnmr"/>
            <xsl:with-param name="valnmr_with_colour" select="$add_val"/>
            <xsl:with-param name="final_valnmr" select="$final_val"/>
          </xsl:call-template>
        </xsl:if>

        <xsl:if test="$add_val = ''">
          <!--<xsl:text> final_val </xsl:text>
           <xsl:value-of select="$final_val"/>
           <xsl:text> ### </xsl:text>-->

          <xsl:choose>
            <xsl:when
              test="contains($final_val,'W') or contains($final_val,'R') or contains($final_val,'G') or contains($final_val,'Bu')or contains($final_val,'Y')or contains($final_val,'Am')
               or contains($final_val,'Vi')or contains($final_val,'Or')">
              <xsl:value-of select="$additional_colour"/>

            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$final_val"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>

        <!--         <xsl:text> OTHERWISE </xsl:text>-->
        <xsl:if test="$add_val != ''">
          <xsl:call-template name="checking_for_same_valnmr_value">
            <xsl:with-param name="additional_colour" select="$additional_colour"/>
            <xsl:with-param name="first_valnmr" select="$first_valnmr"/>
            <xsl:with-param name="valnmr_with_colour" select="$add_val"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:if test="$add_val = ''">
          <!-- <xsl:text> final_val </xsl:text>
           <xsl:value-of select="$final_valnmr"/>
           <xsl:text> ### </xsl:text>-->

          <xsl:choose>
            <xsl:when
              test="contains($final_valnmr,'W') or contains($final_valnmr,'R') or contains($final_valnmr,'G') or contains($final_valnmr,'Bu')or contains($final_valnmr,'Y')or contains($final_valnmr,'Am')
               or contains($final_valnmr,'Vi')or contains($final_valnmr,'Or')">
              <xsl:value-of select="$additional_colour"/>

            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$final_valnmr"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--  Get the attribute value  of the first matching attribute acronym  which comes from a featureid and feature acronym in the passed in lists -->
  <xsl:template name="get_attribute_from_feature_list_for_sectors">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>

    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>


    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value"/>

    <xsl:choose>
      <xsl:when test="($value != '') and ($value != 'UNKNOWN') and ($value !='()') ">
        <xsl:value-of select="$value"/>

      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_attribute_from_feature_list">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="get_attribute_from_feature_sectors_list">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>
    <xsl:param name="litchar_attribute"/>
    <xsl:param name="light_colour"/>
    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>
    <xsl:variable name="sectr1" select="substring-before($attribute,',')"/>
    <xsl:variable name="sectr2" select="substring-after($attribute,',')"/>

    <xsl:variable name="litchar">
      <xsl:if test="$litchar_attribute != ''">
        <xsl:value-of select="$litchar_attribute"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="light_col">
      <xsl:if test="$light_colour !=''">
        <xsl:value-of select="$light_colour"/>
      </xsl:if>
    </xsl:variable>
    <!--<xsl:text> litchar </xsl:text>
    <xsl:value-of select="$litchar"/>
    <xsl:text> **** </xsl:text>-->

    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="sectr1_value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$sectr1]/@value"/>

    <xsl:variable name="sectr2_value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$sectr2]/@value"/>

    <xsl:variable name="litchar_value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$litchar]/@value"/>

    <xsl:variable name="lc"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$light_colour]/@value"/>

    <xsl:variable name="light_color">
      <xsl:choose>
        <xsl:when test="contains($lc,',')">
          <xsl:call-template name="passing_single_color_for_sector_lights">
            <xsl:with-param name="colour" select="concat($lc,',')"/>
          </xsl:call-template>

        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="ColourLookup">
            <xsl:with-param name="colour" select="$lc"/>
            <xsl:with-param name="language" select="'eng'"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!--<xsl:text> lights_colour </xsl:text>
    <xsl:value-of select="$lights_colour"/>
    <xsl:text> **** </xsl:text>-->
    <xsl:variable name="translatedLitchr">
      <xsl:call-template name="LitchrLookup">
        <xsl:with-param name="litchr" select="$litchar_value"/>
        <xsl:with-param name="language" select="'eng'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <xsl:when
        test="($sectr1_value != '') and ($sectr1_value != 'UNKNOWN') and ($sectr1_value !='()') and ($sectr2_value != '') and ($sectr2_value != 'UNKNOWN') and ($sectr2_value !='()')">
        <xsl:value-of
          select="concat($sectr1_value,'-',$sectr2_value,'*',$translatedLitchr,'#',$light_color)"/>

        <xsl:if test="$additionalFeatures != '' ">
          <xsl:text>,</xsl:text>
          <xsl:call-template name="get_attribute_from_feature_sectors_list">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
            <xsl:with-param name="litchar_attribute" select="$litchar_attribute"/>
            <xsl:with-param name="light_colour" select="$light_colour"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>

      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:text>,</xsl:text>
          <xsl:call-template name="get_attribute_from_feature_sectors_list">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
            <xsl:with-param name="litchar_attribute" select="$litchar_attribute"/>
            <xsl:with-param name="light_colour" select="$light_colour"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="tokenize">
    <xsl:param name="text"/>
    <xsl:param name="delimiter" select="','"/>
    <!--<xsl:text> text </xsl:text>
    <xsl:value-of select="$text"/>
    <xsl:text> @@@ </xsl:text>-->
    <xsl:variable name="currentSector" select="substring-before($text,'*')"/>
    <!--<xsl:text> currentSector </xsl:text>
    <xsl:value-of select="$currentSector"/>
    <xsl:text> @@@ </xsl:text>-->
    <xsl:variable name="token" select="substring-before(concat($text, $delimiter), $delimiter)"/>
    <xsl:if test="$token">
      <value>
        <xsl:value-of select="$token"/>
      </value>
    </xsl:if>
    <xsl:if test="contains($text, $delimiter)">
      <!-- recursive call -->
      <xsl:call-template name="tokenize">
        <xsl:with-param name="text" select="substring-after($text, $delimiter)"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>


  <xsl:template name="passing_sector_values">
    <xsl:param name="sectors"/>

    <xsl:variable name="currentSector">
      <xsl:if test="$sectors != ''">
        <xsl:choose>
          <xsl:when test="substring-before($sectors,',') != ''">
            <xsl:value-of select="substring-before($sectors,',')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$sectors"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </xsl:variable>

    <xsl:variable name="lights_sectr1">
      <xsl:if test="substring-before($currentSector,'-') != ''">
        <xsl:value-of select="substring-before($currentSector,'-')"/>
      </xsl:if>
    </xsl:variable>

    <xsl:variable name="lights_sectr2">
      <xsl:if test="substring-before(substring-after($currentSector,'-'),'*') != ''">
        <xsl:value-of select="substring-before(substring-after($currentSector,'-'),'*')"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="lights_litvisTranslated">
      <xsl:if test="substring-before(substring-after($currentSector,'*'),'#') != ''">
        <xsl:value-of select="substring-before(substring-after($currentSector,'*'),'#')"/>
      </xsl:if>
    </xsl:variable>
    <!-- <xsl:text> lights_litvisTranslated </xsl:text>
    <xsl:value-of select="$lights_litvisTranslated"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:variable name="lights_colour">
      <xsl:if test="substring-after($currentSector,'#') != ''">
        <xsl:value-of select="substring-after($currentSector,'#')"/>
      </xsl:if>
    </xsl:variable>

    <xsl:variable name="additionalSectors">
      <xsl:if test="substring-after($sectors,',') !=''">
        <xsl:value-of select="substring-after($sectors,',')"/>
      </xsl:if>
    </xsl:variable>

    <xsl:call-template name="sectors_with_litvis">
      <xsl:with-param name="lights_sectr1" select="$lights_sectr1"/>
      <xsl:with-param name="lights_sectr2" select="$lights_sectr2"/>
      <xsl:with-param name="lights_litvisTranslated" select="$lights_litvisTranslated"/>
      <xsl:with-param name="lights_colour" select="$lights_colour"/>
    </xsl:call-template>

    <xsl:if test="$additionalSectors != ''">
      <xsl:call-template name="passing_sector_values">
        <xsl:with-param name="sectors" select="$additionalSectors"/>
      </xsl:call-template>
    </xsl:if>


  </xsl:template>


  <xsl:template name="sectors_with_litvis">
    <xsl:param name="lights_sectr1"/>
    <xsl:param name="lights_sectr2"/>
    <xsl:param name="lights_litvisTranslated"/>
    <xsl:param name="lights_colour"/>
    <xsl:if test="normalize-space($lights_sectr1) != '' and normalize-space($lights_sectr2) = '' ">
      <xsl:if test="normalize-space($lights_litvisTranslated) = '' ">
        <xsl:value-of select="concat(translate(normalize-space($lights_sectr1), '.', '.'), '°')"/>
        <br/>
      </xsl:if>
      <xsl:if
        test="normalize-space($lights_litvisTranslated) != ''  and normalize-space($lights_litvisTranslated) = 'Obscured'">
        <xsl:value-of select="concat(' ',$lights_litvisTranslated, ' ', c, '°')"/>
        <br/>
      </xsl:if>

    </xsl:if>

    <xsl:if test="normalize-space($lights_sectr1) != '' and normalize-space($lights_sectr2) != '' ">
      <xsl:value-of select="concat($lights_colour,' ')"/>
      <xsl:if test="normalize-space($lights_litvisTranslated) != 'Obscured'">
        <xsl:value-of
          select="concat(translate(normalize-space($lights_sectr1), '.', '.'), '°-', translate(normalize-space($lights_sectr2), '.', '.'), '°' )"/>
        <br/>
      </xsl:if>

      <xsl:if
        test="normalize-space($lights_litvisTranslated) != ''  and normalize-space($lights_litvisTranslated) = 'Obscured'">
        <xsl:value-of
          select="concat($lights_litvisTranslated, ' ', translate(normalize-space($lights_sectr1), '.', ','), '°- ', translate(normalize-space($lights_sectr2), '.', '.'), '°')"/>
        <br/>
      </xsl:if>

      <xsl:if test="$lights_sectr2 > $lights_sectr1"> (<xsl:value-of
          select="format-number(($lights_sectr2 - $lights_sectr1),'#.#')"/>°) <br/>
      </xsl:if>
      <xsl:if test="$lights_sectr1 > $lights_sectr2">
        <!--  Wrong sector value , it should be - ((SECTR1-360)-SECTR2) = ((135-360)-80) = 305 -->
        <!--(<xsl:value-of select="$lights_sectr1 - $lights_sectr2" />°)-->
        <xsl:variable name="angleValue">
          <xsl:value-of select="360"/>
        </xsl:variable> (<xsl:value-of
          select="(($lights_sectr1 - $angleValue) - $lights_sectr2) * (-1)"/>°) <br/>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <xsl:template name="get_attribute_from_feature_sectors_list_copy">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>
    <xsl:param name="litchar_attribute"/>
    <xsl:param name="light_colour"/>
    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>
    <xsl:variable name="sectr1" select="substring-before($attribute,',')"/>
    <xsl:variable name="sectr2" select="substring-after($attribute,',')"/>

    <xsl:variable name="litchar">
      <xsl:if test="$litchar_attribute != ''">
        <xsl:value-of select="$litchar_attribute"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="light_col">
      <xsl:if test="$light_colour !=''">
        <xsl:value-of select="$light_colour"/>
      </xsl:if>
    </xsl:variable>
    <!--<xsl:text> litchar </xsl:text>
    <xsl:value-of select="$litchar"/>
    <xsl:text> **** </xsl:text>-->

    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="sectr1_value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$sectr1]/@value"/>

    <xsl:variable name="sectr2_value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$sectr2]/@value"/>

    <xsl:variable name="litchar_value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$litchar]/@value"/>

    <xsl:variable name="lc"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$light_colour]/@value"/>

    <xsl:variable name="light_color">
      <xsl:choose>
        <xsl:when test="contains($lc,',')">
          <xsl:call-template name="passing_single_color_for_sector_lights">
            <xsl:with-param name="colour" select="concat($lc,',')"/>
          </xsl:call-template>

        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="ColourLookup">
            <xsl:with-param name="colour" select="$lc"/>
            <xsl:with-param name="language" select="'eng'"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!--<xsl:text> lights_colour </xsl:text>
    <xsl:value-of select="$lights_colour"/>
    <xsl:text> **** </xsl:text>-->
    <xsl:variable name="translatedLitchr">
      <xsl:call-template name="LitchrLookup">
        <xsl:with-param name="litchr" select="$litchar_value"/>
        <xsl:with-param name="language" select="'eng'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <xsl:when
        test="($sectr1_value != '') and ($sectr1_value != 'UNKNOWN') and ($sectr1_value !='()') and ($sectr2_value != '') and ($sectr2_value != 'UNKNOWN') and ($sectr2_value !='()')">
        <xsl:value-of
          select="concat($sectr1_value,'-',$sectr2_value,'*',$translatedLitchr,'#',$light_color)"/>

        <xsl:if test="$additionalFeatures != '' ">
          <xsl:text>,</xsl:text>
          <xsl:call-template name="get_attribute_from_feature_sectors_list_copy">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
            <xsl:with-param name="litchar_attribute" select="$litchar_attribute"/>
            <xsl:with-param name="light_colour" select="$light_colour"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>

      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:text>,</xsl:text>
          <xsl:call-template name="get_attribute_from_feature_sectors_list_copy">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
            <xsl:with-param name="litchar_attribute" select="$litchar_attribute"/>
            <xsl:with-param name="light_colour" select="$light_colour"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--  Get the attribute value  of the first matching attribute acronym  which comes from a featureid and feature acronym in the passed in lists -->
  <xsl:template name="get_attribute_from_feature_list_for_slave_inform">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>
    
    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>
    
    
    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value"/>
    <xsl:variable name="sectr1_value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym='SECTR1']/@value"/>
    <!--<xsl:text> sectr1_value </xsl:text>
    <xsl:value-of select="$sectr1_value"/>
    <xsl:text> *** </xsl:text>
    <xsl:text> INFO </xsl:text>
    <xsl:value-of select="$value"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:choose>
      <xsl:when test="($value != '') and ($value != 'UNKNOWN') and ($value !='()') and normalize-space($sectr1_value) ='' ">
        <xsl:choose>
          <xsl:when test="$additionalFeatures != ''">
          
            <xsl:value-of select="concat($value,'|')" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$value"/>
          </xsl:otherwise>
        </xsl:choose>
        
        
        <xsl:if test="$additionalFeatures != '' ">
          <!--<xsl:text> *** </xsl:text><br/>-->
         <!-- <xsl:text>&#x0A;</xsl:text>-->
          <!--<xsl:variable name="break">&lt;br&gt;</xsl:variable>-->
          <xsl:call-template name="get_attribute_from_feature_list_for_slave_inform">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
        
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <!--<xsl:text>&#x0A;</xsl:text>-->
          <!--<xsl:variable name="break">&lt;br&gt;</xsl:variable>-->
          <xsl:call-template name="get_attribute_from_feature_list_for_slave_inform">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!--  Get the attribute value  of the first matching attribute acronym  which comes from a featureid and feature acronym in the passed in lists -->
  <xsl:template name="get_attribute_from_feature_list_for_catlit">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>
    
    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>
    
    
    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value"/>
    
    <xsl:choose>
      <xsl:when test="($value != '') and ($value != 'UNKNOWN') and ($value !='()') and ($value = '1')">
        <xsl:value-of select="$value"/>
        
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_attribute_from_feature_list_for_catlit">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="tokenize_for_break">
    <xsl:param name="text"/>
    <xsl:param name="delimiter" select="'|'"/>
    <xsl:choose>
      <xsl:when test="contains($text, $delimiter)">
        <xsl:if test="substring-before($text, $delimiter) !=''">
        <xsl:value-of select="substring-before($text, $delimiter)"/>
        </xsl:if>
        <!-- recursive call -->
        <xsl:if test="substring-after($text, $delimiter) != ''">
          <br/>
        <xsl:call-template name="tokenize_for_break">
          <xsl:with-param name="text" select="substring-after($text, $delimiter)"/>
        </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- summerising sigseq of lights -->
  <xsl:template name="get_sigseq_from_feature_list">
    <xsl:param name="featureIds"/>
    <xsl:param name="featureAcronyms"/>
    <xsl:param name="attribute"/>
    
    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($featureIds,',') != ''">
          <xsl:value-of select="substring-before($featureIds,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$featureIds"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($featureIds,',')"/>
    </xsl:variable>
    
    
    <!--xsl:variable name="value" select="(/Report/Features/Feature[contains($featureIds, @fid) and contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value)[1]" /-->
    <xsl:variable name="value"
      select="key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@acronym=$attribute]/@value"/>
    <!--<xsl:variable name="count_sigseq" select="count(key('featureids', $currentfeature)[contains($featureAcronyms, @acronym)]/Attributes/Attribute[@value=$value])"/>-->
    
  <!--  <xsl:text> $value </xsl:text>
    <xsl:value-of select="string-length($value)"/>
    <xsl:text> *** </xsl:text>-->
<!--    <xsl:text>  substring_sigseq </xsl:text>
    <xsl:value-of select="$substr_value"/>
    <xsl:text> *** </xsl:text>
    <xsl:text> count substring_sigseq </xsl:text>
    <xsl:value-of select="string-length($substr_value)"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:choose>
      <xsl:when test="($value != '') and ($value != 'UNKNOWN') and ($value !='()') ">
      <xsl:choose>
        <xsl:when test="string-length($value) > 11">
          <xsl:call-template name="summarise_sigseq_from_feature_list">
            <xsl:with-param name="value" select="$value"/>
            <xsl:with-param name="number" select="1"/>
          </xsl:call-template>
        </xsl:when>
        <!--<xsl:when test="string-length($value) > 10">
          <xsl:variable name="substr_value">
            <xsl:value-of select="substring($value,1,10)"/>
          </xsl:variable>
          <!-\-<xsl:text> $substr_value </xsl:text>
          <xsl:value-of select="$substr_value"/>
          <xsl:text> *** </xsl:text>
          <xsl:text> string value </xsl:text>
          <xsl:value-of select="substring-after($value,$substr_value)"/>
          <xsl:text> *** </xsl:text>-\->
          <xsl:choose>
            <xsl:when test=""></xsl:when>
          </xsl:choose>
        </xsl:when>-->
        <xsl:otherwise>
          <xsl:value-of select="concat($value,'$)')"/>
        </xsl:otherwise>
      </xsl:choose>
        
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$additionalFeatures != '' ">
          <xsl:call-template name="get_sigseq_from_feature_list">
            <xsl:with-param name="featureIds" select="$additionalFeatures"/>
            <xsl:with-param name="attribute" select="$attribute"/>
            <xsl:with-param name="featureAcronyms" select="$featureAcronyms"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="summarise_sigseq_from_feature_list">
    <xsl:param name="value"/>
    <xsl:param name="number"/>
    <xsl:param name="old_sigseq"/>
    <xsl:param name="next_value"/>
    <xsl:param name="additional_value"/>
    <xsl:variable name="additional_val" select="concat($additional_value,$old_sigseq)"/>
    <xsl:choose>
      <xsl:when test="$old_sigseq =''">
        <xsl:variable name="substr_value">
          <xsl:value-of select="substring($value,1,11)"/>
        </xsl:variable>
        <xsl:variable name="additionalValue">
          <xsl:value-of select="substring-after($value,$substr_value)"/>
        </xsl:variable>
        <xsl:variable name="next_sigseq">
          <xsl:value-of select="substring($additionalValue,2,11)"/>
        </xsl:variable>
        <xsl:variable name="add_val" select="concat($substr_value,'+',$next_sigseq)"/>
        <!--<xsl:text> value </xsl:text>
        <xsl:value-of select="$value"/>
        <xsl:text> *** </xsl:text>-->
        <!--<xsl:text> add_val </xsl:text>
        <xsl:value-of select="$add_val"/>
        <xsl:text> *** </xsl:text>-->
        <xsl:if test="string-length($additionalValue) >= 10">
          <xsl:choose>
            <xsl:when test="$substr_value = $next_sigseq">
              <xsl:choose>
                <xsl:when test="string-length($add_val) = string-length($value)">
                 
                  <xsl:value-of select="$substr_value"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="next_val" select="substring($value,25,11)"/>
                  <xsl:variable name="add_value" select="substring($value,1,24)"/>
                  
                 <!-- <xsl:text> $substr_value = $next_sigseq </xsl:text>
                  <xsl:text> additional_value </xsl:text>
                  <xsl:value-of select="$add_value"/>
                  <xsl:text> *** </xsl:text>
                  <xsl:text> next_value </xsl:text>
                  <xsl:value-of select="$next_val"/>
                  <xsl:text> *** </xsl:text>
                  <xsl:text> old_sigseq </xsl:text>
                  <xsl:value-of select="$next_sigseq"/>
                  <xsl:text> *** </xsl:text>-->
                  <xsl:call-template name="summarise_sigseq_from_feature_list">
                    <xsl:with-param name="value" select="$value"/>
                    <xsl:with-param name="number" select="$number+1"/>
                    <xsl:with-param name="old_sigseq" select="$next_sigseq"/>
                    <xsl:with-param name="next_value" select="$next_val"/>
                    <xsl:with-param name="additional_value" select="$add_value"/>
                  </xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat($substr_value,'+')"/>
              <xsl:choose>
                <xsl:when test="string-length($add_val) = string-length($value)">
                  <xsl:value-of select="$next_sigseq"/>
                </xsl:when>
                <xsl:otherwise>
                  <!--<xsl:variable name="next_val" select="substring-after($value,substring($value,1,24))"/>-->
                  
                  <xsl:variable name="add_value" select="substring($value,1,24)"/>
                  <!--<xsl:variable name="next_val" select="substring(substring-after($value,concat($substr_value,'+')),1,11)"/>-->
                  <xsl:variable name="next_val" select="substring(substring-after($value,$add_value),1,11)"/>
                  
                 <!-- <xsl:text> $substr_value != $next_sigseq </xsl:text>
                  <xsl:text> additional_value </xsl:text>
                  <xsl:value-of select="$add_value"/>
                  <xsl:text> *** </xsl:text>
                  <xsl:text> next_value </xsl:text>
                  <xsl:value-of select="$next_val"/>
                  <xsl:text> *** </xsl:text>
                  <xsl:text> old_sigseq </xsl:text>
                  <xsl:value-of select="$next_sigseq"/>
                  <xsl:text> *** </xsl:text>-->
                  
                  <xsl:call-template name="summarise_sigseq_from_feature_list">
                    <xsl:with-param name="value" select="$value"/>
                    <xsl:with-param name="number" select="$number"/>
                    <xsl:with-param name="old_sigseq" select="$next_sigseq"/>
                    <xsl:with-param name="next_value" select="$next_val"/>
                    <xsl:with-param name="additional_value" select="$add_value"/>
                  </xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
              
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <!--<xsl:text> second flow </xsl:text>-->
        <xsl:if test="$next_value !=''">
          <xsl:choose>
            <xsl:when test="$next_value = $old_sigseq">
             <!-- <xsl:text> $next_value = $old_sigseq </xsl:text>-->
              <xsl:choose>
                <xsl:when test="string-length($additional_value) = string-length($value)">
                  <!--<xsl:text> string-length($additional_val) = string-length($value) </xsl:text>-->
                  <xsl:value-of select="concat($next_value,'*',$number+1,'$)')"/>
                </xsl:when>
                <xsl:otherwise>
                  <!--<xsl:text> string-length($additional_val) != string-length($value) </xsl:text>-->
                  <!--<xsl:variable name="nxt_val"><xsl:value-of select="substring(substring-after($value,concat($additional_value,'+')),1,11)"/></xsl:variable>-->
                  <xsl:variable name="add_val" select="concat($additional_value,concat($next_value,'+'))"/>
                  <xsl:variable name="nxt_val"><xsl:value-of select="substring(substring-after($value,$add_val),1,11)"/></xsl:variable>
                  <!--<xsl:variable name="nxt_val"><xsl:value-of select="concat(substring-before(substring(substring-after($value,$additional_value),1,15),')'),')')"/></xsl:variable>-->
                  <xsl:variable name="val" select="$number"/>
                  <!--<xsl:variable name="add_val" select="substring($value,1,string-length($nxt_val)*$val+$val)"/>-->
                 <!-- <xsl:text> subtring </xsl:text>
                  <xsl:value-of select="substring(substring-after($value,$add_val),1,12)"/>
                  <xsl:text> *** </xsl:text>
                  <xsl:text> additional_value </xsl:text>
                  <xsl:value-of select="$add_val"/>
                  <xsl:text> *** </xsl:text>
                  <xsl:text> next_value </xsl:text>
                  <xsl:value-of select="$nxt_val"/>
                  <xsl:text> *** </xsl:text>
                  <xsl:text> old_sigseq </xsl:text>
                  <xsl:value-of select="$next_value"/>
                  <xsl:text> *** </xsl:text>-->
                  <xsl:call-template name="summarise_sigseq_from_feature_list">
                    <xsl:with-param name="value" select="$value"/>
                    <xsl:with-param name="number" select="$number+1"/>
                    <xsl:with-param name="old_sigseq" select="$next_value"/>
                    <xsl:with-param name="next_value" select="$nxt_val"/>
                    <xsl:with-param name="additional_value" select="$add_val"/>
                  </xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <!--<xsl:text> $next_value != $old_sigseq </xsl:text>-->
              <xsl:choose>
                <xsl:when test="string-length($additional_value) = string-length($value)">
                  <!--<xsl:text> string-length($additional_val) = string-length($value) </xsl:text>-->
                  <xsl:value-of select="concat($next_value,'*',$number,'$)')"/>
                </xsl:when>
                <xsl:otherwise>
                  <!--<xsl:text> string-length($additional_val) != string-length($value) </xsl:text>-->
                  <xsl:value-of select="concat($old_sigseq,'*',$number,'$)')"/>
                  
                  <!--<xsl:variable name="nxt_val"><xsl:value-of select="substring(substring-after($value,$additional_value),1,12)"/></xsl:variable>-->
                  <xsl:variable name="nxt_val"><xsl:value-of select="concat(substring-before(substring(substring-after($value,$additional_value),1,15),')'),')')"/></xsl:variable>
                  <xsl:variable name="add_val" select="concat(substring-before($value,$nxt_val),$nxt_val)"/>
                  <!--<xsl:text> substring  </xsl:text>
                  <xsl:value-of select="concat(substring-before(substring(substring-after($value,$additional_value),1,15),')'),')')"/>
                  <xsl:text> *** </xsl:text>
                  <xsl:text> additional_value </xsl:text>
                  <xsl:value-of select="$add_val"/>
                  <xsl:text> *** </xsl:text>
                  <xsl:text> next_value </xsl:text>
                  <xsl:value-of select="$nxt_val"/>
                  <xsl:text> *** </xsl:text>
                  <xsl:text> old_sigseq </xsl:text>
                  <xsl:value-of select="$old_sigseq"/>
                  <xsl:text> *** </xsl:text>-->
                  <xsl:if test="string-length($nxt_val) >10">
                  <xsl:call-template name="summarise_sigseq_from_feature_list">
                    <xsl:with-param name="value" select="$value"/>
                    <xsl:with-param name="number" select="1"/>
                    <xsl:with-param name="old_sigseq" select="$old_sigseq"/>
                    <xsl:with-param name="next_value" select="$nxt_val"/>
                    <xsl:with-param name="additional_value" select="$add_val"/>
                  </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>
  <xsl:template name="summarise_FormatLitSigseq">
    <xsl:param name="sigseq"/>
    <xsl:param name="colour"/>
    <xsl:param name="lang"/>
    <!--
    <xsl:text> FormatSigseq </xsl:text>
    <xsl:value-of select="$sigseq"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:variable name="firstLine">
      <xsl:choose>
        <xsl:when test="contains($sigseq,'*')">
          <xsl:value-of select="substring-before($sigseq,'$' )"/>
        </xsl:when>
        <xsl:otherwise>
          <!--<xsl:value-of select="concat(substring-before($sigseq, ')'), ')' )"/>-->
          <!--<xsl:value-of select="substring-before($sigseq,'$' )"/>-->
          <!-- Testing*******272 -->
          <xsl:choose>
            <xsl:when test="contains($sigseq,'$')">
              <xsl:value-of select="substring-before($sigseq,'$' )"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$sigseq"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalLines"
      select="substring-after($sigseq, '$)')"/>
    <!--<xsl:text> firstLine </xsl:text>
    <xsl:value-of select="$firstLine"/>
    <xsl:text> *** </xsl:text>
    <xsl:text> additionalLines </xsl:text>
    <xsl:value-of select="$additionalLines"/>
    <xsl:text> *** </xsl:text>-->
    <!--First - <xsl:value-of select="$firstLine"/> $$$$
  Add -\-\- <xsl:value-of select="$additionalLines"/>-->
    <xsl:variable name="firstColour">
      <xsl:if test="substring-before($colour, ',') != '' ">
        <xsl:value-of select="substring-before($colour, ',')"/>
      </xsl:if>
      <xsl:if test="substring-before($colour, ',') = '' ">
        <xsl:value-of select="$colour"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="translatedColour">
      <xsl:call-template name="ColourLookup">
        <xsl:with-param name="colour" select="$firstColour"/>
        <xsl:with-param name="language" select="$lang"/>
      </xsl:call-template>
    </xsl:variable>
    <!--<xsl:text> first line </xsl:text>
    <xsl:value-of select="$firstLine"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:choose>
      <xsl:when test="contains($firstLine,'*')"> 
        <xsl:variable name="value" select="substring-after($firstLine,'*')"/>
        <xsl:variable name="val">
          <xsl:if test="$value >= 2">
            <xsl:value-of select="$value"/>
          </xsl:if>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$value >=2">
            <xsl:if test="normalize-space($firstLine) != ''">
              
              <xsl:if test="$lang = 'eng' ">
                <i>
                  <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                  <xsl:value-of
                    select="concat('(fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'),') x ',$value)"/>
                  <xsl:if test="(normalize-space($additionalLines))">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </i>
              </xsl:if>
              <xsl:if test="$lang = 'nat' ">
                <i>
                  <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                  <xsl:value-of
                    select="concat('fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
                  <xsl:if test="(normalize-space($additionalLines))">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </i>
              </xsl:if>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="normalize-space($firstLine) != ''">
              
              <xsl:if test="$lang = 'eng' ">
                <i>
                  <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                  <xsl:value-of
                    select="concat('fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
                  <xsl:if test="(normalize-space($additionalLines))">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </i>
              </xsl:if>
              <xsl:if test="$lang = 'nat' ">
                <i>
                  <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                  <xsl:value-of
                    select="concat('fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
                  <xsl:if test="(normalize-space($additionalLines))">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </i>
              </xsl:if>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="normalize-space($firstLine) != ''">
        <xsl:choose>
          
          <xsl:when test="contains(substring($firstLine,1,1),'(')">

           <!-- <xsl:text>first line  </xsl:text>
            <xsl:value-of select="$firstLine"/>
            <xsl:text> *** </xsl:text>-->
            <xsl:if test="$lang = 'eng' ">
              <!--<xsl:text>first string contains  </xsl:text>
              <xsl:value-of select="format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##')"/>
              <xsl:text> *** </xsl:text>
              <xsl:text> sub string after </xsl:text>
              <xsl:value-of select="format-number(translate(number(substring-after($firstLine,'+')), '.', '.'), '0.##')"/>-->

              <!-- NTM-272# Made the changes for the multiple lights i.e. <Attribute acronym="SIGSEQ" value="(01.0)+01.0+(01.0)+03.0"/> in ec/fl format, if <Attribute acronym="LITCHR" value="8"/> -->
              <!--<i>
                <xsl:value-of
                  select="concat('fl ',format-number(translate(number(substring-after($firstLine,'+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
                <xsl:if test="(normalize-space($additionalLines))">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </i>-->
              
              <xsl:if test="string-length($firstLine) > 11 and not(contains($firstLine,'*')) and not(contains($firstLine,'*'))">
                <xsl:variable name="num1">
                  <xsl:value-of select="substring($firstLine,1,11)"/>
                </xsl:variable>
                <xsl:variable name="num2">
                  <xsl:value-of select="substring(substring-after($firstLine,substring($firstLine,1,11)),2)"/>
                </xsl:variable>

                <xsl:if test="normalize-space($num1) != ''">
                  <i>
                    <xsl:value-of
                      select="concat('ec ',format-number(translate(number(substring-before(substring-after($num1, '('), ')' )), '.', '.'), '0.##'), ', fl ',format-number(translate(number(substring-after($num1,'+')), '.', '.'), '0.##'))"/>
                    <xsl:if test="(normalize-space($additionalLines))">
                      <xsl:text>, </xsl:text>
                    </xsl:if>
                  </i>
                </xsl:if>
                <xsl:if test="normalize-space($num2) != ''">
                  <br/>
                  <i>
                    <xsl:value-of
                      select="concat('ec ',format-number(translate(number(substring-before(substring-after($num2, '('), ')' )), '.', '.'), '0.##'), ', fl ',format-number(translate(number(substring-after($num2,'+')), '.', '.'), '0.##'))"/>
                    <xsl:if test="(normalize-space($additionalLines))">
                      <xsl:text>, </xsl:text>
                    </xsl:if>
                  </i>
                </xsl:if>
                
              </xsl:if>
              
              <xsl:if test="string-length($firstLine) &lt;= 11">
              <i>
                <xsl:value-of
                  select="concat('ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'), ', fl ',format-number(translate(number(substring-after($firstLine,'+')), '.', '.'), '0.##'))"/>
                <xsl:if test="(normalize-space($additionalLines))">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </i>
              </xsl:if>
            </xsl:if>
            
            <xsl:if test="$lang = 'nat' ">
              <i>
                <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                <xsl:value-of
                  select="concat('fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
                <xsl:if test="(normalize-space($additionalLines))">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </i>
            </xsl:if>
            
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="$lang = 'eng' ">
              <xsl:text> flash </xsl:text>
              <xsl:value-of select="translate(translate(translate(substring-before($firstLine, '+'), '.', '.'),'(',''),')','')"/>
              <xsl:text> *** </xsl:text>
              <i>
                <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                <!--<xsl:value-of
                select="concat('fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>-->
                <xsl:value-of
                  select="concat('fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
                <xsl:if test="(normalize-space($additionalLines))">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </i>
            </xsl:if>
            <xsl:if test="$lang = 'nat' ">
              <i>
                <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                <xsl:value-of
                  select="concat('fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
                <xsl:if test="(normalize-space($additionalLines))">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </i>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose> 
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
    
    <xsl:if test="normalize-space($additionalLines) != '' ">
      <xsl:call-template name="summarise_FormatLitSigseq">
        <xsl:with-param name="sigseq" select="$additionalLines"/>
        <xsl:with-param name="colour" select="$firstColour"/>
        <xsl:with-param name="lang" select="$lang"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="normalize-space($additionalLines) = '' ">
      <br/>
    </xsl:if>
  </xsl:template>
  <xsl:template name="summarise_FormatSigseq">
    <xsl:param name="sigseq"/>
    <xsl:param name="colour"/>
    <xsl:param name="lang"/>
    
     <!--<xsl:text> FormatSigseq </xsl:text>
    <xsl:value-of select="$sigseq"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:variable name="firstLine">
      <xsl:choose>
        <xsl:when test="not(contains(substring($sigseq,1,15),'*'))">
          <xsl:value-of select="concat(substring-before($sigseq,')'),')')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="contains($sigseq,'*')">
              <xsl:value-of select="substring-before($sigseq,'$' )"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat(substring-before($sigseq, ')'), ')' )"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="additionalLines">
      <xsl:choose>
        <xsl:when test="not(contains(substring($sigseq,1,15),'*'))">
          <xsl:value-of select="substring-after($sigseq,')+')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-after($sigseq, '$)')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
     <!--<xsl:text> firstLine </xsl:text>
    <xsl:value-of select="$firstLine"/>
    <xsl:text> *** </xsl:text>
    <xsl:text> additionalLines </xsl:text>
    <xsl:value-of select="$additionalLines"/>
    <xsl:text> *** </xsl:text>-->
    <!--First - <xsl:value-of select="$firstLine"/> $$$$
  Add -\-\- <xsl:value-of select="$additionalLines"/>-->
    <xsl:variable name="firstColour">
      <xsl:if test="substring-before($colour, ',') != '' ">
        <xsl:value-of select="substring-before($colour, ',')"/>
      </xsl:if>
      <xsl:if test="substring-before($colour, ',') = '' ">
        <xsl:value-of select="$colour"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="translatedColour">
      <xsl:call-template name="ColourLookup">
        <xsl:with-param name="colour" select="$firstColour"/>
        <xsl:with-param name="language" select="$lang"/>
      </xsl:call-template>
    </xsl:variable>
  <!--  <xsl:text> first line </xsl:text>
    <xsl:value-of select="$firstLine"/>
    <xsl:text> *** </xsl:text>-->
    <xsl:choose>
      <xsl:when test="contains($firstLine,'*')"> 
        <xsl:variable name="value" select="substring-after($firstLine,'*')"/>
        <xsl:variable name="val">
          <xsl:if test="$value >= 2">
          <xsl:value-of select="$value"/>
          </xsl:if>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$value >=2">
            <xsl:if test="normalize-space($firstLine) != ''">
              
              <xsl:if test="$lang = 'eng' ">
                <i>
                  <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                  <xsl:value-of
                    select="concat('(fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'),') x ',$value)"/>
                  <xsl:if test="(normalize-space($additionalLines))">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </i>
              </xsl:if>
              <xsl:if test="$lang = 'nat' ">
                <i>
                  <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                  <xsl:value-of
                    select="concat('fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
                  <xsl:if test="(normalize-space($additionalLines))">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </i>
              </xsl:if>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="normalize-space($firstLine) != ''">
              
              <xsl:if test="$lang = 'eng' ">
                <i>
                  <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                  <xsl:value-of
                    select="concat('fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
                  <xsl:if test="(normalize-space($additionalLines))">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </i>
              </xsl:if>
              <xsl:if test="$lang = 'nat' ">
                <i>
                  <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
                  <xsl:value-of
                    select="concat('fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
                  <xsl:if test="(normalize-space($additionalLines))">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </i>
              </xsl:if>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
       
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="normalize-space($firstLine) != ''">
          
          <xsl:if test="$lang = 'eng' ">
            <i>
              <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
              <xsl:value-of
                select="concat('fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
              <xsl:if test="(normalize-space($additionalLines))">
                <xsl:text>, </xsl:text>
              </xsl:if>
            </i>
          </xsl:if>
          <xsl:if test="$lang = 'nat' ">
            <i>
              <!--<xsl:value-of select="concat('fl ', translate(number(substring-before($firstLine, '+')), '.', '.'), ', ec ', translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'))" />-->
              <xsl:value-of
                select="concat('fl ',format-number(translate(number(substring-before($firstLine, '+')), '.', '.'), '0.##'), ', ec ',format-number(translate(number(substring-before(substring-after($firstLine, '('), ')' )), '.', '.'), '0.##'))"/>
              <xsl:if test="(normalize-space($additionalLines))">
                <xsl:text>, </xsl:text>
              </xsl:if>
            </i>
          </xsl:if>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
    
    <xsl:if test="normalize-space($additionalLines) != '' ">
      <xsl:call-template name="summarise_FormatSigseq">
        <xsl:with-param name="sigseq" select="$additionalLines"/>
        <xsl:with-param name="colour" select="$firstColour"/>
        <xsl:with-param name="lang" select="$lang"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="normalize-space($additionalLines) = '' ">
      <br/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="@*|node()"/>
</xsl:transform>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="EnglishTemplates.xsl"/>

  <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

  <!-- Sample Template to convert selected feature(s) from a Paper chart panel or from a panel's project review layer -->
  <!-- This only recognizes a few sample S-57 object classes and is not intended for productio use -->
  
  <!-- April 2020, Edited by CARIS to better match HPD 4.0 functionality 
  Use gml positions to allow notices to be viewed in Source editor and to make queries for overlapping panels etc more effective.
  Initially add additional records but leave code populating obsolete LATITUDE, LONGITUDE 
  Changes in   <xsl:template match="Point"> and in code to generate modified sounding and moved feature instructions.

  Adjust Notice instruction link to panel to use INSTRUCTION_PANEL_LIST, for the time being leave code that populates now obsolete CHART_LIST structure. Changes related to this are confined to  <xsl:template name="ChartList">
  -->

  <!-- Include other stylesheets -->
  <!-- Swap the language based templates with other languages -->
  <xsl:variable name="masterFeatures" select="'BCNCAR,BCNISD,BCNLAT,BCNSAW,BCNSPP,BOYCAR,BOYINB,BOYISD,BOYLAT,BOYSAW,BOYSPP,LNDMRK,LITFLT,LITVES,MORFAC,OFSPLF,PILPNT,BUISGL,BRIDGE,SLCONS,CRANES,FLODOC,FORSTC,FSHFAC,HULKES,PONTON,PYLONS,SILTNK'"/> 
  <xsl:variable name="slaveFeatures" select="'DAYMAR,LIGHTS,RADSTA,TOPMAR,FOGSIG,RDOSTA,RTPBCN,SISTAW,SISTAT,RETRFL'"/>
  <xsl:variable name="blockedattributes" select="'SORDAT,SORIND,SOUACC,SURATH,SUREND,SURSTA,SURTYP,TIMEND,TIMSTA,TS_TSV,T_ACWL,T_HWLW,T_MTOD,T_THDF,T_TINT,T_TSVL,T_VAHC,VALMXR,VERDAT,CLSDEF,CLSNAM,SYMINS,MARSYS'"/>
  
  <!--select="'BOYSPP'"/>-->
    
  <!-- These are the templates for features and attributes etc -->
  <!-- Root template -->
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="count(Report/Changes/ChangedFeature[not(@edit='unchanged')]) &gt; 0">
        <xsl:apply-templates select="Report/Changes"/>
        <!-- For selections made from project review layers -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="Report/Selection"/>
        <!-- For selections made from other layers -->
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <!-- Report/Changes template -->
  <xsl:template match="Changes">
    <xsl:element name="Instructions">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <!-- Report/Selection template -->
  <xsl:template match="Selection">
    <xsl:element name="Instructions">
      <xsl:apply-templates select="SelectedFeature"/>
    </xsl:element>
  </xsl:template>

  <!-- Report/Changes/Feature template -->
  <xsl:template match="ChangedFeature[not(@edit='unchanged')]">
    <xsl:variable name="foid" select="@fid"/>
    <xsl:variable name="c-features-master">
      <xsl:for-each select="/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature">
        <xsl:if test="contains($masterFeatures,./@acronym)">
          <xsl:value-of select="'yes'"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="only-slaves-first-foid">
      <xsl:if test="not(contains($masterFeatures,../../Features/Feature[@fid=$foid]/@acronym))
        and count(/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature) > 1
        and not(normalize-space($c-features-master))">
        <xsl:for-each select="/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature">
          <xsl:if test="position()=1">
            <xsl:value-of select="/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature[1]/@fid"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
    </xsl:variable>
    
    <xsl:variable name="count_of_filteredattributes">
      <xsl:value-of select="count(../ChangedFeature[@fid = $foid]/AttributeEdit[contains($blockedattributes,@acronym)])"/>
    </xsl:variable>
        
    <xsl:variable name="count_of_all_attributes">
    <xsl:value-of select="count(../ChangedFeature[@fid = $foid]/AttributeEdit)"/>
    </xsl:variable>
    <xsl:variable name="count_of_attributes_without_filteredattributes" select="$count_of_all_attributes - $count_of_filteredattributes"/>
   
   <xsl:choose>
      <!-- There is no collocated features associated with this feature;-->
      <xsl:when test="count(/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature)=1">
        <xsl:choose>
          <!--<xsl:if test="not(contains($blockedattributes,./@acronym))">-->
          <xsl:when test="count(../ChangedFeature[@fid = $foid]/AttributeEdit[contains($blockedattributes,@acronym)])">
            <xsl:choose>
              <xsl:when test="$count_of_attributes_without_filteredattributes &gt;= 1">
                
                <xsl:call-template name="generateInstruction">
                  <xsl:with-param name="foid" select="$foid"/>
                  <xsl:with-param name="single" select="'yes'"/>
                  <xsl:with-param name="only-slaves" select="'nothing'"/>
                </xsl:call-template>  
              </xsl:when>
              <xsl:otherwise>
                <!--  no need to generate the instructions-->
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          
          <xsl:otherwise>
            <xsl:call-template name="generateInstruction">
              <xsl:with-param name="foid" select="$foid"/>
              <xsl:with-param name="single" select="'yes'"/>
              <xsl:with-param name="only-slaves" select="'nothing'"/>
            </xsl:call-template>  
          </xsl:otherwise>
        </xsl:choose>
        
       </xsl:when>
      <xsl:when test="not(contains($masterFeatures,../../Features/Feature[@fid=$foid]/@acronym))
        and not(contains($slaveFeatures,../../Features/Feature[@fid=$foid]/@acronym))
        and count(/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature) > 1">
        
        <xsl:call-template name="generateInstruction">
          <xsl:with-param name="foid" select="$foid"/>
          <xsl:with-param name="sigle" select="'yes'"/>
          <xsl:with-param name="only-slaves" select="'nothing'"/>
          <xsl:with-param name="other-feature" select="'yes'"/>
        </xsl:call-template>
      </xsl:when>
      
      <xsl:when test="not(contains($masterFeatures,../../Features/Feature[@fid=$foid]/@acronym))
        and count(/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature) > 1
        and not(normalize-space($c-features-master))">
        
        <xsl:call-template name="generateInstruction">
          <xsl:with-param name="foid" select="$foid"/>
          <xsl:with-param name="only-slaves" select="$only-slaves-first-foid"/>
        </xsl:call-template>
      </xsl:when>
      <!-- Collocated Feature but there is no master feature in the collocated list;-->
      <xsl:when test="count(/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature) > 1
        and not(normalize-space($c-features-master))
        and (normalize-space($c-features-master))">
        
        <xsl:call-template name="generateInstruction">
          <xsl:with-param name="foid" select="$foid"/>
          <xsl:with-param name="single" select="'yes'"/>
          <xsl:with-param name="only-slaves" select="'nothing'"/>
        </xsl:call-template>
      </xsl:when>
      <!-- Collocated Master Feature -->
      <xsl:when test="(contains($masterFeatures,../../Features/Feature[@fid=$foid]/@acronym))
        and count(/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature) > 1">
        
        <xsl:call-template name="generateInstruction">
          <xsl:with-param name="foid" select="$foid"/>
          <xsl:with-param name="only-slaves" select="'nothing'"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>    
  </xsl:template>

  <!-- Report/Selection/Feature template -->
  <xsl:template match="SelectedFeature">
    <xsl:variable name="foid" select="@fid"/>
    <xsl:variable name="c-features-master">
      <xsl:for-each select="/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature">
        <xsl:if test="contains($masterFeatures,./@acronym)">
          <xsl:value-of select="'yes'"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="only-slaves-first-foid">
      <xsl:if test="not(contains($masterFeatures,../../Features/Feature[@fid=$foid]/@acronym))
        and count(/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature) > 1
        and not(normalize-space($c-features-master))">
        <xsl:for-each select="/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature">
        <xsl:if test="position()=1">
          <xsl:value-of select="/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature[1]/@fid"/>
        </xsl:if>
      </xsl:for-each>
      </xsl:if>
    </xsl:variable>
    
    <xsl:choose>
      <!-- There is no collocated features associated with this feature;-->
      <xsl:when test="count(/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature)=1">
        
        <xsl:call-template name="generateInstruction">
          <xsl:with-param name="foid" select="$foid"/>
          <xsl:with-param name="single" select="'yes'"/>
          <xsl:with-param name="only-slaves" select="'nothing'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="not(contains($masterFeatures,../../Features/Feature[@fid=$foid]/@acronym))
        and not(contains($slaveFeatures,../../Features/Feature[@fid=$foid]/@acronym))
        and count(/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature) > 1">
        <xsl:call-template name="generateInstruction">
          <xsl:with-param name="foid" select="$foid"/>
          <xsl:with-param name="sigle" select="'yes'"/>
          <xsl:with-param name="only-slaves" select="'nothing'"/>
          <xsl:with-param name="other-feature" select="'yes'"/>
        </xsl:call-template>
      </xsl:when>
      
      <xsl:when test="not(contains($masterFeatures,../../Features/Feature[@fid=$foid]/@acronym))
        and count(/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature) > 1
        and not(normalize-space($c-features-master))">
        
        <xsl:call-template name="generateInstruction">
          <xsl:with-param name="foid" select="$foid"/>
          <xsl:with-param name="only-slaves" select="$only-slaves-first-foid"/>
        </xsl:call-template>
      </xsl:when>
      <!-- Collocated Feature but there is no master feature in the collocated list;-->
      <xsl:when test="count(/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature) > 1
        and not(normalize-space($c-features-master))
        and (normalize-space($c-features-master))">
        <xsl:call-template name="generateInstruction">
          <xsl:with-param name="foid" select="$foid"/>
          <xsl:with-param name="single" select="'yes'"/>
          <xsl:with-param name="only-slaves" select="'nothing'"/>
        </xsl:call-template>
      </xsl:when>
      <!-- Collocated Master Feature -->
      <xsl:when test="(contains($masterFeatures,../../Features/Feature[@fid=$foid]/@acronym))
                  and count(/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature) > 1">
        
        <xsl:call-template name="generateInstruction">
          <xsl:with-param name="foid" select="$foid"/>
          <xsl:with-param name="only-slaves" select="'nothing'"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>    
  </xsl:template>

  <xsl:template name="generateInstruction">
    <xsl:param name="foid"/>
    <xsl:param name="single"/>
    <xsl:param name="only-slaves"/>
    <xsl:param name="other-feature"/>
    
    
   <!-- <xsl:text> collocated </xsl:text>
    <xsl:value-of select="/Report/Locations/Location/"/>
    <xsl:text> END </xsl:text>-->
    <xsl:variable name="neglecting_delete">
      
    <xsl:if test="normalize-space(@edit)='deleted'">
      <xsl:variable name="delete_fid" select="@fid"/>
     
      <xsl:variable name="matching_with_collocated" >
        
        <xsl:choose>
          <xsl:when test="count(/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature) > 1">
            
            <xsl:value-of select="/Report/Locations/Location/CollocatedFeature[@fid=$delete_fid]/@fid"/>
          </xsl:when>
          <xsl:otherwise>
            <!-- feature is not deleted -->
          </xsl:otherwise>
        </xsl:choose>
        
      </xsl:variable>
      <xsl:value-of select="$matching_with_collocated" />
      
    </xsl:if>
    </xsl:variable>
   
    
    <xsl:if test="(normalize-space($only-slaves) and $only-slaves=$foid ) or $only-slaves='nothing' ">
     <!-- <xsl:text> count </xsl:text>
      <xsl:value-of select="count(/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature)"/>
      <xsl:text> *** </xsl:text>-->
      <xsl:if test="$neglecting_delete !=$foid or count(../../../Report/Changes/ChangedFeature) = count(../../../Report/Changes/ChangedFeature[@edit='deleted'])">
      
    <xsl:element name="NM_CHARTINSTRUCT">
      
      <xsl:variable name="min_x">
      <xsl:value-of select="../../../Report/Changes/ChangedFeature[@fid = $foid]/Cover/MinPoint/X"/>
      </xsl:variable>
      
      <xsl:variable name="min_y">
      <xsl:value-of select="../../../Report/Changes/ChangedFeature[@fid = $foid]/Cover/MinPoint/Y"/>
      </xsl:variable>
      
      <xsl:variable name="max_x">
      <xsl:value-of select="../../../Report/Changes/ChangedFeature[@fid = $foid]/Cover/MaxPoint/X"/>
      </xsl:variable>
      
      <xsl:variable name="max_y">
      <xsl:value-of select="../../../Report/Changes/ChangedFeature[@fid = $foid]/Cover/MaxPoint/Y"/>
      </xsl:variable>
      
      <!-- generating from generic selection assume insert action -->
        
      
      <xsl:element name="ACTION">
      <xsl:choose>
        <xsl:when test="normalize-space(@edit)='deleted'"><xsl:text>Delete</xsl:text></xsl:when>
        
       <xsl:when test="normalize-space(@edit)='modified' and normalize-space(@previous_acronym)"><xsl:text>Replace</xsl:text></xsl:when>
        
        <xsl:when test="normalize-space(@edit)='modified' and normalize-space(@acronym)='SOUNDG'"><xsl:text>Replace</xsl:text></xsl:when>
        
        <xsl:when test="normalize-space(@edit)='modified' and normalize-space(@acronym) !='SOUNDG'">
          <!-- Other than Point features -->
          <xsl:variable name="afid" select="@fid"/>
          <xsl:variable name="EEditsValue" select="/Report/Changes/ChangedFeature[@fid=$afid]/EdgeEdits"/>
          
          <xsl:variable name="AEditValue" select="/Report/Changes/ChangedFeature[@fid=$afid]/AttributeEdit"/>          
          <xsl:choose>
            <xsl:when test="$EEditsValue">
              <xsl:choose>
                <xsl:when test="not($min_x = $max_x) or not($min_y = $max_y)"><xsl:text>Modify</xsl:text></xsl:when>
              </xsl:choose>
           </xsl:when>            
            <xsl:when test="$AEditValue"><xsl:text>Modify</xsl:text></xsl:when>
            <!-- Point features -->
           <xsl:otherwise>
             <xsl:choose>
               <xsl:when test="not($min_x = $max_x) or not($min_y = $max_y)"><xsl:text>Move</xsl:text></xsl:when>
             </xsl:choose>
           </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="normalize-space(@edit)='new'">
            <xsl:variable name="fid" select="@fid"/>
          <xsl:choose>
            <xsl:when test="count(/Report/Locations/Location/CollocatedFeature[@fid=$fid]/../CollocatedFeature) > 1">
              <!-- Assumeing combination of actions (new,new - insert),(new,delete - replace) in collocated -->
              <xsl:variable name="collocatedFids">
              <xsl:for-each select="/Report/Locations/Location/CollocatedFeature[@fid=$fid]/../CollocatedFeature">
                <xsl:if test="@fid != $fid">
                <xsl:value-of select="@fid"/>
                </xsl:if>
                <xsl:if test="position() != last() and @fid != $fid">
                  <xsl:text>,</xsl:text>  
                </xsl:if>
                
              </xsl:for-each>
              </xsl:variable>
             
              <xsl:call-template name="collocated_actions_with_new">
                <xsl:with-param name="collocated_Fids" select="$collocatedFids"/>
              </xsl:call-template>
              
            </xsl:when>
            <xsl:otherwise><xsl:text>Insert</xsl:text></xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
         <xsl:text>Insert</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      </xsl:element>
      <xsl:variable name="fid" select="@fid"/>
     
      <xsl:variable name="collocatedFids">
        <xsl:for-each select="/Report/Locations/Location/CollocatedFeature[@fid=$fid]/../CollocatedFeature">
          <xsl:if test="@fid != $fid">
            <xsl:value-of select="@fid"/>
          </xsl:if>
          <xsl:if test="position() != last() and @fid != $fid">
            <xsl:text>,</xsl:text>  
          </xsl:if>
          
        </xsl:for-each>
      </xsl:variable>
      <xsl:variable name="action_of_other_feature">
      <xsl:call-template name="collocated_actions_with_new">
        <xsl:with-param name="collocated_Fids" select="$collocatedFids"/>
      </xsl:call-template>
      </xsl:variable>
   <!--   <xsl:text> action_of_other_feature </xsl:text>
      <xsl:value-of select="$action_of_other_feature"/>
      <xsl:text> END </xsl:text>-->
      <xsl:choose>
        <xsl:when test="$foid">
          <xsl:choose>
            <xsl:when test="normalize-space(@edit)='modified' and normalize-space(@previous_acronym)">
              <xsl:element name="DESCRIPTION">
                <xsl:call-template name="lookupFeature">
                  <xsl:with-param name="featureClass" select="@previous_acronym"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$alias_with"/>
                <xsl:text> </xsl:text>
                
                <!-- Describe the feature if there is a template, default template will echo acronym -->
                <xsl:apply-templates select="/Report/Features/Feature[@fid=$foid]"/>
              </xsl:element>
            </xsl:when>
            <xsl:when test="normalize-space(@edit)='modified' and count(./AttributeEdit) &gt; 0 and normalize-space(@acronym) !='SOUNDG' ">
              <xsl:element name="DESCRIPTION"> 
                <xsl:for-each select="/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature">
                  <xsl:sort select="string-length(substring-before($slaveFeatures,@acronym))" order="ascending" data-type="number"/>
                  <xsl:variable name="final">
                    <xsl:call-template name="lookupFeature">
                      <xsl:with-param name="featureClass" select="@acronym"/>
                    </xsl:call-template>
                    <xsl:text>,</xsl:text>
                    <xsl:variable name="afid" select="@fid"/>
                    <xsl:for-each select="/Report/Changes/ChangedFeature[@fid=$afid]/AttributeEdit">
                      <xsl:if test="not(contains($blockedattributes,./@acronym))">
                      <xsl:text> </xsl:text>
                      <xsl:call-template name="lookupAttribute">
                        <xsl:with-param name="attributeClass" select="./@acronym"/>
                      </xsl:call-template>
                      <xsl:text> </xsl:text>
                      
                     
                      <xsl:variable name="sv" select="translate(StartValue,'[]','')"/>
                      <xsl:variable name="ev" select="translate(EndValue,'[]','')"/>
                         
                         <xsl:variable name="start_val">
                       <xsl:choose>
                         <xsl:when test="contains($sv,'UNDEFINED')">
                           <xsl:text>undefined</xsl:text>
                         </xsl:when>
                         <xsl:when test="contains($sv,'UNKNOWN')">
                           <xsl:text>unknown</xsl:text>
                         </xsl:when>
                         <xsl:otherwise>
                           <xsl:value-of select="$sv"/>
                         </xsl:otherwise>
                       </xsl:choose>
                         </xsl:variable>
                         
                         <xsl:variable name="end_val">
                           <xsl:choose>
                             <xsl:when test="contains($ev,'UNDEFINED')">
                               <xsl:text>undefined</xsl:text>
                             </xsl:when>
                             <xsl:when test="contains($ev,'UNKNOWN')">
                               <xsl:text>unknown</xsl:text>
                             </xsl:when>
                             <xsl:otherwise>
                               <xsl:value-of select="$ev"/>
                             </xsl:otherwise>
                           </xsl:choose>
                         </xsl:variable>
                         
                      <xsl:choose>
                        <xsl:when test="contains($start_val,': ')">
                          <xsl:text>'</xsl:text>
                          <xsl:value-of select="substring-after($start_val,': ')"/>
                          <xsl:text>'</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text>'</xsl:text>
                          <xsl:value-of select="$start_val"/>
                          <xsl:text>'</xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                      
                      <xsl:text> </xsl:text>
                      
                      <xsl:value-of select="$alias_To"/>
                      <xsl:text> </xsl:text>
                      
                      <xsl:choose>
                        <xsl:when test="contains($end_val,': ')">
                          <xsl:text>'</xsl:text>
                          <xsl:value-of select="substring-after($end_val,': ')"/>
                          <xsl:text>'</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text>'</xsl:text>
                          <xsl:value-of select="$end_val"/>
                          <xsl:text>'</xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                      
                      <!--<xsl:text>&#x0A;</xsl:text>-->
                      <xsl:if test="position() != last()">
                        <xsl:text>; </xsl:text>
                      </xsl:if>
                      </xsl:if>
                      
                    </xsl:for-each>
                    
                  </xsl:variable>   
                  <xsl:call-template name="multiple-incorrect-values-replacement">
                    <xsl:with-param name="input" select="$final"/>
                  </xsl:call-template>
                  <xsl:if test="position() != last()">
                    <xsl:text>&#x0A;</xsl:text>
                  </xsl:if>
                </xsl:for-each>
              </xsl:element>
            </xsl:when>
            <xsl:when test="(normalize-space(@edit)='modified') and (normalize-space(@acronym) = 'SOUNDG')">
              <!--<xsl:text> acronym </xsl:text>
              <xsl:value-of select="@acronym"/>
              <xsl:text> *** </xsl:text>-->
              <xsl:element name="DESCRIPTION">
                <xsl:for-each select="/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature">
                  <xsl:sort select="string-length(substring-before($slaveFeatures,@acronym))" order="ascending" data-type="number"/>
                  <xsl:variable name="final">
                    <!--<xsl:call-template name="lookupFeature">
                      <xsl:with-param name="featureClass" select="@acronym"/>
                    </xsl:call-template>
                    <xsl:text>,</xsl:text>-->
                    
                  <xsl:variable name="afid" select="@fid"/>
                  <xsl:for-each select="/Report/Changes/ChangedFeature[@fid=$afid]/PointEdit">
<!--                    <xsl:if test="not(contains($blockedattributes,./@acronym))">-->
                    <xsl:if test="./@acronym">
                      <xsl:call-template name="lookupAttribute">
                        <xsl:with-param name="attributeClass" select="./@acronym"/>
                      </xsl:call-template>
                      <xsl:text> </xsl:text>
                      </xsl:if>
                      <xsl:variable name="start_depth" select="StartPoint/Depth"/>
                      <xsl:variable name="end_depth" select="EndPoint/Depth"/>
                    <xsl:choose>
                      <xsl:when test="contains($start_depth,'-')">
                        <xsl:text>drying height</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>depth</xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text> </xsl:text>
                    <i><xsl:value-of select="format-number($start_depth,'##.#')"/></i>
                    <xsl:text>m</xsl:text>
                    <!--<xsl:value-of select="$start_depth"/>
                    <xsl:text>m</xsl:text>-->
                       <xsl:text>, </xsl:text>
                      
                      <xsl:value-of select="$alias_with"/>
                      <xsl:text> </xsl:text>
                    <xsl:choose>
                      <xsl:when test="contains($end_depth,'-')">
                        <xsl:text>drying height</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>depth</xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                    
                    <xsl:text> </xsl:text>
                    <i><xsl:value-of select="format-number($end_depth,'##.#')"/></i>
                    <xsl:text>m</xsl:text>
                      
                      <xsl:if test="position() != last()">
                        <xsl:text>; </xsl:text>
                      </xsl:if>
                    <!--</xsl:if>--> 
                  </xsl:for-each>
                  </xsl:variable>
                  <xsl:value-of select="$final"/>
                  <xsl:if test="position() != last()">
                    <xsl:text>&#x0A;</xsl:text>
                  </xsl:if>
                </xsl:for-each>
              </xsl:element>
            </xsl:when>
            <xsl:when test="(normalize-space(@edit)='new') and $action_of_other_feature = 'Replace'">
              <xsl:element name="DESCRIPTION">
                 <xsl:variable name="acronyms">
                 
                  <xsl:for-each select="/Report/Locations/Location/CollocatedFeature[@fid=$foid]/../CollocatedFeature">
                    <xsl:sort select="@fid = $foid"/>
                    <xsl:value-of select="@acronym" />
                    
                    <xsl:if test="position()!=last()">,</xsl:if>
                    
                  </xsl:for-each>

                </xsl:variable>
                
                <xsl:call-template name="description_for_replace">
                  <xsl:with-param name="acronym" select="$acronyms"/>
                </xsl:call-template>
              </xsl:element>
            </xsl:when>
            
            <xsl:otherwise>
              <!-- Use a template to match the feature to a description-->
              <xsl:call-template name="generateDescription">
                <xsl:with-param name="targetFid" select="@fid"/>
                <xsl:with-param name="single" select="$single"/>
                <xsl:with-param name="other-feature" select="$other-feature"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
          
          <!-- use template to format geometry info into location element -->
          <!-- Choose position info -->
          
          <xsl:choose>
            <xsl:when test="(normalize-space(@edit)='modified') and (normalize-space(@acronym) = 'SOUNDG')">
              <xsl:element name="POSITION_LIST">
                <xsl:element name="POSITION">
                  <xsl:element name="LATITUDE">
                    <xsl:value-of select="PointEdit/EndPoint/Y"/>
                  </xsl:element>
                  <xsl:element name="LONGITUDE">
                    <xsl:value-of select="PointEdit/EndPoint/X"/>
                  </xsl:element>
                  <!-- Added April 202 to include gml position in coordinate field -->
                  <xsl:element name="COORDINATE">
                    <xsl:copy-of select="/Report/Features/Feature[@fid=$fid]/Geometry/Point/source/*" />
                  </xsl:element>
                 
                </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:when test="count(./PointEdit) &gt; 0">
              
              <!-- If position was changed -->
              <xsl:element name="POSITION_LIST">
                <xsl:element name="POSITION">
                  <xsl:element name="LATITUDE">
                    <xsl:value-of select="PointEdit/StartPoint/Y"/>
                  </xsl:element>
                  <xsl:element name="LONGITUDE">
                    <xsl:value-of select="PointEdit/StartPoint/X"/>
                  </xsl:element>
                  <xsl:element name="TAG">
                    <xsl:value-of select="$alias_From"/>
                  </xsl:element>
                  <!-- Added April 202 to include gml position in coordinate field -->
                  <xsl:element name="COORDINATE">
                    <xsl:copy-of select="/Report/OldFeatures/Feature[@fid=$fid]/Geometry/Point/source/*" />
                  </xsl:element>
                  
                </xsl:element>
                <xsl:element name="POSITION">
                  <xsl:element name="LATITUDE">
                    <xsl:value-of select="PointEdit/EndPoint/Y"/>
                  </xsl:element>
                  <xsl:element name="LONGITUDE">
                    <xsl:value-of select="PointEdit/EndPoint/X"/>
                  </xsl:element>
                  <xsl:element name="TAG">
                    <xsl:value-of select="$alias_To"/>
                  </xsl:element>
                  <!-- Added April 202 to include gml position in coordinate field -->
                  <xsl:element name="COORDINATE">
                    <xsl:copy-of select="/Report/Features/Feature[@fid=$fid]/Geometry/Point/source/*" />
                  </xsl:element>
                </xsl:element>
              </xsl:element>
              
            </xsl:when>
            <xsl:otherwise>
              <!-- position not changed, use geom from feature -->
              <xsl:apply-templates select="/Report/Features/Feature[@fid=$foid]/Geometry"/>
            </xsl:otherwise>
          </xsl:choose>
          
          <!-- Assign the chart info -->
          <xsl:call-template name="ChartList"/>
          
          <!-- Copy the FOID of the contributing feature into the output for tracing purposes -->
          <xsl:element name="FOID_LIST">
            <xsl:element name="FOID">
              <xsl:value-of select="@fid"/>
            </xsl:element>
          </xsl:element>
        </xsl:when>
        <xsl:otherwise>
          <!-- If the object is coming from a scratch layer it won't have a FOID -->
          <xsl:element name="DESCRIPTION">
            <!-- Describe the feature if there is a template, default template will echo acronym -->
            <xsl:apply-templates select="/Report/Features/Feature"/>
          </xsl:element>
          
          <xsl:apply-templates select="/Report/Features/Feature/Geometry"/>
          <!-- Assign the chart info -->
          <xsl:call-template name="ChartList"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
    
    </xsl:if>
    </xsl:if>
  </xsl:template>
  
  <!-- Features/Feature/Geometry template -->
  <xsl:template match="Geometry">

    <xsl:element name="POSITION_LIST">
      <xsl:apply-templates/>
    </xsl:element>

  </xsl:template>

  <!-- Point geometry template -->
  <xsl:template match="Point">
    <xsl:element name="POSITION">
      <xsl:element name="LATITUDE">
        <xsl:value-of select="@y"/>
        <!--<xsl:call-template name="FormatLatLong">
                <xsl:with-param name="Coordinate"  select="@y" />
                </xsl:call-template> -->
      </xsl:element>
      <xsl:element name="LONGITUDE">
        <xsl:value-of select="@x"/>
        <!--<xsl:call-template name="FormatLatLong">
                <xsl:with-param name="Coordinate"  select="@x" />
                </xsl:call-template> -->
      </xsl:element>
      <!-- Added April 20 to include gml position in COORDINATE, makes NM visible in SE and useful for querying overlapping panels -->
      <xsl:element name="COORDINATE">
        <xsl:copy-of select="source/*" />
      </xsl:element>

    </xsl:element>
  </xsl:template>

  <!-- Line geometry template -->
  <xsl:template match="Line">
    <xsl:apply-templates select="Point"/>
  </xsl:template>

  <!-- Area geometry template -->
  <xsl:template match="Area">
    <xsl:apply-templates select="Point"/>
  </xsl:template>

  <!-- Composite geometry template -->
  <xsl:template match="Collection">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Template for generating the CHART_LIST data -->
  <xsl:template name="ChartList">
    <!-- If we have panel info, fill in the Chart reference details. Not available for scratch layers -->
    <xsl:if test="/Report/Panel">
      <!-- April 2020: This has been made obsolete by INSTRUCTION_PANEL_LIST but leave for support of older scripts -->
      <xsl:element name="CHART_LIST">
        <xsl:element name="CHART">
          <xsl:element name="CHART_TITLE">
            <xsl:value-of select="/Report/Chart/Attributes/Attribute[@acronym='CTITL1']/@value"/>
          </xsl:element>
          <xsl:element name="CHART_NUM">
            <xsl:value-of select="/Report/Chart/Attributes/Attribute[@acronym='CHTNUM']/@value"/>
          </xsl:element>
          <xsl:element name="CHART_INT_NUM">
            <xsl:value-of select="/Report/Chart/Attributes/Attribute[@acronym='INTNUM']/@value"/>
          </xsl:element>
          <xsl:element name="EDITION_DATE">
            <xsl:value-of select="/Report/Chart/Attributes/Attribute[@acronym='EDDATE']/@value"/>
          </xsl:element>
		  <xsl:element name="LAST_CORRECTION">
            <xsl:value-of select="/Report/Chart/Attributes/Attribute[@acronym='LTSTNM']/@value"/>
          </xsl:element>
          <xsl:element name="PANEL">
            <xsl:element name="PANELVER_ID">
              <xsl:value-of select="/Report/Panel/@version_id"/>
            </xsl:element>
            <xsl:element name="PANEL_NAME">
              <xsl:value-of select="/Report/Panel/Attributes/Attribute[@acronym='PANNAM']/@value"/>
            </xsl:element>
            <xsl:element name="PANEL_NUM">
              <xsl:value-of select="/Report/Panel/Attributes/Attribute[@acronym='PANNUM']/@value"/>
            </xsl:element>
            <xsl:element name="CHART_SCALE">
              <xsl:value-of select="/Report/Panel/Attributes/Attribute[@acronym='PSCALE']/@value"/>
            </xsl:element>
            <xsl:element name="PANEL_LIMITS">
              <xsl:element name="PANEL_LIMIT_MINX">
                <xsl:value-of select="/Report/Panel/Boundary/MinX"/>
              </xsl:element>
              <xsl:element name="PANEL_LIMIT_MINY">
                <xsl:value-of select="/Report/Panel/Boundary/MinY"/>
              </xsl:element>
              <xsl:element name="PANEL_LIMIT_MAXX">
                <xsl:value-of select="/Report/Panel/Boundary/MaxX"/>
              </xsl:element>
              <xsl:element name="PANEL_LIMIT_MAXY">
                <xsl:value-of select="/Report/Panel/Boundary/MaxY"/>
              </xsl:element>
            </xsl:element>

            <xsl:variable name="datum"
              select="substring-before(/Report/Panel/Attributes/Attribute[@acronym='DATUM']/@value, ',')"/>
            <xsl:if test="$datum != '' ">
              <xsl:element name="HORIZ_DATUM">
                <xsl:value-of select="$datum"/>
              </xsl:element>
            </xsl:if>

          </xsl:element>
        </xsl:element>
      </xsl:element>

      <!-- Added April 202 to work better with HPD 4 by using a simple panel reference rather than copying panel data for each instruction. -->
      <xsl:element name="INSTRUCTION_PANEL_LIST">
        <xsl:element name="INSTRUCTION_PANEL_LIST_ITEM">
            <xsl:element name="PPRPAN">
               <xsl:attribute name="href"><xsl:value-of select="/Report/Panel/@id"/></xsl:attribute>
            </xsl:element>
        </xsl:element>
      </xsl:element>
      
    </xsl:if>

  </xsl:template>

  <!-- Template to generate the description field -->
  <xsl:template name="generateDescription">
    <xsl:param name="targetFid"/>
    <xsl:param name="single"/>
    <xsl:param name="other-feature"/>
    <!-- ID of the feature to get the description of -->

    <xsl:if test="$targetFid != '' ">
      <!-- Collect the structure description -->
      <xsl:element name="DESCRIPTION">
        <!-- Feature description templates are called from the template included at the beginning of this file -->
        <!-- Describe the feature if there is a template, default template will echo acronym -->
        <!-- If there is a multiple feature elements with same FOID then description must be merged into single one -->

       <xsl:variable name="desc">
        <xsl:variable name="buoy">
          <xsl:for-each select="/Report/Locations/Location/CollocatedFeature[@fid=$targetFid]/../CollocatedFeature">
            <xsl:choose>
              <xsl:when test="not(contains($slaveFeatures,./@acronym)) and contains(./@acronym,'BOY')">
                <xsl:value-of select="'yes'"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="''"/>
              </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        </xsl:variable>
        
         <!-- applying master feature -->
         <xsl:variable name="master">
           <xsl:variable name="ms-count" select="count(/Report/Locations/Location/CollocatedFeature[@fid=$targetFid]/../CollocatedFeature)"/>
        <xsl:for-each select="/Report/Locations/Location/CollocatedFeature[@fid=$targetFid]/../CollocatedFeature">
          <xsl:if test="not(contains($slaveFeatures,./@acronym)) and contains($masterFeatures,./@acronym)">
            <xsl:variable name="cFid" select="@fid"/>
            <xsl:choose>
              <xsl:when test="normalize-space($buoy)">
                <i><xsl:apply-templates select="/Report/Features/Feature[@fid=$cFid]"/></i>
                <xsl:if test="$ms-count > 1">
                  <xsl:text>; </xsl:text>
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates select="/Report/Features/Feature[@fid=$cFid]"/>
                <xsl:if test="$ms-count > 1">
                  <xsl:text>; </xsl:text>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:for-each>
         </xsl:variable>
         
         <xsl:choose>
           <xsl:when test="$other-feature">
             <xsl:apply-templates select="/Report/Features/Feature[@fid=$targetFid]"/>
           </xsl:when>
           <xsl:otherwise>
         <xsl:if test="normalize-space($master)">
           <xsl:copy-of select="$master"/>
         </xsl:if>
         
        <!-- applying slave features -->
         <xsl:variable name="slave">
        <xsl:for-each select="/Report/Locations/Location/CollocatedFeature[@fid=$targetFid]/../CollocatedFeature">
          <xsl:sort select="string-length(substring-before($slaveFeatures,@acronym))" order="ascending" data-type="number"/>
          <xsl:if test="contains($slaveFeatures,@acronym) ">
            <xsl:variable name="cFid" select="@fid"/>
              <xsl:apply-templates select="/Report/Features/Feature[@fid=$cFid]"/>
            <xsl:if test="position()!=last()">
              <xsl:text>; </xsl:text>
            </xsl:if>
          </xsl:if>
        </xsl:for-each>
         </xsl:variable>
            
         <xsl:if test="normalize-space($slave)">
           <xsl:copy-of select="$slave"/>
         </xsl:if>
        
          <xsl:if test="not(normalize-space($master)) and not(normalize-space($slave)) and (normalize-space($single))">
            <xsl:apply-templates select="/Report/Features/Feature[@fid=$targetFid]"/>
          </xsl:if>
           
             
           </xsl:otherwise>
         </xsl:choose>
         
       </xsl:variable>
       <xsl:copy-of select="normalize-space($desc)"/>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <!-- Default Template for a feature that didn't match any of the feature + acronym templates -->
  <xsl:template match="Feature">
    <xsl:value-of select="@acronym"/>
  </xsl:template>

  <!-- Template to match a COLOUR Attribute, recurses if more than 2 colours -->
  <xsl:template name="colourFormat">
    <xsl:param name="colourEnum"/>

    <xsl:choose>
      <xsl:when test="contains($colourEnum,',')">
        <!-- More than one colour,  lookup the first colour to include it's string  -->
        <xsl:call-template name="lookupColour">
          <xsl:with-param name="clrnum" select="substring-before($colourEnum,',')"/>
        </xsl:call-template>
        <!-- Put the rest of the colour(s) into a variable  -->
        <xsl:variable name="additionalColour">
          <xsl:value-of select="substring-after($colourEnum,',')"/>
        </xsl:variable>
        <!--If there is more commas then read one more colour separated by a comma, otherwise use 'and' between the colours -->
        <xsl:choose>
          <xsl:when test="contains($additionalColour,',')">
            <xsl:text>, </xsl:text>
            <!-- Call the same template recursively to deal with more colours -->
            <xsl:call-template name="colourFormat">
              <xsl:with-param name="colourEnum" select="$additionalColour"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$alias_and"/>
            <!-- The local language for 'and' -->
            <xsl:call-template name="lookupColour">
              <xsl:with-param name="clrnum" select="$additionalColour"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="lookupColour">
          <xsl:with-param name="clrnum" select="$colourEnum"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="description_for_replace">
    <xsl:param name="acronym" />
    
    <xsl:variable name="present_acronym" select="substring-after($acronym,',')"/>
    <xsl:variable name="previous_acronym" select="substring-before($acronym,',')"/>
    
    <xsl:variable name="desc_of_previous_acronym">
      <xsl:choose>
        <xsl:when test="$previous_acronym ='BOYSPP'">
          
          <xsl:value-of select="'buoy special purpose'"/>
        </xsl:when>
        <xsl:when test="$previous_acronym ='BCNSPP'">
          
          <xsl:value-of select="'beacon special purpose'"/>
        </xsl:when>
      
      
      <xsl:otherwise>
    <xsl:call-template name="lookupFeature">
      <xsl:with-param name="featureClass" select="$previous_acronym"/>
    </xsl:call-template>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
   
    <xsl:variable name="desc_of_present_acronym">
      <xsl:choose>
        <xsl:when test="$present_acronym ='BOYSPP'">
           <xsl:value-of select="'buoy special purpose'"/>
        </xsl:when>
        <xsl:when test="$present_acronym ='BCNSPP'">
          <xsl:value-of select="'beacon special purpose'"/>
        </xsl:when>
        <xsl:otherwise>
      <xsl:call-template name="lookupFeature">
        <xsl:with-param name="featureClass" select="$present_acronym"/>
      </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:value-of select="normalize-space($desc_of_previous_acronym) "/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$alias_with"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="normalize-space($desc_of_present_acronym)"/>
      
    
  </xsl:template>
  
  <xsl:template name="collocated_actions_with_new" >
    <xsl:param name="collocated_Fids"/>
   
    <xsl:variable name="currentfeature">
      <xsl:choose>
        <xsl:when test="substring-before($collocated_Fids,',') != ''">
          <xsl:value-of select="substring-before($collocated_Fids,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$collocated_Fids" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="additionalFeatures">
      <xsl:value-of select="substring-after($collocated_Fids,',')"/>
    </xsl:variable>
    
    <xsl:variable name="collocatedActions">
    <xsl:choose>
      <xsl:when test="$currentfeature != ''">
        <xsl:value-of select="/Report/Changes/ChangedFeature[@fid=$currentfeature]/@edit"/>
        <xsl:if test="$additionalFeatures != ''" >
          <xsl:text>,</xsl:text>
         
          <xsl:call-template name="collocated_actions_with_new">
            <xsl:with-param name="collocated_Fids" select="$additionalFeatures" />
          </xsl:call-template>
          
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$additionalFeatures"/>
        <xsl:if test="$additionalFeatures != ''" >
          <xsl:call-template name="collocated_actions_with_new">
            <xsl:with-param name="collocated_Fids" select="$additionalFeatures" />
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:variable>
    
    
      <xsl:call-template name="actions_for_new">
        <xsl:with-param name="currentActions" select="$collocatedActions"/>
      </xsl:call-template>
    
  </xsl:template>
  
  <xsl:template name="actions_for_new">
    <xsl:param name="currentActions"/>
    
    <xsl:choose>
      
      <xsl:when test="contains($currentActions,'deleted')">
        <xsl:text>Replace</xsl:text>
      </xsl:when>
      <xsl:when test="contains($currentActions,'modified')">
        <xsl:text>Modify</xsl:text>
      </xsl:when>
      <xsl:when test="contains($currentActions,'new')">
        <xsl:text>Insert</xsl:text>
      </xsl:when>
    </xsl:choose>
    
    
  </xsl:template>
  
  
  <!-- Ignore everything that has no match -->
  <xsl:template match="@*|node()"/>

</xsl:transform>

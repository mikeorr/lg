<!-- documents.xsl -->
<xsl:stylesheet version="1.0"
                  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/"> 
  <html> 
    <head>
      <title>My Documents</title>
    </head>
    
    <body>
	  <xsl:apply-templates select="//document"/>
    </body>
  </html>
</xsl:template>

<xsl:template match="document">
  <xsl:variable name="doc_path">docs</xsl:variable>
  <xsl:variable name="doc_subpath"><xsl:value-of select="module"/></xsl:variable>
  <xsl:variable name="color"/>

  <xsl:variable name="even" select="position() mod 2"/>

  <xsl:choose>
     <xsl:when test="$even = 1">
          <![CDATA[<table width="100%" bgcolor="#cccccc">]]>
	 </xsl:when>
     <xsl:when test="$even = 0">
	     <![CDATA[<table width="100%" bgcolor="#99b0bf">]]>
	 </xsl:when>
     <xsl:otherwise>
        <![CDATA[<table width="100%" bgcolor="#ffffff">]]>
	 </xsl:otherwise>
  </xsl:choose>

     <!-- I will omit all the "fashion" of the tables :-) -->
      <tr>
	     <td>
		    <b>Title: <xsl:value-of select="title"/></b>
		 </td>
	 </tr>
     <xsl:for-each select="author">
	 <tr>
	     <td>
		    Author: <xsl:apply-templates />
		 </td>
	  </tr>
	  </xsl:for-each>
	 <tr>
	     <td>
		    <table width="100%">
			   <tr>
			      <td width="33%">
				     <xsl:if test="format/@pdf = 'yes'">
					   <a href="{$doc_path}/{$doc_subpath}/{$doc_subpath}.pdf">PDF</a>
					 </xsl:if>
					 <![CDATA[&nbsp;]]> <!-- blank space, so your browser could 
					                         format perfectly if the 'xsl:if' fails -->
				  </td>
			      <td width="33%">
				     <xsl:if test="format/@ps = 'yes'">
					   <a href="{$doc_path}/{$doc_subpath}/{$doc_subpath}.ps">PS</a>
					 </xsl:if>
					 <![CDATA[&nbsp;]]> <!-- blank space, so your browser could 
					                         format perfectly if the 'xsl:if' fails -->
				  </td>
			      <td width="33%">
				     <xsl:if test="format/@html = 'yes'">
					   <a href="{$doc_path}/{$doc_subpath}/{$doc_subpath}/">HTML (online)</a>
					 </xsl:if>
					 <![CDATA[&nbsp;]]> <!-- blank space, so your browser could 
					                         format perfectly if the 'xsl:if' fails -->
				  </td>
			   </tr>
			</table>
		 </td>
	  </tr>
  <![CDATA[</table>]]>
</xsl:template>

</xsl:stylesheet>

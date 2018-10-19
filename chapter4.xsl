<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tei="http://www.tei-c.org/ns/1.0" >

	<xsl:output method="html" />

	<!-- Variablen -->
	<xsl:param name="witness" />

	<xsl:variable name="witnessgroup">
		<xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:listWit/tei:witness"/>
	</xsl:variable>

	<!-- Template 1: Gesamtdokument -->
	<xsl:template match="/">
		<h2>
			<xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/."/>
		</h2>
		<h3>by <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/."/></h3>
		<select id="witness" name="witness" onchange="displayResult(this.value)">
			<xsl:for-each select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:listWit/tei:witness">
				<option>
						<xsl:attribute name="value">
							<xsl:value-of select="./@xml:id"/>
						</xsl:attribute>
						<xsl:if test="./@xml:id = $witness">
								<xsl:attribute name="selected">
									selected
								</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="./@xml:id"/>  =
						<xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:settlement/."/>,
						<xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:repository/."/>,
						<xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:idno/."/>, part of the
						<xsl:value-of select="../tei:head/text()"/>
					</option>
			</xsl:for-each>
		</select>
		<ul>
			<xsl:for-each select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:listWit/tei:witness">
				<li>
					<xsl:value-of select="./@xml:id"/> =
					<xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:settlement/."/>,
					<xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:repository/."/>,
					<xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:idno/."/>, part of the
					<xsl:value-of select="../tei:head/text()"/>
				</li>
			</xsl:for-each>
		</ul>

		<xsl:apply-templates select="tei:TEI/tei:text"/>

	</xsl:template>

		<!-- Template: Text-->
		<xsl:template match="tei:text">
			<div style="direction:rtl">
				<xsl:apply-templates select="node()"/>
			</div>
		</xsl:template>


	<!-- Template: Variable witnessgroup -->
	<xsl:template match="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:listWit/tei:witness">
			<xsl:for-each select=".">
				<xsl:if test="$witness = @xml:id">
					<xsl:value-of select="../@xml:id"/>
				</xsl:if>
			</xsl:for-each>
	</xsl:template>

	<!-- Template: Überschriften -->
	<xsl:template match="tei:head">
		<p style="color:red;">
			<xsl:apply-templates select="node()"/>
		</p>
	</xsl:template>

<!-- Template Paragragphes -->
	<xsl:template match="tei:p">
		<p>
			<xsl:apply-templates select="node()"/>
		</p>
	</xsl:template>

<!-- Template Apparat -->
	<xsl:template match="tei:app">
		<strong>
			<xsl:for-each select="tei:rdg">
				<xsl:if test="(contains(@wit, $witness)) or (contains(@wit, $witnessgroup))" >
					<xsl:value-of select="."/>
				</xsl:if>
			</xsl:for-each>
		</strong>
	</xsl:template>

</xsl:transform>

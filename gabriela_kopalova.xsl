<?xml version="1.0" encoding="UTF-8"?>
<!-- github: https://github.com/GabrielaKopalova/Receptar -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>  
                <title>
                    <!-- jako titulek stránky zvolíme název aktuálního tagu -->
                    <xsl:value-of select="name(./receptar)"/>            
                </title> 
                <!-- pripojeni souboru s CSS styly -->
                <link rel="stylesheet" type="text/css" href="styly.css"/>
                <meta charset="UTF-8"></meta>
            </head>
            <body>
                <h1>
                    <xsl:value-of select="name(./receptar)"/>            
                </h1>   
                <!-- najdeme tag zakladni-nastaveni a aplikujeme na něj jeho vlastní template - dále postupujeme obdobně-->
                <xsl:apply-templates select="//zakladni-nastaveni" /> 
                <xsl:apply-templates select="//tabulka-prav" />   
            </body>
        </html>
    </xsl:template>
    <xsl:template match="zakladni-nastaveni" >
        <!-- jako nadpis 2. úrovně zvolíme název aktuálního tagu-->
        <h2>
            <xsl:value-of select ="name(.)"/>
        </h2>
        <dl>
            <!-- zobrazení zakladniho nastaveni-->
            <dt><xsl:value-of select ="name(./jazyk)"/></dt>
            <dd><xsl:value-of select ="./jazyk"/></dd>
            <dt><xsl:value-of select ="name(./charset)"/></dt>
            <dd><xsl:value-of select ="./charset"/></dd>
            <dt><xsl:value-of select ="name(./javascript)"/></dt>
            <dd><xsl:value-of select ="./javascript"/></dd>
            <dt><xsl:value-of select ="name(./bez-stylu)"/></dt>
            <dd><xsl:value-of select ="./bez-stylu"/></dd>
            <dt><xsl:value-of select ="name(./debug-mode)"/></dt>
            <dd><xsl:value-of select ="./debug-mode"/></dd>
            <dt><xsl:value-of select ="name(./maximalni-odezva)"/></dt>
            <dd><xsl:value-of select ="./maximalni-odezva"/></dd>
            <dd><xsl:value-of select ="./maximalni-odezva/@jednotka"/></dd>
            <dt><xsl:value-of select ="name(./nastaveni-receptu)"/></dt>
            <table id="t01" >
                <xsl:for-each select="./nastaveni-receptu/child::*"> 
                    <tr>
                        <td class="nastaveni-receptu"><xsl:value-of select ="name(.)"/></td>
                        <td class="nastaveni-receptu"><xsl:value-of select ="./@*"/></td>
                        <td class="nastaveni-receptu"><xsl:value-of select ="."/></td>
                    </tr>
                </xsl:for-each >
            </table>
            <dt><xsl:value-of select ="name(./protokol)"/></dt>
            <dd><xsl:value-of select ="./protokol"/></dd>
            <dt><xsl:value-of select ="name(./kontakt-spravce)"/></dt>
            <dd><xsl:value-of select ="./kontakt-spravce"/></dd>
        </dl>
    </xsl:template>
    <xsl:template match="tabulka-prav">
        <h2>
            <xsl:value-of select ="name(.)"/>
        </h2>        
        <div>
            <!-- zde zavolá na všechny potomky osoba-->
            <xsl:apply-templates select="./osoba" /> 
        </div>
    </xsl:template>   
     
    <xsl:template match="osoba">
        <!-- zobrazení části s osobou-->
        <h3><xsl:value-of select="@typ"/></h3>
        <dl>
            <table id="t02" >
                <xsl:for-each select="./child::*">
                    <tr> 
                        <td class="osoba"><xsl:value-of select ="name(.)"/></td>
                        <td class="osoba"><xsl:value-of select ="./@*"/></td>
                        <td class="osoba"><xsl:value-of select ="."/></td>
                    </tr>
                </xsl:for-each >
            </table>
        </dl>
    </xsl:template>
</xsl:stylesheet>
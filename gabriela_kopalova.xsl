<?xml version="1.0" encoding="UTF-8"?>
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
                <xsl:apply-templates select="//seznam-receptu" mode="menu"/> 
                <xsl:apply-templates select="//seznam-receptu" mode="priprava"/> 
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
    
    <xsl:template match="seznam-receptu" mode="menu">
        <h2>Menu</h2>
        <table >
            <tr >
                <th>Název</th>
                <th>Kuchyně</th>
                <th>Chod</th>
            </tr>
            <xsl:for-each select="./recept">
                <tr>
                    <td><xsl:value-of select="nazev"/></td>
                    <td><xsl:value-of select="kuchyne"/></td>
                    <td><xsl:value-of select="chod"/></td>
                </tr>
            </xsl:for-each>
        </table>
        <br />
    </xsl:template>   
    <xsl:template match="seznam-receptu" mode="priprava">
        <h2>Postup jednotlivých jídel</h2>
        <div>
            <xsl:apply-templates select="./recept" /> 
        </div>
    </xsl:template>   
    
    <xsl:template match="recept">
        <!-- zobrazení části s receptem-->
        <h3><xsl:value-of select="nazev"/></h3>
        <dl>
            <dt><xsl:value-of select ="name(./doba-pripravy)"/></dt>
            <dd><xsl:value-of select ="./doba-pripravy"/><xsl:text> </xsl:text><xsl:value-of select ="./doba-pripravy/@jednotka"/></dd>
            <dt></dt>
            <br />
            <dt><xsl:value-of select ="name(./suroviny)"/></dt>
        </dl>
        <table>
            <tr>
                <th>Ingredience</th>
                <th>Množství</th>
                <th>Jednotka</th>
            </tr>
            <xsl:for-each select="./suroviny/child::*"> 
                <tr>
                <td class="surovina"><xsl:value-of select ="."/></td>
                <td class="surovina"><xsl:value-of select ="./@mnozstvi"/></td>
                <td class="surovina"><xsl:value-of select ="./@jednotka"/></td>
                </tr>
            </xsl:for-each >
        </table>
        <br />
        <dl>
            <dt id="dt01"><xsl:value-of select ="name(./postup)"/></dt>
            <dd id="dd01"><xsl:value-of select ="./postup"/></dd>
            <dd>
                <img>
                    <xsl:attribute name="src">
                        <xsl:value-of select ="./obrazek/@odkaz"/>
                    </xsl:attribute>
                    <xsl:attribute name="alt">
                        <xsl:value-of select ="."/>
                    </xsl:attribute>
                </img>
            </dd>
            <br />
            <dt><xsl:value-of select ="name(./komentare)"/></dt>
        </dl>
        <table>
            <tr>
                <th>Autor</th>
                <th>Čas</th>
                <th>Datum</th>
                <th>Text</th>
            </tr>
            <xsl:for-each select="./komentare/child::*"> 
                <tr>
                <td class="kometar"><xsl:value-of select ="./@autor"/></td>
                <td class="kometar"><xsl:value-of select ="./@cas"/></td>
                <td class="kometar"><xsl:value-of select ="./@datum"/></td>
                <td class="kometar"><xsl:value-of select ="."/></td>
                </tr>
            </xsl:for-each>
        </table>
        <br />
        <br />
    </xsl:template>
</xsl:stylesheet>
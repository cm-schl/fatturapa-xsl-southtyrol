<?xml version="1.0" encoding="UTF-8"?>
<!--
fatturapa_de-it.xsl
Copyright (C) 2020 Ferdinand Tavernini WOBI-IPES Bozen/Bolzano
and contributors.

Compatibility: FatturaPA v1.2.2

The XSL-stylesheet fatturapa_de-it.xsl is free software:
you can redistribute it and/or modify it under the terms of the
GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or any later version.

fatturapa_de-it.xsl is distributed in the hope that it will
be useful, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program (see LICENSE file). If not, see
http://www.gnu.org/licenses/.

-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:a="http://ivaservizi.agenziaentrate.gov.it/docs/xsd/fatture/v1.2">
     <xsl:output method="html" />

     <xsl:variable name="VersionFT">
          <p>
               Stylesheet FatturaPA. Contributors and license:
               https://github.com/provbz/fatturapa-xsl-southtyrol / https://github.com/cm-schl/fatturapa-xsl-southtyrol
          </p>
     </xsl:variable>
     <xsl:decimal-format name="euro" decimal-separator="," grouping-separator="." />

     <xsl:template name="CodiceUnivocoUfficio">
          <xsl:param name="kode" />
          <xsl:choose>
               <xsl:when test="$kode = '0000000'">
                    <span>
                         <xsl:value-of select="$kode" />
                    </span>
                    <br />
                    Nicht akkreditierter Rechnungsempfänger
                    <br />
                    <i>Destinatario non accreditato</i>
               </xsl:when>
               <xsl:when test="$kode = 'XXXXXXX'">
                    <span>
                         <xsl:value-of select="$kode" />
                    </span>
                    <br />
                    Ausländischer Rechnungsempfänger
                    <br />
                    <i>Destinatario non residenti</i>
               </xsl:when>
               <xsl:otherwise>
                    <span>
                         <xsl:value-of select="$kode" />
                    </span>
               </xsl:otherwise>
          </xsl:choose>
     </xsl:template>

     <xsl:template name="FormatDate">
          <xsl:param name="DateTime" />

          <xsl:variable name="year" select="substring($DateTime,1,4)" />
          <xsl:variable name="month" select="substring($DateTime,6,2)" />
          <xsl:variable name="day" select="substring($DateTime,9,2)" />

          <xsl:variable name="month_substitution">
               <xsl:choose>
                    <xsl:when test="$month = '1' or $month = '01'"><xsl:value-of select="'01'" /></xsl:when>
                    <xsl:when test="$month = '2' or $month = '02'"><xsl:value-of select="'02'" /></xsl:when>
                    <xsl:when test="$month = '3' or $month = '03'"><xsl:value-of select="'03'" /></xsl:when>
                    <xsl:when test="$month = '4' or $month = '04'"><xsl:value-of select="'04'" /></xsl:when>
                    <xsl:when test="$month = '5' or $month = '05'"><xsl:value-of select="'05'" /></xsl:when>
                    <xsl:when test="$month = '6' or $month = '06'"><xsl:value-of select="'06'" /></xsl:when>
                    <xsl:when test="$month = '7' or $month = '07'"><xsl:value-of select="'07'" /></xsl:when>
                    <xsl:when test="$month = '8' or $month = '08'"><xsl:value-of select="'08'" /></xsl:when>
                    <xsl:when test="$month = '9' or $month = '09'"><xsl:value-of select="'09'" /></xsl:when>
                    <xsl:when test="$month = '10'"><xsl:value-of select="'10'" /></xsl:when>
                    <xsl:when test="$month = '11'"><xsl:value-of select="'11'" /></xsl:when>
                    <xsl:when test="$month = '12'"><xsl:value-of select="'12'" /></xsl:when>
                    <xsl:otherwise>
                         <xsl:value-of select="'unbekannter Monat-mese non riconosciuto'" />
                    </xsl:otherwise>
               </xsl:choose>
          </xsl:variable>

          <xsl:variable name="time" select="substring($DateTime,12)" />
          <xsl:variable name="time_text">
               <xsl:if test="$time != ''">
                         <xsl:variable name="hh" select="substring($time,1,2)" />
                         <xsl:variable name="mm" select="substring($time,4,2)" />
                         <xsl:variable name="ss" select="substring($time,7,2)" />
                         <xsl:value-of select="' '" />
                         <xsl:value-of select="$hh" />
                         <xsl:value-of select="':'" />
                         <xsl:value-of select="$mm" />
                         <xsl:value-of select="':'" />
                         <xsl:value-of select="$ss" />
               </xsl:if>
          </xsl:variable>

          <xsl:value-of select="concat($day, '.', $month_substitution, '.', $year, ' ', $time_text)" />
     </xsl:template>

     <xsl:template match="/">
          <html>
               <head>
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <style type="text/css">
                         #fattura-container { width: 100%; position: relative; }

                         #fattura-elettronica { font-family: sans-serif; font-size: 10px; margin-left: auto; margin-right: auto; max-width: 840px; min-width: 600px; padding: 0; }                         
                         #fattura-elettronica h1 { padding: 5px 0 0 0; margin: 0; font-size: 22px; }
                         #fattura-elettronica h2 { padding: 5px 0 0 0; margin: 0; font-size: 18px; }
                         #fattura-elettronica h3 { padding: 5px 0 0 0; margin: 0; font-size: 15px; }
                         #fattura-elettronica h4 { padding: 5px 0 0 0; margin: 0; font-size: 12px; }
                         #fattura-elettronica h5 { padding: 3px 0 0 0; margin: 0; font-size: 10px; font-style: italic; }
                         #fattura-elettronica ul { list-style-type: none; margin: 0 !important; padding: 10px 0 0 40px !important; }
                         #fattura-elettronica ul li {}
                         #fattura-elettronica span { font-weight: bold; }
                         #fattura-elettronica .smalltext { font-size: 10px; }
                         #fattura-elettronica fehler {color: red; text-decoration:blink; }
                         #fattura-elettronica div {
                              padding: 1; 
                         }
                         #fattura-elettronica div.page {
                         background-color: #fff !important;
                         position: relative;

                         margin: 10px 0 5px 0; padding: 5px;

                         background: -moz-linear-gradient(0% 0 360deg, #FFFFFF, #F2F2F2 20%, #FFFFFF) repeat scroll 0 0 transparent;
                         border: 1px solid #CCCCCC;
                         -webkitbox-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
                         -mozbox-shadow: 0
                         0 10px rgba(0, 0, 0, 0.3);
                         box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
                         }

                         table {
                              table-layout: auto; 
                              width: 99%; 
                              font-size: 12px; 
                              border: none; 
                         }

                         table td {
                              overflow: hidden;
                         }

                         table, td, th { 
                              border-collapse: collapse;
                         }

                         #t1 td, #t1 th {
                               border: none; 
                         }

                         #ti td {
                              color: #000000; 
                              background-color: #EAF2D3;
                         }

                         #t2 td, #t2 th {
                              border: 1px solid #a6a5a5;
                         }
                         
                         th { padding: 2px;}
                         td { padding: 2px; word-wrap: break-word;}
                         div.footer { padding: 10px 0 0 0; margin: 0; font-size: 10px; text-align: center; color: #777777; clear:both; }
                         tr:nth-of-type(even){background-color: #F3F3F3;}
                         tr:nth-of-type(odd) {background-color:#FFFFFF;}
                         th {background-color:#808080; color: #ffffff;}
                         
                         #cedente,
                         #cessionario, 
                         #dati-ordine-acquisto, 
                         #dati-contratto, 
                         #dati-convenzione, 
                         #dati-ricezione, 
                         #dati-fatture-collegate, 
                         #dati-sal, 
                         #dati-ddt, 
                         #dati-trasporto, 
                         #fattura-principale,
                         #dati-pagamento-condizioni,
                         #controlli-contabilita-pa { 
                              float: left; 
                              width: 48%; 
                              clear: right; 
                              margin: 0.5px;
                         }

                         #dati-trasmissione { 
                              float:left; 
                              clear:both;
                              margin-top: 2px;
                              margin-right: 1px;
                              margin-bottom: 0px;
                              margin-left: 0px;
                              width: 32%;
                              
                         }
                         #terzointermediario { 
                              float:left; 
                              margin-top: 2px;
                              margin-right: 1px;
                              margin-bottom: 0px;
                              margin-left: 0px;
                              width: 31%;
                         }
                         #soggetto-emittente { 
                              float:left; 
                              margin-top: 2px;
                              margin-right: 0px;
                              margin-bottom: 0px;
                              margin-left: 0px;
                              width: 31%;
                         }

                         /* Used to break words that are to long - like mail adresses etc. */
                         .allow_break_word {
                              word-break: break-all;
                         }

                         #sub-heading {
                              font-size: 13px;
                              font-weight: bold;
                              text-decoration-line: underline;
                              text-decoration-style: solid;
                         }

                         .highlighted {
                              font-size: 16px;
                              font-weight: bold;
                              color: #b00000;
                         }

                         /* use flexboxes to align the items in this container (same height for example) */
                         #flex-container {
                              float:left;
                              clear: both;
                              display: flex;
                              flex-wrap: wrap;
                              width: 100%;
                           }

                           .roundedCorners {
                              border-radius: 10px;
                              border: 2px solid #cccccc;
                              padding: 5px !important;
                              clear: both;
                         }

                         #dati-dettaglio-linee, #riepilogo-aliquote-nature {
                              margin-top: 12px;
                              margin-bottom: 12px;
                              clear: both;
                         }

			     </style>
               </head>
               <body>
                    <div id="fattura-container">
                         <!--INIZIO DATI HEADER-->
                         <xsl:if test="a:FatturaElettronica">
                              <div id="fattura-elettronica">
                                   <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader">
                                        <div class="page">
                                             <div id="flex-container">
                                                  <!--INIZIO DATI CEDENTE PRESTATORE-->
                                                  <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/CedentePrestatore">
                                                       <div id="cedente" class="roundedCorners">
                                                            <h3>
                                                                 Daten zum Lieferanten/Freiberufler
                                                                 <br />
                                                                 <i>Dati del cedente/prestatore</i>
                                                            </h3>
                                                            <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/CedentePrestatore/DatiAnagrafici">
                                                                 <table id="t1">
                                                                      <xsl:for-each select="a:FatturaElettronica/FatturaElettronicaHeader/CedentePrestatore/DatiAnagrafici">
                                                                           <xsl:if test="Anagrafica/Denominazione or Anagrafica/Nome">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          Benennung
                                                                                          <br />
                                                                                          <i>Nominativo</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span>
                                                                                               <xsl:value-of select="Anagrafica/Denominazione" />
                                                                                                
                                                                                               <xsl:value-of select="Anagrafica/Titolo" />
                                                                                                
                                                                                               <xsl:value-of select="Anagrafica/Nome" />
                                                                                                
                                                                                               <xsl:value-of select="Anagrafica/Cognome" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="Anagrafica/CodEORI">
                                                                                <tr>
                                                                                     <td>
                                                                                          EORI-Kennung
                                                                                          <br />
                                                                                          <i>Codice EORI</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="Anagrafica/CodEORI" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="AlboProfessionale or ProvinciaAlbo or NumeroIscrizioneAlbo or DataIscrizioneAlbo">
                                                                                <tr>
                                                                                     <td>
                                                                                          Zugehörigkeit Berufsalbum
                                                                                          <br />
                                                                                          <i>Albo professionale di appartenenza</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="AlboProfessionale" />
                                                                                                
                                                                                               <xsl:value-of select="ProvinciaAlbo" />
                                                                                                
                                                                                               <xsl:value-of select="NumeroIscrizioneAlbo" />
                                                                                          </span>
                                                                                          <xsl:if test="DataIscrizioneAlbo">
                                                                                                
                                                                                               <span>
                                                                                                    <xsl:call-template name="FormatDate">
                                                                                                         <xsl:with-param name="DateTime" select="DataIscrizioneAlbo" />
                                                                                                    </xsl:call-template>
                                                                                               </span>
                                                                                          </xsl:if>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>


                                                                           <xsl:if test="IdFiscaleIVA">
                                                                                <tr>
                                                                                     <td>
                                                                                          Mehrwertsteuernummer
                                                                                          <br />
                                                                                          <i>Ident. fiscale ai fini IVA</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="IdFiscaleIVA/IdPaese" />
                                                                                               <xsl:value-of select="IdFiscaleIVA/IdCodice" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="CodiceFiscale">
                                                                                <tr>
                                                                                     <td>
                                                                                          Steuernummer
                                                                                          <br />
                                                                                          <i>Codice fiscale</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="CodiceFiscale" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="RegimeFiscale">
                                                                                <tr>
                                                                                     <td>
                                                                                          Steuersystem
                                                                                          <br />
                                                                                          <i>Regime fiscale</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <xsl:variable name="RF">
                                                                                               <xsl:value-of select="RegimeFiscale" />
                                                                                          </xsl:variable>
                                                                                          <span>
                                                                                               <xsl:choose>
                                                                                                    <xsl:when test="$RF='RF01'">ordinario </xsl:when>
                                                                                                    <xsl:when test="$RF='RF02'">contribuenti minimi </xsl:when>
                                                                                                    <xsl:when test="$RF='RF03'">nuove iniziative produttive </xsl:when>
                                                                                                    <xsl:when test="$RF='RF04'">agricoltura e attività connesse e pesca </xsl:when>
                                                                                                    <xsl:when test="$RF='RF05'">vendita sali e tabacchi </xsl:when>
                                                                                                    <xsl:when test="$RF='RF06'">commercio fiammiferi </xsl:when>
                                                                                                    <xsl:when test="$RF='RF07'">editoria </xsl:when>
                                                                                                    <xsl:when test="$RF='RF08'">gestione servizi telefonia pubblica </xsl:when>
                                                                                                    <xsl:when test="$RF='RF09'">rivendita documenti di trasporto pubblico e di sosta </xsl:when>
                                                                                                    <xsl:when test="$RF='RF10'">intrattenimenti, giochi e altre attività di cui alla tariffa allegata al DPR 640/72 </xsl:when>
                                                                                                    <xsl:when test="$RF='RF11'">agenzie viaggi e turismo </xsl:when>
                                                                                                    <xsl:when test="$RF='RF12'">agriturismo </xsl:when>
                                                                                                    <xsl:when test="$RF='RF13'">vendite a domicilio </xsl:when>
                                                                                                    <xsl:when test="$RF='RF14'">rivendita beni usati, oggetti d’arte, d’antiquariato o da collezione </xsl:when>
                                                                                                    <xsl:when test="$RF='RF15'">agenzie di vendite all’asta di oggetti d’arte, antiquariato o da collezione </xsl:when>
                                                                                                    <xsl:when test="$RF='RF16'">IVA per cassa P.A. </xsl:when>
                                                                                                    <xsl:when test="$RF='RF17'">IVA per cassa - art. 32-bis, D.L. 83/2012 </xsl:when>
                                                                                                    <xsl:when test="$RF='RF19'">Regime forfettario </xsl:when>
                                                                                                    <xsl:when test="$RF='RF18'">altro </xsl:when>
                                                                                                    <xsl:when test="$RF=''" />
                                                                                                    <xsl:otherwise>
                                                                                                         <fehler>
                                                                                                              (!!! falsche Kennung !!!)
                                                                                                              <i>(!!! codice non previsto !!!)</i>
                                                                                                         </fehler>
                                                                                                    </xsl:otherwise>
                                                                                               </xsl:choose>
                                                                                          </span>
                                                                                          (<xsl:value-of select="RegimeFiscale" />)
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                      </xsl:for-each>
                                                                 </table>
                                                            </xsl:if>
                                                            <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/CedentePrestatore/Sede">
                                                                 <div id="sub-heading">
                                                                      Firmensitz -
                                                                      <i>Dati della sede</i>
                                                                 </div>
                                                                 <table id="t1">
                                                                      <xsl:for-each select="a:FatturaElettronica/FatturaElettronicaHeader/CedentePrestatore/Sede">
                                                                           <xsl:if test="Indirizzo or NumeroCivico or CAP or Comune or Provincia or Nazione">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          Anschrift
                                                                                          <br />
                                                                                          <i>indirizzo</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span>
                                                                                               <xsl:value-of select="Indirizzo" />
                                                                                                
                                                                                               <xsl:value-of select="NumeroCivico" />
                                                                                               <br />
                                                                                               <xsl:value-of select="CAP" />
                                                                                                
                                                                                               <xsl:value-of select="Comune" />
                                                                                                
                                                                                               <xsl:value-of select="Provincia" />
                                                                                                
                                                                                               <xsl:value-of select="Nazione" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                      </xsl:for-each>
                                                                 </table>
                                                            </xsl:if>

                                                            <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/CedentePrestatore/StabileOrganizzazione">
                                                                 <div id="sub-heading">
                                                                      Daten der Organisation -
                                                                      <i>Dati della stabile organizzazione</i>
                                                                 </div>
                                                                 <table id="t1">
                                                                      <xsl:for-each select="a:FatturaElettronica/FatturaElettronicaHeader/CedentePrestatore/StabileOrganizzazione">
                                                                           <xsl:if test="Indirizzo or NumeroCivico or CAP or Comune or Provincia or Nazione">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          Anschrift
                                                                                          <br />
                                                                                          <i>indirizzo</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span>
                                                                                               <xsl:value-of select="Indirizzo" />
                                                                                                
                                                                                               <xsl:value-of select="NumeroCivico" />
                                                                                               <br />
                                                                                               <xsl:value-of select="CAP" />
                                                                                                
                                                                                               <xsl:value-of select="Comune" />
                                                                                                
                                                                                               <xsl:value-of select="Provincia" />
                                                                                                
                                                                                               <xsl:value-of select="Nazione" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                      </xsl:for-each>
                                                                 </table>
                                                            </xsl:if>

                                                            <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/CedentePrestatore/IscrizioneREA">
                                                                 <div id="sub-heading">
                                                                      Handelsregistereintragung -
                                                                      <i>Dati di iscrizione nel registro delle imprese</i>
                                                                 </div>
                                                                 <table id="t1" class="smalltext">
                                                                      <xsl:for-each select="a:FatturaElettronica/FatturaElettronicaHeader/CedentePrestatore/IscrizioneREA">
                                                                           <xsl:if test="Ufficio">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          Handelsregister der Provinz
                                                                                          <br />
                                                                                          <i>Uff. Reg. Imp. Provinciale</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span>
                                                                                               <xsl:value-of select="Ufficio" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="NumeroREA">
                                                                                <tr>
                                                                                     <td>
                                                                                          Eintragungsnummer
                                                                                          <br />
                                                                                          <i>Numero di iscrizione</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="NumeroREA" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="CapitaleSociale or SocioUnico">
                                                                                <tr>
                                                                                     <td>
                                                                                          Handelskapital
                                                                                          <br />
                                                                                          <i>Capitale sociale </i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <xsl:if test="CapitaleSociale">
                                                                                               <span>
                                                                                                    <xsl:value-of select="format-number(CapitaleSociale, '###.##0,00 €', 'euro')" />
                                                                                               </span>
                                                                                          </xsl:if>
                                                                                          <xsl:if test="SocioUnico">
                                                                                               <xsl:variable name="NS">
                                                                                                    <xsl:value-of select="SocioUnico" />
                                                                                               </xsl:variable>
                                                                                               <span>
                                                                                                    <xsl:choose>
                                                                                                         <xsl:when test="$NS='SU'">
                                                                                                              Einzelgesellschafter
                                                                                                              <i>socio unico </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$NS='SM'">
                                                                                                              mehrere Gesellschafter
                                                                                                              <i>più soci </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$NS=''" />
                                                                                                         <xsl:otherwise>
                                                                                                              <fehler>
                                                                                                                   (!!! falsche Kennung !!!)
                                                                                                                   <i>(!!! codice non previsto !!!)</i>
                                                                                                              </fehler>
                                                                                                         </xsl:otherwise>
                                                                                                    </xsl:choose>
                                                                                               </span>
                                                                                               (<xsl:value-of select="SocioUnico" />)
                                                                                          </xsl:if>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="StatoLiquidazione">
                                                                                <tr>
                                                                                     <td>
                                                                                          Auflösung
                                                                                          <br />
                                                                                          <i>Stato di liquidazione</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <xsl:variable name="SL">
                                                                                               <xsl:value-of select="StatoLiquidazione" />
                                                                                          </xsl:variable>
                                                                                          <span>
                                                                                               <xsl:choose>
                                                                                                    <xsl:when test="$SL='LS'">
                                                                                                         in Auflösung
                                                                                                         <i>in liquidazione </i>
                                                                                                    </xsl:when>
                                                                                                    <xsl:when test="$SL='LN'">
                                                                                                         nicht in Auflösung
                                                                                                         <i>non in liquidazione </i>
                                                                                                    </xsl:when>
                                                                                                    <xsl:when test="$SL=''" />
                                                                                                    <xsl:otherwise>
                                                                                                         <fehler>
                                                                                                              (!!! falsche Kennung !!!)
                                                                                                              <i>(!!! codice non previsto !!!)</i>
                                                                                                         </fehler>
                                                                                                    </xsl:otherwise>
                                                                                               </xsl:choose>
                                                                                          </span>     
                                                                                          (<xsl:value-of select="StatoLiquidazione" />)
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                      </xsl:for-each>
                                                                 </table>
                                                            </xsl:if>

                                                            <xsl:for-each select="a:FatturaElettronica/FatturaElettronicaHeader/CedentePrestatore/Contatti">
                                                                 <xsl:if test="Telefono or Fax or Email">
                                                                      <div id="sub-heading">
                                                                           Adresse -
                                                                           <i>Recapiti</i>
                                                                      </div>
                                                                      <table id="t1">
                                                                           <xsl:if test="Telefono">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          Telefon
                                                                                          <br />
                                                                                          <i>Telefono</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span>
                                                                                               <xsl:value-of select="Telefono" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="Fax">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          FAX
                                                                                          <br />
                                                                                          <i>Fax</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span>
                                                                                               <xsl:value-of select="Fax" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="Email">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          E-Mail
                                                                                          <br />
                                                                                          <i>E-mail</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span class="allow_break_word">
                                                                                               <xsl:value-of select="Email" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                      </table>
                                                                 </xsl:if>
                                                            </xsl:for-each>

                                                            <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/CedentePrestatore/RiferimentoAmministrazione">
                                                                 <div id="sub-heading">
                                                                      Hinweis Verwaltung / Buchhaltung -
                                                                      <i>Riferimento amministrativo</i>
                                                                 </div>
                                                                 <table id="t1">
                                                                      <tr>
                                                                           <td width="200px">
                                                                                Referenz
                                                                                <br />
                                                                                <i>Riferimento</i>
                                                                           </td>
                                                                           <td width="500px">
                                                                                <span>
                                                                                     <xsl:value-of select="a:FatturaElettronica/FatturaElettronicaHeader/CedentePrestatore/RiferimentoAmministrazione" />
                                                                                </span>
                                                                           </td>
                                                                      </tr>
                                                                 </table>
                                                            </xsl:if>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI CEDENTE PRESTATORE-->
                                                  <!--INIZIO DATI RAPPRESENTANTE FISCALE-->
                                                  <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/RappresentanteFiscale">
                                                       <div id="rappresentante-fiscale">
                                                            <h3>
                                                                 Daten des Vertreters für Steuerfragen für Dienstleisters / Lieferanten
                                                                 <br />
                                                                 <i>Dati del rappresentante fiscale del cedente / prestatore</i>
                                                            </h3>
                                                            <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/RappresentanteFiscale/DatiAnagrafici">
                                                                 <table id="t1">
                                                                      <xsl:for-each select="a:FatturaElettronica/FatturaElettronicaHeader/RappresentanteFiscale/DatiAnagrafici">
                                                                           <xsl:if test="IdFiscaleIVA">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          Mehrwertsteuernummer
                                                                                          <br />
                                                                                          <i>Ident. fiscale ai fini IVA</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span>
                                                                                               <xsl:value-of select="IdFiscaleIVA/IdPaese" />
                                                                                               <xsl:value-of select="IdFiscaleIVA/IdCodice" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="CodiceFiscale">
                                                                                <tr>
                                                                                     <td>
                                                                                          Steuernummer
                                                                                          <br />
                                                                                          <i>Codice fiscale</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="CodiceFiscale" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="Anagrafica/Denominazione or Anagrafica/Titolo or Anagrafica/Nome or Anagrafica/Cognome">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          Anschrift
                                                                                          <br />
                                                                                          <i>indirizzo</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span>
                                                                                               <xsl:value-of select="Anagrafica/Denominazione" />
                                                                                                
                                                                                               <xsl:value-of select="Anagrafica/Titolo" />
                                                                                               <xsl:value-of select="Anagrafica/Nome" />
                                                                                                
                                                                                               <xsl:value-of select="Anagrafica/Cognome" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>

                                                                           <xsl:if test="Anagrafica/CodEORI">
                                                                                <tr>
                                                                                     <td>
                                                                                          EORI-Kennung
                                                                                          <br />
                                                                                          <i>Codice EORI</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="Anagrafica/CodEORI" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                      </xsl:for-each>
                                                                 </table>
                                                            </xsl:if>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI RAPPRESENTANTE FISCALE-->

                                                  <!--INIZIO DATI CESSIONARIO COMMITTENTE-->
                                                  <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/CessionarioCommittente">
                                                       <div id="cessionario" class="roundedCorners">
                                                            <h3>
                                                                 Daten des Rechnungsempfängers
                                                                 <br />
                                                                 <i>Dati del cessionario / committente</i>
                                                            </h3>
                                                            <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/CessionarioCommittente/DatiAnagrafici">
                                                                 <table id="t1">
                                                                      <xsl:for-each select="a:FatturaElettronica/FatturaElettronicaHeader/CessionarioCommittente/DatiAnagrafici">
                                                                           <xsl:if test="Anagrafica/Denominazione or Anagrafica/Titolo or Anagrafica/Nome or Anagrafica/Cognome">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          Benennung
                                                                                          <br />
                                                                                          <i>denominazione</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span>
                                                                                               <xsl:value-of select="Anagrafica/Denominazione" />
                                                                                                
                                                                                               <xsl:value-of select="Anagrafica/Titolo" />
                                                                                               <xsl:value-of select="Anagrafica/Nome" />
                                                                                                
                                                                                               <xsl:value-of select="Anagrafica/Cognome" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="IdFiscaleIVA">
                                                                                <tr>
                                                                                     <td>
                                                                                          Mehrwertsteuernummer
                                                                                          <br />
                                                                                          <i>Ident. fiscale ai fini IVA</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="IdFiscaleIVA/IdPaese" />
                                                                                               <xsl:value-of select="IdFiscaleIVA/IdCodice" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="CodiceFiscale">
                                                                                <tr>
                                                                                     <td>
                                                                                          Steuernummer
                                                                                          <br />
                                                                                          <i>Codice Fiscale</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="CodiceFiscale" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="Anagrafica/CodEORI">
                                                                                <tr>
                                                                                     <td>
                                                                                          EORI-Kennung
                                                                                          <br />
                                                                                          <i>Codice EORI</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="Anagrafica/CodEORI" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                      </xsl:for-each>
                                                                 </table>
                                                            </xsl:if>
                                                            <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/CessionarioCommittente/Sede">
                                                                 <div id="sub-heading">
                                                                      Firmensitz -
                                                                      <i>Dati della sede</i>
                                                                 </div>
                                                                 <table id="t1">
                                                                      <xsl:for-each select="a:FatturaElettronica/FatturaElettronicaHeader/CessionarioCommittente/Sede">
                                                                           <xsl:if test="Indirizzo or NumeroCivico or CAP or Comune or Provincia or Nazione">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          Anschrift
                                                                                          <br />
                                                                                          <i>indirizzo</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span>
                                                                                               <xsl:value-of select="Indirizzo" />
                                                                                                
                                                                                               <xsl:value-of select="NumeroCivico" />
                                                                                               <br />
                                                                                               <xsl:value-of select="CAP" />
                                                                                                
                                                                                               <xsl:value-of select="Comune" />
                                                                                                
                                                                                               <xsl:value-of select="Provincia" />
                                                                                                
                                                                                               <xsl:value-of select="Nazione" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                      </xsl:for-each>
                                                                 </table>
                                                            </xsl:if>
                                                            <!-- neu seit Version 1.2-->
                                                            <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/CessionarioCommittente/StabileOrganizzazione">
                                                                 <div id="sub-heading">
                                                                      Firmensitz -
                                                                      <i>Dati della stabile organizzazione</i>
                                                                 </div>
                                                                 <table id="t1">
                                                                      <xsl:for-each select="a:FatturaElettronica/FatturaElettronicaHeader/CessionarioCommittente/StabileOrganizzazione">
                                                                           <xsl:if test="Indirizzo or NumeroCivico or CAP or Comune or Provincia or Nazione">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          Anschrift
                                                                                          <br />
                                                                                          <i>indirizzo</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span>
                                                                                               <xsl:value-of select="Indirizzo" />
                                                                                                
                                                                                               <xsl:value-of select="NumeroCivico" />
                                                                                               <br />
                                                                                               <xsl:value-of select="CAP" />
                                                                                                
                                                                                               <xsl:value-of select="Comune" />
                                                                                                
                                                                                               <xsl:value-of select="Provincia" />
                                                                                                
                                                                                               <xsl:value-of select="Nazione" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                      </xsl:for-each>
                                                                 </table>
                                                            </xsl:if>
                                                            <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/CessionarioCommittente/RappresentanteFiscale">
                                                                 <div id="sub-heading">
                                                                      Steuerberater -
                                                                      <i>Rappresentante fiscale</i>
                                                                 </div>
                                                                 <table id="t1">
                                                                      <xsl:for-each select="a:FatturaElettronica/FatturaElettronicaHeader/CessionarioCommittente/RappresentanteFiscale">
                                                                           <xsl:if test="IdFiscaleIVA">
                                                                                <tr>
                                                                                     <td>
                                                                                          Mehrwertsteuernummer
                                                                                          <br />
                                                                                          <i>Ident. fiscale ai fini IVA</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="IdFiscaleIVA/IdPaese" />
                                                                                               <xsl:value-of select="IdFiscaleIVA/IdCodice" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="Denominazione or Nome or Cognome">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          Benennung
                                                                                          <br />
                                                                                          <i>denominazione</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span>
                                                                                               <xsl:value-of select="Denominazione" />
                                                                                                
                                                                                               <xsl:value-of select="Nome" />
                                                                                                
                                                                                               <xsl:value-of select="Cognome" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                      </xsl:for-each>
                                                                 </table>
                                                            </xsl:if>
                                                            <!-- -->
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI CESSIONARIO COMMITTENTE-->
                                             </div>
                                             <div id="flex-container">                                             
                                                  <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/DatiTrasmissione">
                                                  <!--INIZIO DATI DELLA TRASMISSIONE-->
                                                  <div id="dati-trasmissione" class="roundedCorners">
                                                       <div id="sub-heading">
                                                            Daten zur Übertragung
                                                            <br />
                                                            <i>Dati relativi alla trasmissione</i>
                                                       </div>
                                                       <table id="t1" class="smalltext">
                                                            <xsl:for-each select="a:FatturaElettronica/FatturaElettronicaHeader/DatiTrasmissione">
                                                                 <xsl:if test="IdTrasmittente or ProgressivoInvio or FormatoTrasmissione">
                                                                      <tr>
                                                                           <td>
                                                                                Übertragungskennung
                                                                                <br />
                                                                                <i>Ident. di trasmissione</i>
                                                                           </td>
                                                                           <td>
                                                                                <span>
                                                                                     <xsl:if test="FormatoTrasmissione">
                                                                                          <xsl:value-of select="FormatoTrasmissione" />
                                                                                          :
                                                                                     </xsl:if>
                                                                                     <xsl:if test="IdTrasmittente">
                                                                                          <xsl:value-of select="IdTrasmittente/IdPaese" />
                                                                                          <xsl:value-of select="IdTrasmittente/IdCodice" />
                                                                                          _
                                                                                     </xsl:if>
                                                                                     <xsl:if test="ProgressivoInvio">
                                                                                          <xsl:value-of select="ProgressivoInvio" />
                                                                                     </xsl:if>
                                                                                </span>
                                                                           </td>
                                                                      </tr>
                                                                 </xsl:if>
                                                                 <xsl:if test="CodiceDestinatario">
                                                                      <tr>
                                                                           <td>
                                                                                Kennung Rechnungsempfänger
                                                                                <br />
                                                                                <i>Codice destinatario</i>
                                                                           </td>
                                                                           <td>
                                                                                <xsl:call-template name="CodiceUnivocoUfficio">
                                                                                     <xsl:with-param name="kode" select="CodiceDestinatario" />
                                                                                </xsl:call-template>
                                                                           </td>
                                                                      </tr>
                                                                 </xsl:if>
                                                                 <xsl:if test="ContattiTrasmittente/Telefono">
                                                                      <tr>
                                                                           <td>
                                                                                Telefonnummer Sender
                                                                                <br />
                                                                                <i>Telefono del trasmittente</i>
                                                                           </td>
                                                                           <td>
                                                                                <span>
                                                                                     <xsl:value-of select="ContattiTrasmittente/Telefono" />
                                                                                </span>
                                                                           </td>
                                                                      </tr>
                                                                 </xsl:if>
                                                                 <xsl:if test="ContattiTrasmittente/Email">
                                                                      <tr>
                                                                           <td>
                                                                                E-Mail des Senders
                                                                                <br />
                                                                                <i>E-mail del trasmittente</i>
                                                                           </td>
                                                                           <td>
                                                                                <span class="allow_break_word">
                                                                                     <xsl:value-of select="ContattiTrasmittente/Email" />
                                                                                </span>
                                                                           </td>
                                                                      </tr>
                                                                 </xsl:if>
                                                                 <!-- Version 1.2 -->
                                                                 <xsl:if test="PECDestinatario">
                                                                      <tr>
                                                                           <td>
                                                                                zertifizierte E-Mail des Empfängers
                                                                                <br />
                                                                                <i>E-mail certificata del destinatario</i>
                                                                           </td>
                                                                           <td>
                                                                                <span class="allow_break_word">
                                                                                     <xsl:value-of select="PECDestinatario" />
                                                                                </span>
                                                                           </td>
                                                                      </tr>
                                                                 </xsl:if>
                                                            </xsl:for-each>
                                                       </table>
                                                  </div>
                                             </xsl:if>
                                             <!--FINE DATI DELLA TRASMISSIONE-->

                                                  <!--INIZIO DATI TERZO INTERMEDIARIO SOGGETTO EMITTENTE-->
                                                  <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/TerzoIntermediarioOSoggettoEmittente">
                                                       <div id="terzointermediario" class="roundedCorners">

                                                            <xsl:for-each select="a:FatturaElettronica/FatturaElettronicaHeader/TerzoIntermediarioOSoggettoEmittente">
                                                                 <div id="sub-heading">
                                                                      Daten des Vermittlers des Emittenten
                                                                      <br />
                                                                      <i>Dati del terzo intermediario soggetto emittente</i>
                                                                 </div>

                                                                 <xsl:if test="DatiAnagrafici">
                                                                      <table id="t1" class="smalltext">
                                                                           <xsl:if test="DatiAnagrafici/Anagrafica/Denominazione or DatiAnagrafici/Anagrafica/Titolo or DatiAnagrafici/Anagrafica/Nome or DatiAnagrafici/Anagrafica/Cognome">
                                                                                <tr>
                                                                                     <td>
                                                                                          Anschrift
                                                                                          <br />
                                                                                          <i>indirizzo</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="DatiAnagrafici/Anagrafica/Denominazione" />
                                                                                                
                                                                                               <xsl:value-of select="DatiAnagrafici/Anagrafica/Titolo" />
                                                                                                
                                                                                               <xsl:value-of select="DatiAnagrafici/Anagrafica/Nome" />
                                                                                                
                                                                                               <xsl:value-of select="DatiAnagrafici/Anagrafica/Cognome" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>


                                                                           <xsl:if test="DatiAnagrafici/IdFiscaleIVA">
                                                                                <tr>
                                                                                     <td>
                                                                                          Mehrwertsteuernummer
                                                                                          <br />
                                                                                          <i>Ident. fiscale ai fini IVA</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="DatiAnagrafici/IdFiscaleIVA/IdPaese" />
                                                                                               <xsl:value-of select="DatiAnagrafici/IdFiscaleIVA/IdCodice" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="DatiAnagrafici/CodiceFiscale">
                                                                                <tr>
                                                                                     <td>
                                                                                          Steuernummer
                                                                                          <br />
                                                                                          <i>Codice Fiscale</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="DatiAnagrafici/CodiceFiscale" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="DatiAnagrafici/Anagrafica/CodEORI">
                                                                                <tr>
                                                                                     <td>
                                                                                          EORI-Kennung
                                                                                          <br />
                                                                                          <i>Codice EORI</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="DatiAnagrafici/Anagrafica/CodEORI" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                      </table>
                                                                 </xsl:if>
                                                            </xsl:for-each>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI TERZO INTERMEDIARIO SOGGETTO EMITTENTE-->

                                                  <!--INIZIO DATI SOGGETTO EMITTENTE-->
                                                  <xsl:if test="a:FatturaElettronica/FatturaElettronicaHeader/SoggettoEmittente">
                                                       <div id="soggetto-emittente" class="roundedCorners">
                                                            <div id="sub-heading">
                                                                 Rechnungsersteller
                                                                 <br />
                                                                 <i>Soggetto emittente la fattura</i>
                                                            </div>
                                                            <table id="t1" class="smalltext">
                                                                 <tr>
                                                                      <td>
                                                                           Austeller
                                                                           <br />
                                                                           <i>Soggetto emittente</i>
                                                                      </td>
                                                                      <td>
                                                                           <xsl:variable name="SC">
                                                                                <xsl:value-of select="a:FatturaElettronica/FatturaElettronicaHeader/SoggettoEmittente" />
                                                                           </xsl:variable>
                                                                           <span>
                                                                                <xsl:choose>
                                                                                     <xsl:when test="$SC='CC'">
                                                                                          Rechnungssteller
                                                                                          <i>cessionario/committente </i>
                                                                                     </xsl:when>
                                                                                     <xsl:when test="$SC='TZ'">
                                                                                          dritter
                                                                                          <i>terzo </i>
                                                                                     </xsl:when>
                                                                                     <xsl:when test="$SC=''" />
                                                                                     <xsl:otherwise>
                                                                                          <fehler>
                                                                                               (!!! falsche Kennung !!!)
                                                                                               <i>(!!! codice non previsto !!!)</i>
                                                                                          </fehler>
                                                                                     </xsl:otherwise>
                                                                                </xsl:choose>
                                                                           </span>
                                                                           (<xsl:value-of select="a:FatturaElettronica/FatturaElettronicaHeader/SoggettoEmittente" />)
                                                                      </td>
                                                                 </tr>
                                                            </table>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI SOGGETTO EMITTENTE-->
                                             </div>
                                             <div class="footer"></div>
                                        </div>
                                   </xsl:if>
                                   <!--FINE DATI HEADER-->

                                   <!--INIZIO DATI BODY-->

                                   <xsl:variable name="TOTALBODY">
                                        <xsl:value-of select="count(a:FatturaElettronica/FatturaElettronicaBody)" />
                                   </xsl:variable>

                                   <xsl:for-each select="a:FatturaElettronica/FatturaElettronicaBody">
                                        <xsl:if test="$TOTALBODY&gt;1">
                                             <h2>
                                                  Dokument Nummer
                                                  <i>Numero documento nel lotto</i>
                                                  :
                                                  <xsl:value-of select="position()" />
                                             </h2>
                                        </xsl:if>

                                        <div class="page">

                                             <xsl:variable name="Valuta" select="DatiGenerali/DatiGeneraliDocumento/Divisa" />

                                             <xsl:if test="DatiGenerali">
                                                  <!--INIZIO DATI GENERALI-->
                                                  <div id="dati-generali">
                                                       <xsl:if test="DatiGenerali/DatiGeneraliDocumento">
                                                            <!--INIZIO DATI GENERALI DOCUMENTO-->
                                                            <div id="dati-generali-documento" class="roundedCorners">
                                                                 <h2>
                                                                      <xsl:variable name="TD">
                                                                           <xsl:value-of select="DatiGenerali/DatiGeneraliDocumento/TipoDocumento" />
                                                                      </xsl:variable>
                                                                      <xsl:choose>
                                                                           <xsl:when test="$TD='TD01'">
                                                                                Rechnung
                                                                                <i>fattura </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD02'">
                                                                                Accontorechnung
                                                                                <i>acconto/anticipo su fattura </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD03'">
                                                                                Accontohonorar
                                                                                <i>acconto/anticipo su parcella </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD04'">
                                                                                Gutschrift
                                                                                <i>nota di credito </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD05'">
                                                                                Lastschrift
                                                                                <i>nota di debito </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD06'">
                                                                                Honorarnote
                                                                                <i>parcella </i>
                                                                           </xsl:when>
                                                                           <!-- Version 1.2.1 -->
                                                                           <xsl:when test="$TD='TD16'">
                                                                                Integration der internenen reverse charge Rechnungen
                                                                                <br />
                                                                                <i>Integrazione fattura reverse charge interno </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD17'">
                                                                                Integration/Selbsfakturierung für den Einkauf von Dienstleistungen aus dem Ausland
                                                                                <br />
                                                                                <i>Integrazione/autofattura per acquisto servizi dall'estero </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD18'">
                                                                                Integration für den Kauf von innergemeinschaftlichen Waren
                                                                                <br />
                                                                                <i>Integrazione per acquisto di beni intracomunitari </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD19'">
                                                                                Integration/Selbstfakturierung für den Kauf von Waren ex Art. 17, Abs. 2 DPR 633/72
                                                                                <br />
                                                                                <i>Integrazione/autofattura per acquisto di beni ex art.17 c.2 DPR 633/72 </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD20'">
                                                                                Selbstfakturierung Anzeige (Art.6c, Komma 8 Dekret 471/97)
                                                                                <br />
                                                                                <i>Autofattura denuncia (art.6c .8 d.lgs. 471/97) </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD21'">
                                                                                Selbstfakturierung bei Überschreiten des Plafonds
                                                                                <i>Autofattura per splafonamento </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD22'">
                                                                                Warenentnahme aus dem Mehrwertsteuerlager
                                                                                <br />
                                                                                <i>Estrazione beni da Deposito IVA </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD23'">
                                                                                Warenentnahme aus dem Mehrwertsteuerlager mit Mehrwertsteuerzahlung
                                                                                <br />
                                                                                <i>Estrazione beni da Deposito IVA con versamento dell'IVA </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD24'">
                                                                                Aufgeschobene Rechnung gemäß Artikel 21, Absatz 4, Dritter Satz Buchstabe a) (DPR 633/72)
                                                                                <br />
                                                                                <i>Fattura differita di cui all'art.21, comma 4, terzo periodo lett. a) DPR 633/72 </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD25'">
                                                                                Aufgeschobene Rechnung gemäß Artikel 21, Absatz 4, Dritter Satz Buchstabe b) (DPR 633/72)
                                                                                <br />
                                                                                <i>Fattura differita di cui all'art.21, comma 4, terzo periodo lett. b) DPR 633/72 </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD26'">
                                                                                Übertragung von abschreibungsfähigen Gütern und für interner Transaktionen (Art. 36 DPR 633/72)
                                                                                <br />
                                                                                <i>Cessione di beni ammortizzabili e per passaggi interni (art.36 DPR 633/72) </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD='TD27'">
                                                                                Rechnung für Eigenverbrauch oder für kostenlose Abtretungen ohne Entschädigung
                                                                                <br />
                                                                                <i>Fattura per autoconsumo o per cessioni gratuite senza rivalsa </i>
                                                                           </xsl:when>
                                                                           <!-- Version 1.2.2 -->
                                                                           <xsl:when test="$TD='TD28'">
                                                                                Ankäufe aus San Marino mit MwSt. (Rechnung in Papierform)
                                                                                <br />
                                                                                <i>Acquisti da San Marino con IVA (fattura cartacea) </i>
                                                                           </xsl:when>
                                                                           <xsl:when test="$TD=''" />
                                                                           <xsl:otherwise>
                                                                                <fehler>
                                                                                     !!! falsche Kennung !!!
                                                                                     <i>!!! codice non previsto !!!</i>
                                                                                </fehler>
                                                                           </xsl:otherwise>
                                                                      </xsl:choose>
                                                                      (<xsl:value-of select="DatiGenerali/DatiGeneraliDocumento/TipoDocumento" />)
                                                                 </h2>

                                                                 <table id="t1">
                                                                      <tr>
                                                                           <xsl:if test="DatiGenerali/DatiGeneraliDocumento/Data">
                                                                                <td>
                                                                                     Dok.-nummer und -datum
                                                                                     <br />
                                                                                     <i>Numero e data doc.</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span class="highlighted">
                                                                                          <xsl:value-of select="DatiGenerali/DatiGeneraliDocumento/Numero" />
                                                                                          vom / del 
                                                                                          <xsl:call-template name="FormatDate">
                                                                                               <xsl:with-param name="DateTime" select="DatiGenerali/DatiGeneraliDocumento/Data" />
                                                                                          </xsl:call-template>
                                                                                     </span>
                                                                                </td>
                                                                           </xsl:if>
                                                                           <xsl:if test="DatiGenerali/DatiGeneraliDocumento/ImportoTotaleDocumento">
                                                                                <td>
                                                                                     Gesamtbetrag Dokument
                                                                                     <br />
                                                                                     <i>Importo totale documento</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span class="highlighted">
                                                                                          <xsl:value-of select="$Valuta" />
                                                                                           
                                                                                          <xsl:variable name="ITD" select="DatiGenerali/DatiGeneraliDocumento/ImportoTotaleDocumento" />
                                                                                          <xsl:value-of select="format-number($ITD, '###.##0,00', 'euro')" />
                                                                                     </span>
                                                                                </td>
                                                                           </xsl:if>
                                                                      </tr>
                                                                      <xsl:if test="DatiGenerali/DatiGeneraliDocumento/Arrotondamento">
                                                                           <tr>
                                                                                <td>
                                                                                     Rundung auf dem Gesamtbetrag
                                                                                     <br />
                                                                                     <i>Arrotondamento su Importo totale documento</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="DatiGenerali/DatiGeneraliDocumento/Arrotondamento" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:for-each select="DatiGenerali/DatiGeneraliDocumento/Causale">
                                                                           <tr>
                                                                                <td>
                                                                                     Grund
                                                                                     <br />
                                                                                     <i>Causale</i>
                                                                                </td>
                                                                                <td colspan="3">
                                                                                     <span>
                                                                                          <xsl:value-of select="current()" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:for-each>
                                                                      <xsl:if test="DatiGenerali/DatiGeneraliDocumento/Art73">
                                                                           <tr>
                                                                                <td colspan="2">Art. 73 DPR 633/72</td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="DatiGenerali/DatiGeneraliDocumento/Art73" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                 </table>

                                                                 <!--INIZIO DATI DELLA RITENUTA-->
                                                                 <xsl:if test="DatiGenerali/DatiGeneraliDocumento/DatiRitenuta">
                                                                      <div id="dati-ritenuta">
                                                                           <xsl:for-each select="DatiGenerali/DatiGeneraliDocumento/DatiRitenuta">
                                                                                <div id="sub-heading">
                                                                                     Einbehalte -
                                                                                     <i>Ritenuta</i>
                                                                                </div>
                                                                                <table id="t1">
                                                                                     <xsl:if test="TipoRitenuta">
                                                                                          <tr>
                                                                                               <td width="200px">
                                                                                                    Art des Einbehaltes
                                                                                                    <br />
                                                                                                    <i>Tipologia ritenuta</i>
                                                                                               </td>
                                                                                               <td width="500px">
                                                                                                    <xsl:variable name="TR">
                                                                                                         <xsl:value-of select="TipoRitenuta" />
                                                                                                    </xsl:variable>
                                                                                                    <span>
                                                                                                         <xsl:choose>
                                                                                                              <xsl:when test="$TR='RT01'">ritenuta persone fisiche </xsl:when>
                                                                                                              <xsl:when test="$TR='RT02'">ritenuta persone giuridiche </xsl:when>
                                                                                                              <!-- Version 1.2.1-->
                                                                                                              <xsl:when test="$TR='RT03'">contributo INPS </xsl:when>
                                                                                                              <xsl:when test="$TR='RT04'">contributo ENASARCO </xsl:when>
                                                                                                              <xsl:when test="$TR='RT05'">contributo ENPAM </xsl:when>
                                                                                                              <xsl:when test="$TR='RT06'">altro contributo previdenziale </xsl:when>
                                                                                                              <xsl:when test="$TR=''" />
                                                                                                              <xsl:otherwise>
                                                                                                                   <fehler>
                                                                                                                        (!!! falsche Kennung !!!)
                                                                                                                        <i>(!!! codice non previsto !!!)</i>
                                                                                                                   </fehler>
                                                                                                              </xsl:otherwise>
                                                                                                         </xsl:choose>
                                                                                                    </span>
                                                                                                    (<xsl:value-of select="TipoRitenuta" />)
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="ImportoRitenuta">
                                                                                          <tr>
                                                                                               <td>
                                                                                                    Einbehaltener Betrag
                                                                                                    <br />
                                                                                                    <i>Importo ritenuta</i>
                                                                                               </td>
                                                                                               <td>
                                                                                                    <span>
                                                                                                         <xsl:value-of select="$Valuta" />
                                                                                                          
                                                                                                         <xsl:value-of select="format-number(ImportoRitenuta, '###.##0,00', 'euro')" />
                                                                                                    </span>
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="AliquotaRitenuta">
                                                                                          <tr>
                                                                                               <td>
                                                                                                    Einbehaltsatz
                                                                                                    <br />
                                                                                                    <i>Aliquota ritenuta (%)</i>
                                                                                               </td>
                                                                                               <td>
                                                                                                    <span>
                                                                                                         <xsl:value-of select="format-number(AliquotaRitenuta, '###')" />
                                                                                                         %
                                                                                                    </span>
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="CausalePagamento">
                                                                                          <tr>
                                                                                               <td>
                                                                                                    Zahlungsgrund
                                                                                                    <br />
                                                                                                    <i>Causale di pagamento</i>
                                                                                               </td>
                                                                                               <td>
                                                                                                    <xsl:variable name="CP">
                                                                                                         <xsl:value-of select="CausalePagamento" />
                                                                                                    </xsl:variable>
                                                                                                    <span>
                                                                                                         <xsl:if test="$CP!=''">
                                                                                                              Kennung nach Modell 770S
                                                                                                              <i>decodifica come da modello 770S </i>
                                                                                                         </xsl:if>
                                                                                                    </span>
                                                                                                    (<xsl:value-of select="CausalePagamento" />)
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                </table>
                                                                           </xsl:for-each>
                                                                      </div>
                                                                 </xsl:if>
                                                                 <!--FINE DATI DELLA RITENUTA-->

                                                                 <!--INIZIO DATI DEL BOLLO-->
                                                                 <xsl:if test="DatiGenerali/DatiGeneraliDocumento/DatiBollo">
                                                                      <div id="dati-bollo">
                                                                           <xsl:for-each select="DatiGenerali/DatiGeneraliDocumento/DatiBollo">
                                                                                <div id="sub-heading">
                                                                                     Stempelwert -
                                                                                     <i>Bollo</i>
                                                                                </div>
                                                                                <table id="t1">
                                                                                     <xsl:if test="BolloVirtuale">
                                                                                          <tr>
                                                                                               <td width="200px">
                                                                                                    Virtueller Stempelwert
                                                                                                    <br />
                                                                                                    <i>Bollo virtuale</i>
                                                                                               </td>
                                                                                               <td width="500px">
                                                                                                    <span>
                                                                                                         <xsl:value-of select="BolloVirtuale" />
                                                                                                    </span>
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="ImportoBollo">
                                                                                          <tr>
                                                                                               <td>
                                                                                                    Betrag Stempelwert
                                                                                                    <br />
                                                                                                    <i>Importo bollo</i>
                                                                                               </td>
                                                                                               <td>
                                                                                                    <span>
                                                                                                         <xsl:value-of select="$Valuta" />
                                                                                                          
                                                                                                         <xsl:value-of select="format-number(ImportoBollo, '###.##0,00', 'euro')" />
                                                                                                    </span>
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                </table>
                                                                           </xsl:for-each>
                                                                      </div>
                                                                 </xsl:if>
                                                                 <!--FINE DATI DEL BOLLO-->

                                                                 <!--INIZIO DATI DELLA CASSA PREVIDENZIALE-->
                                                                 <xsl:if test="DatiGenerali/DatiGeneraliDocumento/DatiCassaPrevidenziale">
                                                                      <div id="dati-cassa-previdenziale">
                                                                           <div id="sub-heading">
                                                                                Fürsorgekasse -
                                                                                <i>Cassa previdenziale</i>
                                                                           </div>
                                                                           <xsl:for-each select="DatiGenerali/DatiGeneraliDocumento/DatiCassaPrevidenziale">
                                                                                <table id="t1">
                                                                                     <xsl:if test="TipoCassa">
                                                                                          <tr>
                                                                                               <td width="200px">
                                                                                                    Fürsorgekasse
                                                                                                    <br />
                                                                                                    <i>Cassa previdenziale</i>
                                                                                               </td>
                                                                                               <td width="500px">
                                                                                                    <xsl:variable name="TC">
                                                                                                         <xsl:value-of select="TipoCassa" />
                                                                                                    </xsl:variable>
                                                                                                    <span>
                                                                                                         <xsl:choose>
                                                                                                              <xsl:when test="$TC='TC01'">Cassa Nazionale Previdenza e Assistenza Avvocati e Procuratori legali </xsl:when>
                                                                                                              <xsl:when test="$TC='TC02'">Cassa Previdenza Dottori Commercialisti </xsl:when>
                                                                                                              <xsl:when test="$TC='TC03'">Cassa Previdenza e Assistenza Geometri </xsl:when>
                                                                                                              <xsl:when test="$TC='TC04'">Cassa Nazionale Previdenza e Assistenza Ingegneri e Architetti liberi profess. </xsl:when>
                                                                                                              <xsl:when test="$TC='TC05'">Cassa Nazionale del Notariato </xsl:when>
                                                                                                              <xsl:when test="$TC='TC06'">Cassa Nazionale Previdenza e Assistenza Ragionieri e Periti commerciali </xsl:when>
                                                                                                              <xsl:when test="$TC='TC07'">Ente Nazionale Assistenza Agenti e Rappresentanti di Commercio-ENASARCO </xsl:when>
                                                                                                              <xsl:when test="$TC='TC08'">Ente Nazionale Previdenza e Assistenza Consulenti del Lavoro-ENPACL </xsl:when>
                                                                                                              <xsl:when test="$TC='TC09'">Ente Nazionale Previdenza e Assistenza Medici-ENPAM </xsl:when>
                                                                                                              <xsl:when test="$TC='TC10'">Ente Nazionale Previdenza e Assistenza Farmacisti-ENPAF </xsl:when>
                                                                                                              <xsl:when test="$TC='TC11'">Ente Nazionale Previdenza e Assistenza Veterinari-ENPAV </xsl:when>
                                                                                                              <xsl:when test="$TC='TC12'">Ente Nazionale Previdenza e Assistenza Impiegati dell'Agricoltura-ENPAIA </xsl:when>
                                                                                                              <xsl:when test="$TC='TC13'">Fondo Previdenza Impiegati Imprese di Spedizione e Agenzie Marittime </xsl:when>
                                                                                                              <xsl:when test="$TC='TC14'">Istituto Nazionale Previdenza Giornalisti Italiani-INPGI </xsl:when>
                                                                                                              <xsl:when test="$TC='TC15'">Opera Nazionale Assistenza Orfani Sanitari Italiani-ONAOSI </xsl:when>
                                                                                                              <xsl:when test="$TC='TC16'">Cassa Autonoma Assistenza Integrativa Giornalisti Italiani-CASAGIT </xsl:when>
                                                                                                              <xsl:when test="$TC='TC17'">Ente Previdenza Periti Industriali e Periti Industriali Laureati-EPPI </xsl:when>
                                                                                                              <xsl:when test="$TC='TC18'">Ente Previdenza e Assistenza Pluricategoriale-EPAP </xsl:when>
                                                                                                              <xsl:when test="$TC='TC19'">Ente Nazionale Previdenza e Assistenza Biologi-ENPAB </xsl:when>
                                                                                                              <xsl:when test="$TC='TC20'">Ente Nazionale Previdenza e Assistenza Professione Infermieristica-ENPAPI </xsl:when>
                                                                                                              <xsl:when test="$TC='TC21'">Ente Nazionale Previdenza e Assistenza Psicologi-ENPAP </xsl:when>
                                                                                                              <xsl:when test="$TC='TC22'">INPS </xsl:when>
                                                                                                              <xsl:when test="$TC=''" />
                                                                                                              <xsl:otherwise>
                                                                                                                   <fehler>
                                                                                                                        (!!! falsche Kennung !!!)
                                                                                                                        <i>(!!! codice non previsto !!!)</i>
                                                                                                                   </fehler>
                                                                                                              </xsl:otherwise>
                                                                                                         </xsl:choose>
                                                                                                    </span>
                                                                                                    (<xsl:value-of select="TipoCassa" />)
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="ImponibileCassa">
                                                                                          <tr>
                                                                                               <td>
                                                                                                    Grundlage Fürsorgebeitrag
                                                                                                    <br />
                                                                                                    <i>Imponibile previdenziale</i>
                                                                                               </td>
                                                                                               <td>
                                                                                                    <span>
                                                                                                         <xsl:value-of select="$Valuta" />
                                                                                                          
                                                                                                         <xsl:value-of select="format-number(ImponibileCassa, '###.##0,00', 'euro')" />
                                                                                                    </span>
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="AlCassa">
                                                                                          <tr>
                                                                                               <td>
                                                                                                    Fürsorgebeitragssatz (%)
                                                                                                    <br />
                                                                                                    <i>Aliquota contri. cassa (%)</i>
                                                                                               </td>
                                                                                               <td>
                                                                                                    <span>
                                                                                                         <xsl:value-of select="format-number(AlCassa, '###')" />
                                                                                                         %
                                                                                                    </span>
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="ImportoContributoCassa">
                                                                                          <tr>
                                                                                               <td>
                                                                                                    Fürsorgebeitrag
                                                                                                    <br />
                                                                                                    <i>Importo contributo cassa</i>
                                                                                               </td>
                                                                                               <td>
                                                                                                    <span>
                                                                                                         <xsl:value-of select="$Valuta" />
                                                                                                          
                                                                                                         <xsl:value-of select="format-number(ImportoContributoCassa, '###.##0,00', 'euro')" />
                                                                                                    </span>
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="AliquotaIVA">
                                                                                          <tr>
                                                                                               <td>
                                                                                                    MwSt-Satz
                                                                                                    <br />
                                                                                                    <i>Aliquota IVA applicata</i>
                                                                                               </td>
                                                                                               <td>
                                                                                                    <span>
                                                                                                         <xsl:value-of select="format-number(AliquotaIVA, '###')" />
                                                                                                         %
                                                                                                    </span>
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="Ritenuta">
                                                                                          <tr>
                                                                                               <td>
                                                                                                    Fürsorgebeitrag im Abzug
                                                                                                    <br />
                                                                                                    <i>Contributo cassa soggetto a ritenuta</i>
                                                                                               </td>
                                                                                               <td>
                                                                                                    <span>
                                                                                                         <xsl:value-of select="Ritenuta" />
                                                                                                    </span>
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="Natura">
                                                                                          <tr>
                                                                                               <td>
                                                                                                    Art der Beitragsfreistellung
                                                                                                    <br />
                                                                                                    <i>Tipologia di non imponibilità del contributo</i>
                                                                                               </td>
                                                                                               <td>
                                                                                                    <xsl:variable name="NT">
                                                                                                         <xsl:value-of select="Natura" />
                                                                                                    </xsl:variable>
                                                                                                    <span>
                                                                                                         <xsl:choose>
                                                                                                              <!-- Version 1.2.1 -->
                                                                                                              <xsl:when test="$NT='N1'">
                                                                                                                   ausgenommener Geschäftsvorg. ex Art. 15 (DPR 633/1972)
                                                                                                                   <br />
                                                                                                                   <i>Escluse ex. art. 15 del D.P.R. 633/1972 </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N2'">
                                                                                                                   nicht unterworfener Geschäftsvorg. (darf nach dem 31.12.2020 nicht mehr verwendet werden)
                                                                                                                   <br />
                                                                                                                   <i>non soggette (non più utilizabile dopo il 31.12.2020) </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N2.1'">
                                                                                                                   nicht unterworfener Geschäftsvorg. im Sinne der Artikel von 7 bis 7-septies des DPR 633/72
                                                                                                                   <br />
                                                                                                                   <i>Non soggette ad IVA ai sensi degli artt. da 7 a 7- septies del DPR 633/72 </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N2.2'">
                                                                                                                   nicht unterworfener Geschäftsvorg. – andere Fälle
                                                                                                                   <br />
                                                                                                                   <i>non soggette – altri casi </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N3'">
                                                                                                                   nicht Mehrwertsteuerpflichtig (darf nach dem 31.12.2020 nicht mehr verwendet werden)
                                                                                                                   <br />
                                                                                                                   <i>non imponibili (non più utilizabile dopo il 31.12.2020) </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N3.1'">
                                                                                                                   nicht Mehrwertsteuerpflichtig--Export
                                                                                                                   <br />
                                                                                                                   <i>non imponibili – esportazioni </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N3.2'">
                                                                                                                   nicht Mehrwertsteuerpflichtig--innergemeinschaftliche Verkäufe
                                                                                                                   <br />
                                                                                                                   <i>non imponibili – cessioni intracomunitarie </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N3.3'">
                                                                                                                   nicht Mehrwertsteuerpflichtig--Verkäufe nach San Marino
                                                                                                                   <br />
                                                                                                                   <i>non imponibili – cessioni verso San Marino </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N3.4'">
                                                                                                                   nicht Mehrwertsteuerpflichtig--als Exporte behandelte Transaktionen
                                                                                                                   <br />
                                                                                                                   <i>non imponibili – operazioni assimilate alle cessioni all’esportazione </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N3.5'">
                                                                                                                   nicht Mehrwertsteuerpflichtig--nach einer Absichtserklärung
                                                                                                                   <br />
                                                                                                                   <i>non imponibili – a seguito di dichiarazioni d’intento </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N3.6'">
                                                                                                                   nicht Mehrwertsteuerpflichtig--andere Operationen, die nicht zur Bildung des Plafonds beitragen
                                                                                                                   <br />
                                                                                                                   <i>non imponibili – altre operazioni che non concorrono alla formazione del plafond </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N4'">
                                                                                                                   befreit
                                                                                                                   <br />
                                                                                                                   <i>esenti </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N5'">
                                                                                                                   im Rahmen der Differenzbesteuerung
                                                                                                                   <br />
                                                                                                                   <i>regime del margine </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N6'">
                                                                                                                   Umkehrung der Steuerschuldnerschaft(darf nach dem 31.12.2020 nicht mehr verwendet werden)
                                                                                                                   <br />
                                                                                                                   <i>inversione contabile (non più utilizabile dopo il 31.12.2020) </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N6.1'">
                                                                                                                   Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Verkauf von Schrott und anderen recycelten Materialien
                                                                                                                   <br />
                                                                                                                   <i>inversione contabile – cessione di rottami e altri materiali di recupero </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N6.2'">
                                                                                                                   Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Verkauf von Gold und Silber laut Gesetz 7/2000 sowie gebrauchter Goldschmiedekunst durch zugelassene Händler (OPO)
                                                                                                                   <br />
                                                                                                                   <i>Inversione contabile - cessione di oro e argento ai sensi della legge 7/2000 nonché di oreficeria usata ad OPO </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N6.3'">
                                                                                                                   Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Unteraufträge im Bausektor
                                                                                                                   <br />
                                                                                                                   <i>inversione contabile – subappalto nel settore edile </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N6.4'">
                                                                                                                   Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Verkauf von Gebäuden
                                                                                                                   <br />
                                                                                                                   <i>inversione contabile – cessione di fabbricati </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N6.5'">
                                                                                                                   Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Verkauf von Mobiltelefonen
                                                                                                                   <br />
                                                                                                                   <i>inversione contabile – cessione di telefoni cellulari </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N6.6'">
                                                                                                                   Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Verkauf von elektronischen Geräten 
                                                                                                                   <br />
                                                                                                                   <i>inversione contabile – cessione di prodotti elettronici </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N6.7'">
                                                                                                                   Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Dienstleistungen des Bausektors und damit verwandte Sektoren
                                                                                                                   <br />
                                                                                                                   <i>inversione contabile – prestazioni comparto edile e settori connessi </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N6.8'">
                                                                                                                   Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Operationen im Energiesektor
                                                                                                                   <br />
                                                                                                                   <i>inversione contabile – operazioni settore energetico </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT='N6.9'">
                                                                                                                   Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - andere Fälle
                                                                                                                   <br />
                                                                                                                   <i>inversione contabile – altri casi </i>
                                                                                                              </xsl:when>
                                                                                                              <!-- Version 1.2 -->
                                                                                                              <xsl:when test="$NT='N7'">
                                                                                                                   MwSt.-Schuld in einem anderen EU-Land abgegolten (Dienstleistung im Bereich Telekommunikation, Rundfunk und Elektronik ex Art. 7-octies Buchstabe a, b, Art. 74-sexies DPR 633/72)
                                                                                                                   <br />
                                                                                                                   <i>IVA assolta in altro stato UE (prestazione di servizi di telecomunicazioni, tele-radiodiffusione ed elettronici ex art. 7-octies lett. a, b, art. 74-sexies DPR 633/72) </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$NT=''" />
                                                                                                              <xsl:otherwise>
                                                                                                                   <fehler>
                                                                                                                        (!!! falsche Kennung !!!)
                                                                                                                        <i>(!!! codice non previsto !!!)</i>
                                                                                                                   </fehler>
                                                                                                              </xsl:otherwise>
                                                                                                         </xsl:choose>
                                                                                                    </span>
                                                                                                    (<xsl:value-of select="Natura" />)
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="RiferimentoAmministrazione">
                                                                                          <tr>
                                                                                               <td>
                                                                                                    Hinweis Verwaltung / Buchhaltung
                                                                                                    <br />
                                                                                                    <i>Riferimento amministrativo / contabile</i>
                                                                                               </td>
                                                                                               <td>
                                                                                                    <span>
                                                                                                         <xsl:value-of select="RiferimentoAmministrazione" />
                                                                                                    </span>
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                </table>
                                                                           </xsl:for-each>
                                                                      </div>
                                                                 </xsl:if>
                                                                 <!--FINE DATI DELLA CASSA PREVIDENZIALE-->

                                                                 <!--INIZIO DATI SCONTO / MAGGIORAZIONE-->
                                                                 <xsl:if test="DatiGenerali/DatiGeneraliDocumento/ScontoMaggiorazione">
                                                                      <div id="sub-heading">
                                                                           Skonto/Aufschläge -
                                                                           <i>Sconto/maggiorazione</i>
                                                                      </div>
                                                                      <div id="dati-sconto-maggiorazione">
                                                                           <xsl:for-each select="DatiGenerali/DatiGeneraliDocumento/ScontoMaggiorazione">
                                                                                <table id="t1">
                                                                                     <xsl:if test="Tipo">
                                                                                          <tr>
                                                                                               <td width="200px">
                                                                                                    Prozentsatz-Typologie
                                                                                                    <br />
                                                                                                    <i>Percentuale e tipologia</i>
                                                                                               </td>
                                                                                               <td width="500px">
                                                                                                    <xsl:if test="Percentuale">
                                                                                                         <span>
                                                                                                              <xsl:value-of select="Percentuale" />
                                                                                                              %
                                                                                                         </span>
                                                                                                    </xsl:if>
                                                                                                    <xsl:variable name="TSM">
                                                                                                         <xsl:value-of select="Tipo" />
                                                                                                    </xsl:variable>
                                                                                                    <span>     
                                                                                                         <xsl:choose>
                                                                                                              <xsl:when test="$TSM='SC'">
                                                                                                                   Skonto
                                                                                                                   <i>sconto </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:when test="$TSM='MG'">
                                                                                                                   Aufpreis
                                                                                                                   <i>maggiorazione </i>
                                                                                                              </xsl:when>
                                                                                                              <xsl:otherwise>
                                                                                                                   <fehler>
                                                                                                                        (!!! falsche Kennung !!!)
                                                                                                                        <i>(!!! codice non previsto !!!)</i>
                                                                                                                   </fehler>
                                                                                                              </xsl:otherwise>
                                                                                                         </xsl:choose>
                                                                                                    </span>
                                                                                                    (<xsl:value-of select="Tipo" />)
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if> <!--
                                                                                     <xsl:if test="Percentuale">
                                                                                          <tr><td>2.1.1.8.2</td><td>Prozentsatz<br /><i>Percentuale</i></td>
                                                                                               <td><span><xsl:value-of select="Percentuale" /> %</span></td>
                                                                                          </tr>
                                                                                     </xsl:if> -->
                                                                                     <xsl:if test="Importo">
                                                                                          <tr>
                                                                                               <td>
                                                                                                    Betrag
                                                                                                    <br />
                                                                                                    <i>Importo</i>
                                                                                               </td>
                                                                                               <td>
                                                                                                    <span>
                                                                                                         <xsl:variable name="TSCM">
                                                                                                              <xsl:value-of select="Tipo" />
                                                                                                         </xsl:variable>
                                                                                                         <xsl:choose>
                                                                                                              <xsl:when test="$TSCM='SC'">-</xsl:when>
                                                                                                              <xsl:when test="$TSCM='MG'">+</xsl:when>
                                                                                                         </xsl:choose>
                                                                                                         <xsl:value-of select="format-number(Importo, '###.##0,00', 'euro')" />
                                                                                                    </span>
                                                                                               </td>
                                                                                          </tr>
                                                                                     </xsl:if>
                                                                                </table>
                                                                           </xsl:for-each>
                                                                      </div>
                                                                 </xsl:if>
                                                                 <!--FINE DATI SCONTO / MAGGIORAZIONE-->

                                                            </div>
                                                       </xsl:if>
                                                       <!--FINE DATI GENERALI DOCUMENTO-->
                                                  </div>
                                             </xsl:if>
                                             <!--FINE DATI GENERALI-->

                                             <!--INIZIO DATI BENI E SERVIZI-->
                                             <xsl:if test="DatiBeniServizi/DettaglioLinee">
                                                  <div id="dati-dettaglio-linee">
                                                       <!--INIZIO DATI DI DETTAGLIO DELLE LINEE-->
                                                       <xsl:if test="DatiBeniServizi/DettaglioLinee">
                                                            <div id="righe">
                                                                 <h3>
                                                                      Daten zur Lieferung -
                                                                      <i>Dati relativi alle linee di dettaglio della fornitura</i>
                                                                 </h3>
                                                                 <table id="t2">
                                                                      <tr bgcolor="#808080">
                                                                           <th align="center" width="5%">Nr</th>
                                                                           <th width="41%">
                                                                                Beschreibung
                                                                                <br />
                                                                                <i>
                                                                                     Descrizione cessione/prestazione
                                                                                </i>
                                                                           </th>
                                                                           <th width="8%">
                                                                                Menge
                                                                                <br />
                                                                                <i>
                                                                                     Quantità
                                                                                </i>
                                                                           </th>
                                                                           <th width="8%">
                                                                                ME
                                                                                <br />
                                                                                <i>
                                                                                     UM
                                                                                </i>
                                                                           </th>
                                                                           <th width="10%">
                                                                                Preis
                                                                                <br />
                                                                                <i>
                                                                                     Prezzo
                                                                                </i>
                                                                           </th>
                                                                           <th width="10%">
                                                                                + / -
                                                                           </th>
                                                                           <th width="10%">
                                                                                Preis gesamt
                                                                                <br />
                                                                                <i>
                                                                                     Prezzo totale
                                                                                </i>
                                                                           </th>
                                                                           <th width="8%">
                                                                                MwSt
                                                                                <br />
                                                                                <i>
                                                                                     IVA
                                                                                </i>
                                                                           </th>
                                                                      </tr>
                                                                      <xsl:for-each select="DatiBeniServizi/DettaglioLinee">
                                                                           <tr>
                                                                                <td align="center">
                                                                                     <span>
                                                                                          <xsl:value-of select="NumeroLinea" />
                                                                                     </span>
                                                                                </td>
                                                                                <td>
                                                                                     <xsl:if test="Descrizione">
                                                                                          <xsl:if test="CodiceArticolo">
                                                                                               <xsl:for-each select="CodiceArticolo">
                                                                                                    <xsl:if test="CodiceTipo">
                                                                                                         <span>
                                                                                                              <xsl:value-of select="CodiceTipo" />
                                                                                                         </span>
                                                                                                    </xsl:if>
                                                                                                    <xsl:if test="CodiceValore">
                                                                                                         <span>
                                                                                                              <xsl:value-of select="CodiceValore" />
                                                                                                         </span>
                                                                                                    </xsl:if>
                                                                                                    <br />
                                                                                               </xsl:for-each>
                                                                                          </xsl:if>
                                                                                          <span>
                                                                                               <xsl:value-of select="Descrizione" />
                                                                                          </span>
                                                                                     </xsl:if> <!-- 2.2.1.2 -->
                                                                                     <xsl:if test="TipoCessionePrestazione">
                                                                                          <br />
                                                                                          <xsl:variable name="TCP">
                                                                                               <xsl:value-of select="TipoCessionePrestazione" />
                                                                                          </xsl:variable>
                                                                                          <span>
                                                                                               <xsl:choose>
                                                                                                    <xsl:when test="$TCP='SC'">
                                                                                                         Skonto
                                                                                                         <i>sconto </i>
                                                                                                    </xsl:when>
                                                                                                    <xsl:when test="$TCP='PR'">
                                                                                                         Prämie
                                                                                                         <i>premio </i>
                                                                                                    </xsl:when>
                                                                                                    <xsl:when test="$TCP='AB'">
                                                                                                         Gutschrift
                                                                                                         <i>abbuono </i>
                                                                                                    </xsl:when>
                                                                                                    <xsl:when test="$TCP='AC'">
                                                                                                         Zusatzspesen
                                                                                                         <i>spesa accessoria </i>
                                                                                                    </xsl:when>
                                                                                                    <xsl:otherwise>
                                                                                                         <fehler>
                                                                                                              (!!! falsche Kennung !!!)
                                                                                                              <i>(!!! codice non previsto !!!)</i>
                                                                                                         </fehler>
                                                                                                    </xsl:otherwise>
                                                                                               </xsl:choose>
                                                                                          </span>
                                                                                          (<xsl:value-of select="TipoCessionePrestazione" />)
                                                                                          <!-- <span><xsl:value-of select="ScontoMaggiorazione/Percentuale" />%</span>   -->
                                                                                     </xsl:if>
                                                                                     <xsl:if test="RiferimentoAmministrazione">
                                                                                          <br />
                                                                                          <!-- 2.2.1.15: RiferimentoAmministrazione -->
                                                                                          Hinweis Verwaltung / Buchhaltung
                                                                                          <i>Riferimento amministrazione </i>
                                                                                          <span>
                                                                                               <xsl:value-of select="RiferimentoAmministrazione" />
                                                                                          </span>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="AltriDatiGestionali">
                                                                                          <xsl:for-each select="AltriDatiGestionali">
                                                                                               <xsl:if test="TipoDato">
                                                                                                    <br />
                                                                                                    <!-- 2.2.1.16.1: Datentyp <i>Tipo dato:</i> -->
                                                                                                    <xsl:value-of select="TipoDato" />
                                                                                                    :
                                                                                               </xsl:if>
                                                                                               <xsl:if test="RiferimentoTesto">
                                                                                                    <br />
                                                                                                    <!-- 2.2.1.16.2: Text-Wert <i>Valore testo</i> -->
                                                                                                    <span>
                                                                                                         <xsl:value-of select="RiferimentoTesto" />
                                                                                                    </span>
                                                                                               </xsl:if>
                                                                                               <xsl:if test="RiferimentoNumero">
                                                                                                    <br />
                                                                                                    <!-- 2.2.1.16.3: Nummerischer Wert<i>Valore numerico</i> -->
                                                                                                    <span>
                                                                                                         <xsl:value-of select="RiferimentoNumero" />
                                                                                                    </span>
                                                                                               </xsl:if>
                                                                                               <xsl:if test="RiferimentoData">
                                                                                                    <br />
                                                                                                    <!-- 2.2.1.16.4: Datumswert <i>Valore data </i>  -->
                                                                                                    <span>
                                                                                                         <xsl:call-template name="FormatDate">
                                                                                                              <xsl:with-param name="DateTime" select="RiferimentoData" />
                                                                                                         </xsl:call-template>
                                                                                                    </span>
                                                                                               </xsl:if>
                                                                                          </xsl:for-each>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="DataInizioPeriodo or DataFinePeriodo">
                                                                                          <br />
                                                                                          Leistungszeitraum
                                                                                          <i>periodo di riferimento:</i>
                                                                                          <br />
                                                                                          <span>
                                                                                               <xsl:if test="DataInizioPeriodo">
                                                                                                         <xsl:call-template name="FormatDate">
                                                                                                              <xsl:with-param name="DateTime" select="DataInizioPeriodo" />
                                                                                                         </xsl:call-template>
                                                                                               </xsl:if>
                                                                                               -
                                                                                               <xsl:if test="DataFinePeriodo">
                                                                                                         <xsl:call-template name="FormatDate">
                                                                                                              <xsl:with-param name="DateTime" select="DataFinePeriodo" />
                                                                                                         </xsl:call-template>
                                                                                               </xsl:if>
                                                                                          </span>
                                                                                     </xsl:if>
                                                                                </td>
                                                                                <td align="right">
                                                                                     <xsl:if test="Quantita">
                                                                                          <span>
                                                                                               <xsl:value-of select="format-number(Quantita, '#.###,###','euro')" />
                                                                                          </span>
                                                                                     </xsl:if>
                                                                                </td>
                                                                                <td>
                                                                                     <xsl:if test="UnitaMisura">
                                                                                          <span>
                                                                                               <xsl:value-of select="UnitaMisura" />
                                                                                          </span>
                                                                                     </xsl:if>
                                                                                </td>
                                                                                <td align="right">
                                                                                     <xsl:if test="PrezzoUnitario">
                                                                                          <span>
                                                                                               <xsl:value-of select="format-number(PrezzoUnitario, '###.##0,00###', 'euro')" />
                                                                                          </span>
                                                                                     </xsl:if>
                                                                                </td>
                                                                                <td align="right">
                                                                                     <xsl:if test="ScontoMaggiorazione/Tipo">
                                                                                          <xsl:for-each select="ScontoMaggiorazione">
                                                                                               <xsl:variable name="TSCM">
                                                                                                    <xsl:value-of select="Tipo" />
                                                                                               </xsl:variable>
                                                                                               <xsl:if test="Percentuale">
                                                                                                    <xsl:choose>
                                                                                                         <xsl:when test="$TSCM='SC'">-</xsl:when>
                                                                                                         <xsl:when test="$TSCM='MG'">+</xsl:when>
                                                                                                    </xsl:choose>
                                                                                                    <span>
                                                                                                         <xsl:value-of select="Percentuale" />
                                                                                                         %
                                                                                                    </span>
                                                                                                    <br />
                                                                                               </xsl:if>
                                                                                               <xsl:if test="Importo">
                                                                                                    <xsl:choose>
                                                                                                         <xsl:when test="$TSCM='SC'"> -</xsl:when>
                                                                                                         <xsl:when test="$TSCM='MG'"> +</xsl:when>
                                                                                                    </xsl:choose>
                                                                                                    <span>
                                                                                                         <xsl:value-of select="format-number(Importo, '###.##0,00', 'euro')" />
                                                                                                    </span>
                                                                                                    <br />
                                                                                               </xsl:if>
                                                                                               <xsl:choose>
                                                                                                    <xsl:when test="$TSCM='SC'">
                                                                                                         Rabatt
                                                                                                         <br /> 
                                                                                                         <i>sconto</i>
                                                                                                    </xsl:when>
                                                                                                    <xsl:when test="$TSCM='MG'">
                                                                                                         Aufpreis
                                                                                                         <br />
                                                                                                         <i>maggior.</i>
                                                                                                    </xsl:when>
                                                                                                    <xsl:otherwise>
                                                                                                         <fehler>
                                                                                                              (!!! falsche Kennung !!!)
                                                                                                              <i>(!!! codice non previsto !!!)</i>
                                                                                                         </fehler>
                                                                                                    </xsl:otherwise>
                                                                                               </xsl:choose>
                                                                                          </xsl:for-each>
                                                                                     </xsl:if>
                                                                                </td>
                                                                                <td align="right">
                                                                                     <xsl:if test="PrezzoTotale">
                                                                                          <span>
                                                                                               <xsl:value-of select="format-number(PrezzoTotale, '###.##0,00', 'euro')" />
                                                                                          </span>
                                                                                     </xsl:if>
                                                                                </td>
                                                                                <td align="center">
                                                                                     <xsl:if test="AliquotaIVA">
                                                                                          <xsl:variable name="IVA" select="AliquotaIVA" />
                                                                                          <xsl:choose>
                                                                                               <xsl:when test="$IVA='0.00' or $IVA='0'">
                                                                                                    <xsl:if test="Natura">
                                                                                                         <span>
                                                                                                              <xsl:value-of select="Natura" />
                                                                                                         </span>
                                                                                                    </xsl:if>
                                                                                               </xsl:when>
                                                                                               <xsl:otherwise>
                                                                                                    <span>
                                                                                                         <xsl:value-of select="format-number(AliquotaIVA, '##0')" />
                                                                                                    </span>
                                                                                               </xsl:otherwise>
                                                                                          </xsl:choose>
                                                                                     </xsl:if>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:for-each>
                                                                 </table>
                                                            </div>
                                                       </xsl:if>
                                                       <!--FINE DATI DI DETTAGLIO DELLE LINEE-->
                                                  </div>
                                             </xsl:if>
                                             <!--FINE DATI BENI E SERVIZI-->

                                             <!-- INIZIO BLOCCO DATI AGGIUNTIVI -->
                                             <div id="flex-container">
                                                  <!--INIZIO DATI DELL'ORDINE DI ACQUISTO-->
                                                  <xsl:if test="DatiGenerali/DatiOrdineAcquisto">
                                                       <div id="dati-ordine-acquisto"  class="roundedCorners">
                                                            <h3>
                                                                 Daten zur Bestellung -
                                                                 <i>Dati dell'ordine di acquisto</i>
                                                            </h3>
                                                            <table id="t1">
                                                                 <xsl:for-each select="DatiGenerali/DatiOrdineAcquisto">
                                                                      <xsl:if test="RiferimentoNumeroLinea">
                                                                           <tr>
                                                                                <td width="200px">
                                                                                     Zugehörige Zeilennummer der Rechnung
                                                                                     <br />
                                                                                     <i>Numero linea di fattura a cui si riferisce</i>
                                                                                </td>
                                                                                <td width="500px">
                                                                                     <xsl:for-each select="RiferimentoNumeroLinea">
                                                                                          <span>
                                                                                               <xsl:if test="(position( )) &gt; 1">, </xsl:if>
                                                                                               <xsl:value-of select="." />
                                                                                          </span>
                                                                                     </xsl:for-each>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="IdDocumento">
                                                                           <tr>
                                                                                <td width="200px">
                                                                                     Bestellkennung
                                                                                     <br />
                                                                                     <i>Ident. ordine di acquisto</i>
                                                                                </td>
                                                                                <td width="500px">
                                                                                     <span>
                                                                                          <xsl:value-of select="IdDocumento" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="Data">
                                                                           <tr>
                                                                                <td>
                                                                                     Bestellungsdatum
                                                                                     <br />
                                                                                     <i>Data ordine di acquisto</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:call-template name="FormatDate">
                                                                                               <xsl:with-param name="DateTime" select="Data" />
                                                                                          </xsl:call-template>
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="NumItem">
                                                                           <tr>
                                                                                <td>
                                                                                     Zeilennummer der Bestellung
                                                                                     <br />
                                                                                     <i>Numero linea ordine di acquisto</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="NumItem" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCommessaConvenzione">
                                                                           <tr>
                                                                                <td>
                                                                                     Verkaufs-/Konventionskodex
                                                                                     <br />
                                                                                     <i>Codice commessa/convenzione</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCommessaConvenzione" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCUP">
                                                                           <tr>
                                                                                <td>
                                                                                     Staatlicher Projektkodex
                                                                                     <br />
                                                                                     <i>Codice Unitario Progetto (CUP)</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCUP" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCIG">
                                                                           <tr>
                                                                                <td>
                                                                                     Ausschreibungskode
                                                                                     <br />
                                                                                     <i>Codice Ident. Gara (CIG)</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCIG" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                 </xsl:for-each>
                                                            </table>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI DELL'ORDINE DI ACQUISTO-->

                                                  <!--INIZIO DATI DEL CONTRATTO-->
                                                  <xsl:if test="DatiGenerali/DatiContratto">
                                                       <div id="dati-contratto" class="roundedCorners">
                                                            <h3>
                                                                 Vertragsdaten -
                                                                 <i>Dati del contratto</i>
                                                            </h3>
                                                            <table id="t1">
                                                                 <xsl:for-each select="DatiGenerali/DatiContratto">
                                                                      <xsl:if test="RiferimentoNumeroLinea">
                                                                           <tr>
                                                                                <td width="200px">
                                                                                     Zugehörige Zeilennummer der Rechnung
                                                                                     <br />
                                                                                     <i>Numero linea di fattura a cui si riferisce</i>
                                                                                </td>
                                                                                <td width="500px">
                                                                                     <xsl:for-each select="RiferimentoNumeroLinea">
                                                                                          <span>
                                                                                               <xsl:if test="(position( )) &gt; 1">, </xsl:if>
                                                                                               <xsl:value-of select="." />
                                                                                          </span>
                                                                                     </xsl:for-each>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="IdDocumento">
                                                                           <tr>
                                                                                <td width="200px">
                                                                                     Vertragskenndaten
                                                                                     <br />
                                                                                     <i>Ident. contratto</i>
                                                                                </td>
                                                                                <td width="500px">
                                                                                     <span>
                                                                                          <xsl:value-of select="IdDocumento" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="Data">
                                                                           <tr>
                                                                                <td>
                                                                                     Vertagsdatum
                                                                                     <br />
                                                                                     <i>Data contratto</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:call-template name="FormatDate">
                                                                                               <xsl:with-param name="DateTime" select="Data" />
                                                                                          </xsl:call-template>
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="NumItem">
                                                                           <tr>
                                                                                <td>
                                                                                     Zeilennummer Vertrag
                                                                                     <br />
                                                                                     <i>Numero linea contratto</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="NumItem" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCommessaConvenzione">
                                                                           <tr>
                                                                                <td>
                                                                                     Verkaufs-/Konventionskodex
                                                                                     <br />
                                                                                     <i>Codice commessa/convenzione</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCommessaConvenzione" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCUP">
                                                                           <tr>
                                                                                <td>
                                                                                     Staatlicher Projektkodex
                                                                                     <br />
                                                                                     <i>Codice Unitario Progetto (CUP)</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCUP" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCIG">
                                                                           <tr>
                                                                                <td>
                                                                                     Ausschreibungskode
                                                                                     <br />
                                                                                     <i>Codice Ident. Gara (CIG)</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCIG" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                 </xsl:for-each>
                                                            </table>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI DEL CONTRATTO-->

                                                  <!--INIZIO DATI CONVENZIONE-->
                                                  <xsl:if test="DatiGenerali/DatiConvenzione">
                                                       <div id="dati-convenzione" class="roundedCorners">
                                                            <h3>
                                                                 Daten der Konvention -
                                                                 <i>Dati della convenzione</i>
                                                            </h3>
                                                            <table id="t1">
                                                                 <xsl:for-each select="DatiGenerali/DatiConvenzione">
                                                                      <xsl:if test="RiferimentoNumeroLinea">
                                                                           <tr>
                                                                                <td width="200px">
                                                                                     Zugehörige Zeilennummer der Rechnung
                                                                                     <br />
                                                                                     <i>Numero linea di fattura a cui si riferisce</i>
                                                                                </td>
                                                                                <td width="500px">
                                                                                     <xsl:for-each select="RiferimentoNumeroLinea">
                                                                                          <span>
                                                                                               <xsl:if test="(position( )) &gt; 1">, </xsl:if>
                                                                                               <xsl:value-of select="." />
                                                                                          </span>
                                                                                     </xsl:for-each>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="IdDocumento">
                                                                           <tr>
                                                                                <td>
                                                                                     Konventionskennung
                                                                                     <br />
                                                                                     <i>Ident. convenzione</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="IdDocumento" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="Data">
                                                                           <tr>
                                                                                <td>
                                                                                     Datum Konvention
                                                                                     <br />
                                                                                     <i>Data convenzione</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:call-template name="FormatDate">
                                                                                               <xsl:with-param name="DateTime" select="Data" />
                                                                                          </xsl:call-template>
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="NumItem">
                                                                           <tr>
                                                                                <td>
                                                                                     Zeilennummer Konvention
                                                                                     <br />
                                                                                     <i>Numero linea convenzione</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="NumItem" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCommessaConvenzione">
                                                                           <tr>
                                                                                <td>
                                                                                     Verkaufs-/Konventionskodex
                                                                                     <br />
                                                                                     <i>Codice commessa/convenzione</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCommessaConvenzione" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCUP">
                                                                           <tr>
                                                                                <td>
                                                                                     Staatlicher Projektkodex
                                                                                     <br />
                                                                                     <i>Codice Unitario Progetto (CUP)</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCUP" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCIG">
                                                                           <tr>
                                                                                <td>
                                                                                     Ausschreibungskode
                                                                                     <br />
                                                                                     <i>Codice Ident. Gara (CIG)</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCIG" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                 </xsl:for-each>
                                                            </table>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI CONVENZIONE-->

                                                  <!--INIZIO DATI RICEZIONE-->
                                                  <xsl:if test="DatiGenerali/DatiRicezione">
                                                       <div id="dati-ricezione" class="roundedCorners">
                                                            <h3>
                                                                 Daten zum Erhalt der Leistung -
                                                                 <i>Dati della ricezione</i>
                                                            </h3>
                                                            <table id="t1">
                                                                 <xsl:for-each select="DatiGenerali/DatiRicezione">
                                                                      <xsl:if test="RiferimentoNumeroLinea">
                                                                           <tr>
                                                                                <td width="200px">
                                                                                     Zugehörige Zeilennummer der Rechnung
                                                                                     <br />
                                                                                     <i>Numero linea di fattura a cui si riferisce</i>
                                                                                </td>
                                                                                <td width="500px">
                                                                                     <xsl:for-each select="RiferimentoNumeroLinea">
                                                                                          <span>
                                                                                               <xsl:if test="(position( )) &gt; 1">, </xsl:if>
                                                                                               <xsl:value-of select="." />
                                                                                          </span>
                                                                                     </xsl:for-each>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="IdDocumento">
                                                                           <tr>
                                                                                <td>
                                                                                     Kennzeichen des Empfangs
                                                                                     <br />
                                                                                     <i>Ident. ricezione</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="IdDocumento" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="Data">
                                                                           <tr>
                                                                                <td>
                                                                                     Empfangsdatum
                                                                                     <br />
                                                                                     <i>Data ricezione</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:call-template name="FormatDate">
                                                                                               <xsl:with-param name="DateTime" select="Data" />
                                                                                          </xsl:call-template>
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="NumItem">
                                                                           <tr>
                                                                                <td>
                                                                                     Zeilennummer des Empfangs
                                                                                     <br />
                                                                                     <i>Numero linea ricezione</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="NumItem" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCommessaConvenzione">
                                                                           <tr>
                                                                                <td>
                                                                                     Verkaufs-/Konventionskodex
                                                                                     <br />
                                                                                     <i>Codice commessa/convenzione</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCommessaConvenzione" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCUP">
                                                                           <tr>
                                                                                <td>
                                                                                     Staatlicher Projektkodex
                                                                                     <br />
                                                                                     <i>Codice Unitario Progetto (CUP)</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCUP" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCIG">
                                                                           <tr>
                                                                                <td>
                                                                                     Ausschreibungskode
                                                                                     <br />
                                                                                     <i>Codice Ident. Gara (CIG)</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCIG" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                 </xsl:for-each>
                                                            </table>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI RICEZIONE-->

                                                  <!--INIZIO DATI FATTURE COLLEGATE-->
                                                  <xsl:if test="DatiGenerali/DatiFattureCollegate">
                                                       <div id="dati-fatture-collegate" class="roundedCorners">
                                                            <h3>
                                                                 Daten zu verbundenen Rechnungen -
                                                                 <i>Dati della fattura collegata</i>
                                                            </h3>
                                                            <table id="t1">
                                                                 <xsl:for-each select="DatiGenerali/DatiFattureCollegate">
                                                                      <xsl:if test="RiferimentoNumeroLinea">
                                                                           <tr>
                                                                                <td width="200px">
                                                                                     Zugehörige Zeilennummer der Rechnung
                                                                                     <br />
                                                                                     <i>Numero linea di fattura a cui si riferisce</i>
                                                                                </td>
                                                                                <td width="500px">
                                                                                     <xsl:for-each select="RiferimentoNumeroLinea">
                                                                                          <span>
                                                                                               <xsl:if test="(position( )) &gt; 1">, </xsl:if>
                                                                                               <xsl:value-of select="." />
                                                                                          </span>
                                                                                     </xsl:for-each>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="IdDocumento">
                                                                           <tr>
                                                                                <td>
                                                                                     Kennzeichen der dazugehörenden Rechnung
                                                                                     <br />
                                                                                     <i>Ident. fattura collegata</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="IdDocumento" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="Data">
                                                                           <tr>
                                                                                <td>
                                                                                     Datum der dazugehörenden Rechnung
                                                                                     <br />
                                                                                     <i>Data fattura collegata</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:call-template name="FormatDate">
                                                                                               <xsl:with-param name="DateTime" select="Data" />
                                                                                          </xsl:call-template>
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="NumItem">
                                                                           <tr>
                                                                                <td>
                                                                                     Zeilennummer bei der dazugehörenden Rechnung
                                                                                     <br />
                                                                                     <i>Numero linea fattura collegata</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="NumItem" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCommessaConvenzione">
                                                                           <tr>
                                                                                <td>
                                                                                     Verkaufs-/Konventionskodex
                                                                                     <br />
                                                                                     <i>Codice commessa/convenzione</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCommessaConvenzione" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCUP">
                                                                           <tr>
                                                                                <td>
                                                                                     Staatlicher Projektkodex
                                                                                     <br />
                                                                                     <i>Codice Unitario Progetto (CUP)</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCUP" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="CodiceCIG">
                                                                           <tr>
                                                                                <td>
                                                                                     Ausschreibungskode
                                                                                     <br />
                                                                                     <i>Codice Ident. Gara (CIG)</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="CodiceCIG" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                 </xsl:for-each>
                                                            </table>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI FATTURE COLLEGATE-->

                                                  <!--INIZIO DATI RIFERIMENTO SAL-->
                                                  <xsl:if test="DatiGenerali/DatiSAL">
                                                       <div id="dati-sal" class="roundedCorners">
                                                            <h3>
                                                                 Baufortschritt -
                                                                 <i>Stato avanzamento lavori</i>
                                                            </h3>
                                                            <table id="t1">
                                                                 <xsl:if test="DatiGenerali/DatiSAL/RiferimentoFase">
                                                                      <tr>
                                                                           <td width="200px">
                                                                                Nummer Baufortschritt
                                                                                <br />
                                                                                <i>Numero fase avanzamento</i>
                                                                           </td>
                                                                           <td width="500px">
                                                                                <xsl:for-each select="DatiGenerali/DatiSAL/RiferimentoFase">
                                                                                     <span>
                                                                                          <xsl:if test="(position( )) &gt; 1">, </xsl:if>
                                                                                          <xsl:value-of select="." />
                                                                                     </span>
                                                                                </xsl:for-each>
                                                                           </td>
                                                                      </tr>
                                                                 </xsl:if>
                                                            </table>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI RIFERIMENTO SAL-->

                                                  <!--INIZIO DATI  DDT-->
                                                  <xsl:if test="DatiGenerali/DatiDDT">
                                                       <div id="dati-ddt" class="roundedCorners">
                                                            <h3>
                                                                 Daten zum Warenbegleitschein (WBS) -
                                                                 <i>Dati del documento di trasporto (DDT)</i>
                                                            </h3>
                                                            <table id="t1">
                                                                 <xsl:for-each select="DatiGenerali/DatiDDT">
                                                                      <xsl:if test="NumeroDDT or DataDDT or RiferimentoNumeroLinea">
                                                                           <tr>
                                                                                <td width="200px">
                                                                                     Nummer, Datum WBS
                                                                                     <br />
                                                                                     <i>Numero data DDT</i>
                                                                                </td>
                                                                                <td width="500px">
                                                                                     <xsl:if test="NumeroDDT">
                                                                                          <span>
                                                                                               <xsl:value-of select="NumeroDDT" />
                                                                                          </span>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="DataDDT">
                                                                                          vom/
                                                                                          <i>del</i>
                                                                                           
                                                                                          <span>
                                                                                               <xsl:call-template name="FormatDate">
                                                                                                    <xsl:with-param name="DateTime" select="DataDDT" />
                                                                                               </xsl:call-template>
                                                                                          </span>
                                                                                     </xsl:if>
                                                                                     <xsl:if test="RiferimentoNumeroLinea">
                                                                                          <br />
                                                                                          Betrifft Zeile/
                                                                                          <i>Rif.linea</i>
                                                                                           
                                                                                          <xsl:for-each select="RiferimentoNumeroLinea">
                                                                                               <span>
                                                                                                    <xsl:if test="(position( )) &gt; 1">, </xsl:if>
                                                                                                    <xsl:value-of select="." />
                                                                                               </span>
                                                                                          </xsl:for-each>
                                                                                     </xsl:if>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                 </xsl:for-each>
                                                            </table>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI DDT-->

                                                  <!--INIZIO DATI  TRASPORTO-->
                                                  <xsl:if test="DatiGenerali/DatiTrasporto">
                                                       <div id="dati-trasporto" class="roundedCorners">
                                                            <h3>
                                                                 Daten zum Warentransport -
                                                                 <i>Dati relativi al trasporto</i>
                                                            </h3>
                                                            <xsl:if test="DatiGenerali/DatiTrasporto/DatiAnagraficiVettore">
                                                                 <div id="sub-heading">
                                                                      Daten des Frächters -
                                                                      <i>Dati del vettore</i>
                                                                 </div>
                                                            </xsl:if>
                                                            <table id="t1">
                                                                 <xsl:if test="DatiGenerali/DatiTrasporto/DatiAnagraficiVettore">
                                                                      <xsl:for-each select="DatiGenerali/DatiTrasporto/DatiAnagraficiVettore">
                                                                           <xsl:if test="Anagrafica/Denominazione">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          Benennung
                                                                                          <br />
                                                                                          <i>Denominazione</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span>
                                                                                               <xsl:value-of select="Anagrafica/Denominazione" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="Anagrafica/Titolo">
                                                                                <tr>
                                                                                     <td>
                                                                                          Honorartitel
                                                                                          <br />
                                                                                          <i>Titolo onorifico</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="Anagrafica/Titolo" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="Anagrafica/Nome">
                                                                                <tr>
                                                                                     <td width="200px">
                                                                                          Name
                                                                                          <br />
                                                                                          <i>Nome</i>
                                                                                     </td>
                                                                                     <td width="500px">
                                                                                          <span>
                                                                                               <xsl:value-of select="Anagrafica/Nome" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="Anagrafica/Cognome">
                                                                                <tr>
                                                                                     <td>
                                                                                          Nachname
                                                                                          <br />
                                                                                          <i>Cognome</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="Anagrafica/Cognome" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="IdFiscaleIVA/IdPaese">
                                                                                <tr>
                                                                                     <td>
                                                                                          Mehrwertsteuernummer
                                                                                          <br />
                                                                                          <i>Ident. fiscale ai fini IVA</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="IdFiscaleIVA/IdPaese" />
                                                                                               <xsl:value-of select="IdFiscaleIVA/IdCodice" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="CodiceFiscale">
                                                                                <tr>
                                                                                     <td>
                                                                                          Steuernummer
                                                                                          <br />
                                                                                          <i>Codice Fiscale</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="CodiceFiscale" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="Anagrafica/CodEORI">
                                                                                <tr>
                                                                                     <td>
                                                                                          EORI-Kennung
                                                                                          <br />
                                                                                          <i>Codice EORI</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="Anagrafica/CodEORI" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="NumeroLicenzaGuida">
                                                                                <tr>
                                                                                     <td>
                                                                                          Führerscheinnummer
                                                                                          <br />
                                                                                          <i>Numero licenza di guida</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="NumeroLicenzaGuida" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                      </xsl:for-each>
                                                                 </xsl:if>

                                                                 <xsl:if test="DatiGenerali/DatiTrasporto/MezzoTrasporto or DatiGenerali/DatiTrasporto/CausaleTrasporto or DatiGenerali/DatiTrasporto/NumeroColli or DatiGenerali/DatiTrasporto/Descrizione or DatiGenerali/DatiTrasporto/UnitaMisuraPeso or DatiGenerali/DatiTrasporto/PesoLordo or DatiGenerali/DatiTrasporto/PesoNetto or DatiGenerali/DatiTrasporto/DataOraRitiro or DatiGenerali/DatiTrasporto/DataInizioTrasporto or DatiGenerali/DatiTrasporto/TipoResa or DatiGenerali/DatiTrasporto/IndirizzoResa or DatiGenerali/DatiTrasporto/DataOraConsegna">
                                                                      <tr>
                                                                           <td colspan="3">
                                                                                <div id="sub-heading">
                                                                                     Weitere Daten -
                                                                                     <i>Altri dati</i>
                                                                                </div>
                                                                           </td>
                                                                      </tr>
                                                                      <xsl:for-each select="DatiGenerali/DatiTrasporto">
                                                                           <xsl:if test="MezzoTrasporto">
                                                                                <tr>
                                                                                     <td>
                                                                                          Transortmittel
                                                                                          <br />
                                                                                          <i>Mezzo di trasporto</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="MezzoTrasporto" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="CausaleTrasporto">
                                                                                <tr>
                                                                                     <td>
                                                                                          Transportgrund
                                                                                          <br />
                                                                                          <i>Causale trasporto</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="CausaleTrasporto" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="NumeroColli">
                                                                                <tr>
                                                                                     <td>
                                                                                          Anzahl der Frachtstücke
                                                                                          <br />
                                                                                          <i>Numero colli trasportati</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="NumeroColli" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="Descrizione">
                                                                                <tr>
                                                                                     <td>
                                                                                          Beschreibung der transportierten Güter
                                                                                          <br />
                                                                                          <i>Descrizione beni trasportati</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="Descrizione" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="UnitaMisuraPeso">
                                                                                <tr>
                                                                                     <td>
                                                                                          Messeinheit der Ware
                                                                                          <br />
                                                                                          <i>Unità di misura del peso merce</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="UnitaMisuraPeso" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="PesoLordo">
                                                                                <tr>
                                                                                     <td>
                                                                                          Bruttogewicht
                                                                                          <br />
                                                                                          <i>Peso lordo</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="PesoLordo" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="PesoNetto">
                                                                                <tr>
                                                                                     <td>
                                                                                          Nettogewicht
                                                                                          <br />
                                                                                          <i>Peso netto</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="PesoNetto" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="DataOraRitiro">
                                                                                <tr>
                                                                                     <td>
                                                                                          Datum und Zeit der Abholung
                                                                                          <br />
                                                                                          <i>Data e ora ritiro merce</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:call-template name="FormatDate">
                                                                                                    <xsl:with-param name="DateTime" select="DataOraRitiro" />
                                                                                               </xsl:call-template>
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="DataInizioTrasporto">
                                                                                <tr>
                                                                                     <td>
                                                                                          Datum Transportbeginn
                                                                                          <br />
                                                                                          <i>Data inizio trasporto</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:call-template name="FormatDate">
                                                                                                    <xsl:with-param name="DateTime" select="DataInizioTrasporto" />
                                                                                               </xsl:call-template>
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="TipoResa">
                                                                                <tr>
                                                                                     <td>
                                                                                          Typologie der Abgabe
                                                                                          <br />
                                                                                          <i>Tipologia di resa</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="TipoResa" />
                                                                                          </span>
                                                                                          (Kodifizierung nach ICC-Standard)
                                                                                          <br />
                                                                                          <i>(codifica secondo standard ICC)</i>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="IndirizzoResa/Indirizzo">
                                                                                <tr>
                                                                                     <td>
                                                                                          Adresse der Abgabe
                                                                                          <br />
                                                                                          <i>Indirizzo di resa</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="IndirizzoResa/Indirizzo" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="IndirizzoResa/NumeroCivico">
                                                                                <tr>
                                                                                     <td>
                                                                                          Hausnummer Abgabeadresse
                                                                                          <br />
                                                                                          <i>Numero civico indirizzo di resa</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="IndirizzoResa/NumeroCivico" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="IndirizzoResa/CAP">
                                                                                <tr>
                                                                                     <td>
                                                                                          PLZ Adresse Abgabe
                                                                                          <br />
                                                                                          <i>CAP indirizzo di resa</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="IndirizzoResa/CAP" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="IndirizzoResa/Comune">
                                                                                <tr>
                                                                                     <td>
                                                                                          Gemeinde Abgabe
                                                                                          <br />
                                                                                          <i>Comune di resa</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="IndirizzoResa/Comune" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="IndirizzoResa/Provincia">
                                                                                <tr>
                                                                                     <td>
                                                                                          Provinz Abgabe
                                                                                          <br />
                                                                                          <i>Provincia di resa</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="IndirizzoResa/Provincia" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="IndirizzoResa/Nazione">
                                                                                <tr>
                                                                                     <td>
                                                                                          Land der Abgabe
                                                                                          <br />
                                                                                          <i>Nazione di resa</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:value-of select="IndirizzoResa/Nazione" />
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="DataOraConsegna">
                                                                                <tr>
                                                                                     <td>
                                                                                          Datum und Uhrzeit der Lieferung
                                                                                          <br />
                                                                                          <i>Data e ora della consegna</i>
                                                                                     </td>
                                                                                     <td>
                                                                                          <span>
                                                                                               <xsl:call-template name="FormatDate">
                                                                                                    <xsl:with-param name="DateTime" select="DataOraConsegna" />
                                                                                               </xsl:call-template>
                                                                                          </span>
                                                                                     </td>
                                                                                </tr>
                                                                           </xsl:if>
                                                                      </xsl:for-each>
                                                                 </xsl:if>
                                                            </table>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI TRASPORTO-->

                                                  <!--INIZIO DATI VEICOLI-->
                                                  <xsl:if test="DatiVeicoli">
                                                       <div id="dati-veicoli" class="roundedCorners">
                                                            <h3>
                                                                 Daten zum Transportfahrzeug -
                                                                 <i>Dati Veicoli ex art. 38 dl 331/1993</i>
                                                            </h3>
                                                            <table id="t1">
                                                                 <xsl:for-each select="DatiVeicoli">
                                                                      <xsl:if test="Data">
                                                                           <tr>
                                                                                <td width="200px">
                                                                                     Datum Ersteinschreibung des Fahrzeuges
                                                                                     <br />
                                                                                     <i> prima immatricolazione / iscrizione PR </i>
                                                                                </td>
                                                                                <td width="500px">
                                                                                     <span>
                                                                                          <xsl:call-template name="FormatDate">
                                                                                               <xsl:with-param name="DateTime" select="Data" />
                                                                                          </xsl:call-template>
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                      <xsl:if test="TotalePercorso">
                                                                           <tr>
                                                                                <td>
                                                                                     Gesamtlänge Fahrt
                                                                                     <br />
                                                                                     <i>Totale percorso</i>
                                                                                </td>
                                                                                <td>
                                                                                     <span>
                                                                                          <xsl:value-of select="TotalePercorso" />
                                                                                     </span>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                 </xsl:for-each>
                                                            </table>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI VEICOLI-->                                                            

                                                  <!--INIZIO FATTURA PRINCIPALE-->
                                                  <xsl:if test="DatiGenerali/FatturaPrincipale/NumeroFatturaPrincipale">
                                                       <div id="fattura-principale" class="roundedCorners">
                                                            <h3>
                                                                 Daten zur Hauptrechnung -
                                                                 <i>Dati relativi alla fattura principale</i>
                                                            </h3>
                                                            <table id="t1">
                                                                 <xsl:if test="DatiGenerali/FatturaPrincipale/NumeroFatturaPrincipale">
                                                                      <tr>
                                                                           <td width="200px">
                                                                                Nummer der Hauptrechnung
                                                                                <br />
                                                                                <i>Numero fattura principale</i>
                                                                           </td>
                                                                           <td width="500px">
                                                                                <span>
                                                                                     <xsl:value-of select="DatiGenerali/FatturaPrincipale/NumeroFatturaPrincipale" />
                                                                                </span>
                                                                           </td>
                                                                      </tr>
                                                                 </xsl:if>
                                                                 <xsl:if test="DatiGenerali/FatturaPrincipale/DataFatturaPrincipale">
                                                                      <tr>
                                                                           <td width="200px">
                                                                                Datum Hauptrechnung
                                                                                <br />
                                                                                <i>Data fattura principale</i>
                                                                           </td>
                                                                           <td width="500px">
                                                                                <span>
                                                                                     <xsl:call-template name="FormatDate">
                                                                                          <xsl:with-param name="DateTime" select="DatiGenerali/FatturaPrincipale/DataFatturaPrincipale" />
                                                                                     </xsl:call-template>
                                                                                </span>
                                                                           </td>
                                                                      </tr>
                                                                 </xsl:if>
                                                            </table>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE FATTURA PRINCIPALE-->
                                             </div>
                                             <!-- FINE BLOCCO DATI AGGIUNTIVI -->

                                             <!--INIZIO DATI DI RIEPILOGO ALIQUOTE E NATURE-->
                                             <xsl:if test="DatiBeniServizi/DatiRiepilogo">
                                                  <div id="riepilogo-aliquote-nature">
                                                       <h3>
                                                            Daten zur MwSt. nach Satz und Art -
                                                            <i>Dati di riepilogo per aliquota IVA e natura</i>
                                                       </h3>
                                                       <table id="t2">
                                                            <tr bgcolor="#808080">
                                                                 <th width="8%">
                                                                      MwSt
                                                                      <br />
                                                                      <i>
                                                                           Aliq.
                                                                      </i>
                                                                 </th>
                                                                 <th width="20%">
                                                                      Art
                                                                      <br />
                                                                      <i>
                                                                           Natura
                                                                      </i>
                                                                 </th>
                                                                 <th width="10%">
                                                                      Spesen
                                                                      <br />
                                                                      <i>                                                                                
                                                                           Spese
                                                                      </i>
                                                                 </th>
                                                                 <th width="10%">
                                                                      Rundung
                                                                      <br />
                                                                      <i>                                                                             
                                                                           Arroton.
                                                                      </i>
                                                                 </th>
                                                                 <th width="10%">
                                                                      Grundlage
                                                                      <br />
                                                                      <i>
                                                                           Imponibile
                                                                      </i>
                                                                 </th>
                                                                 <th width="10%">
                                                                      Steuer
                                                                      <br />
                                                                      <i>
                                                                           Imposta
                                                                      </i>
                                                                 </th>
                                                                 <th width="10%">
                                                                      Fälligkeit
                                                                      <br />
                                                                      <i>
                                                                           Esigibilita
                                                                      </i>
                                                                 </th>
                                                                 <th width="20%">
                                                                      Ges.Bezug
                                                                      <br />
                                                                      <i>
                                                                           Rif.Norma
                                                                      </i>
                                                                 </th>
                                                            </tr>
                                                            <xsl:for-each select="DatiBeniServizi/DatiRiepilogo">
                                                                 <tr>
                                                                      <td align="center">
                                                                           <xsl:if test="AliquotaIVA">
                                                                                <xsl:variable name="IVA" select="AliquotaIVA" />
                                                                                <xsl:choose>
                                                                                     <xsl:when test="$IVA='0.00' or $IVA='0'">
                                                                                          <xsl:if test="Natura">
                                                                                               <span>
                                                                                                    <xsl:value-of select="Natura" />
                                                                                               </span>
                                                                                          </xsl:if>
                                                                                     </xsl:when>
                                                                                     <xsl:otherwise>
                                                                                          <span>
                                                                                               <xsl:value-of select="format-number(AliquotaIVA, '##0')" />
                                                                                          </span>
                                                                                     </xsl:otherwise>
                                                                                </xsl:choose>
                                                                           </xsl:if>
                                                                      </td>

                                                                      <td>
                                                                           <xsl:if test="Natura">
                                                                                <xsl:variable name="NAT1">
                                                                                     <xsl:value-of select="Natura" />
                                                                                </xsl:variable>
                                                                                <span>
                                                                                     <xsl:choose>
                                                                                          <!-- Version 1.2.1 -->
                                                                                          <xsl:when test="$NAT1='N1'">
                                                                                               ausgenommener Geschäftsvorg. ex Art. 15 (DPR 633/1972)
                                                                                               <br />
                                                                                               <i>Escluse ex. art. 15 del D.P.R. 633/1972 </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N2'">
                                                                                               nicht unterworfener Geschäftsvorg. (darf nach dem 31.12.2020 nicht mehr verwendet werden)
                                                                                               <br />
                                                                                               <i>non soggette (non più utilizabile dopo il 31.12.2020) </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N2.1'">
                                                                                               nicht unterworfener Geschäftsvorg. im Sinne der Artikel von 7 bis 7-septies des DPR 633/72
                                                                                               <br />
                                                                                               <i>Non soggette ad IVA ai sensi degli artt. da 7 a 7- septies del DPR 633/72 </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N2.2'">
                                                                                               nicht unterworfener Geschäftsvorg. – andere Fälle
                                                                                               <br />
                                                                                               <i>non soggette – altri casi </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N3'">
                                                                                               nicht Mehrwertsteuerpflichtig (darf nach dem 31.12.2020 nicht mehr verwendet werden)
                                                                                               <br />
                                                                                               <i>non imponibili (non più utilizabile dopo il 31.12.2020) </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N3.1'">
                                                                                               nicht Mehrwertsteuerpflichtig - Export
                                                                                               <br />
                                                                                               <i>non imponibili – esportazioni </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N3.2'">
                                                                                               nicht Mehrwertsteuerpflichtig--innergemeinschaftliche Verkäufe
                                                                                               <br />
                                                                                               <i>non imponibili – cessioni intracomunitarie </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N3.3'">
                                                                                               nicht Mehrwertsteuerpflichtig--Verkäufe nach San Marino
                                                                                               <br />
                                                                                               <i>non imponibili – cessioni verso San Marino </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N3.4'">
                                                                                               nicht Mehrwertsteuerpflichtig--als Exporte behandelte Transaktionen
                                                                                               <br />
                                                                                               <i>non imponibili – operazioni assimilate alle cessioni all’esportazione </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N3.5'">
                                                                                               nicht Mehrwertsteuerpflichtig--nach einer Absichtserklärung
                                                                                               <br />
                                                                                               <i>non imponibili – a seguito di dichiarazioni d’intento </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N3.6'">
                                                                                               nicht Mehrwertsteuerpflichtig--andere Operationen, die nicht zur Bildung des Plafonds beitragen
                                                                                               <br />
                                                                                               <i>non imponibili – altre operazioni che non concorrono alla formazione del plafond </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N4'">
                                                                                               befreit
                                                                                               <br />
                                                                                               <i>esenti </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N5'">
                                                                                               im Rahmen der Differenzbesteuerung
                                                                                               <br />
                                                                                               <i>regime del margine </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N6'">
                                                                                               Umkehrung derSteuerschuldnerschaft (darf nach dem 31.12.2020 nicht mehr verwendet werden)
                                                                                               <br />
                                                                                               <i>inversione contabile (non più utilizabile dopo il 31.12.2020) </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N6.1'">
                                                                                               Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Verkauf von Schrott und anderen recycelten Materialien
                                                                                               <br />
                                                                                               <i>inversione contabile – cessione di rottami e altri materiali di recupero </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N6.2'">
                                                                                               Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Verkauf von Gold und Silber laut Gesetz 7/2000 sowie gebrauchter Goldschmiedekunst durch zugelassene Händler (OPO)
                                                                                               <br />
                                                                                               <i>Inversione contabile - cessione di oro e argento ai sensi della legge 7/2000 nonché di oreficeria usata ad OPO </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N6.3'">
                                                                                               Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Unteraufträge im Bausektor
                                                                                               <br />
                                                                                               <i>inversione contabile – subappalto nel settore edile </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N6.4'">
                                                                                               Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Verkauf von Gebäuden
                                                                                               <br />
                                                                                               <i>inversione contabile – cessione di fabbricati </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N6.5'">
                                                                                               Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Verkauf von Mobiltelefonen
                                                                                               <br />
                                                                                               <i>inversione contabile – cessione di telefoni cellulari </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N6.6'">
                                                                                               Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Verkauf von elektronischen Geräten
                                                                                               <br />
                                                                                               <i>inversione contabile – cessione di prodotti elettronici </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N6.7'">
                                                                                               Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Dienstleistungen des Bausektors und damit verwandte Sektoren
                                                                                               <br />
                                                                                               <i>inversione contabile – prestazioni comparto edile e settori connessi </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N6.8'">
                                                                                               Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - Operationen im Energiesektor
                                                                                               <br />
                                                                                               <i>inversione contabile – operazioni settore energetico </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1='N6.9'">
                                                                                               Reverse-Charge (Umkehrung der Steuerschuldnerschaft) - andere Fälle
                                                                                               <br />
                                                                                               <i>inversione contabile – altri casi </i>
                                                                                          </xsl:when>
                                                                                          <!-- Version 1.2 -->
                                                                                          <xsl:when test="$NAT1='N7'">
                                                                                               MwSt.-Schuld in einem anderen EU-Land abgegolten (Dienstleistung im Bereich Telekommunikation, Rundfunk und Elektronik ex Art. 7-octies Buchstabe a, b, Art. 74-sexies DPR 633/72)
                                                                                               <br />
                                                                                               <i>IVA assolta in altro stato UE (prestazione di servizi di telecomunicazioni, tele-radiodiffusione ed elettronici ex art. 7-octies lett. a, b, art. 74-sexies DPR 633/72) </i>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$NAT1=''" />
                                                                                          <xsl:otherwise>
                                                                                               <fehler>
                                                                                                    (!!! falsche Kennung !!!)
                                                                                                    <i>(!!! codice non previsto !!!)</i>
                                                                                               </fehler>
                                                                                          </xsl:otherwise>
                                                                                     </xsl:choose>
                                                                                </span>
                                                                                (<xsl:value-of select="Natura" />)
                                                                           </xsl:if>
                                                                      </td>
                                                                      <td align="right">
                                                                           <xsl:if test="SpeseAccessorie">
                                                                                <span>
                                                                                     <xsl:value-of select="format-number(SpeseAccessorie, '###.##0,00', 'euro')" />
                                                                                </span>
                                                                           </xsl:if>
                                                                      </td>
                                                                      <td align="right">
                                                                           <xsl:if test="Arrotondamento">
                                                                                <span>
                                                                                     <xsl:value-of select="format-number(Arrotondamento, '###.##0,00', 'euro')" />
                                                                                </span>
                                                                           </xsl:if>
                                                                      </td>
                                                                      <td align="right">
                                                                           <xsl:if test="ImponibileImporto">
                                                                                <span>
                                                                                     <xsl:variable name="Ii" select="ImponibileImporto" />
                                                                                     <xsl:value-of select="format-number($Ii, '###.##0,00', 'euro')" />
                                                                                </span>
                                                                           </xsl:if>
                                                                      </td>
                                                                      <td align="right">
                                                                           <xsl:if test="Imposta">
                                                                                <span>
                                                                                     <xsl:value-of select="format-number(Imposta, '###.##0,00', 'euro')" />
                                                                                </span>
                                                                           </xsl:if>
                                                                      </td>
                                                                      <td>
                                                                           <xsl:if test="EsigibilitaIVA">
                                                                                <xsl:variable name="EI">
                                                                                     <xsl:value-of select="EsigibilitaIVA" />
                                                                                </xsl:variable>
                                                                                <span>
                                                                                     <xsl:choose>
                                                                                          <xsl:when test="$EI='I'">
                                                                                               <span>
                                                                                                    sofortige Fälligkeit
                                                                                                    <br />
                                                                                                    <i>
                                                                                                         esigibilità immediata 
                                                                                                    </i>
                                                                                               </span>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$EI='D'">
                                                                                               <span>
                                                                                                    aufgesch. Fälligkeit
                                                                                                    <br />
                                                                                                    <i>
                                                                                                         esigibilità differita 
                                                                                                    </i>
                                                                                               </span>
                                                                                          </xsl:when>
                                                                                          <xsl:when test="$EI='S'">
                                                                                               <span>
                                                                                                    split payment
                                                                                                    <br />
                                                                                                    <i>
                                                                                                         scissione dei pagamenti 
                                                                                                    </i>
                                                                                               </span>
                                                                                          </xsl:when>
                                                                                          <xsl:otherwise>
                                                                                               <fehler>
                                                                                                    (!!! falsche Kennung !!!)
                                                                                                    <i>(!!! codice non previsto !!!)</i>
                                                                                               </fehler>
                                                                                          </xsl:otherwise>
                                                                                     </xsl:choose>
                                                                                </span>
                                                                                (<xsl:value-of select="EsigibilitaIVA" />)
                                                                           </xsl:if>
                                                                      </td>
                                                                      <td>
                                                                           <xsl:if test="RiferimentoNormativo">
                                                                                <span>
                                                                                     <xsl:value-of select="RiferimentoNormativo" />
                                                                                </span>
                                                                           </xsl:if>
                                                                      </td>
                                                                 </tr>
                                                            </xsl:for-each>
                                                       </table>
                                                  </div>
                                             </xsl:if>
                                             <!--FINE DATI RIEPILOGO ALIQUOTE E NATURE-->

                                             <div id="flex-container">
                                                  <!--INIZIO DATI PAGAMENTO-->
                                                  <xsl:if test="DatiPagamento">
                                                       <div id="dati-pagamento-condizioni" class="roundedCorners">
                                                            <h3>
                                                                 Daten zur Bezahlung -
                                                                 <i>Dati relativi al pagamento</i>
                                                            </h3>
                                                            <xsl:for-each select="DatiPagamento">
                                                                 <xsl:if test="CondizioniPagamento">
                                                                      <table id="t1">
                                                                           <tr>
                                                                                <td width="200px">
                                                                                     Zahlungsbedingungen
                                                                                     <br />
                                                                                     <i>Condizioni di pagamento</i>
                                                                                </td>
                                                                                <td width="500px">
                                                                                     <xsl:variable name="CP">
                                                                                          <xsl:value-of select="CondizioniPagamento" />
                                                                                     </xsl:variable>
                                                                                     <span>
                                                                                          <xsl:choose>
                                                                                               <xsl:when test="$CP='TP01'">
                                                                                                    Ratenzahlung 
                                                                                                    <i>pagamento a rate </i>
                                                                                               </xsl:when>
                                                                                               <xsl:when test="$CP='TP02'">
                                                                                                    Einmalzahlung 
                                                                                                    <i>pagamento completo </i>
                                                                                               </xsl:when>
                                                                                               <xsl:when test="$CP='TP03'">
                                                                                                    Vorauszahlung 
                                                                                                    <i>anticipo </i>
                                                                                               </xsl:when>
                                                                                               <xsl:when test="$CP=''" />
                                                                                               <xsl:otherwise>
                                                                                                    <fehler>
                                                                                                         (!!! falsche Kennung !!!)
                                                                                                         <i>(!!! codice non previsto !!!)</i>
                                                                                                    </fehler>
                                                                                               </xsl:otherwise>
                                                                                          </xsl:choose>
                                                                                     </span>
                                                                                     (<xsl:value-of select="CondizioniPagamento" />)
                                                                                </td>
                                                                           </tr>
                                                                      </table>
                                                                 </xsl:if>

                                                                 <xsl:if test="DettaglioPagamento">
                                                                      <xsl:variable name="TOTALRATEN" select="count(DettaglioPagamento)" />
                                                                      <xsl:for-each select="DettaglioPagamento">
                                                                           <xsl:if test="$TOTALRATEN&gt;1">
                                                                                <div id="sub-heading">
                                                                                     Rate Nr.
                                                                                     <i>Rata N°</i>
                                                                                     : 
                                                                                     <xsl:value-of select="position()" />
                                                                                      
                                                                                     <xsl:call-template name="FormatDate">
                                                                                          <xsl:with-param name="DateTime" select="DataScadenzaPagamento" />
                                                                                     </xsl:call-template>
                                                                                </div>
                                                                           </xsl:if>
                                                                           <table id="t1">
                                                                                <xsl:if test="Beneficiario">
                                                                                     <tr>
                                                                                          <td width="200px">
                                                                                               Zahlungsempfänger
                                                                                               <br />
                                                                                               <i>Beneficiario pagamento</i>
                                                                                          </td>
                                                                                          <td width="500px">
                                                                                               <span>
                                                                                                    <xsl:value-of select="Beneficiario" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="ModalitaPagamento">
                                                                                     <tr>
                                                                                          <td width="200px">
                                                                                               Zahlungsmodalität
                                                                                               <br />
                                                                                               <i>Modalità di pagamento</i>
                                                                                          </td>
                                                                                          <td width="500px">
                                                                                               <xsl:variable name="MP">
                                                                                                    <xsl:value-of select="ModalitaPagamento" />
                                                                                               </xsl:variable>
                                                                                               <span>
                                                                                                    <xsl:choose>
                                                                                                         <xsl:when test="$MP='MP01'">
                                                                                                              bar
                                                                                                              <i>contanti </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP02'">
                                                                                                              Scheck
                                                                                                              <i>assegno </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP03'">
                                                                                                              Zirkularscheck
                                                                                                              <i>assegno circolare </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP04'">
                                                                                                              über Schatzamt
                                                                                                              <i>contanti presso Tesoreria </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP05'">
                                                                                                              Überweisung
                                                                                                              <i>bonifico </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP06'">
                                                                                                              Wechsel
                                                                                                              <i>vaglia cambiario </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP07'">
                                                                                                              Bankmitteilung
                                                                                                              <i>bollettino bancario </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP08'">
                                                                                                              Zahlkarte
                                                                                                              <i>carta di pagamento </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP09'"> (RID)</xsl:when>
                                                                                                         <xsl:when test="$MP='MP10'">
                                                                                                              RID normal
                                                                                                              <i>RID utenze </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP11'">
                                                                                                              RID Schnell
                                                                                                              <i>RID veloce </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP12'"> 
                                                                                                              RIBA 
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP13'"> 
                                                                                                              MAV 
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP14'"> 
                                                                                                              quietanza erario 
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP15'"> 
                                                                                                              giroconto su conti di contabilità speciale 
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP16'">
                                                                                                              Bankdauerauftrag
                                                                                                              <i>domiciliazione bancaria </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP17'">
                                                                                                              Postdauerauftrag
                                                                                                              <i>domiciliazione postale </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP18'">
                                                                                                              Postüberweisung
                                                                                                              <i>bollettino di c/c postale </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP19'"> 
                                                                                                              SEPA Direct Debit 
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP20'"> 
                                                                                                              SEPA Direct Debit CORE 
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP='MP21'"> 
                                                                                                              SEPA Direct Debit B2B 
                                                                                                         </xsl:when>
                                                                                                         <!-- Version 1.2 -->
                                                                                                         <xsl:when test="$MP='MP22'">
                                                                                                              Einbehalt auf bereits bezahlte Summe
                                                                                                              <i>Trattenuta su somme già riscosse </i>
                                                                                                         </xsl:when>
                                                                                                         <!-- Version 1.2.1 -->
                                                                                                         <xsl:when test="$MP='MP23'">
                                                                                                              pagoPA
                                                                                                              <i>pagoPA </i>
                                                                                                         </xsl:when>
                                                                                                         <xsl:when test="$MP=''" />
                                                                                                         <xsl:otherwise>
                                                                                                              <fehler>
                                                                                                                   (!!! falsche Kennung !!!)
                                                                                                                   <i>(!!! codice non previsto !!!)</i>
                                                                                                              </fehler>
                                                                                                         </xsl:otherwise>
                                                                                                    </xsl:choose>
                                                                                               </span>
                                                                                               (<xsl:value-of select="ModalitaPagamento" />)
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="DataRiferimentoTerminiPagamento">
                                                                                     <tr>
                                                                                          <td>
                                                                                               Beginn Zahlungsfrist
                                                                                               <br />
                                                                                               <i>Dec. termine pagamento</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:call-template name="FormatDate">
                                                                                                         <xsl:with-param name="DateTime" select="DataRiferimentoTerminiPagamento" />
                                                                                                    </xsl:call-template>
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="GiorniTerminiPagamento">
                                                                                     <tr>
                                                                                          <td>
                                                                                               Zahlungsziel (Tage)
                                                                                               <br />
                                                                                               <i>Term. pagamento (giorni)</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="GiorniTerminiPagamento" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="DataScadenzaPagamento">
                                                                                     <tr>
                                                                                          <td>
                                                                                               Datum Zahlungsziel
                                                                                               <br />
                                                                                               <i>Data scadenza pagamento</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:call-template name="FormatDate">
                                                                                                         <xsl:with-param name="DateTime" select="DataScadenzaPagamento" />
                                                                                                    </xsl:call-template>
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="ImportoPagamento">
                                                                                     <tr>
                                                                                          <td>
                                                                                               Betrag
                                                                                               <br />
                                                                                               <i>Importo</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="$Valuta" />
                                                                                                     
                                                                                                    <xsl:value-of select="format-number(ImportoPagamento, '###.##0,00', 'euro')" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="CodUfficioPostale">
                                                                                     <tr>
                                                                                          <td>
                                                                                               Kennung Postamt
                                                                                               <br />
                                                                                               <i>Codice Ufficio Postale</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="CodUfficioPostale" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="TitoloQuietanzante">
                                                                                     <tr>
                                                                                          <td>
                                                                                               Titel des Quittierenden
                                                                                               <br />
                                                                                               <i>Titolo del quietanzante</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="TitoloQuietanzante" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="NomeQuietanzante">
                                                                                     <tr>
                                                                                          <td>
                                                                                               Name des Quittierenden
                                                                                               <br />
                                                                                               <i>Nome del quietanzante</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="NomeQuietanzante" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="CognomeQuietanzante">
                                                                                     <tr>
                                                                                          <td>
                                                                                               Nachname des Quittierenden
                                                                                               <br />
                                                                                               <i>Cognome del quietanzante</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="CognomeQuietanzante" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="CFQuietanzante">
                                                                                     <tr>
                                                                                          <td>
                                                                                               StNr. des Quittierenden
                                                                                               <br />
                                                                                               <i>CF del quietanzante</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="CFQuietanzante" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="IstitutoFinanziario">
                                                                                     <tr>
                                                                                          <td>
                                                                                               Finanzinstitut
                                                                                               <br />
                                                                                               <i>Istituto finanziario</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="IstitutoFinanziario" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="IBAN">
                                                                                     <tr>
                                                                                          <td>
                                                                                               IBAN
                                                                                               <br />
                                                                                               <i>Codice IBAN</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="IBAN" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="ABI">
                                                                                     <tr>
                                                                                          <td>
                                                                                               ABI
                                                                                               <br />
                                                                                               <i>Codice ABI</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="ABI" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="CAB">
                                                                                     <tr>
                                                                                          <td>
                                                                                               CAB
                                                                                               <br />
                                                                                               <i>Codice CAB</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="CAB" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="BIC">
                                                                                     <tr>
                                                                                          <td>
                                                                                               BIC
                                                                                               <br />
                                                                                               <i>Codice BIC</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="BIC" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="ScontoPagamentoAnticipato">
                                                                                     <tr>
                                                                                          <td>
                                                                                               Skonto für Zahlung vor Zahlungsziel
                                                                                               <br />
                                                                                               <i>Sconto per pagamento anticipato</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="ScontoPagamentoAnticipato" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="DataLimitePagamentoAnticipato">
                                                                                     <tr>
                                                                                          <td>
                                                                                               letzter Termin für Zahlung vor Zahlungsziel
                                                                                               <br />
                                                                                               <i>Data limite per il pagamento anticipato</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:call-template name="FormatDate">
                                                                                                         <xsl:with-param name="DateTime" select="DataLimitePagamentoAnticipato" />
                                                                                                    </xsl:call-template>
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="PenalitaPagamentiRitardati">
                                                                                     <tr>
                                                                                          <td>
                                                                                               Pönale für verspätete Zahlung
                                                                                               <br />
                                                                                               <i>Penale per ritardato pagamento</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="PenalitaPagamentiRitardati" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="DataDecorrenzaPenale">
                                                                                     <tr>
                                                                                          <td>
                                                                                               Beginndatum für Anwendung der Pönale
                                                                                               <br />
                                                                                               <i>Data di decorrenza della penale</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:call-template name="FormatDate">
                                                                                                         <xsl:with-param name="DateTime" select="DataDecorrenzaPenale" />
                                                                                                    </xsl:call-template>
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                                <xsl:if test="CodicePagamento">
                                                                                     <tr>
                                                                                          <td>
                                                                                               Zahlungs-Kennung
                                                                                               <br />
                                                                                               <i>Codice pagamento</i>
                                                                                          </td>
                                                                                          <td>
                                                                                               <span>
                                                                                                    <xsl:value-of select="CodicePagamento" />
                                                                                               </span>
                                                                                          </td>
                                                                                     </tr>
                                                                                </xsl:if>
                                                                           </table>
                                                                      </xsl:for-each>
                                                                 </xsl:if>
                                                            </xsl:for-each>
                                                       </div>
                                                  </xsl:if>
                                                  <!--FINE DATI PAGAMENTO-->

                                                  <!-- INIZIO BLOCCO CONTROLLI PER CONTABILITÀ PA -->
                                                  <div id="controlli-contabilita-pa" class="roundedCorners">
                                                       <h3>
                                                            Kontrollen -
                                                            <i>Controlli</i>
                                                       </h3>
                                                       <table id="t1">
                                                            <tr>
                                                                 <td>
                                                                      MwSt.Nr. Rechnungsempfänger
                                                                      <br />
                                                                      <i>Partita IVA cessionario / committente</i>
                                                                 </td>
                                                                 <td>
                                                                      <xsl:choose>   
                                                                           <xsl:when test="/a:FatturaElettronica/FatturaElettronicaHeader/CessionarioCommittente/DatiAnagrafici/IdFiscaleIVA/IdCodice">
                                                                                <span style="color: green">
                                                                                     vorhanden 
                                                                                     <i>presente </i>
                                                                                     (<xsl:value-of select="/a:FatturaElettronica/FatturaElettronicaHeader/CessionarioCommittente/DatiAnagrafici/IdFiscaleIVA/IdPaese" />
                                                                                     <xsl:value-of select="/a:FatturaElettronica/FatturaElettronicaHeader/CessionarioCommittente/DatiAnagrafici/IdFiscaleIVA/IdCodice" />)
                                                                                </span>
                                                                           </xsl:when>
                                                                           <xsl:otherwise>
                                                                                <span style="color: #b00000">
                                                                                     nicht vorhanden 
                                                                                     <i>non presente</i>
                                                                                </span>
                                                                           </xsl:otherwise>
                                                                      </xsl:choose>
                                                                 </td>
                                                            </tr>
                                                            <tr>
                                                                 <td>
                                                                      CIG Kodex
                                                                      <br />
                                                                      <i>Codice CIG</i>
                                                                 </td>
                                                                 <td>
                                                                      <xsl:choose>   
                                                                           <xsl:when test="DatiGenerali/DatiOrdineAcquisto/CodiceCIG or DatiGenerali/DatiContratto/CodiceCIG or DatiGenerali/DatiConvenzione/CodiceCIG or DatiGenerali/DatiRicezione/CodiceCIG or DatiGenerali/DatiFattureCollegate/CodiceCIG">
                                                                                <span style="color: green">
                                                                                     vorhanden 
                                                                                     <i>presente </i>
                                                                                </span>
                                                                           </xsl:when>
                                                                           <xsl:otherwise>
                                                                                <span style="color: #b00000">
                                                                                     nicht vorhanden 
                                                                                     <i>non presente</i>
                                                                                </span>
                                                                           </xsl:otherwise>
                                                                      </xsl:choose>
                                                                 </td>
                                                            </tr>
                                                            <tr>
                                                                 <td>
                                                                      CUP Kodex
                                                                      <br />
                                                                      <i>Codice CUP</i>
                                                                 </td>
                                                                 <td>
                                                                      <xsl:choose>   
                                                                           <xsl:when test="DatiGenerali/DatiOrdineAcquisto/CodiceCUP or DatiGenerali/DatiContratto/CodiceCUP or DatiGenerali/DatiConvenzione/CodiceCUP or DatiGenerali/DatiRicezione/CodiceCUP or DatiGenerali/DatiFattureCollegate/CodiceCUP">
                                                                                <span style="color: green">
                                                                                     vorhanden 
                                                                                     <i>presente </i>
                                                                                </span>
                                                                           </xsl:when>
                                                                           <xsl:otherwise>
                                                                                <span style="color: #b00000">
                                                                                     nicht vorhanden 
                                                                                     <i>non presente</i>
                                                                                </span>
                                                                           </xsl:otherwise>
                                                                      </xsl:choose>
                                                                 </td>
                                                            </tr>                                                                                                                    
                                                       </table>
                                                  </div>
                                                  <!-- FINE BLOCCO CONTROLLI PER CONTABILITÀ PA -->
                                             </div>

                                             <!--INIZIO ALLEGATI-->
                                             <xsl:if test="Allegati">
                                                  <div id="allegati" class="roundedCorners">
                                                       <h3>
                                                            Daten zu den Anlagen -
                                                            <i>Dati relativi agli allegati</i>
                                                       </h3>
                                                       <xsl:for-each select="Allegati">
                                                            <table id="t1">
                                                                 <!-- generate a clickable link when the attachment is a pdf file -->
                                                                 <!-- TO TEST
                                                                      <xsl:if test="lower-case(FormatoAttachment)='pdf'">
                                                                           <tr>
                                                                                <td width="200px">
                                                                                     PDF-Datei
                                                                                     <br />
                                                                                     <i>File pdf</i>
                                                                                </td>
                                                                                <td>
                                                                                     <a>
                                                                                          <xsl:attribute name="href">
                                                                                               <xsl:value-of select="concat('data:application/pdf;base64,',Attachment)" />
                                                                                          </xsl:attribute>
                                                                                          Anlage öffnen / apri allegato
                                                                                     </a>
                                                                                </td>
                                                                           </tr>
                                                                      </xsl:if>
                                                                 -->
                                                                 <xsl:if test="NomeAttachment">
                                                                      <tr>
                                                                           <td width="200px">
                                                                                Name der Anlage
                                                                                <br />
                                                                                <i>Nome dell'allegato</i>
                                                                           </td>
                                                                           <td width="500px">
                                                                                <span>
                                                                                     <xsl:value-of select="NomeAttachment" />
                                                                                </span>
                                                                           </td>
                                                                      </tr>
                                                                 </xsl:if>
                                                                 <xsl:if test="AlgoritmoCompressione">
                                                                      <tr>
                                                                           <td>
                                                                                Kompressionsalgoritmus
                                                                                <br />
                                                                                <i>Algoritmo di compressione</i>
                                                                           </td>
                                                                           <td>
                                                                                <span>
                                                                                     <xsl:value-of select="AlgoritmoCompressione" />
                                                                                </span>
                                                                           </td>
                                                                      </tr>
                                                                 </xsl:if>
                                                                 <xsl:if test="FormatoAttachment">
                                                                      <tr>
                                                                           <td>
                                                                                Format
                                                                                <br />
                                                                                <i>Formato</i>
                                                                           </td>
                                                                           <td>
                                                                                <span>
                                                                                     <xsl:value-of select="FormatoAttachment" />
                                                                                </span>
                                                                           </td>
                                                                      </tr>
                                                                 </xsl:if>
                                                                 <xsl:if test="DescrizioneAttachment">
                                                                      <tr>
                                                                           <td>
                                                                                Beschreibung
                                                                                <br />
                                                                                <i>Descrizione</i>
                                                                           </td>
                                                                           <td>
                                                                                <span>
                                                                                     <xsl:value-of select="DescrizioneAttachment" />
                                                                                </span>
                                                                           </td>
                                                                      </tr>
                                                                 </xsl:if>
                                                            </table>
                                                       </xsl:for-each>
                                                  </div>
                                             </xsl:if>
                                             <!--FINE ALLEGATI-->
                                             <div class="footer">
                                                  <xsl:copy-of select="$VersionFT" />
                                                  FatturaPA Version/
                                                  <i>versione </i>
                                                  <xsl:value-of select="/a:FatturaElettronica/@versione" />
                                             </div>
                                        </div>
                                   </xsl:for-each>
                                   <!--FINE BODY-->

                              </div>
                         </xsl:if>
                    </div>
               </body>
          </html>
     </xsl:template>
</xsl:stylesheet>

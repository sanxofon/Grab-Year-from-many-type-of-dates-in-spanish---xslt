<?php

$xml_file = "dates.xml";
$xsl_file = "date_transform.xsl";

// Load the XML sources
$xml = new DOMDocument;
$xml->load($xml_file);
$xsl = new DOMDocument;
$xsl->load($xsl_file);

// Define the transformer
$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl); 

// Do transformation
$xml_transformed = $proc->transformToXML($xml);

// Output content
header("Content-Type: application/xml; charset=utf-8");
echo $xml_transformed;

?>
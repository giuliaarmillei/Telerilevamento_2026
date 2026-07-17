// ==============================================
// Sentinel-2 Surface Reflectance - Cloud Masking and Visualization
// Progetto Serra da Estrela - Giulia Armillei
// ==============================================

// Funzione per il mascheramento delle nuvole tramite banda QA60
function maskS2clouds(image) {
  var qa = image.select('QA60');
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;
  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
                 .and(qa.bitwiseAnd(cirrusBitMask).eq(0));
  return image.updateMask(mask).divide(10000);
}

// Selezione delle bande coerenti con la relazione in R (B12 esclusa)
var bands_to_export = ['B2', 'B3', 'B4', 'B8'];

// ==============================================
// 1. Pre-incendio (luglio2022)
// ==============================================
var col_luglio2022 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
  .filterBounds(aoi)
  .filterDate('2022-07-01', '2022-07-31') 
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
  .map(maskS2clouds);

var composite_luglio2022 = col_luglio2022.median().clip(aoi).select(bands_to_export);

Export.image.toDrive({
  image: composite_luglio2022,
  description: 'SerradaEstrela_Preincendio_luglio2022',
  folder: 'GEE_exports',
  fileNamePrefix: 'Preincendio_luglio2022',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326',
  maxPixels: 1e13
});

// ==============================================
// 2. Post-incendio (agosto 2022)
// ==============================================
var col_agosto2022 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
  .filterBounds(aoi)
  .filterDate('2022-08-10', '2022-08-31')
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
  .map(maskS2clouds);

var composite_agosto2022 = col_agosto2022.median().clip(aoi).select(bands_to_export);

Export.image.toDrive({
  image: composite_agosto2022,
  description: 'SerradaEstrela_Postincendio_agosto2022',
  folder: 'GEE_exports',
  fileNamePrefix: 'Postincendio_agosto2022',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326',
  maxPixels: 1e13
});

// ==============================================
// 3. Fase di recupero due anni dopo (agosto2024)
// ==============================================
var col_agosto2024 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
  .filterBounds(aoi)
  .filterDate('2024-08-10', '2024-08-31') 
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
  .map(maskS2clouds);

var composite_agosto2024 = col_agosto2024.median().clip(aoi).select(bands_to_export);

Export.image.toDrive({
  image: composite_agosto2024,
  description: 'SerradaEstrela_agosto2024',
  folder: 'GEE_exports',
  fileNamePrefix: 'SerradaEstrela_agosto2024',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326',
  maxPixels: 1e13
});

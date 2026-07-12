// ==============================================
// Immagine pre-incendio: luglio 2022
// ==============================================
// Funzione per mascherare le nuvole Sentinel-2
// Funzione per mascherare le nuvole Sentinel-2
function maskS2clouds(image) {
  var qa = image.select('QA60');
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;

  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
               .and(qa.bitwiseAnd(cirrusBitMask).eq(0));

  return image.updateMask(mask).divide(10000);
}

// ==============================================
// Area di interesse
var aoi = ee.Geometry.Rectangle([-7.7, 40.5, -7.2, 40.2]);
// ==============================================
Map.centerObject(aoi, 11);
Map.addLayer(aoi, {color: 'red'}, 'AOI Serra Da Estrela');

// ==============================================
// Caricamento Image Collection post-incendio
// ==============================================
var collection_pre = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
  .filterBounds(aoi)
  .filterDate('2022-07-01', '2022-07-31')
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
  .map(maskS2clouds);


// Numero di immagini disponibili
print('Number of images in post-fire collection:', collection_pre.size());

// ==============================================
// Creazione median composite
// ==============================================
var composite_pre = collection_pre.median().clip(aoi);

// ==============================================
// Visualizzazione sulla mappa (solo 3 bande per RGB)
// ==============================================
Map.centerObject(aoi, 10);

// Prima immagine RGB
Map.addLayer(collection_pre.first(), {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'First post-fire image RGB');

// Composite mediano RGB
Map.addLayer(composite_pre, {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'Median post-fire composite RGB');

// ==============================================
// Export su Google Drive
// ==============================================
Export.image.toDrive({
  image: composite_pre.select(['B2','B3','B4','B8']), 
  description: 'SerradaEstrela_PreIncendio_luglio2022',
  folder: 'GEE_exports',
  fileNamePrefix: 'PreIncendio_luglio2022',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326',
  maxPixels: 1e13
});

// Immagine Post incendio (dal 10/08/2022 al 31/08/2022)
// Nell'immagine è stata calcolata  la mediana 


// ==============================================
// Function to mask clouds using the QA60 band
// Bits 10 and 11 correspond to opaque clouds and cirrus
// ==============================================
// Funzione per mascherare le nuvole Sentinel-2
// Funzione per mascherare le nuvole Sentinel-2
function maskS2clouds(image) {
  var qa = image.select('QA60');
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;

  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
               .and(qa.bitwiseAnd(cirrusBitMask).eq(0));

  return image.updateMask(mask).divide(10000);
}

// ==============================================
// Area di interesse
var aoi = ee.Geometry.Rectangle([-7.7, 40.5, -7.2, 40.2]);
// ==============================================
Map.centerObject(aoi, 11);
Map.addLayer(aoi, {color: 'red'}, 'AOI Serra da Estrela');

// ==============================================
// Caricamento Image Collection post-incendio
// ==============================================
var collection_post = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
  .filterBounds(aoi)
  .filterDate('2022-08-10', '2022-08-31')       // Periodo post-incendio
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
  .map(maskS2clouds);

// Numero di immagini disponibili
print('Number of images in post-fire collection:', collection_post.size());

// ==============================================
// Creazione median composite
// ==============================================
var composite_post = collection_post.median().clip(aoi);

// ==============================================
// Visualizzazione sulla mappa (solo 3 bande per RGB)
// ==============================================
Map.centerObject(aoi, 10);

// Prima immagine RGB
Map.addLayer(collection_post.first(), {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'First post-fire image RGB');

// Composite mediano RGB
Map.addLayer(composite_post, {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'Median post-fire composite RGB');

// ==============================================
// Export su Google Drive 
// ==============================================
Export.image.toDrive({
  image: composite_post.select(['B2','B3','B4','B8']),  
  description: 'SerradaEstrela_PostIncendio_Agosto2022',
  folder: 'GEE_exports',
  fileNamePrefix: 'PostIncendio_Agosto2022',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326',
  maxPixels: 1e13
});

// Scarico l'immmagine dopo due anni 
function maskS2clouds(image) {
  var qa = image.select('QA60');
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;

  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
               .and(qa.bitwiseAnd(cirrusBitMask).eq(0));

  return image.updateMask(mask).divide(10000);
}

// ==============================================
// Area di interesse
var aoi = ee.Geometry.Rectangle([-7.7, 40.5, -7.2, 40.2]);
// ==============================================
Map.centerObject(aoi, 11);
Map.addLayer(aoi, {color: 'red'}, 'AOI Serra da Estrela');

// ==============================================
// Caricamento Image Collection un anno dopo (2024)
// ==============================================
var collection_post_2024 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
  .filterBounds(aoi)
  .filterDate('2024-08-10', '2024-08-31')       // stesso periodo, ma anno successivo
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
  .map(maskS2clouds);

// Numero di immagini disponibili
print('Number of images in 2024 collection:', collection_post_2023.size());

// ==============================================
// Creazione median composite
// ==============================================
var composite_post_2024 = collection_post_2024.median().clip(aoi);

// ==============================================
// Visualizzazione sulla mappa (solo 3 bande per RGB)
// ==============================================
Map.centerObject(aoi, 10);

// Prima immagine RGB 2024
Map.addLayer(collection_post_2024.first(), {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'First 2024 image RGB');

// Composite mediano RGB 2023
Map.addLayer(composite_post_2024, {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'Median 2024 composite RGB');

// ==============================================
// Export su Google Drive (include B12)
// ==============================================
Export.image.toDrive({
  image: composite_post_2024.select(['B2','B3','B4','B8']),
  description: 'SerradaEstrela_PostIncendio_Agosto2024',
  folder: 'GEE_exports',
  fileNamePrefix: 'PostIncendio_Agosto2024',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326',
  maxPixels: 1e13
});



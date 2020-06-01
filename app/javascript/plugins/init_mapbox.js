import mapboxgl from 'mapbox-gl';

console.log("on entre dans init mapbox");

var mapElement = document.getElementById('map');

const buildMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    //style: 'mapbox://styles/mapbox/streets-v11'
    style: 'mapbox://styles/olboaz/ck8oioz2c0st21inxruy9hij6?optimize=true',
    center: [2.341935, 48.859622], // starting position
    zoom: 10
  });
};

const addMarkersToMap = (map, markers) => {
  console.log("on entre dans addmarkers");
  console.log(markers);
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

    const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '25px';
      element.style.height = '25px';

    new mapboxgl.Marker(element)
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(map);
  });
};

const fitMapToMarkers = (map, markers) => {
  var bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 10.5, duration: 0});
};

const initMapbox = () => {
  if (mapElement) {
    var mapElementNew = document.getElementById('map');
    const map = buildMap();
    const markers = JSON.parse(mapElementNew.dataset.markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
    window.setTimeout(()=>map.resize(), 200);
    map.addControl(new mapboxgl.NavigationControl());
  }
};

export { initMapbox };

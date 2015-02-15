/**
 * An application with a basic interactive map. You can zoom and pan the map.
 */

import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.utils.*;
import java.util.*;

UnfoldingMap map;
List countryMarkers = new ArrayList();

void setup() {
  size(800, 600, P2D);

  map = new UnfoldingMap(this);
  map.zoomAndPanTo(new Location(39f, -94f), 4);
  MapUtils.createDefaultEventDispatcher(this, map);
  
  List airports = GeoJSONReader.loadData(this, "airports.geo.json");
  MarkerFactory markerFactory = new MarkerFactory();
  markerFactory.setPointClass(EarthquakeMarker.class);
  List<Marker> markers = markerFactory.createMarkers(airports);
  map.addMarkers(markers);
}

void draw() {
    map.draw();
    Location location = map.getLocation(mouseX, mouseY);
    fill(0);
    text(location.getLat() + ", " + location.getLon(), mouseX, mouseY);
}

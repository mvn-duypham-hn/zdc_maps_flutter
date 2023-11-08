part of zdc_maps_flutter;

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: library_private_types_in_public_api

/// Controller for a single ZdcMap instance running on the host platform.
class ZdcMapController {
  ZdcMapController._(
    this._zdcMapState, {
    required this.mapId,
  }) {
    _connectStreams(mapId);
  }

  /// The mapId for this controller
  final int mapId;

  /// Initialize control of a [ZdcMap] with [id].
  ///
  /// Mainly for internal use when instantiating a [ZdcMapController] passed
  /// in [ZdcMap.onMapCreated] callback.
  static Future<ZdcMapController> init(
    int id,
    CameraPosition initialCameraPosition,
    _ZdcMapState zdcMapState,
  ) async {
    await ZdcMapsFlutterPlatform.instance.init(id);
    return ZdcMapController._(
      zdcMapState,
      mapId: id,
    );
  }

  final _ZdcMapState _zdcMapState;

  void _connectStreams(int mapId) {
    if (_zdcMapState.widget.onCameraMoveStarted != null) {
      ZdcMapsFlutterPlatform.instance
          .onCameraMoveStarted(mapId: mapId)
          .listen((_) => _zdcMapState.widget.onCameraMoveStarted!());
    }
    if (_zdcMapState.widget.onCameraMove != null) {
      ZdcMapsFlutterPlatform.instance.onCameraMove(mapId: mapId).listen(
          (CameraMoveEvent e) => _zdcMapState.widget.onCameraMove!(e.value));
    }
    if (_zdcMapState.widget.onCameraIdle != null) {
      ZdcMapsFlutterPlatform.instance
          .onCameraIdle(mapId: mapId)
          .listen((_) => _zdcMapState.widget.onCameraIdle!());
    }
    ZdcMapsFlutterPlatform.instance
        .onMarkerTap(mapId: mapId)
        .listen((MarkerTapEvent e) => _zdcMapState.onMarkerTap(e.value));
    ZdcMapsFlutterPlatform.instance.onMarkerDragStart(mapId: mapId).listen(
        (MarkerDragStartEvent e) =>
            _zdcMapState.onMarkerDragStart(e.value, e.position));
    ZdcMapsFlutterPlatform.instance.onMarkerDrag(mapId: mapId).listen(
        (MarkerDragEvent e) => _zdcMapState.onMarkerDrag(e.value, e.position));
    ZdcMapsFlutterPlatform.instance.onMarkerDragEnd(mapId: mapId).listen(
        (MarkerDragEndEvent e) =>
            _zdcMapState.onMarkerDragEnd(e.value, e.position));
    ZdcMapsFlutterPlatform.instance.onInfoWindowTap(mapId: mapId).listen(
        (InfoWindowTapEvent e) => _zdcMapState.onInfoWindowTap(e.value));
    ZdcMapsFlutterPlatform.instance
        .onPolylineTap(mapId: mapId)
        .listen((PolylineTapEvent e) => _zdcMapState.onPolylineTap(e.value));
    ZdcMapsFlutterPlatform.instance
        .onPolygonTap(mapId: mapId)
        .listen((PolygonTapEvent e) => _zdcMapState.onPolygonTap(e.value));
    ZdcMapsFlutterPlatform.instance
        .onCircleTap(mapId: mapId)
        .listen((CircleTapEvent e) => _zdcMapState.onCircleTap(e.value));
    ZdcMapsFlutterPlatform.instance
        .onTap(mapId: mapId)
        .listen((MapTapEvent e) => _zdcMapState.onTap(e.position));
    ZdcMapsFlutterPlatform.instance
        .onLongPress(mapId: mapId)
        .listen((MapLongPressEvent e) => _zdcMapState.onLongPress(e.position));
  }

  /// Updates configuration options of the map user interface.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updateMapConfiguration(MapConfiguration update) {
    return ZdcMapsFlutterPlatform.instance
        .updateMapConfiguration(update, mapId: mapId);
  }

  /// Updates marker configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updateMarkers(MarkerUpdates markerUpdates) {
    return ZdcMapsFlutterPlatform.instance
        .updateMarkers(markerUpdates, mapId: mapId);
  }

  /// Updates polygon configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updatePolygons(PolygonUpdates polygonUpdates) {
    return ZdcMapsFlutterPlatform.instance
        .updatePolygons(polygonUpdates, mapId: mapId);
  }

  /// Updates polyline configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updatePolylines(PolylineUpdates polylineUpdates) {
    return ZdcMapsFlutterPlatform.instance
        .updatePolylines(polylineUpdates, mapId: mapId);
  }

  /// Updates circle configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updateCircles(CircleUpdates circleUpdates) {
    return ZdcMapsFlutterPlatform.instance
        .updateCircles(circleUpdates, mapId: mapId);
  }

  /// Updates tile overlays configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updateTileOverlays(Set<TileOverlay> newTileOverlays) {
    return ZdcMapsFlutterPlatform.instance
        .updateTileOverlays(newTileOverlays: newTileOverlays, mapId: mapId);
  }

  /// Clears the tile cache so that all tiles will be requested again from the
  /// [TileProvider].
  ///
  /// The current tiles from this tile overlay will also be
  /// cleared from the map after calling this method. The API maintains a small
  /// in-memory cache of tiles. If you want to cache tiles for longer, you
  /// should implement an on-disk cache.
  Future<void> clearTileCache(TileOverlayId tileOverlayId) async {
    return ZdcMapsFlutterPlatform.instance
        .clearTileCache(tileOverlayId, mapId: mapId);
  }

  /// Starts an animated change of the map camera position.
  ///
  /// The returned [Future] completes after the change has been started on the
  /// platform side.
  Future<void> animateCamera(CameraUpdate cameraUpdate) {
    return ZdcMapsFlutterPlatform.instance
        .animateCamera(cameraUpdate, mapId: mapId);
  }

  /// Changes the map camera position.
  ///
  /// The returned [Future] completes after the change has been made on the
  /// platform side.
  Future<void> moveCamera(CameraUpdate cameraUpdate) {
    return ZdcMapsFlutterPlatform.instance
        .moveCamera(cameraUpdate, mapId: mapId);
  }

  /// Sets the styling of the base map.
  ///
  /// Set to `null` to clear any previous custom styling.
  ///
  /// If problems were detected with the [mapStyle], including un-parsable
  /// styling JSON, unrecognized feature type, unrecognized element type, or
  /// invalid styler keys: [MapStyleException] is thrown and the current
  /// style is left unchanged.
  ///
  /// The style string can be generated using [map style tool](https://mapstyle.withgoogle.com/).
  /// Also, refer [iOS](https://developers.google.com/maps/documentation/ios-sdk/style-reference)
  /// and [Android](https://developers.google.com/maps/documentation/android-sdk/style-reference)
  /// style reference for more information regarding the supported styles.
  Future<void> setMapStyle(String? mapStyle) {
    return ZdcMapsFlutterPlatform.instance.setMapStyle(mapStyle, mapId: mapId);
  }

  /// Return [LatLngBounds] defining the region that is visible in a map.
  Future<LatLngBounds> getVisibleRegion() {
    return ZdcMapsFlutterPlatform.instance.getVisibleRegion(mapId: mapId);
  }

  /// Return [ScreenCoordinate] of the [LatLng] in the current map view.
  ///
  /// A projection is used to translate between on screen location and geographic coordinates.
  /// Screen location is in screen pixels (not display pixels) with respect to the top left corner
  /// of the map, not necessarily of the whole screen.
  Future<ScreenCoordinate> getScreenCoordinate(LatLng latLng) {
    return ZdcMapsFlutterPlatform.instance
        .getScreenCoordinate(latLng, mapId: mapId);
  }

  /// Returns [LatLng] corresponding to the [ScreenCoordinate] in the current map view.
  ///
  /// Returned [LatLng] corresponds to a screen location. The screen location is specified in screen
  /// pixels (not display pixels) relative to the top left of the map, not top left of the whole screen.
  Future<LatLng> getLatLng(ScreenCoordinate screenCoordinate) {
    return ZdcMapsFlutterPlatform.instance
        .getLatLng(screenCoordinate, mapId: mapId);
  }

  /// Programmatically show the Info Window for a [Marker].
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [hideMarkerInfoWindow] to hide the Info Window.
  ///   * [isMarkerInfoWindowShown] to check if the Info Window is showing.
  Future<void> showMarkerInfoWindow(MarkerId markerId) {
    return ZdcMapsFlutterPlatform.instance
        .showMarkerInfoWindow(markerId, mapId: mapId);
  }

  /// Programmatically hide the Info Window for a [Marker].
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [showMarkerInfoWindow] to show the Info Window.
  ///   * [isMarkerInfoWindowShown] to check if the Info Window is showing.
  Future<void> hideMarkerInfoWindow(MarkerId markerId) {
    return ZdcMapsFlutterPlatform.instance
        .hideMarkerInfoWindow(markerId, mapId: mapId);
  }

  /// Returns `true` when the [InfoWindow] is showing, `false` otherwise.
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [showMarkerInfoWindow] to show the Info Window.
  ///   * [hideMarkerInfoWindow] to hide the Info Window.
  Future<bool> isMarkerInfoWindowShown(MarkerId markerId) {
    return ZdcMapsFlutterPlatform.instance
        .isMarkerInfoWindowShown(markerId, mapId: mapId);
  }

  /// Returns the current zoom level of the map
  Future<double> getZoomLevel() {
    return ZdcMapsFlutterPlatform.instance.getZoomLevel(mapId: mapId);
  }

  /// Returns the image bytes of the map
  Future<Uint8List?> takeSnapshot() {
    return ZdcMapsFlutterPlatform.instance.takeSnapshot(mapId: mapId);
  }

  /// Disposes of the platform resources
  void dispose() {
    ZdcMapsFlutterPlatform.instance.dispose(mapId: mapId);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'ui/style/colors.dart';

class MapScreenOSM extends StatefulWidget {
  const MapScreenOSM({super.key});

  @override
  State<MapScreenOSM> createState() => _MapScreenOSMState();
}

class _MapScreenOSMState extends State<MapScreenOSM> {
  LatLng? pontoClicado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Obter Coordenadas'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: const LatLng(-22.7130000, -46.8180000),
              initialZoom: 15.0,
              onTap: (tapPosition, latLng) {
                setState(() {
                  pontoClicado = latLng;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.flutter_obter_posicao_map',
              ),
              if (pontoClicado != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: pontoClicado!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_on,
                        color: AppColors.yellow,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: const BoxDecoration(
                color: AppColors.navy,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: pontoClicado == null
                  ? const Row(
                      children: [
                        Icon(Icons.touch_app, color: AppColors.yellow, size: 20),
                        SizedBox(width: 10),
                        Text(
                          "Toque em um ponto do mapa",
                          style: TextStyle(color: AppColors.white, fontSize: 14),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.location_on, color: AppColors.yellow, size: 18),
                            SizedBox(width: 6),
                            Text(
                              "Coordenadas do ponto",
                              style: TextStyle(
                                color: AppColors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Latitude: ${pontoClicado!.latitude.toStringAsFixed(6)}",
                          style: const TextStyle(color: AppColors.white, fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Longitude: ${pontoClicado!.longitude.toStringAsFixed(6)}",
                          style: const TextStyle(color: AppColors.yellowLight, fontSize: 15),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
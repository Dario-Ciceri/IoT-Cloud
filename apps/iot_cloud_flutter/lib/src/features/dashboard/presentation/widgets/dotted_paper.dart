import 'package:flutter/material.dart';

class DottedPaperBackground extends StatelessWidget {
  final Color backgroundColor;
  final Color dotColor;
  final double dotSize;
  final double spacing;
  final Widget child;

  const DottedPaperBackground({
    super.key,
    required this.child,
    this.backgroundColor = Colors.blueGrey,
    this.dotColor = const Color(0xFFCCCCCC),
    this.dotSize = 1.0,
    this.spacing = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: CustomPaint(
        painter: DottedPaperPainter(
          dotColor: dotColor,
          dotSize: dotSize,
          spacing: spacing,
        ),
        child: child,
      ),
    );
  }
}

class DottedPaperPainter extends CustomPainter {
  final Color dotColor;
  final double dotSize;
  final double spacing;

  DottedPaperPainter({
    required this.dotColor,
    required this.dotSize,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = dotColor
          ..style = PaintingStyle.fill;

    // Calcola il numero esatto di punti che possono entrare
    final int numDotsX = (size.width / spacing).ceil();
    final int numDotsY = (size.height / spacing).ceil();

    // Calcola la spaziatura reale per distribuire i punti uniformemente
    final double adjustedSpacingX = size.width / (numDotsX - 1);
    final double adjustedSpacingY = size.height / (numDotsY - 1);

    // Disegna la griglia di punti
    for (int i = 0; i < numDotsX; i++) {
      for (int j = 0; j < numDotsY; j++) {
        // Posiziona i punti usando la spaziatura aggiustata
        final double x = i * adjustedSpacingX;
        final double y = j * adjustedSpacingY;

        // Disegna solo se il punto è all'interno della vista
        if (x >= 0 && x <= size.width && y >= 0 && y <= size.height) {
          canvas.drawCircle(Offset(x, y), dotSize, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// Esempio di utilizzo
class DottedPaperExample extends StatelessWidget {
  const DottedPaperExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dotted Paper Background')),
      body: DottedPaperBackground(
        backgroundColor: const Color(
          0xFF2D3A41,
        ), // Colore scuro come nell'immagine
        dotColor: Colors.white.withOpacity(
          0.2,
        ), // Punti bianchi semi-trasparenti
        dotSize: 0.8, // Dimensione ridotta per i punti
        spacing: 20.0,
        child: Center(
          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Questo è un esempio di contenuto sovrapposto allo sfondo a puntini.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

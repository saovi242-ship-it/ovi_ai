import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';

class GlassCard extends StatefulWidget {
  const GlassCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(20),
    this.margin,
    this.onTap,
    this.borderRadius = 22,
    this.tint = OviColors.glass,
    this.borderColor = OviColors.border,
    this.blur = 16,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double borderRadius;
  final Color tint;
  final Color borderColor;
  final double blur;

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final card = AnimatedScale(
      scale:
          _isPressed
              ? 0.985
              : _isHovered && widget.onTap != null
              ? 1.008
              : 1,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            margin: widget.margin,
            decoration: BoxDecoration(
              color:
                  _isHovered && widget.onTap != null
                      ? widget.tint.withValues(alpha: 0.78)
                      : widget.tint,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color:
                    _isHovered && widget.onTap != null
                        ? OviColors.primary.withValues(alpha: 0.38)
                        : widget.borderColor,
              ),
              boxShadow:
                  _isHovered && widget.onTap != null
                      ? [
                        BoxShadow(
                          color: OviColors.primary.withValues(alpha: 0.08),
                          blurRadius: 26,
                          spreadRadius: 1,
                        ),
                      ]
                      : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                onHover: (value) => setState(() => _isHovered = value),
                onHighlightChanged:
                    (value) => setState(() => _isPressed = value),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: Padding(padding: widget.padding, child: widget.child),
              ),
            ),
          ),
        ),
      ),
    );

    return card;
  }
}

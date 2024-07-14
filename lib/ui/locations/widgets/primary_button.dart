import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.enabled,
    this.height = 40,
    this.inactiveColor,
    this.loading = false,
    this.textColor = const Color(0xFFFFFFFF),
    this.activeColor = const Color(0xFFF7691F),
    this.highlightColor = const Color(0xFFAE3C00),
  });

  final String label;
  final Function? onTap;
  final Color highlightColor;
  final Color textColor;
  final double height;
  final bool loading;
  final Color activeColor;
  final Color? inactiveColor;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Material(
        color: (loading || !(enabled ?? true)) ? inactiveColor ?? activeColor.withOpacity(0.7) : activeColor,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: loading
              ? null
              : enabled ?? true
                  ? () => onTap?.call()
                  : null,
          highlightColor: highlightColor,
          splashColor: highlightColor,
          hoverColor: highlightColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(6),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Visibility(
                  visible: loading,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      SizedBox(
                        width: (height / 3),
                        height: (height / 3),
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

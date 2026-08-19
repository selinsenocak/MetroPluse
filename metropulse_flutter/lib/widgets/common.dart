import 'package:flutter/material.dart';
import '../theme/colors.dart';

/// The official Metro İstanbul mark (assets/images/metro-istanbul-mark.png).
class MpMark extends StatelessWidget {
  final double size;
  const MpMark({super.key, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/metro-istanbul-mark.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}

/// The small uppercase eyebrow label used above design sections
/// ("01 · Cihaz Tarama" etc.) — reused here as list section headers.
class SectionEyebrow extends StatelessWidget {
  final String text;
  const SectionEyebrow(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.7,
          color: MpColors.textMuted,
        ),
      ),
    );
  }
}

/// Reusable top app bar matching the mockups' 56px colored header.
class MpHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color background;
  final IconData? trailingIcon;
  final VoidCallback? onTrailing;
  final bool showBack;

  const MpHeader({
    super.key,
    required this.title,
    this.background = MpColors.navy,
    this.trailingIcon,
    this.onTrailing,
    this.showBack = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: background,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: showBack,
      leading: showBack
          ? const BackButton(color: Colors.white)
          : Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Center(child: MpMark(size: 22)),
            ),
      leadingWidth: showBack ? null : 46,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      actions: [
        if (trailingIcon != null)
          IconButton(
            icon: Icon(trailingIcon, color: Colors.white),
            onPressed: onTrailing,
          ),
        const SizedBox(width: 6),
      ],
    );
  }
}

/// Status pill, e.g. "AKTİF ÇALIŞIYOR", "ARIZALI", "BEKLEMEDE".
class MpBadge extends StatelessWidget {
  final String text;
  final Color fg;
  final Color bg;
  final bool dot;
  const MpBadge({
    super.key,
    required this.text,
    required this.fg,
    required this.bg,
    this.dot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w700,
              fontSize: 10.5,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class MpPrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;
  final VoidCallback? onTap;
  const MpPrimaryButton({
    super.key,
    required this.label,
    this.icon,
    this.color = MpColors.navy,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[Icon(icon, size: 16), const SizedBox(width: 8)],
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class MpSecondaryButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onTap;
  const MpSecondaryButton({
    super.key,
    required this.label,
    this.color = MpColors.textDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap ?? () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color == MpColors.textDark ? MpColors.border : color),
          padding: const EdgeInsets.symmetric(vertical: 13),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
      ),
    );
  }
}

/// Labelled info row used in device / lost item detail cards.
class MpInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? valueWidget;
  final bool divider;
  const MpInfoRow({
    super.key,
    required this.label,
    this.value = '',
    this.valueWidget,
    this.divider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (divider) const Divider(height: 1, color: MpColors.border),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: MpColors.textMuted,
                ),
              ),
              const SizedBox(height: 4),
              valueWidget ??
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: MpColors.textDark,
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A tappable placeholder "select" field used on forms.
class MpFieldSelect extends StatelessWidget {
  final String hint;
  final bool required;
  const MpFieldSelect({super.key, required this.hint, this.required = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: MpColors.cardBg,
        border: Border.all(color: MpColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(hint, style: const TextStyle(color: MpColors.textFaint, fontSize: 13.5)),
          const Icon(Icons.keyboard_arrow_down, color: MpColors.textFaint, size: 18),
        ],
      ),
    );
  }
}

class MpFieldText extends StatelessWidget {
  final String label;
  final String hint;
  final bool required;
  final int lines;
  final TextEditingController? controller;
  const MpFieldText({
    super.key,
    required this.label,
    required this.hint,
    this.required = false,
    this.lines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: MpColors.textDark)),
            if (required) const Text(' *', style: TextStyle(color: MpColors.red, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: lines,
          style: const TextStyle(fontSize: 13.5, color: MpColors.textDark),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: MpColors.textFaint, fontSize: 13.5),
            filled: true,
            fillColor: MpColors.cardBg,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: MpColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: MpColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: MpColors.citizenBlue),
            ),
          ),
        ),
      ],
    );
  }
}

/// Dashed upload box ("Fotoğraf çek veya yükle").
class MpUploadBox extends StatelessWidget {
  final String label;
  final String? sub;
  const MpUploadBox({super.key, required this.label, this.sub});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MpColors.borderSoft, width: 1.4, style: BorderStyle.solid),
        ),
        child: Column(
          children: [
            const Icon(Icons.camera_alt_outlined, color: MpColors.textFaint, size: 24),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: MpColors.textDark, fontWeight: FontWeight.w600, fontSize: 12.5), textAlign: TextAlign.center),
            if (sub != null) ...[
              const SizedBox(height: 3),
              Text(sub!, style: const TextStyle(color: MpColors.textFaint, fontSize: 11.5)),
            ],
          ],
        ),
      ),
    );
  }
}

/// Simple stat tile used across dashboards.
class MpStatTile extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final IconData? icon;
  final Color? iconBg;
  final Color? iconColor;
  const MpStatTile({
    super.key,
    required this.label,
    required this.value,
    this.valueColor = MpColors.textDark,
    this.icon,
    this.iconBg,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: MpColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label.toUpperCase(),
                    style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: MpColors.textMuted)),
                const SizedBox(height: 4),
                Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: valueColor)),
              ],
            ),
          ),
          if (icon != null)
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, size: 14, color: iconColor),
            ),
        ],
      ),
    );
  }
}

class MpCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color? topBorderColor;
  const MpCard({super.key, required this.child, this.padding = const EdgeInsets.all(14), this.topBorderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: MpColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (topBorderColor != null)
            Container(height: 3, decoration: BoxDecoration(color: topBorderColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(11)))),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key, required this.onEmergencyTap});

  final VoidCallback onEmergencyTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 110),
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Ready to master a new skill?',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, size: 20),
              splashRadius: 18,
            ),
          ],
        ),
        const SizedBox(height: 10),
        _HeroCard(onEmergencyTap: onEmergencyTap),
        const SizedBox(height: 16),
        const _SectionHeader(title: 'Explore Library'),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(
              child: _LibraryCard(
                icon: Icons.local_fire_department_outlined,
                title: 'Cooking Essentials',
                subtitle: '11 modules + recipes',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _LibraryCard(
                icon: Icons.handyman_outlined,
                title: 'Home Repairs',
                subtitle: '13 modules + diagnostics',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _LibraryCard(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Personal Finance',
                subtitle: '9 templates + tracker',
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const _SectionHeader(title: "Today's Briefing", compact: true),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF0F1630),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF1C2954)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 68,
                height: 58,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5B6679), Color(0xFF2A3140)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PRO TIP: CAST IRON CARE',
                      style: TextStyle(
                        color: Color(0xFF71E5A0),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Pro Tip: Cast Iron',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'The seasoning layer of polymerized oil, not grease. Learn maintenance to avoid rust and smoke.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11, color: Color(0xFF9EB0CC)),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Read Full Tip',
                      style: TextStyle(
                        color: Color(0xFF52A9FF),
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.onEmergencyTap});

  final VoidCallback onEmergencyTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 188,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF0D314A), Color(0xFF071725)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFF11344E)),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            top: 18,
            child: Container(
              width: 184,
              height: 112,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF513A2B), Color(0xFF1C130E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(56),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B1D2D),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'COOKING ESSENTIALS',
                    style: TextStyle(fontSize: 9, letterSpacing: 0.8),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Knife Skills 101',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Master the foundation of professional cooking. Learn the chop, slice, and safety rhythm.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Color(0xFF9BB7C9)),
                ),
                const Spacer(),
                Row(
                  children: [
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF3F9EEA),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(130, 36),
                      ),
                      child: const Text('Continue Learning'),
                    ),
                    const Spacer(),
                    IconButton.filled(
                      onPressed: onEmergencyTap,
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFB61D2A),
                      ),
                      icon: const Icon(Icons.warning_amber_rounded),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.compact = false});

  final String title;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: compact ? 15 : 16,
          ),
        ),
        const Spacer(),
        const Text(
          'View all',
          style: TextStyle(
            color: Color(0xFF4F8BFF),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _LibraryCard extends StatelessWidget {
  const _LibraryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF111A34),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1C2954)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF0A122A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 15, color: const Color(0xFF3ED5F0)),
          ),
          const Spacer(),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 9, color: Color(0xFF6E85A4)),
          ),
        ],
      ),
    );
  }
}

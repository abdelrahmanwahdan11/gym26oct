import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class InnovationLabScreen extends StatefulWidget {
  const InnovationLabScreen({super.key});

  @override
  State<InnovationLabScreen> createState() => _InnovationLabScreenState();
}

class _InnovationLabScreenState extends State<InnovationLabScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.78);
  final List<_FeatureIdea> _ideas = const [
    _FeatureIdea('Mini Coach AI', 'ذكاء اصطناعي يقترح تعديلات فورية على خطتك', 'يدمج بيانات النوم والمزاج لتوصيات يومية مخصصة.'),
    _FeatureIdea('Breath Sync', 'تمارين تنفس تفاعلية', 'تزامن مع إضاءة الهاتف للتنفس الواعي قبل الجلسة.'),
    _FeatureIdea('Dynamic Warm-up', 'اقتراح تسخين حسب درجة حرارة الطقس', 'يعدل طول التسخين وفق الحرارة والرطوبة.'),
    _FeatureIdea('Form Mirror', 'مراية وضعية باستخدام الكاميرا', 'تعقب مفاصل بسيط لاقتراح تعديلات على الوقفة.'),
    _FeatureIdea('Mood Pulse', 'ربط المزاج بالموسيقى', 'يختار قائمة تشغيل حسب حالة المزاج اليومية.'),
    _FeatureIdea('HIIT Composer', 'إنشاء جلسة HIIT بضغطة واحدة', 'اخلط تمارين جاهزة مع فترات راحة مخصصة.'),
    _FeatureIdea('Recovery Cloud', 'سحابة الاستشفاء', 'اقتراح إطالات ومساج بالأدوات المتاحة لديك.'),
    _FeatureIdea('Macro Diary', 'تتبع الماكروز بواجهة صور', 'التقط صورة الوجبة ليتم تحليلها لاحقاً (Mock).'),
    _FeatureIdea('Hydration Lights', 'إشعارات الماء المتدرجة', 'كل كوب يضيء حلقة ثلاثية الأبعاد في لوحة التحكم.'),
    _FeatureIdea('Plate Math', 'حاسبة الأوزان على البار', 'اختر الوزن الهدف وسترى التوزيع تلقائياً.'),
    _FeatureIdea('One-Rep Max', 'حاسبة 1RM السريعة', 'ادخل وزن وتكرار وسيتم تخزينه في مخطط تقدم.'),
    _FeatureIdea('Tempo Trainer', 'مدرب الإيقاع الصوتي', 'إيقاع صوتي لضبط سرعة التكرار (Mock).'),
    _FeatureIdea('Streak Forge', 'صناعة سلسلة الأيام', 'أضف تحديات مصغرة للحفاظ على streak أطول.'),
    _FeatureIdea('FlexPass Map', 'خريطة النوادي التفاعلية', 'اسحب لترى مزايا كل نادي ضمن اشتراكك.'),
    _FeatureIdea('Coupon Vault', 'خزنة الكوبونات', 'قسائم ذكية تتجدد أسبوعياً حسب نشاطك.'),
    _FeatureIdea('Avatar Badges', 'شارات ثلاثية الأبعاد', 'ترقية الشارة مع كل milestone جديد.'),
    _FeatureIdea('Mindful Cooldown', 'تهدئة واعية', 'جلسات صوتية قصيرة بعد التمرين لتصفية الذهن.'),
    _FeatureIdea('Run Worlds', 'عوالم ركض افتراضية', 'أصوات طبيعة ومدينة لتجربة جري غامرة.'),
    _FeatureIdea('Grip Strength', 'متابعة قوة القبضة', 'سجل نتائج جهاز القبضة وراقب التحسن.'),
    _FeatureIdea('Core Radar', 'رادار عضلات الوسط', 'شريط تفاعلي يوضح التوازن بين عضلات core.'),
    _FeatureIdea('Sprint Ghost', 'شبح السرعة', 'قارن سرعتك مع نسخة مسجلة لك (Mock).'),
    _FeatureIdea('Coach Feedback', 'تقييم المدرب بعد الجلسة', 'أسئلة سريعة مع إمكانية إرسال ملاحظة صوتية.'),
    _FeatureIdea('Partner Sync', 'مزامنة التدريب مع صديق', 'تابع تمارينكما كأنها غرفة مشتركة.'),
    _FeatureIdea('Mindset Cards', 'بطاقات تحفيزية يومية', 'اسحب بطاقة صباحية بنصوص مختارة بعناية.'),
    _FeatureIdea('Hero Journal', 'دفتر الإنجازات', 'أضف صور وتمارين في ألبوم تقدم زجاجي.'),
    _FeatureIdea('Barbell Camera', 'التقاط الفيديو أثناء الرفعة', 'يخزن مقطع قصير لمراجعة الأداء لاحقاً.'),
    _FeatureIdea('Class Remix', 'إعادة مزج الحصص المباشرة', 'ادمج مقاطع من حصص مختلفة لإنشاء جلسة خاصة.'),
    _FeatureIdea('Coach Marketplace', 'سوق البرامج المصغرة', 'مدربون يبيعون خطط أسبوعية مصغرة محلياً.'),
    _FeatureIdea('Refuel Timer', 'مؤقت التغذية بعد الجلسة', 'ذكّر نفسك بالوجبة المثالية بعد التمرين.'),
    _FeatureIdea('Wellness Vault', 'مكتبة العافية', 'مقالات مختصرة حول النوم، التغذية، والإجهاد.'),
    _FeatureIdea('Zen Garden', 'حديقة الاسترخاء', 'واجهات صوتية ولمسية للاسترخاء قبل النوم.'),
  ];
  int _expandedIndex = 0;
  final Set<int> _flipped = <int>{};

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Innovation Lab')),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Text('استكشف 30 فكرة جديدة', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold))
              .animate()
              .fadeIn(duration: 320.ms)
              .moveY(begin: 12, end: 0),
          const SizedBox(height: 12),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _ideas.length,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) => setState(() => _expandedIndex = index),
              itemBuilder: (context, index) {
                final idea = _ideas[index];
                final isExpanded = index == _expandedIndex;
                final isFlipped = _flipped.contains(index);
                return AnimatedScale(
                  scale: isExpanded ? 1 : 0.92,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOut,
                  child: AnimatedContainer(
                    margin: EdgeInsets.only(top: isExpanded ? 0 : 32, bottom: 32, right: 12, left: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary.withOpacity(0.82),
                          theme.colorScheme.secondary.withOpacity(0.82),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: const [
                        BoxShadow(color: Color.fromARGB(64, 16, 24, 64), blurRadius: 24, offset: Offset(0, 16)),
                      ],
                    ),
                    duration: const Duration(milliseconds: 380),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _expandedIndex = index;
                              if (isFlipped) {
                                _flipped.remove(index);
                              }
                            });
                          },
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 420),
                            transitionBuilder: (child, animation) {
                              final rotate = Tween(begin: pi, end: 0.0).animate(animation);
                              return AnimatedBuilder(
                                animation: rotate,
                                child: child,
                                builder: (context, child) {
                                  final isUnder = (ValueKey(isFlipped) != child?.key);
                                  final tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
                                  final value = isUnder ? min(rotate.value, pi / 2) : rotate.value;
                                  return Transform(
                                    transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
                                    alignment: Alignment.center,
                                    child: child,
                                  );
                                },
                              );
                            },
                            child: isFlipped
                                ? _FeatureForm(key: ValueKey('form-$index'), idea: idea, onClose: () {
                                    setState(() => _flipped.remove(index));
                                  })
                                : _FeatureFront(
                                    key: ValueKey('front-$index'),
                                    idea: idea,
                                    isExpanded: isExpanded,
                                    onExplore: () {
                                      setState(() => _flipped.add(index));
                                    },
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _FeatureFront extends StatelessWidget {
  const _FeatureFront({super.key, required this.idea, required this.isExpanded, required this.onExplore});

  final _FeatureIdea idea;
  final bool isExpanded;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: isExpanded ? 28 : 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.18), Colors.white.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(idea.title, style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              Text(idea.subtitle, style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70)),
              if (isExpanded) ...[
                const SizedBox(height: 16),
                Text(
                  idea.details,
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.85)),
                ),
              ]
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FilledButton(
              onPressed: onExplore,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.9),
                foregroundColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
              ),
              child: const Text('جربها الآن'),
            ),
          )
        ],
      ),
    );
  }
}

class _FeatureForm extends StatelessWidget {
  const _FeatureForm({super.key, required this.idea, required this.onClose});

  final _FeatureIdea idea;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.55),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(idea.title, style: theme.textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('شاركنا كيف تحب أن ترى هذه الميزة داخل التطبيق', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70)),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'ما الهدف الرئيسي؟',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.08),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'ملاحظات إضافية',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.08),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: onClose, child: const Text('عودة')),
              FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم حفظ فكرتك (Mock)')),
                  );
                  onClose();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                ),
                child: const Text('إرسال الفكرة'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _FeatureIdea {
  const _FeatureIdea(this.title, this.subtitle, this.details);

  final String title;
  final String subtitle;
  final String details;
}

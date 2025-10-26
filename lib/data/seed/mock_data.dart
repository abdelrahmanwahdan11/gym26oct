final mockPrograms = <Map<String, dynamic>>[
  {
    "id": "p1",
    "title": "Thunder Boult 5x5",
    "level": "Intermediate",
    "weeks": 4,
    "image": "https://images.unsplash.com/photo-1517963628607-235ccdd5476b",
    "desc": "رحلة قوة 4 أسابيع بأسلوب 5x5.",
    "coach": "John Snow",
    "durationMin": 39,
    "setsPerWeek": 5,
    "tags": ["Strength", "Upper"],
    "exercises": ["e1", "e2", "e3"]
  },
  {
    "id": "p2",
    "title": "Core Intensity 3x3",
    "level": "Intermediate",
    "weeks": 5,
    "image": "https://images.unsplash.com/photo-1554344728-77cf90d9ed26",
    "desc": "لبّ قوي وتمارين محسّنة.",
    "coach": "Jane Fit",
    "durationMin": 32,
    "setsPerWeek": 3,
    "tags": ["Core", "Mobility"],
    "exercises": ["e4", "e5"]
  }
];

final mockExercises = <Map<String, dynamic>>[
  {
    "id": "e1",
    "title": "Dumbbell Bicep Curl",
    "image": "https://images.unsplash.com/photo-1599058917212-d750089bc07b",
    "video": "",
    "durationSec": 45,
    "reps": 7,
    "sets": 7,
    "restSec": 30,
    "tips": ["أبقِ المرفقين ثابتين"]
  },
  {
    "id": "e2",
    "title": "High Knees",
    "image": "https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b",
    "video": "",
    "durationSec": 35,
    "reps": 0,
    "sets": 5,
    "restSec": 25,
    "tips": ["حافظ على الإيقاع"]
  },
  {
    "id": "e3",
    "title": "Rock Barbell Semi-Squat",
    "image": "https://images.unsplash.com/photo-1517836357463-d25dfeac3438",
    "video": "",
    "durationSec": 60,
    "reps": 0,
    "sets": 5,
    "restSec": 40,
    "tips": ["ظهر مستقيم"]
  }
];

final mockClips = <Map<String, dynamic>>[
  {
    "id": "c1",
    "title": "Kettlebell Swing",
    "thumb": "https://images.unsplash.com/photo-1521805103424-d8f8430e893f",
    "durationSec": 132,
    "coach": "Alex"
  },
  {
    "id": "c2",
    "title": "Dumbbell Curl 4×4",
    "thumb": "https://images.unsplash.com/photo-1549068106-b024baf5062d",
    "durationSec": 120,
    "coach": "Maya"
  }
];

final mockTrainers = <Map<String, dynamic>>[
  {
    "id": "t1",
    "name": "Omar Khaled",
    "avatar": "https://i.pravatar.cc/150?img=17",
    "bio": "قوّة وHIIT",
    "rating": 4.8,
    "specialties": ["Strength", "HIIT"],
    "pricePerSession": 25,
    "gyms": [
      {
        "id": "g1",
        "name": "Rawabi Gym",
        "address": "Q-Center",
        "city": "Rawabi",
        "mapImage": "https://images.unsplash.com/photo-1554284126-aa88f22d8b74",
        "phone": "+970-000",
        "discountPercent": 15
      }
    ],
    "contacts": {
      "phone": "+970-000",
      "whatsapp": "+970-000",
      "email": "omar@gym.com"
    },
    "slots": ["2025-11-02 18:00", "2025-11-03 19:00"]
  }
];

final mockProducts = <Map<String, dynamic>>[
  {
    "id": "pr1",
    "title": "Whey Protein 2kg",
    "image": "https://images.unsplash.com/photo-1605296867304-46d5465a13f1",
    "price": 79.0,
    "category": "Supplements",
    "rating": 4.7,
    "desc": "عزل بروتين عالي الجودة",
    "stock": 15
  },
  {
    "id": "pr2",
    "title": "Adjustable Dumbbells",
    "image": "https://images.unsplash.com/photo-1583454110551-21f2fa1b0a9a",
    "price": 149.0,
    "category": "Equipment",
    "rating": 4.6,
    "desc": "من 5 إلى 25 كغ",
    "stock": 7
  },
  {
    "id": "pr3",
    "title": "Deodorant Sport",
    "image": "https://images.unsplash.com/photo-1582719478185-ff61da3d5f3f",
    "price": 9.9,
    "category": "Care",
    "rating": 4.5,
    "desc": "مزيل عرق رياضي",
    "stock": 42
  }
];

final mockFlexPass = <String, dynamic>{
  "id": "fx1",
  "holderName": "Athletica User",
  "tier": "Pro",
  "clubsAllowed": 5,
  "expiry": "2026-01-01",
  "weeklySchedule": [
    {"day": "Tue", "class": "Zumba", "club": "Rawabi Gym", "time": "18:00"},
    {"day": "Thu", "class": "Aerobics", "club": "CityFit", "time": "19:30"}
  ],
  "perks": ["خصم 15% على المتجر", "جلسة تقييم مجانية كل شهر", "دخول أكثر من نادٍ"]
};

final mockChallenges = <Map<String, dynamic>>[
  {
    "id": "ch1",
    "title": "Galaxy Steps",
    "description": "امشِ 45 ألف خطوة خلال أسبوع وشارك لقطة الشاشة.",
    "category": "Cardio",
    "goal": "45k steps",
    "reward": "شعار Galaxy Explorer",
    "isCommunity": true
  },
  {
    "id": "ch2",
    "title": "Strength Ladder",
    "description": "أكمل خمس حصص قوة متتالية بزيادة الوزن تدريجية.",
    "category": "Strength",
    "goal": "5 Sessions",
    "reward": "شارة Iron Streak",
    "isCommunity": true
  },
  {
    "id": "ch3",
    "title": "Mindful Mornings",
    "description": "ابدأ كل صباح بجلسة تنفس لمدة 6 دقائق لمدة 7 أيام.",
    "category": "Wellness",
    "goal": "7 Days",
    "reward": "مرشد تنفس متقدّم",
    "isCommunity": false
  },
  {
    "id": "ch4",
    "title": "Hydration Hero",
    "description": "اشرب 8 أكواب يومياً لمدة 10 أيام متتالية.",
    "category": "Wellness",
    "goal": "80 Cups",
    "reward": "فلتر زجاجي خاص",
    "isCommunity": true
  },
  {
    "id": "ch5",
    "title": "HIIT Remix",
    "description": "اصنع جلسة HIIT خاصة بك وشاركها مع المجتمع.",
    "category": "Cardio",
    "goal": "Create + Share",
    "reward": "بطاقة تمرين قابلة للطباعة",
    "isCommunity": true
  },
  {
    "id": "ch6",
    "title": "Recovery Ritual",
    "description": "نفّذ بروتوكول استشفاء من 4 خطوات بعد كل جلسة لمدة أسبوع.",
    "category": "Recovery",
    "goal": "7 Sessions",
    "reward": "وصفة مشروب استشفاء",
    "isCommunity": false
  },
  {
    "id": "ch7",
    "title": "Core Composer",
    "description": "وثّق 3 جلسات Core مختلفة وشارك مقاطع قصيرة.",
    "category": "Strength",
    "goal": "3 Core Workouts",
    "reward": "حزمة موسيقى Core",
    "isCommunity": true
  },
  {
    "id": "ch8",
    "title": "Flex Flow",
    "description": "التزم بسلسلة إطالات مرنة كل مساء لمدة 12 يوماً.",
    "category": "Mobility",
    "goal": "12 Evenings",
    "reward": "خلفية FlexPass حصرية",
    "isCommunity": false
  },
  {
    "id": "ch9",
    "title": "Sleep Sanctuary",
    "description": "أغلق الأجهزة قبل النوم بساعة كاملة لمدة 14 ليلة.",
    "category": "Wellness",
    "goal": "14 Nights",
    "reward": "دليل نوم رقمي",
    "isCommunity": false
  },
  {
    "id": "ch10",
    "title": "Trailblazer",
    "description": "شارك صورة من تمرين خارجي مميز ثلاث مرات هذا الشهر.",
    "category": "Adventure",
    "goal": "3 Outdoor Sessions",
    "reward": "بطاقة مغامرة رقمية",
    "isCommunity": true
  },
  {
    "id": "ch11",
    "title": "Coach Spotlight",
    "description": "جرّب حصتين مع مدربين مختلفين واكتب مراجعة قصيرة.",
    "category": "Community",
    "goal": "2 Coaches",
    "reward": "كوبون خصم مدرب",
    "isCommunity": true
  },
  {
    "id": "ch12",
    "title": "Fuel Artist",
    "description": "إعداد وجبتين صحيتين ومشاركتها في قصص المجتمع.",
    "category": "Nutrition",
    "goal": "2 Meals",
    "reward": "كتاب وصفات مصغر",
    "isCommunity": true
  }
];

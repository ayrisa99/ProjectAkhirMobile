class Article {
  final String title;
  final String image;
  final String content;
  final DateTime createdAt; // tambah field ini

  Article({
    required this.title,
    required this.image,
    required this.content,
    required this.createdAt, // wajib diisi saat instansiasi
  });
}

final List<Article> articles = [
  Article(
    title: "Tips for a Healthier Heart",
    image: "assets/images/article1.jpeg",
    content: '''
Heart health is essential for overall wellbeing. Maintaining a healthy heart can reduce the risk of cardiovascular diseases such as heart attacks and strokes.

Here are some practical tips to keep your heart healthy:

1. **Eat a Balanced Diet:** Focus on consuming fruits, vegetables, whole grains, lean proteins, and healthy fats like those found in nuts and olive oil. Limit intake of processed foods, salt, sugar, and saturated fats.

2. **Exercise Regularly:** Aim for at least 150 minutes of moderate-intensity aerobic activity, like brisk walking, every week. Exercise helps control weight, lowers blood pressure, and improves cholesterol levels.

3. **Maintain a Healthy Weight:** Being overweight increases the strain on your heart. Achieving and maintaining a healthy weight reduces your risk of heart disease.

4. **Avoid Smoking and Limit Alcohol:** Smoking damages your blood vessels and increases heart disease risk. Limit alcohol consumption to moderate levels, as excessive drinking can harm your heart.

5. **Manage Stress:** Chronic stress may contribute to heart problems. Practice relaxation techniques such as meditation, yoga, or deep breathing.

6. **Regular Health Check-ups:** Monitor your blood pressure, cholesterol, and blood sugar levels regularly. Early detection and management of issues are key.

By integrating these habits into your daily life, you can support your heart health and overall wellness.
''',
    createdAt: DateTime(2023, 8, 15),
  ),
  Article(
    title: "How to Manage Stress Effectively",
    image: "assets/images/article2.jpg",
    content: '''
Stress is a natural response to challenges but prolonged stress can negatively impact your mental and physical health.

Here are effective strategies to manage stress:

1. **Identify Stress Triggers:** Recognize situations or people that cause you stress to better manage or avoid them.

2. **Practice Mindfulness and Meditation:** Mindfulness exercises help you stay present and reduce anxiety. Meditation can calm your mind and improve emotional resilience.

3. **Physical Activity:** Regular exercise releases endorphins, natural mood boosters, which help combat stress.

4. **Time Management:** Prioritize tasks, break big projects into smaller steps, and delegate when possible to reduce overwhelming feelings.

5. **Connect with Others:** Talking with friends, family, or counselors can provide support and help process stressful experiences.

6. **Healthy Lifestyle Choices:** Maintain a balanced diet, get enough sleep, and avoid excessive caffeine or alcohol consumption.

7. **Relaxation Techniques:** Deep breathing exercises, progressive muscle relaxation, or hobbies can help lower stress levels.

By adopting these techniques, you can better cope with stress and improve your quality of life.
''',
    createdAt: DateTime(2023, 9, 2),
  ),
];

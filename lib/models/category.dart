class Category {
  final String id;
  final String name;
  final String title;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.title,
    required this.image,
  });
}

final categories = [
  Category(
    id: 'programming',
    name: 'برمجة',
    title: 'Programming Category',
    image: 'images/programming.jpg',
  ),
  Category(
    id: 'design',
    name: 'تصميم',
    title: 'Design Category',
    image: 'images/disgin.png',
  ),
  Category(
    id: 'engineering',
    name: 'اعلانات',
    title: 'Engineering Category',
    image: 'images/referral2.jpg',
  ),
  Category(
    id: 'advertising',
    name: 'هندسة',
    title: 'Advertising Category',
    image: 'images/eng.jpg',
  ),
  Category(
    id: 'accounting',
    name: 'محاسبة',
    title: 'Accounting Category',
    image: 'images/cant.jpg',
  ),
];

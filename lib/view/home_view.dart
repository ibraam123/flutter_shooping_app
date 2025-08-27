import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/featured_product_card.dart';
import '../widgets/hot_offer_item.dart';
import '../widgets/product_card.dart';
import '../widgets/section_title.dart';

class HomeView extends StatefulWidget {
  static const String viewName = "/home"; // for navigation
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Map<String, String>> _featuredProducts = [
    {"title": "Premium Laptop Collection", "image": "assets/images/lap1.jpeg"},
    {"title": "Smartphone Deals", "image": "assets/images/lap2.jpeg"},
    {"title": "Gaming Accessories", "image": "assets/images/lap3.jpeg"},
  ];

  final List<Map<String, String>> _gridProducts = [
    {"title": "Laptop Pro", "image": "assets/images/lap1.jpeg"},
    {"title": "iPhone 15", "image": "assets/images/lap2.jpeg"},
    {"title": "Gaming Headset", "image": "assets/images/lap3.jpeg"},
    {"title": "Smart Watch", "image": "assets/images/lap1.jpeg"},
  ];

  final List<Map<String, String>> _hotOffers = List.generate(
    5,
        (index) => {
      "title": "Special Offer #${index + 1}",
      "image": "assets/images/lap2.jpeg",
      "description":
      "Grab this exclusive deal on product ${index + 1}! Limited time only."
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Products"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          // FEATURED PRODUCTS
          const SectionTitle(title: "Featured Products"),
          const SizedBox(height: 10),
          CarouselSlider.builder(
            itemCount: _featuredProducts.length,
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.8,
              aspectRatio: 16 / 9,
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, realIdx) {
              final product = _featuredProducts[index];
              return FeaturedProductCard(product: product);
            },
          ),
          const SizedBox(height: 10),
          // DOTS INDICATOR
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _featuredProducts.asMap().entries.map((entry) {
              return Container(
                width: 10,
                height: 10,
                margin:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Colors.purple
                      : Colors.grey[300],
                ),
              );
            }).toList(),
          ),

          // GRID PRODUCTS
          const SectionTitle(title: "Shop Collection"),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _gridProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final product = _gridProducts[index];
              return ProductCard(product: product);
            },
          ),

          // HOT OFFERS
          const SectionTitle(title: "Hot Offers"),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _hotOffers.length,
            itemBuilder: (context, index) {
              final offer = _hotOffers[index];
              return HotOfferItem(offer: offer);
            },
          ),
        ],
      ),
    );
  }
}





import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/app_scope.dart';
import '../../controllers/store_controller.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/feature_catalog_section.dart';
import '../../widgets/product_card.dart';

class StoreHomeScreen extends StatefulWidget {
  const StoreHomeScreen({super.key});

  @override
  State<StoreHomeScreen> createState() => _StoreHomeScreenState();
}

class _StoreHomeScreenState extends State<StoreHomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final store = AppScope.of(context).store;
    if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 200) {
      store.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context).store;
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        return AppScaffold(
          activeTab: 'store',
          onTabSelected: (tab) => _handleTab(context, tab),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Get.toNamed('/store/cart'),
            icon: const Icon(Icons.shopping_cart_outlined),
            label: Text('${store.cart.length}'),
          ),
          body: RefreshIndicator(
            onRefresh: store.refresh,
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: 120),
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 42,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _CategoryChip(label: 'All', selected: store.categoryFilter == 'All', onTap: () => store.setCategory('All')),
                      _CategoryChip(label: 'Supplements', selected: store.categoryFilter == 'Supplements', onTap: () => store.setCategory('Supplements')),
                      _CategoryChip(label: 'Equipment', selected: store.categoryFilter == 'Equipment', onTap: () => store.setCategory('Equipment')),
                      _CategoryChip(label: 'Care', selected: store.categoryFilter == 'Care', onTap: () => store.setCategory('Care')),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(colors: [Color(0xFF6C7CFF), Color(0xFFA77DFF)]),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('خصم 20% على Proteins',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('Use ATHLETICA20 at checkout',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.68,
                    children: store.products
                        .map((product) => ProductCard(
                              product: product,
                              onTap: () => Get.toNamed('/store/product/${product.id}'),
                              onAdd: () => store.addToCart(product),
                            ))
                        .toList(),
                  ),
                ),
                if (store.isLoading)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                FeatureCatalogSection(pageKey: 'store', title: 'ابتكارات متجر Athletica'),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleTab(BuildContext context, String tab) {
    if (tab == 'store') return;
    Get.offNamed(_tabToRoute(tab));
  }

  String _tabToRoute(String tab) {
    switch (tab) {
      case 'generator':
        return '/home/generator';
      case 'programs':
        return '/programs';
      case 'clips':
        return '/clips';
      case 'trainers':
        return '/trainers';
      case 'profile':
        return '/profile';
      default:
        return '/store';
    }
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ChoiceChip(label: Text(label), selected: selected, onSelected: (_) => onTap()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const orange = Color(0xFFF47717);
const brown = Color(0xFF38241B);
const cream = Color(0xFFFFF8EF);
const softGold = Color(0xFFFFE8C5);
const fees = {'Centro': 5.0, 'Candeias': 7.0, 'Brasil': 8.0, 'Recreio': 6.0};
String money(double n) => 'R\$ ${n.toStringAsFixed(2).replaceAll('.', ',')}';

class Product {
  final String title, detail, category, icon, image;
  final double price;
  const Product(this.title, this.detail, this.category, this.icon, this.price, this.image);
}
const catalog = <Product>[
  Product('Fiore Especial', 'Pão artesanal, carne 180g, queijo, bacon e molho especial', 'Hambúrgueres', '🍔', 29.90, 'assets/images/burger.png'),
  Product('X-Burguer Simples', 'Pão, carne, queijo e salada', 'Hambúrgueres', '🍔', 18.90, 'assets/images/burger2.png'),
  Product('X-Bacon', 'Pão, carne, queijo, bacon e salada', 'Hambúrgueres', '🍔', 24.90, 'assets/images/burger.png'),
  Product('Batata Frita Média', 'Crocante e sequinha', 'Acompanhamentos', '🍟', 12.00, 'assets/images/fries.png'),
  Product('Refrigerante Lata', 'Diversos sabores', 'Bebidas', '🥤', 6.00, 'assets/images/soda.png'),
];
const extras = {'Extra queijo': 3.00, 'Extra bacon': 5.00, 'Extra carne': 8.00};
class CartItem {
  final int productIndex;
  final List<String> selectedExtras;
  final String note;
  final String doneness;
  int qty;
  CartItem(this.productIndex, this.selectedExtras, this.note, this.qty, this.doneness);
  double get unit => catalog[productIndex].price + selectedExtras.fold<double>(0, (v, k) => v + (extras[k] ?? 0));
  double get total => unit * qty;
}
void main() => runApp(const FioreApp());
class FioreApp extends StatelessWidget {
  const FioreApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(
    title: 'Fiore Lanches', debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: cream,
      colorScheme: ColorScheme.fromSeed(seedColor: orange),
      textTheme: const TextTheme(titleLarge: TextStyle(fontWeight: FontWeight.w800, color: brown),
        titleMedium: TextStyle(fontWeight: FontWeight.w800, color: brown))),
    home: const FioreSplash());
}
class FioreSplash extends StatefulWidget {
  const FioreSplash({super.key});
  @override State<FioreSplash> createState() => _FioreSplashState();
}
class _FioreSplashState extends State<FioreSplash> {
  @override void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const FioreHome()));
    });
  }
  @override Widget build(BuildContext context) => Scaffold(
    backgroundColor: orange,
    body: SafeArea(child: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(36)),
          child: Image.asset('assets/images/logo_oficial.png', width: 245, height: 245)),
        const SizedBox(height: 24),
        const Text('Delivery Fiore Lanches',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
      ],
    ))),
  );
}
class FioreHome extends StatefulWidget {
  const FioreHome({super.key});
  @override State<FioreHome> createState() => _FioreHomeState();
}
class _FioreHomeState extends State<FioreHome> {
  int tab = 0;
  String category = 'Todos';
  String search = '';
  String? neighborhood;
  String payment = 'Pix';
  final customer = TextEditingController();
  final phone = TextEditingController();
  final street = TextEditingController();
  final reference = TextEditingController();
  final change = TextEditingController();
  final items = <CartItem>[];
  double get subtotal => items.fold<double>(0, (sum, item) => sum + item.total);
  int get count => items.fold<int>(0, (sum, item) => sum + item.qty);
  double get fee => fees[neighborhood] ?? 0;
  @override void dispose() { for (final c in [customer, phone, street, reference, change]) { c.dispose(); } super.dispose(); }
  void notify(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  Widget orangeButton(String label, VoidCallback onTap, {IconData icon = Icons.arrow_forward}) =>
    SizedBox(width: double.infinity, height: 52, child: FilledButton.icon(
      style: FilledButton.styleFrom(backgroundColor: orange, foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      onPressed: onTap, icon: Icon(icon), label: Text(label, style: const TextStyle(fontWeight: FontWeight.w800))));
  Widget section(String title) => Padding(padding: const EdgeInsets.only(bottom: 12),
    child: Text(title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: brown)));
  Widget productTile(int index) {
    final p = catalog[index];
    return Card(color: Colors.white, elevation: 0, margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      child: InkWell(borderRadius: BorderRadius.circular(19), onTap: () => details(index),
        child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
          ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(p.image, width: 92, height: 92, fit: BoxFit.cover)),
          const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(p.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: brown)),
            const SizedBox(height: 4), Text(p.detail, maxLines: 2, overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 8), Text(money(p.price), style: const TextStyle(color: orange, fontWeight: FontWeight.w900, fontSize: 16)),
          ])), const Icon(Icons.add_circle, color: orange, size: 30),
        ]))));
  }
  Future<void> details(int index) async {
    final p = catalog[index];
    final selected = <String>{};
    String doneness = 'Ao ponto';
    final note = TextEditingController();
    int qty = 1;
    await showModalBottomSheet<void>(context: context, isScrollControlled: true,
      backgroundColor: cream, showDragHandle: true,
      builder: (sheetContext) => StatefulBuilder(builder: (context, refresh) =>
        SafeArea(child: Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.of(context).viewInsets.bottom + 20),
          child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Center(child: ClipRRect(borderRadius: BorderRadius.circular(22), child: Image.asset(index == 0 ? 'assets/images/hero.png' : p.image, width: double.infinity, height: 225, fit: BoxFit.cover))),
            const SizedBox(height: 14), section(p.title), Text(p.detail),
            const SizedBox(height: 8), Text(money(p.price), style: const TextStyle(color: orange, fontSize: 24, fontWeight: FontWeight.w900)),
            const SizedBox(height: 14), if (p.category == 'Hambúrgueres') ...[
              const Text('Ponto da carne', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              Wrap(spacing: 6, children: ['Ao ponto', 'Bem passada', 'Mal passada'].map((v) => ChoiceChip(label: Text(v), selected: doneness == v, selectedColor: softGold, onSelected: (_) => refresh(() => doneness = v))).toList()),
              const SizedBox(height: 10),
              const Text('Escolha seus adicionais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ...extras.entries.map((e) => CheckboxListTile(contentPadding: EdgeInsets.zero,
                title: Text(e.key), subtitle: Text('+ ${money(e.value)}'), value: selected.contains(e.key),
                activeColor: orange, onChanged: (v) => refresh(() { if (v == true) { selected.add(e.key); } else { selected.remove(e.key); } }))),
            ],
            TextField(controller: note, maxLines: 2, decoration: const InputDecoration(labelText: 'Observações (opcional)',
              hintText: 'Ex.: sem cebola', border: OutlineInputBorder())),
            const SizedBox(height: 12), Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(onPressed: qty > 1 ? () => refresh(() => qty--) : null, icon: const Icon(Icons.remove_circle_outline)),
              Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
              IconButton(onPressed: () => refresh(() => qty++), icon: const Icon(Icons.add_circle_outline)),
            ]),
            orangeButton('Adicionar • ${money((p.price + selected.fold<double>(0, (s, k) => s + extras[k]!)) * qty)}', () {
              setState(() => items.add(CartItem(index, selected.toList(), note.text.trim(), qty, p.category == 'Hambúrgueres' ? doneness : '')));
              Navigator.pop(sheetContext); notify('Produto adicionado ao carrinho');
            }, icon: Icons.add_shopping_cart),
          ]))))));
    note.dispose();
  }
  Widget home() => ListView(padding: EdgeInsets.zero, children: [
    Container(padding: const EdgeInsets.fromLTRB(20, 18, 20, 25), decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xFFFFA12B), Color(0xFFFF6B00)]),
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))),
      child: Column(children: [
        Image.asset('assets/images/logo_oficial.png', height: 128, fit: BoxFit.contain),
        const SizedBox(height: 5),
        const Text('Sabor que Apaixona', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900, color: Colors.white)),
        const SizedBox(height: 18),
        Container(padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: cream, borderRadius: BorderRadius.circular(23)),
          child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Fiore Especial', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: orange)),
            const SizedBox(height: 8), const Text('Pão artesanal, carne 180g, queijo, bacon e molho especial', style: TextStyle(color: brown, fontSize: 12)),
            const SizedBox(height: 12), Text(money(29.90), style: const TextStyle(color: orange, fontWeight: FontWeight.w900, fontSize: 21)),
            TextButton(onPressed: () => details(0), child: const Text('Ver detalhes →')),
          ])), ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset('assets/images/burger.png', width: 140, height: 155, fit: BoxFit.cover))]))
      ])),
    Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Expanded(child: _shortcut(Icons.restaurant_menu, 'Cardápio', () => setState(() => tab = 1))),
        const SizedBox(width: 10), Expanded(child: _shortcut(Icons.shopping_bag, 'Carrinho', () => setState(() => tab = 2)))]),
      const SizedBox(height: 24), section('Promoções do Dia'),
      productTile(0), productTile(3),
      orangeButton('Ver cardápio completo', () => setState(() => tab = 1)),
    ])),
  ]);
  Widget _shortcut(IconData icon, String label, VoidCallback action) => InkWell(onTap: action,
    child: Container(height: 95, decoration: BoxDecoration(color: orange, borderRadius: BorderRadius.circular(23)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 8), Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 17))])));
  Widget menu() => ListView(padding: const EdgeInsets.all(18), children: [
    section('Nosso cardápio'),
    TextField(onChanged: (v) => setState(() => search = v),
      decoration: InputDecoration(hintText: 'Buscar seu lanche...', prefixIcon: const Icon(Icons.search),
        filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none))),
    const SizedBox(height: 14), SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
      for (final c in ['Todos', 'Hambúrgueres', 'Acompanhamentos', 'Bebidas'])
        Padding(padding: const EdgeInsets.only(right: 7), child: ChoiceChip(label: Text(c), selected: category == c,
          selectedColor: const Color(0xFFFFD5AA), onSelected: (_) => setState(() => category = c))),
    ])), const SizedBox(height: 16),
    for (int i = 0; i < catalog.length; i++) if ((category == 'Todos' || catalog[i].category == category) &&
      (catalog[i].title.toLowerCase().contains(search.toLowerCase()) || catalog[i].detail.toLowerCase().contains(search.toLowerCase()))) productTile(i),
  ]);
  Widget field(TextEditingController c, String label, {TextInputType? keyboard}) => Padding(
    padding: const EdgeInsets.only(bottom: 11), child: TextField(controller: c, keyboardType: keyboard,
      decoration: InputDecoration(labelText: label, filled: true, fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)))));
  Widget priceLine(String label, String price, {bool bold = false}) => Padding(padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label,
      style: TextStyle(fontWeight: bold ? FontWeight.w900 : FontWeight.normal)),
      Text(price, style: TextStyle(fontWeight: FontWeight.w900, color: bold ? orange : brown, fontSize: bold ? 20 : 15))]));
  Widget cart() => ListView(padding: const EdgeInsets.all(18), children: [
    section('Meu carrinho'),
    if (items.isEmpty) const Padding(padding: EdgeInsets.all(35), child: Center(child: Text('Seu carrinho está vazio 🛒'))),
    for (int i = 0; i < items.length; i++) Card(color: Colors.white, elevation: 0, child: Padding(
      padding: const EdgeInsets.all(10), child: Row(children: [
        ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(catalog[items[i].productIndex].image, width: 64, height: 64, fit: BoxFit.cover)),
        const SizedBox(width: 9), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(catalog[items[i].productIndex].title, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (items[i].doneness.isNotEmpty) Text(items[i].doneness, style: const TextStyle(fontSize: 11)),
          if (items[i].selectedExtras.isNotEmpty) Text(items[i].selectedExtras.join(', '), style: const TextStyle(fontSize: 11)),
          if (items[i].note.isNotEmpty) Text('Obs.: ${items[i].note}', style: const TextStyle(fontSize: 11)),
          Text(money(items[i].total), style: const TextStyle(color: orange, fontWeight: FontWeight.bold)),
        ])), IconButton(onPressed: () => setState(() { if (--items[i].qty == 0) items.removeAt(i); }), icon: const Icon(Icons.remove_circle_outline)),
        Text('${items[i].qty}'), IconButton(onPressed: () => setState(() => items[i].qty++), icon: const Icon(Icons.add_circle_outline)),
      ]))),
    const SizedBox(height: 15), section('Endereço de entrega'),
    field(customer, 'Nome completo'), field(phone, 'Telefone / WhatsApp', keyboard: TextInputType.phone),
    field(street, 'Rua e número'),
    DropdownButtonFormField<String>(initialValue: neighborhood, decoration: InputDecoration(labelText: 'Bairro',
      filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(13))),
      items: fees.entries.map((e) => DropdownMenuItem(value: e.key, child: Text('${e.key} — ${money(e.value)}'))).toList(),
      onChanged: (v) => setState(() => neighborhood = v)),
    const SizedBox(height: 11), field(reference, 'Complemento / ponto de referência'),
    section('Pagamento'),
    DropdownButtonFormField<String>(initialValue: payment, decoration: const InputDecoration(filled: true, fillColor: Colors.white,
      border: OutlineInputBorder()), items: ['Pix', 'Dinheiro', 'Cartão na entrega'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (v) => setState(() => payment = v ?? 'Pix')),
    const SizedBox(height: 11), if (payment == 'Dinheiro') field(change, 'Troco para quanto? (opcional)', keyboard: TextInputType.number),
    Card(color: Colors.white, elevation: 0, child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
      priceLine('Subtotal', money(subtotal)),
      priceLine('Taxa de entrega', neighborhood == null ? 'Selecione o bairro' : money(fee)),
      const Divider(), priceLine('Total', neighborhood == null ? '—' : money(subtotal + fee), bold: true),
    ]))), const SizedBox(height: 12), orangeButton('Enviar pedido pelo WhatsApp', sendOrder, icon: Icons.send),
    const SizedBox(height: 16),
  ]);
  Future<void> sendOrder() async {
    if (items.isEmpty) { notify('Adicione pelo menos um produto.'); return; }
    if (customer.text.trim().isEmpty || phone.text.trim().isEmpty || street.text.trim().isEmpty || neighborhood == null) {
      notify('Informe nome, telefone, rua, número e bairro.'); return;
    }
    final lines = items.map((e) {
      final p = catalog[e.productIndex];
      final pointText = e.doneness.isEmpty ? '' : '\n  Ponto da carne: ${e.doneness}';
      final extraText = e.selectedExtras.isEmpty ? '' : '\n  Adicionais: ${e.selectedExtras.join(', ')}';
      final noteText = e.note.isEmpty ? '' : '\n  Obs.: ${e.note}';
      return '${e.qty}x ${p.title} — ${money(e.total)}$pointText$extraText$noteText';
    }).join('\n');
    final msg = '🍔 *FIORE LANCHES — PEDIDO DELIVERY*\n\n$lines\n\n'
      'Subtotal: ${money(subtotal)}\nTaxa ($neighborhood): ${money(fee)}\n*TOTAL: ${money(subtotal + fee)}*\n\n'
      '*CLIENTE*\nNome: ${customer.text.trim()}\nTelefone: ${phone.text.trim()}\n'
      'Endereço: ${street.text.trim()}\nBairro: $neighborhood\nReferência: ${reference.text.trim()}\n'
      'Pagamento: $payment${payment == 'Dinheiro' && change.text.trim().isNotEmpty ? '\nTroco para: ${change.text.trim()}' : ''}';
    final url = Uri.https('wa.me', '/5577981288807', {'text': msg});
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) { notify('Não foi possível abrir o WhatsApp.'); }
    } catch (_) { notify('Não foi possível abrir o WhatsApp.'); }
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(backgroundColor: orange, foregroundColor: Colors.white,
      title: const Text('FIORE LANCHES', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: .5)),
      actions: [IconButton(onPressed: () => setState(() => tab = 2), icon: Badge(label: Text('$count'),
        isLabelVisible: count > 0, child: const Icon(Icons.shopping_bag_outlined)))]),
    body: IndexedStack(index: tab, children: [home(), menu(), cart()]),
    bottomNavigationBar: NavigationBar(backgroundColor: Colors.white, indicatorColor: const Color(0xFFFFD5AA),
      selectedIndex: tab, onDestinationSelected: (v) => setState(() => tab = v), destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Início'),
        NavigationDestination(icon: Icon(Icons.restaurant_menu_outlined), selectedIcon: Icon(Icons.restaurant_menu), label: 'Cardápio'),
        NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), selectedIcon: Icon(Icons.shopping_cart), label: 'Carrinho'),
      ]));
}

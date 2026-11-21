import 'package:flutter/material.dart';

void main() => runApp(const CholoKothaBoliApp());

const bg = Color(0xFF0D0D12);
const panel = Color(0xFF191923);
const purple = Color(0xFF9B7BFF);
const muted = Color(0xFFAAA8B7);

class CholoKothaBoliApp extends StatelessWidget {
  const CholoKothaBoliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'চলো কথা বলি',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: purple,
          surface: panel,
        ),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: panel,
          hintStyle: const TextStyle(color: muted),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phone = TextEditingController();
  bool accepted = true;

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }

  void continueDemo() {
    final digits = phone.text.replaceAll(RegExp(r'\\D'), '');
    if (digits.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('সঠিক ১০ সংখ্যার মোবাইল নম্বর লিখুন')),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage(phone: phone.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 28),
                Container(
                  height: 86,
                  width: 86,
                  decoration: BoxDecoration(
                    color: purple.withOpacity(.16),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(Icons.forum_rounded, color: purple, size: 44),
                ),
                const SizedBox(height: 24),
                const Text('চলো কথা বলি',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 31, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('বন্ধুত্বের নতুন ঠিকানা ❤️',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: muted, fontSize: 15)),
                const SizedBox(height: 44),
                const Text('মোবাইল নম্বর', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                TextField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    prefixText: '+91  ',
                    hintText: 'আপনার মোবাইল নম্বর',
                    counterText: '',
                    prefixStyle: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: continueDemo,
                  style: FilledButton.styleFrom(
                    backgroundColor: purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('ডেমোতে প্রবেশ করুন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 14),
                const Text(
                  'এটি এখন UI ডেমো। এই বোতামটি আসল SMS OTP পাঠায় না।',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: muted, fontSize: 12),
                ),
                const SizedBox(height: 54),
                const Text('নিরাপদে কথা বলুন • সম্মান বজায় রাখুন',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: muted, fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatItem {
  final String name;
  final String message;
  final String time;
  final int unread;
  final Color color;
  const ChatItem(this.name, this.message, this.time, this.unread, this.color);
}

const demoChats = [
  ChatItem('সায়ন', 'কী খবর? আজ কথা হবে?', 'এখন', 2, Color(0xFF7057C8)),
  ChatItem('বন্ধুদের আড্ডা', 'রাহুল: সবাই অনলাইনে আছো?', '১০:৪২', 4, Color(0xFF287C72)),
  ChatItem('মৌ', 'ছবিটা দারুণ হয়েছে 😊', 'গতকাল', 0, Color(0xFFB66C85)),
  ChatItem('রাহুল', 'ঠিক আছে, পরে কথা হবে', 'গতকাল', 0, Color(0xFF9A7548)),
];

class HomePage extends StatefulWidget {
  final String phone;
  const HomePage({super.key, required this.phone});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('চলো কথা বলি', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('সবাইকে সঙ্গে রাখুন', style: TextStyle(fontSize: 11, color: muted)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: IndexedStack(
        index: tab,
        children: [
          _chats(),
          _simplePage(Icons.call_outlined, 'কল', 'কলের সুবিধা পরবর্তী সংস্করণে যোগ হবে।'),
          _simplePage(Icons.people_outline, 'কমিউনিটি', 'এখানে পাবলিক গ্রুপ দেখা যাবে।'),
          _profile(),
        ],
      ),
      floatingActionButton: tab == 0
          ? FloatingActionButton(
              backgroundColor: purple,
              onPressed: () => _newChat(),
              child: const Icon(Icons.edit_rounded, color: Colors.white),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        backgroundColor: panel,
        indicatorColor: purple.withOpacity(.22),
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: 'চ্যাট'),
          NavigationDestination(icon: Icon(Icons.call_outlined), label: 'কল'),
          NavigationDestination(icon: Icon(Icons.groups_outlined), label: 'গ্রুপ'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'প্রোফাইল'),
        ],
      ),
    );
  }

  Widget _chats() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, color: muted),
              hintText: 'নাম বা মেসেজ খুঁজুন',
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: demoChats.length,
            separatorBuilder: (_, __) => const Divider(height: 1, indent: 84, color: Color(0xFF292936)),
            itemBuilder: (context, i) {
              final c = demoChats[i];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                leading: CircleAvatar(
                  radius: 26,
                  backgroundColor: c.color,
                  child: Text(c.name.characters.first, style: const TextStyle(fontSize: 20, color: Colors.white)),
                ),
                title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(c.message, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: muted)),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(c.time, style: const TextStyle(color: muted, fontSize: 11)),
                    const SizedBox(height: 6),
                    if (c.unread > 0)
                      CircleAvatar(radius: 10, backgroundColor: purple,
                          child: Text('${c.unread}', style: const TextStyle(fontSize: 10, color: Colors.white))),
                  ],
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage(name: c.name))),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _simplePage(IconData icon, String title, String subtitle) => Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 58, color: purple),
      const SizedBox(height: 14),
      Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Text(subtitle, style: const TextStyle(color: muted), textAlign: TextAlign.center),
    ]),
  );

  Widget _profile() => Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      const CircleAvatar(radius: 42, backgroundColor: purple, child: Icon(Icons.person, size: 46)),
      const SizedBox(height: 14),
      const Text('আমার প্রোফাইল', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      Text('+91 ${widget.phone}', style: const TextStyle(color: muted)),
      const SizedBox(height: 18),
      OutlinedButton.icon(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage())),
        icon: const Icon(Icons.logout), label: const Text('লগ আউট')),
    ]),
  );

  void _newChat() {
    showModalBottomSheet(
      context: context,
      backgroundColor: panel,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('নতুন চ্যাট', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('পরবর্তী সংস্করণে ফোন নম্বর দিয়ে ব্যবহারকারী খোঁজা যাবে।', style: TextStyle(color: muted)),
            const SizedBox(height: 12),
            FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('ঠিক আছে')),
          ]),
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String name;
  const ChatPage({super.key, required this.name});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  final messages = <String>['হ্যালো! কেমন আছো?', 'ভালো আছি। তুমি?'];
  @override
  void dispose() { controller.dispose(); super.dispose(); }

  void send() {
    final value = controller.text.trim();
    if (value.isEmpty) return;
    setState(() { messages.add(value); controller.clear(); });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Row(children: [
        const CircleAvatar(backgroundColor: purple, child: Icon(Icons.person, color: Colors.white)),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.name, style: const TextStyle(fontSize: 16)),
          const Text('ডেমো চ্যাট', style: TextStyle(fontSize: 11, color: muted)),
        ]),
      ]),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.call)), IconButton(onPressed: () {}, icon: const Icon(Icons.videocam))],
    ),
    body: Column(children: [
      Expanded(child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: messages.length,
        itemBuilder: (_, i) => Align(
          alignment: i.isEven ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            constraints: const BoxConstraints(maxWidth: 290),
            decoration: BoxDecoration(
              color: i.isEven ? panel : purple.withOpacity(.28),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Text(messages[i]),
          ),
        ),
      )),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
          child: Row(children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline, color: purple)),
            Expanded(child: TextField(
              controller: controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => send(),
              decoration: const InputDecoration(hintText: 'মেসেজ লিখুন...', contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
            )),
            const SizedBox(width: 6),
            IconButton(onPressed: send, icon: const Icon(Icons.send_rounded, color: purple)),
          ]),
        ),
      ),
    ]),
  );
}

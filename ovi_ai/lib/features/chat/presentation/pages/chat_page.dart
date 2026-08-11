import 'package:flutter/material.dart';  

import '../../../../app/theme/app_theme.dart';  
import '../../../../core/widgets/glass_card.dart';  
import '../../../../shared/widgets/natasha_avatar.dart';  

class ChatPage extends StatefulWidget {  
  const ChatPage({super.key});  

  @override  
  State<ChatPage> createState() => _ChatPageState();  
}  

class _ChatMessage {  
  _ChatMessage({required this.text, required this.isUser});  

  final String text;  
  final bool isUser;  
}  

class _ChatPageState extends State<ChatPage> {  
  final List<_ChatMessage> _messages = [  
    _ChatMessage(  
      text: "I'm here, OVI. What's on your mind?",  
      isUser: false,  
    ),  
  ];  

  final TextEditingController _controller = TextEditingController();  
  final ScrollController _scrollController = ScrollController();  
  final FocusNode _focusNode = FocusNode();  

  bool _canSend = false;  
  bool _disposed = false;  

  @override  
  void initState() {  
    super.initState();  
    _controller.addListener(() {  
      final canSend = _controller.text.trim().isNotEmpty;  
      if (canSend != _canSend) {  
        setState(() => _canSend = canSend);  
      }  
    });  
  }  

  @override  
  void dispose() {  
    _disposed = true;  
    _controller.dispose();  
    _scrollController.dispose();  
    _focusNode.dispose();  
    super.dispose();  
  }  

  void _scrollToBottom() {  
    if (!_scrollController.hasClients) return;  
    WidgetsBinding.instance.addPostFrameCallback((_) {  
      if (!_scrollController.hasClients) return;  
      _scrollController.animateTo(  
        _scrollController.position.maxScrollExtent,  
        duration: const Duration(milliseconds: 260),  
        curve: Curves.easeOutCubic,  
      );  
    });  
  }  

  void _handleSend() {  
    final text = _controller.text.trim();  
    if (text.isEmpty) return;  

    setState(() {  
      _messages.add(_ChatMessage(text: text, isUser: true));  
    });  
    _controller.clear();  
    _scrollToBottom();  

    // Temporary local simulation only — no API/network call.  
    Future.delayed(const Duration(milliseconds: 700), () {  
      if (_disposed) return; // এখানে ডিসপোজড চেকটা বসিয়ে দেওয়া হয়েছে  
      setState(() {  
        _messages.add(  
          _ChatMessage(  
            text: "I'm here, OVI. How can I help you?",  
            isUser: false,  
          ),  
        );  
      });  
      _scrollToBottom();  
    });  
  }  

  @override  
  Widget build(BuildContext context) {  
    return SafeArea(  
      child: Column(  
        children: [  
          Expanded(  
            child: Center(  
              child: ConstrainedBox(  
                constraints: const BoxConstraints(maxWidth: 760),  
                child: ListView.builder(  
                  controller: _scrollController,  
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),  
                  itemCount: _messages.length,  
                  itemBuilder: (context, index) {  
                    final message = _messages[index];  
                    return _AnimatedMessageEntry(  
                      child: _ChatBubble(message: message),  
                    );  
                  },  
                ),  
              ),  
            ),  
          ),  
          _ChatInputBar(  
            controller: _controller,  
            focusNode: _focusNode,  
            canSend: _canSend,  
            onSend: _handleSend,  
          ),  
        ],  
      ),  
    );  
  }  
}  

class _AnimatedMessageEntry extends StatefulWidget {  
  const _AnimatedMessageEntry({required this.child});  

  final Widget child;  

  @override  
  State<_AnimatedMessageEntry> createState() => _AnimatedMessageEntryState();  
}  

class _AnimatedMessageEntryState extends State<_AnimatedMessageEntry>  
    with SingleTickerProviderStateMixin {  
  late final AnimationController _controller = AnimationController(  
    vsync: this,  
    duration: const Duration(milliseconds: 260),  
  )..forward();  

  late final Animation<double> _fade = CurvedAnimation(  
    parent: _controller,  
    curve: Curves.easeOut,  
  );  

  late final Animation<Offset> _slide = Tween<Offset>(  
    begin: const Offset(0, 0.06),  
    end: Offset.zero,  
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));  

  @override  
  void dispose() {  
    _controller.dispose();  
    super.dispose();  
  }  

  @override  
  Widget build(BuildContext context) {  
    return FadeTransition(  
      opacity: _fade,  
      child: SlideTransition(position: _slide, child: widget.child),  
    );  
  }  
}  

class _ChatBubble extends StatelessWidget {  
  const _ChatBubble({required this.message});  

  final _ChatMessage message;  

  @override  
  Widget build(BuildContext context) {  
    final isUser = message.isUser;  

    return Padding(  
      padding: const EdgeInsets.symmetric(vertical: 6),  
      child: Row(  
        mainAxisAlignment:  
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,  
        crossAxisAlignment: CrossAxisAlignment.end,  
        children: [  
          if (!isUser) ...[  
            const NatashaAvatar(size: 32, showGlow: false),  
            const SizedBox(width: 10),  
          ],  
          Flexible(  
            child: LayoutBuilder(  
              builder: (context, constraints) {  
                final maxBubbleWidth =  
                    MediaQuery.of(context).size.width * 0.74;  
                return ConstrainedBox(  
                  constraints: BoxConstraints(maxWidth: maxBubbleWidth),  
                  child: isUser  
                      ? _UserBubble(text: message.text)  
                      : _NatashaBubble(text: message.text),  
                );  
              },  
            ),  
          ),  
          if (isUser) const SizedBox(width: 4),  
        ],  
      ),  
    );  
  }  
}  

class _NatashaBubble extends StatelessWidget {  
  const _NatashaBubble({required this.text});  

  final String text;  

  @override  
  Widget build(BuildContext context) {  
    return GlassCard(  
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),  
      borderRadius: 20,  
      tint: OviColors.glass,  
      borderColor: OviColors.border,  
      blur: 14,  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        mainAxisSize: MainAxisSize.min,  
        children: [  
          Text(  
            'NATASHA',  
            style: Theme.of(context).textTheme.labelLarge?.copyWith(  
              color: OviColors.primaryBright,  
              fontSize: 10,  
              letterSpacing: 1.4,  
            ),  
          ),  
          const SizedBox(height: 4),  
          Text(text, style: Theme.of(context).textTheme.bodyLarge),  
        ],  
      ),  
    );  
  }  
}  

class _UserBubble extends StatelessWidget {  
  const _UserBubble({required this.text});  

  final String text;  

  @override  
  Widget build(BuildContext context) {  
    return Container(  
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),  
      decoration: BoxDecoration(  
        gradient: LinearGradient(  
          begin: Alignment.topLeft,  
          end: Alignment.bottomRight,  
          colors: [  
            OviColors.primary.withValues(alpha: 0.32),  
            OviColors.cyan.withValues(alpha: 0.22),  
          ],  
        ),  
        borderRadius: BorderRadius.circular(20),  
        border: Border.all(color: OviColors.primary.withValues(alpha: 0.28)),  
      ),  
      child: Text(  
        text,  
        style: Theme.of(  
          context,  
        ).textTheme.bodyLarge?.copyWith(color: OviColors.text),  
      ),  
    );  
  }  
}  

class _ChatInputBar extends StatelessWidget {  
  const _ChatInputBar({  
    required this.controller,  
    required this.focusNode,  
    required this.canSend,  
    required this.onSend,  
  });  

  final TextEditingController controller;  
  final FocusNode focusNode;  
  final bool canSend;  
  final VoidCallback onSend;  

  @override  
  Widget build(BuildContext context) {  
    return Padding(  
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),  
      child: Center(  
        child: ConstrainedBox(  
          constraints: const BoxConstraints(maxWidth: 760),  
          child: GlassCard(  
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),  
            borderRadius: 26,  
            tint: OviColors.glassStrong,  
            borderColor: OviColors.border,  
            blur: 20,  
            child: Row(  
              children: [  
                IconButton(  
                  onPressed: null,  
                  icon: const Icon(Icons.add_circle_outline_rounded),  
                  color: OviColors.textMuted,  
                  tooltip: 'Attach',  
                ),  
                Expanded(  
                  child: TextField(  
                    controller: controller,  
                    focusNode: focusNode,  
                    minLines: 1,  
                    maxLines: 5,  
                    textInputAction: TextInputAction.send,  
                    onSubmitted: (_) => onSend(),  
                    style: Theme.of(  
                      context,  
                    ).textTheme.bodyLarge?.copyWith(color: OviColors.text),  
                    decoration: InputDecoration(  
                      hintText: 'Message Natasha…',  
                      hintStyle: Theme.of(context).textTheme.bodyLarge  
                          ?.copyWith(color: OviColors.textMuted),  
                      border: InputBorder.none,  
                      isCollapsed: true,  
                      contentPadding: const EdgeInsets.symmetric(  
                        vertical: 12,  
                      ),  
                    ),  
                  ),  
                ),  
                const SizedBox(width: 4),  
                _MicButton(onPressed: null),  
                const SizedBox(width: 4),  
                _SendButton(enabled: canSend, onPressed: onSend),  
              ],  
            ),  
          ),  
        ),  
      ),  
    );  
  }  
}  

class _MicButton extends StatelessWidget {  
  const _MicButton({required this.onPressed});  

  final VoidCallback? onPressed;  

  @override  
  Widget build(BuildContext context) {  
    return Container(  
      width: 42,  
      height: 42,  
      decoration: BoxDecoration(  
        shape: BoxShape.circle,  
        gradient: LinearGradient(  
          begin: Alignment.topLeft,  
          end: Alignment.bottomRight,  
          colors: [  
            OviColors.primary.withValues(alpha: 0.9),  
            OviColors.cyan.withValues(alpha: 0.8),  
          ],  
        ),  
        boxShadow: [  
          BoxShadow(  
            color: OviColors.primary.withValues(alpha: 0.35),  
            blurRadius: 16,  
            spreadRadius: 1,  
          ),  
        ],  
      ),  
      child: IconButton(  
        onPressed: onPressed,  
        icon: const Icon(Icons.mic_rounded),  
        color: OviColors.background,  
        tooltip: 'Voice (coming soon)',  
      ),  
    );  
  }  
}  

class _SendButton extends StatelessWidget {  
  const _SendButton({required this.enabled, required this.onPressed});  

  final bool enabled;  
  final VoidCallback onPressed;  

  @override  
  Widget build(BuildContext context) {  
    return AnimatedOpacity(  
      duration: const Duration(milliseconds: 160),  
      opacity: enabled ? 1 : 0.4,  
      child: Container(  
        width: 42,  
        height: 42,  
        decoration: BoxDecoration(  
          shape: BoxShape.circle,  
          color: OviColors.primary.withValues(alpha: enabled ? 0.9 : 0.3),  
        ),  
        child: IconButton(  
          onPressed: enabled ? onPressed : null,  
          icon: const Icon(Icons.arrow_upward_rounded),  
          color: OviColors.background,  
          tooltip: 'Send',  
        ),  
      ),  
    );  
  }  
}  

// ignore: unused_element  
class _FeaturePlaceholderPage extends StatelessWidget {  
  const _FeaturePlaceholderPage({  
    required this.title,  
    required this.eyebrow,  
    required this.description,  
    required this.icon,  
    required this.accent,  
    this.avatar = false,  
  });  

  final String title;  
  final String eyebrow;  
  final String description;  
  final IconData icon;  
  final Color accent;  
  final bool avatar;  

  @override  
  Widget build(BuildContext context) {  
    return Center(  
      child: SingleChildScrollView(  
        padding: const EdgeInsets.all(24),  
        child: ConstrainedBox(  
          constraints: const BoxConstraints(maxWidth: 620),  
          child: GlassCard(  
            padding: const EdgeInsets.all(34),  
            tint: accent.withValues(alpha: 0.07),  
            borderColor: accent.withValues(alpha: 0.22),  
            child: Column(  
              children: [  
                if (avatar)  
                  const NatashaAvatar(size: 80)  
                else  
                  Container(  
                    width: 74,  
                    height: 74,  
                    decoration: BoxDecoration(  
                      color: accent.withValues(alpha: 0.14),  
                      shape: BoxShape.circle,  
                    ),  
                    child: Icon(icon, color: accent, size: 30),  
                  ),  
                const SizedBox(height: 24),  
                Text(  
                  eyebrow,  
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(  
                    color: accent,  
                    letterSpacing: 1.6,  
                    fontSize: 10,  
                  ),  
                ),  
                const SizedBox(height: 10),  
                Text(title, style: Theme.of(context).textTheme.headlineMedium),  
                const SizedBox(height: 10),  
                Text(  
                  description,  
                  textAlign: TextAlign.center,  
                  style: Theme.of(  
                    context,  
                  ).textTheme.bodyLarge?.copyWith(color: OviColors.textMuted),  
                ),  
                const SizedBox(height: 22),  
                Text(  
                  'This foundation is ready for the next feature layer.',  
                  textAlign: TextAlign.center,  
                  style: Theme.of(context).textTheme.bodyMedium,  
                ),  
              ],  
            ),  
          ),  
        ),  
      ),  
    );  
  }  
}

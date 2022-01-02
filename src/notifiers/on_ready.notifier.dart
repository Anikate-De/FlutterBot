import 'package:riverpod/riverpod.dart';

import '../commands/commands.dart';
import './../services/logs.dart';
import 'package:nyxx/nyxx.dart';

class ClientReady {
  /// On bot ready Do what ever you want 😎.
  static Future<void> onReadyEvent(
      INyxxWebsocket? client, ProviderContainer container) async {
    client!.eventsWs.onReady.listen((_) async {
      try {
        /// Set the bot activity to listening.
        client.setPresence(
          PresenceBuilder.of(
            status: UserStatus.online,
            activity: ActivityBuilder.listening('your commands')
              ..url = 'https://flutter.dev/',
          ),
        );
        await Flutter.getData(container);
        BotLogger.logln(
            LogType.success, '${client.self.tag} is ready to go 🔥');
      } catch (e) {
        /// Throw Exception if something goes wrong.
        BotLogger.logln(LogType.error, e.toString());
      }
    });
  }
}

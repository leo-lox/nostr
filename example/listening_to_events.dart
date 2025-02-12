import 'dart:async';

import 'package:dart_nostr/dart_nostr.dart';

void main() async {
  // // I did disabled logs here so we can see the output of the example exclusively.
  // Nostr.instance.disableLogs();

  // We initialize the Nostr Relays Service with relays.
  await Nostr.instance.relaysService.init(
    relaysUrl: <String>["wss://nos.lol"],
    onRelayError: (relay, error) {
      print("Relay error: $error");
    },
    onRelayDone: (relayUrl) => print("Relay done: $relayUrl"),
    onRelayListening: (relayUrl, receivedData) {
      // print("Relay listening: $relayUrl");
      // print("Relay listening data: $receivedData");
    },
  );
  Timer.periodic(Duration(milliseconds: 200), (timer) {
    // Then we create the request.
    final notesKindList = <int>[1];
    final tTags = ["nostr"];
    final sinceDateTime = DateTime.now().subtract(Duration(days: 2));
    final request = NostrRequest(
      filters: <NostrFilter>[
        NostrFilter(
          kinds: notesKindList,
          since: sinceDateTime,
        ),
      ],
    );

    // Now we create the stream of that request.
    final requestStream =
        Nostr.instance.relaysService.startEventsSubscription(request: request);
  });
  // We listen to the stream and print the events.
  // requestStream.listen((event) {
  //   print("-------------------");
  //   print(event.content);
  //   print(event.createdAt);
  //   print("-------------------");
  // });
}

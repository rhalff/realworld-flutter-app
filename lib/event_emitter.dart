import 'package:event_bus/event_bus.dart';

/// Purely cosmetic extension as throughout this application the
/// emitter is not used as an EventBus yet contains all the functionality needed
/// for a simple event emitter.
class EventEmitter extends EventBus {}

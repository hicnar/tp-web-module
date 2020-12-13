import 'dart:async';

import 'package:optional/optional.dart';
import 'package:tuple/tuple.dart';

import '../web_request_handler.dart';

class RemoteHandler extends WebRequestHandler{

    static RemoteHandler _instance;
  RemoteHandler._();

  factory RemoteHandler() => _instance ?? (_instance = RemoteHandler._());

  @override
  FutureOr<dynamic> doGet(req, res) async {

    return res.render('remote', {
      'title' : 'Sieciowy pilot zdalnego sterowania',
      'buttons' : {
        'web-button-0' : _buttonJson('digit-0', Optional.of(Tuple3('Start/Stop','', false))),
        'web-button-1' : _buttonJson('digit-1', Optional.of(Tuple3('Następny Cue Punkt',
            'Skacze do następnego cue punktu lub przewija 75% ekranu w górę, jeśli w skrypcie nie ma zdefiniowanych cue punktów', true))),
        'web-button-2' : _buttonJson('digit-2', Optional.of(Tuple3('Poprzedni Cue Punkt',
            'Skacze do poprzedniego cue punktu lub przewija 75% ekranu w dół, jeśli w skrypcie nie ma zdefiniowanych cue punktów', true))),
        'web-button-3' : _buttonJson('digit-3', Optional.of(Tuple3('Zwiększ Prędkość',
            'Zwiększa prędkość o jeden punkt, albo przewija 10% ekranu w górę jeśli skrypt nie jest aktualnie odtwarzany', true))),
        'web-button-4' : _buttonJson('digit-4', Optional.of(Tuple3('Zmniejsz Prędkość',
            'Zmniejsza prędkość o jeden punkt, albo przewija 10% ekranu w dół jeśli skrypt nie jest aktualnie odtwarzany', true))),
      },
      'scrollers': {
        'seek' : {
          'min': -300,
          'max': 300,
          'value': 0,
          'step': 10
        },
        'speed' : {
          'min': 1,
          'max': 100,
          'value': 10,
          'step': 1
        }
      }
    });
  }

  Map<String, dynamic> _buttonJson(String action, Optional<Tuple3<String, String, bool>> info) => {
      'action': action,
      'label': info.map((i) => i.item1).orElse('?'),
      'tooltip': info.map((i) => i.item2).orElse('?'),
      'hasTooltip': info.map((i) => i.item3).orElse(false),
    };
}
